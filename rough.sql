SELECT * FROM datauser;
SELECT * FROM buyer;
SELECT * FROM seller;
SELECT * FROM agent;
SELECT * FROM deal;
SELECT * FROM house;
SELECT * FROM brokerage;
SELECT * FROM document;
SELECT * FROM message;
SELECT * FROM datauser;

--first view created
CREATE VIEW buyer_and_seller_info (first_name, last_name, email, highest_price, lowest_price) AS
	SELECT	 d.first_name,
		 	d.last_name, 
		   	d.email, 
		   	b.highest_price,  
		   	s.lowest_price
		FROM  datauser d
				LEFT JOIN buyer b ON d.email = b.email
			LEFT JOIN seller s ON d.email = s.email;

--second view created
CREATE VIEW million_dollar_property (address, unit_num, price, status, sell_agent) AS
	SELECT	 h.address,
			h.unitnum,
			h.price,
			d.status,
			d.sellagent
		FROM house h
				LEFT JOIN deal d ON h.address = d.address AND h.unitnum = d.unitnum
			WHERE h.price >= 1000000;
--running queries on first view: return the user who is both a buyer and a seller
SELECT CONCAT(bsi.first_name, ' ' , bsi.last_name) AS both_buyer_and_seller, bsi.email FROM buyer_and_seller_info bsi
	WHERE bsi.lowest_price IS NOT NULL AND bsi.highest_price IS NOT NULL;

--running queries on the second view: All the associated info about million dollar house that's currently being negotiated
SELECT	m.address, 
		m.unit_num, 
		m.status,
		m.sell_agent,
		d.seller1,
		d.seller2,
		d.buyagent,
		d.buyer1,
		d.buyer2
	FROM million_dollar_property m 
			LEFT JOIN deal d ON m.address = d.address AND m.unit_num = d.unitnum
		WHERE m.status = 'Negotiating';

-- We try to update one of our million dollar property's status from 'Negotiating' to 'Closing' in our million_dollar_property VIEW
UPDATE million_dollar_property SET status = 'Closing' 
	WHERE address = '1023 King St W.' AND unit_num = 1408;

-- We try to update email 
UPDATE buyer_and_seller_info SET email = 'alice_smith@gmail.com'
	WHERE first_name = 'Alice' AND last_name = 'Smith';
--Now We create a temporary VIEW that is created from a single table and see if UPDATE works or not
CREATE TEMP VIEW temp_brokerage_view (name, address) AS 
	SELECT	 b.name,
			b.address
		FROM brokerage b;

--UPDATE query
UPDATE temp_brokerage_view SET address = '123 Berry Ave West' WHERE name = 'Little Brokers';





