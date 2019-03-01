DROP TABLE Brokerage CASCADE;
DROP TABLE dataUser CASCADE;
DROP TABLE Seller CASCADE;
DROP TABLE Buyer CASCADE;
DROP TABLE Agent CASCADE;
DROP TABLE House CASCADE;
DROP TABLE Deal CASCADE;
DROP TABLE Document CASCADE;
DROP TABLE Message CASCADE;

CREATE TABLE Brokerage(
name varchar(50),
address varchar(100),
commission real, 
PRIMARY KEY (name,address)
);

CREATE TABLE dataUser(
email varchar(50) PRIMARY KEY,
first_name varchar(50),
last_name varchar(50), 
password varchar(30) NOT NULL
);

CREATE TABLE Seller(
email varchar(50),
lowest_price int CHECK(lowest_price > 0),
PRIMARY KEY (email),
FOREIGN KEY (email) REFERENCES dataUser(email)
);

CREATE TABLE Buyer(
email varchar(50),
highest_price int CHECK(highest_price > 0),
PRIMARY KEY (email), 
FOREIGN KEY (email) REFERENCES dataUser(email)
);

CREATE TABLE Agent(
email varchar(50),
brName varchar(50) NOT NULL, 
brAddress varchar(100) NOT NULL, 
PRIMARY KEY (email), 
FOREIGN KEY (email) REFERENCES dataUser(email),
FOREIGN KEY (brName,brAddress) REFERENCES Brokerage(name,address)
);

CREATE TABLE House(
address varchar(100), 
unitNum int CHECK(unitNum >= 0),
price bigint CHECK(price > 0),
PRIMARY KEY (address,unitNum)
);

CREATE TABLE Deal(
id serial, 
address varchar(100) NOT NULL, 
unitNum int NOT NULL, 
status varchar(50), 
sellAgent varchar(50) NOT NULL, 
seller1 varchar(50), 
seller2 varchar(50),
buyAgent varchar(50), 
buyer1 varchar(50), 
buyer2 varchar(50), 
PRIMARY KEY (id), 
FOREIGN KEY (address,unitNum) REFERENCES House(address,unitNum),
FOREIGN KEY (buyer1) REFERENCES Buyer(email), 
FOREIGN KEY (buyer2) REFERENCES Buyer(email), 
FOREIGN KEY (seller1) REFERENCES Seller(email),
FOREIGN KEY (seller2) REFERENCES Seller(email), 
FOREIGN KEY (sellAgent) REFERENCES Agent(email), 
FOREIGN KEY (buyAgent) REFERENCES Agent(email)
);

CREATE TABLE Document(
name varchar(50),
id int,
version int CHECK(version >= 0),
fileDoc varchar(10000),
is_signed boolean,
PRIMARY KEY (name, id, version), 
FOREIGN KEY (id) REFERENCES Deal(id)
);

CREATE TABLE Message(
dateAndTime varchar(50),
text varchar(1000),
email varchar(50),
id int NOT NULL,


PRIMARY KEY (email, dateAndTime),
FOREIGN KEY (email) REFERENCES dataUser(email),
FOREIGN KEY (id) REFERENCES Deal(id)
);


INSERT INTO dataUser VALUES('user1@gmail.com','Alice','Smith','pass1234');
INSERT INTO dataUser VALUES('user2@gmail.com','Bob','Smith','dogo2020');
INSERT INTO dataUser VALUES('user3@gmail.com','Kevin','Smith','snowboard_time');
INSERT INTO dataUser VALUES('user4@gmail.com','Calvin','Johns','il0v3c4t5');
INSERT INTO dataUser VALUES('user5@gmail.com','Kevin','Benz','12345678890');
INSERT INTO dataUser VALUES('user6@gmail.com','Amy','Appleseed','6135552020');
INSERT INTO dataUser VALUES('user7@gmail.com','Mister','Manley','manley1414');
INSERT INTO dataUser VALUES('user8@gmail.com','Misses','Manley','miss_man1');
INSERT INTO dataUser VALUES('user9@gmail.com','Betty','Buyer','buydatdank');
INSERT INTO dataUser VALUES('user10@gmail.com','Brendan','Buyer','buydatdank420');

SELECT * FROM dataUser;

INSERT INTO Brokerage VALUES('Little Brokers','123 Berry Ave', 2.5);
INSERT INTO Brokerage VALUES('Buy a Home Inc.','456 Apple Ave', 1);
INSERT INTO Brokerage VALUES('Green-Key','5050 Commission St.', 5);
INSERT INTO Brokerage VALUES('Comfree','0 Commission St.', 0);
INSERT INTO Brokerage VALUES('Luxury Service Brokers','999 Pro Road', 9);
INSERT INTO Brokerage VALUES('Bad Brokers','10 Bad Place', 20.5);

SELECT * FROM Brokerage;

INSERT INTO Agent VALUES('user1@gmail.com', 'Little Brokers', '123 Berry Ave');
INSERT INTO Agent VALUES('user2@gmail.com', 'Buy a Home Inc.', '456 Apple Ave');
INSERT INTO Agent VALUES('user5@gmail.com', 'Green-Key', '5050 Commission St.');
INSERT INTO Agent VALUES('user6@gmail.com', 'Comfree', '0 Commission St.');
INSERT INTO Agent VALUES('user4@gmail.com', 'Luxury Service Brokers', '999 Pro Road');
INSERT INTO Agent VALUES('user3@gmail.com', 'Bad Brokers', '10 Bad Place');

SELECT * FROM Agent;

INSERT INTO Seller VALUES('user7@gmail.com', 800000);
INSERT INTO Seller VALUES('user8@gmail.com', 850000);
INSERT INTO Seller VALUES('user1@gmail.com', 50000);
INSERT INTO Seller VALUES('user2@gmail.com', 1000000);
INSERT INTO Seller VALUES('user3@gmail.com', 1250000);
INSERT INTO Seller VALUES('user4@gmail.com', 1250000);

SELECT * FROM Seller;

INSERT INTO Buyer VALUES('user4@gmail.com', 100000);
INSERT INTO Buyer VALUES('user5@gmail.com', 400000);
INSERT INTO Buyer VALUES('user6@gmail.com', 800000);
INSERT INTO Buyer VALUES('user9@gmail.com', 1200000);
INSERT INTO Buyer VALUES('user10@gmail.com', 1600000);

SELECT * FROM Buyer;

INSERT INTO House VALUES('20 Hally Ave', 2, 500000);
INSERT INTO House VALUES('25 Gray Street', 0, 800000);
INSERT INTO House VALUES('253 Maripose Ave', 3, 850000);
INSERT INTO House VALUES('202 Rue Universirt', 14, 825000);
INSERT INTO House VALUES('1023 King St W.', 1408, 1000000);
INSERT INTO House VALUES('1023 King St W.', 1409, 1500000);
INSERT INTO House VALUES('909 Nike Street', 0, 20000000);
INSERT INTO House VALUES('3209 Balmer Road', 1408, 100000);
INSERT INTO House VALUES('84 Monster Place', 0, 500);

SELECT * FROM House;

INSERT INTO Deal VALUES(1, '20 Hally Ave', 2, 'Listed', 'user5@gmail.com', 'user1@gmail.com', null, null, null, null);
INSERT INTO Deal VALUES(2, '25 Gray Street', 0, 'Getting Listed', 'user5@gmail.com', 'user1@gmail.com', 'user2@gmail.com', null, null, null);
INSERT INTO Deal VALUES(3, '253 Maripose Ave', 3, 'Closing', 'user1@gmail.com', 'user7@gmail.com', 'user8@gmail.com', 'user1@gmail.com', 'user9@gmail.com', 'user10@gmail.com');
INSERT INTO Deal VALUES(4, '1023 King St W.', 1408, 'Negotiating', 'user4@gmail.com', 'user4@gmail.com', null, 'user2@gmail.com', 'user5@gmail.com', 'user6@gmail.com');
INSERT INTO Deal VALUES(1000, '1023 King St W.', 1409, 'Negotiating', 	'user4@gmail.com', 'user4@gmail.com', 'user3@gmail.com', 'user1@gmail.com', 'user9@gmail.com', 'user10@gmail.com');
INSERT INTO Deal VALUES(1010, '84 Monster Place', 0, 'Listed','user6@gmail.com', null, null, null, null, null);
INSERT INTO Deal VALUES(1011, '909 Nike Street', 0, 'Closing','user6@gmail.com', null, null, 'user1@gmail.com', null, null);
INSERT INTO Deal VALUES(1012, '3209 Balmer Road', 1408, 'Closing','user6@gmail.com', 'user4@gmail.com', null, null, 'user10@gmail.com', null);
INSERT INTO Deal VALUES(2000, '202 Rue Universirt', 14, 'Listed','user6@gmail.com', null, null, null, 'user4@gmail.com', null);

SELECT * FROM Deal;

INSERT INTO Document VALUES('Listing Agreement', 1, 1, 'This document lets me sell your house!', '0');
INSERT INTO Document VALUES('Listing Agreement', 1, 2, 'This document lets me sell your house!', '1');
INSERT INTO Document VALUES('Working With a REALTOR', 1, 1, 'You are working with an official REALTOR', '0');
INSERT INTO Document VALUES('Working With a REALTOR', 1, 2, 'You are working with an official REALTOR', '1');
INSERT INTO Document VALUES('Selling Plan', 1, 1000, 'We are going to sell to developers and here is why...', '0');
INSERT INTO Document VALUES('Selling Plan Ppt', 1, 1010, 'Here are some images', '0');
INSERT INTO Document VALUES('Notice of Condition Fufillment', 1, 1, 'The house is hereby inspecrted', 'true');

SELECT * FROM Document;

INSERT INTO Message VALUES('20120618 10:34:09 AM', 'Is this home online yet', 'user1@gmail.com', 1);
INSERT INTO Message VALUES('20120618 10:34:09 AM', 'Is this home up online yet', 'user2@gmail.com', 2);
INSERT INTO Message VALUES('20120619 10:34:59 AM', 'Is this home for sale?', 'user10@gmail.com', 3);
INSERT INTO Message VALUES('20120619 10:35:29 AM', 'Yeah, you can buy it for $850000', 'user1@gmail.com', 3);
INSERT INTO Message VALUES('20120619 10:36:20 AM', 'I''ll go $825k and thats final.', 'user9@gmail.com', 3);
INSERT INTO Message VALUES('20120619 10:36:25 AM', 'SOLD!', 'user7@gmail.com', 3);
INSERT INTO Message VALUES('20190619 10:36:25 AM', 'It''s 2019 and still no offers...', 'user6@gmail.com', 1010);
INSERT INTO Message VALUES('20190619 10:36:26 AM', 'Eff me...', 'user6@gmail.com', 1010);

SELECT * FROM Message;
