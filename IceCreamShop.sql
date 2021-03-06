
CREATE TABLE ProduceSagaDataDb (
	ProductionId UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
	ProductId INT NULL,
	ProductName NVARCHAR(256) NULL,
	ProductAmount DECIMAL(10,2) NULL,
);

CREATE TABLE SaleSagaDataDb (
	SaleId UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
	Products NVARCHAR(1000) NULL,
);



USE IceCreamShop;

DROP TABLE SemiFinishedGood;
DROP TABLE Product;

CREATE TABLE SemiFinishedGood (
	Id INT PRIMARY KEY NOT NULL,
	Name VARCHAR(256) NOT NULL
);

CREATE TABLE Product (
	Id INT PRIMARY KEY NOT NULL,
	Name VARCHAR(25) NOT NULL
);


INSERT INTO Product VALUES (1, 'Lody czekoladowe');
INSERT INTO Product VALUES (2, 'Lody waniliowe');
INSERT INTO Product VALUES (3, 'Lody truskawkowe');
INSERT INTO Product VALUES (4, 'Lody malinowe');
INSERT INTO Product VALUES (5, 'Lody bananowe');
INSERT INTO Product VALUES (6, 'Lody śmietankowe');

INSERT INTO SemiFinishedGood VALUES (1, 'Mleko UHT 2% tł. WYPASIONE 1 L');
INSERT INTO SemiFinishedGood VALUES (2, 'Mleko UHT 3,2% tł. WYPASIONE 1 L');
INSERT INTO SemiFinishedGood VALUES (3, 'Mleko Wypasione od szczęśliwych krów BEZ GMO 3,2% 1 L');
INSERT INTO SemiFinishedGood VALUES (4, 'Wydojone bez laktozy 1 L UHT 1,5% tł.');
INSERT INTO SemiFinishedGood VALUES (5, 'Mleko UHT Twój Kubek 0,5% tł. 1 L z zakrętką');
INSERT INTO SemiFinishedGood VALUES (6, 'Żółtka jaj');
INSERT INTO SemiFinishedGood VALUES (7, 'Śmietana POLSKA gęsta 12% 200 g Mlekovita');
INSERT INTO SemiFinishedGood VALUES (8, 'Śmietana Polska 18% bez laktozy 200 g Mlekovita');
INSERT INTO SemiFinishedGood VALUES (9, 'Śmietana POLSKA gęsta 18% 400 g Mlekovita');
INSERT INTO SemiFinishedGood VALUES (10, 'Śmietanka POLSKA 30% 200 ml Mlekovita');
INSERT INTO SemiFinishedGood VALUES (11, 'Śmietanka UHT Polska 36% tłuszczu 1 L Mlekovita');
INSERT INTO SemiFinishedGood VALUES (12, 'Cukier biały Diamant 1 kg');
INSERT INTO SemiFinishedGood VALUES (13, 'Tabliczka czekolady Wedel');
INSERT INTO SemiFinishedGood VALUES (14, 'Truskawki 1 kg');
INSERT INTO SemiFinishedGood VALUES (15, 'Maliny 400 g');
INSERT INTO SemiFinishedGood VALUES (16, 'Wanilia 1 laska');
INSERT INTO SemiFinishedGood VALUES (17, 'Wafelek mały');
INSERT INTO SemiFinishedGood VALUES (18, 'Wafelek duży');
INSERT INTO SemiFinishedGood VALUES (19, 'Polewa toffi');
INSERT INTO SemiFinishedGood VALUES (20, 'Polewa czekoladowa');
INSERT INTO SemiFinishedGood VALUEs (21, 'Banany 1 kiść');

USE IceCreamShop_Warehouse;
DROP TABLE ProductAmount;
DROP TABLE SemiFinishedGoodAmount;
DROP VIEW Product;
DROP VIEW SemiFinishedGood;
GO
CREATE VIEW Product AS
SELECT *
FROM IceCreamShop.dbo.Product;
GO
CREATE VIEW SemiFinishedGood AS
SELECT *
FROM IceCreamShop.dbo.SemiFinishedGood;
GO
CREATE TABLE ProductAmount (
	ProductId INT PRIMARY KEY NOT NULL,
	Amount DECIMAL(10,2)
);

CREATE TABLE SemiFinishedGoodAmount (
	SemiFinishedGoodId INT PRIMARY KEY NOT NULL,
	Amount DECIMAL(10,2)
);

INSERT INTO ProductAmount VALUES (1, 5);
INSERT INTO ProductAmount VALUES (2, 6);
INSERT INTO ProductAmount VALUES (3, 7);
INSERT INTO ProductAmount VALUES (4, 8);
INSERT INTO ProductAmount VALUES (5, 8);
INSERT INTO ProductAmount VALUES (6, 8);

INSERT INTO SemiFinishedGoodAmount VALUES (1, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (2, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (3, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (4, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (5, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (6, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (7, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (8, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (9, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (10, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (11, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (12, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (13, 2);
INSERT INTO SemiFinishedGoodAmount VALUES (14, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (15, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (16, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (17, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (18, 3);
INSERT INTO SemiFinishedGoodAmount VALUES (19, 0);
INSERT INTO SemiFinishedGoodAmount VALUES (20, 0);
INSERT INTO SemiFinishedGoodAmount VALUEs (21, 0);


USE IceCreamShop_Production;

DROP TABLE Recipe;


CREATE TABLE Recipe (
	ProductId INT NOT NULL,
	SemiFinishedGoodName NVARCHAR(100) NOT NULL,
	Amount DECIMAL(10,2),
	PRIMARY KEY (SemiFinishedGoodName, ProductId)
);

INSERT INTO Recipe VALUES (1, 'Mleko UHT 2% tł. WYPASIONE 1 L', 1);
INSERT INTO Recipe VALUES (1, 'Żółtka jaj', 5);
INSERT INTO Recipe VALUES (1, 'Śmietana POLSKA gęsta 12% 200 g Mlekovita', 1);
INSERT INTO Recipe VALUES (1, 'Cukier biały Diamant 1 kg', 1);
INSERT INTO Recipe VALUES (1, 'Tabliczka czekolady Wedel', 10);
INSERT INTO Recipe VALUES (2, 'Mleko Wypasione od szczęśliwych krów BEZ GMO 3,2% 1 L', 1);
INSERT INTO Recipe VALUES (2, 'Żółtka jaj', 3);
INSERT INTO Recipe VALUES (2, 'Mleko UHT 2% tł. WYPASIONE 1 L', 1);
INSERT INTO Recipe VALUES (2, 'Śmietana POLSKA gęsta 18% 400 g Mlekovita', 1);
INSERT INTO Recipe VALUES (2, 'Cukier biały Diamant 1 kg', 1);
INSERT INTO Recipe VALUES (2, 'Wanilia 1 laska', 15);
INSERT INTO Recipe VALUES (3, 'Mleko UHT Twój Kubek 0,5% tł. 1 L z zakrętką', 1);
INSERT INTO Recipe VALUES (3, 'Śmietanka POLSKA 30% 200 ml Mlekovita', 1);
INSERT INTO Recipe VALUES (3, 'Cukier biały Diamant 1 kg', 1);
INSERT INTO Recipe VALUES (3, 'Truskawki 1 kg', 2);
INSERT INTO Recipe VALUES (4, 'Wydojone bez laktozy 1 L UHT 1,5% tł.', 1);
INSERT INTO Recipe VALUES (4, 'Śmietana POLSKA gęsta 12% 200 g Mlekovita', 1);
INSERT INTO Recipe VALUES (4, 'Żółtka jaj', 5);
INSERT INTO Recipe VALUES (4, 'Cukier biały Diamant 1 kg', 1);
INSERT INTO Recipe VALUES (4, 'Maliny 400 g', 3);
INSERT INTO Recipe VALUES (5, 'Mleko UHT 2% tł. WYPASIONE 1 L', 1);
INSERT INTO Recipe VALUES (5, 'Żółtka jaj', 3);
INSERT INTO Recipe VALUES (5, 'Śmietana POLSKA gęsta 18% 400 g Mlekovita', 1);
INSERT INTO Recipe VALUES (5, 'Cukier biały Diamant 1 kg', 1);
INSERT INTO Recipe VALUES (5, 'Banany 1 kiść', 3);
INSERT INTO Recipe VALUES (6, 'Mleko UHT 3,2% tł. WYPASIONE 1 L', 1);
INSERT INTO Recipe VALUES (6, 'Śmietanka UHT Polska 36% tłuszczu 1 L Mlekovita', 2);
INSERT INTO Recipe VALUES (6, 'Cukier biały Diamant 1 kg', 1);

DROP TABLE Production;

CREATE TABLE Production (
	Id INT PRIMARY KEY NOT NULL,
	Date DATE NOT NULL,
	ProductName NVARCHAR(100) NOT NULL,
	Amount DECIMAL(10,2)

);

USE IceCreamShop_Sale

DROP TABLE SalePosition;
DROP TABLE Sale;

CREATE TABLE Sale (
	Id INT PRIMARY KEY NOT NULL,
	Date DATE NOT NULL,
	SumPrice INT NOT NULL 
);

CREATE TABLE SalePosition (
	SaleId INT NOT NULL REFERENCES Sale,
	ProductId INT NOT NULL,
	Amount DECIMAL(10,2),
	PRIMARY KEY (SaleId, ProductId)
);
