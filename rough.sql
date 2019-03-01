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
--running queries on first view
SELECT CONCAT(bsi.first_name, ' ' , bsi.last_name) AS both_buyer_and_seller, bsi.email FROM buyer_and_seller_info bsi
	WHERE bsi.lowest_price IS NOT NULL AND bsi.highest_price IS NOT NULL;