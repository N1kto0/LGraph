USE MASTER
GO
DROP DATABASE IF EXISTS LGraph
GO
CREATE DATABASE LGraph
GO
USE LGraph
GO

CREATE TABLE Suppliers (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Address VARCHAR(255),
    ContactInformation VARCHAR(255)
) AS NODE;

CREATE TABLE Warehouses (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Address VARCHAR(255),
    Capacity INT
) AS NODE;

CREATE TABLE Customers (
    ID INT PRIMARY KEY,
    Address VARCHAR(255),
    ContactInformation VARCHAR(255)
) AS NODE;

CREATE TABLE Goods (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    [Description] VARCHAR(255)
) AS NODE;

CREATE TABLE Buying ([time] DATETIME) AS EDGE;

CREATE TABLE Keeping (
    [count] INT,
) AS EDGE;

CREATE TABLE Deliving AS EDGE;

CREATE TABLE Working AS EDGE;
-- Добавление данных для поставщиков
INSERT INTO Suppliers (ID, Name, Address, ContactInformation)
VALUES 
    (1, 'Supplier A', '123 Main St', 'supplierA@example.com'),
    (2, 'Supplier B', '456 Elm St', 'supplierB@example.com'),
    (3, 'Supplier C', '789 Oak St', 'supplierC@example.com'),
    (4, 'Supplier D', '101 Pine St', 'supplierD@example.com'),
    (5, 'Supplier E', '202 Cedar St', 'supplierE@example.com'),
    (6, 'Supplier F', '303 Maple St', 'supplierF@example.com'),
    (7, 'Supplier G', '404 Walnut St', 'supplierG@example.com'),
    (8, 'Supplier H', '505 Pineapple Ave', 'supplierH@example.com'),
    (9, 'Supplier I', '606 Peach St', 'supplierI@example.com'),
    (10, 'Supplier J', '707 Orange Blvd', 'supplierJ@example.com');

-- Добавление данных для складов
INSERT INTO Warehouses (ID, Name, Address, Capacity)
VALUES 
    (1, 'Warehouse X', '100 Industrial Ave', 1000),
    (2, 'Warehouse Y', '200 Commercial Blvd', 1500),
    (3, 'Warehouse Z', '300 Logistics Pkwy', 2000),
    (4, 'Warehouse W', '400 Distribution Dr', 1200),
    (5, 'Warehouse V', '500 Storage Ln', 1800),
    (6, 'Warehouse U', '600 Shipping St', 1600),
    (7, 'Warehouse T', '700 Cargo Rd', 1400),
    (8, 'Warehouse S', '800 Transport Ave', 1700),
    (9, 'Warehouse R', '900 Freight Blvd', 1300),
    (10, 'Warehouse Q', '1000 Export Ln', 1900);

-- Добавление данных для клиентов
INSERT INTO Customers (ID, Address, ContactInformation)
VALUES 
    (1, '789 Elm St', 'customer1@example.com'),
    (2, '456 Oak St', 'customer2@example.com'),
    (3, '123 Cedar St', 'customer3@example.com'),
    (4, '101 Pine St', 'customer4@example.com'),
    (5, '202 Main St', 'customer5@example.com'),
    (6, '303 Walnut St', 'customer6@example.com'),
    (7, '404 Maple St', 'customer7@example.com'),
    (8, '505 Peach St', 'customer8@example.com'),
    (9, '606 Orange Blvd', 'customer9@example.com'),
    (10, '707 Apple Ave', 'customer10@example.com');

-- Добавление данных для товаров
INSERT INTO Goods (ID, Name, [Description])
VALUES 
    (1, 'Product A', 'Description of Product A'),
    (2, 'Product B', 'Description of Product B'),
    (3, 'Product C', 'Description of Product C'),
    (4, 'Product D', 'Description of Product D'),
    (5, 'Product E', 'Description of Product E'),
    (6, 'Product F', 'Description of Product F'),
    (7, 'Product G', 'Description of Product G'),
    (8, 'Product H', 'Description of Product H'),
    (9, 'Product I', 'Description of Product I'),
    (10, 'Product J', 'Description of Product J');

	INSERT INTO Buying ($from_id, $to_id, [time])
VALUES ((SELECT $node_id FROM Customers WHERE ID = 1),
 (SELECT $node_id FROM Goods WHERE ID = 6), '2021-09-10 09:45:00'),
 ((SELECT $node_id FROM Customers WHERE ID = 5),
 (SELECT $node_id FROM Goods WHERE ID = 1), '2021-09-05 09:45:00'),
 ((SELECT $node_id FROM Customers WHERE ID = 8),
 (SELECT $node_id FROM Goods WHERE ID = 7), '2021-09-10 09:45:00'),
 ((SELECT $node_id FROM Customers WHERE ID = 2),
 (SELECT $node_id FROM Goods WHERE ID = 2), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Customers WHERE ID = 3),
 (SELECT $node_id FROM Goods WHERE ID = 5), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Customers WHERE ID = 4),
 (SELECT $node_id FROM Goods WHERE ID = 3), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Customers WHERE ID = 6),
 (SELECT $node_id FROM Goods WHERE ID = 4), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Customers WHERE ID = 7),
 (SELECT $node_id FROM Goods WHERE ID = 2), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Customers WHERE ID = 1),
 (SELECT $node_id FROM Goods WHERE ID = 9), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Customers WHERE ID = 9),
 (SELECT $node_id FROM Goods WHERE ID = 8), '2021-11-05 09:45:00'),
 ((SELECT $node_id FROM Customers WHERE ID = 10),
 (SELECT $node_id FROM Goods WHERE ID = 10), '2021-11-10 09:45:00');

 INSERT INTO Keeping ($from_id, $to_id, [count])
VALUES ((SELECT $node_id FROM Warehouses WHERE ID = 1),
 (SELECT $node_id FROM Goods WHERE ID = 6), 10),
 ((SELECT $node_id FROM Warehouses WHERE ID = 5),
 (SELECT $node_id FROM Goods WHERE ID = 1), 9),
 ((SELECT $node_id FROM Warehouses WHERE ID = 8),
 (SELECT $node_id FROM Goods WHERE ID = 7), 15),
 ((SELECT $node_id FROM Warehouses WHERE ID = 2),
 (SELECT $node_id FROM Goods WHERE ID = 2), 40),
 ((SELECT $node_id FROM Warehouses WHERE ID = 3),
 (SELECT $node_id FROM Goods WHERE ID = 5), 113),
 ((SELECT $node_id FROM Warehouses WHERE ID = 4),
 (SELECT $node_id FROM Goods WHERE ID = 3), 25),
 ((SELECT $node_id FROM Warehouses WHERE ID = 6),
 (SELECT $node_id FROM Goods WHERE ID = 4), 111),
 ((SELECT $node_id FROM Warehouses WHERE ID = 7),
 (SELECT $node_id FROM Goods WHERE ID = 2), 2),
 ((SELECT $node_id FROM Warehouses WHERE ID = 1),
 (SELECT $node_id FROM Goods WHERE ID = 9), 400),
 ((SELECT $node_id FROM Warehouses WHERE ID = 9),
 (SELECT $node_id FROM Goods WHERE ID = 8), 15),
 ((SELECT $node_id FROM Warehouses WHERE ID = 10),
 (SELECT $node_id FROM Goods WHERE ID = 10), 77);

 INSERT INTO Deliving ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Suppliers WHERE ID = 1),
 (SELECT $node_id FROM Goods WHERE ID = 6)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 5),
 (SELECT $node_id FROM Goods WHERE ID = 1)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 8),
 (SELECT $node_id FROM Goods WHERE ID = 7)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 2),
 (SELECT $node_id FROM Goods WHERE ID = 2)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 3),
 (SELECT $node_id FROM Goods WHERE ID = 5)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 4),
 (SELECT $node_id FROM Goods WHERE ID = 3)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 6),
 (SELECT $node_id FROM Goods WHERE ID = 4)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 7),
 (SELECT $node_id FROM Goods WHERE ID = 2)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 1),
 (SELECT $node_id FROM Goods WHERE ID = 9)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 9),
 (SELECT $node_id FROM Goods WHERE ID = 8)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 10),
 (SELECT $node_id FROM Goods WHERE ID = 10));

 INSERT INTO Working ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Suppliers WHERE ID = 1),
 (SELECT $node_id FROM Suppliers WHERE ID = 6)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 5),
 (SELECT $node_id FROM Suppliers WHERE ID = 1)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 8),
 (SELECT $node_id FROM Suppliers WHERE ID = 7)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 2),
 (SELECT $node_id FROM Suppliers WHERE ID = 4)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 3),
 (SELECT $node_id FROM Suppliers WHERE ID = 5)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 4),
 (SELECT $node_id FROM Suppliers WHERE ID = 3)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 6),
 (SELECT $node_id FROM Suppliers WHERE ID = 4)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 7),
 (SELECT $node_id FROM Suppliers WHERE ID = 2)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 1),
 (SELECT $node_id FROM Suppliers WHERE ID = 9)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 9),
 (SELECT $node_id FROM Suppliers WHERE ID = 8)),
 ((SELECT $node_id FROM Suppliers WHERE ID = 10),
 (SELECT $node_id FROM Suppliers WHERE ID = 9));

 -- Запросы с Match
 SELECT Customer.contactInformation
FROM Customers AS Customer
	, Buying
	, Goods AS Good
WHERE MATCH([Good]<-(Buying)-[Customer])
	AND Good.name = N'Product B';

SELECT Supplier.name
FROM Suppliers AS Supplier
	, Deliving
	, Goods AS Good
WHERE MATCH([Good]<-(Deliving)-[Supplier])
	AND Good.name = N'Product D';

	SELECT Warehouse.name
FROM Warehouses AS Warehouse
	, Keeping
	, Goods AS Good
WHERE MATCH([Good]<-(Keeping)-[Warehouse])
	AND Good.name = N'Product I';

	 SELECT Customer.contactInformation
FROM Customers AS Customer
	, Buying
	, Goods AS Good
WHERE MATCH([Good]<-(Buying)-[Customer])
	AND Buying.time > '2021-05-09 14:30:00';

		SELECT Warehouse.name
FROM Warehouses AS Warehouse
	, Keeping
	, Goods AS Good
WHERE MATCH([Good]<-(Keeping)-[Warehouse])
	AND Keeping.count < 50;

SELECT Supplier1.name AS SupplierName
 , STRING_AGG(Supplier2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Coopers
FROM Suppliers AS Supplier1
 , Working FOR PATH AS w
 , Suppliers FOR PATH AS Supplier2
WHERE MATCH(SHORTEST_PATH(Supplier1(-(w)->Supplier2)+))
 AND Supplier1.name = N'Supplier A';

 SELECT Supplier1.name AS SupplierName
 , STRING_AGG(Supplier2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Coopers
FROM Suppliers AS Supplier1
 , Working FOR PATH AS w
 , Suppliers FOR PATH AS Supplier2
WHERE MATCH(SHORTEST_PATH(Supplier1(-(w)->Supplier2){1, 3}))
 AND Supplier1.name = N'Supplier D';

 SELECT Supplier1.id AS IdFirst
	, Supplier1.name AS First
	, CONCAT(N'suppliers', Supplier1.id) AS [First image name]
	, Supplier2.id AS IdSecond
	, Supplier2.name AS Second
	, CONCAT(N'suppliers', Supplier2.id) AS [Second image name]
FROM Suppliers AS Supplier1
	, Working AS w
	, Suppliers AS Supplier2
WHERE MATCH(Supplier1-(w)->[Supplier2]);

 SELECT Supplier.id AS IdFirst
	, Supplier.name AS First
	, CONCAT(N'suppliers', Supplier.id) AS [First image name]
	, Good.id AS IdSecond
	, Good.name AS Second
	, CONCAT(N'goods', Good.id) AS [Second image name]
FROM Suppliers AS Supplier
	, Deliving AS d
	, Goods AS Good
WHERE MATCH(Supplier-(d)->Good);

 SELECT Warehouse.id AS IdFirst
	, Warehouse.name AS First
	, CONCAT(N'wares', Warehouse.id) AS [First image name]
	, k.[count] AS [Count]
	, Good.id AS IdSecond
	, Good.name AS Second
	, CONCAT(N'goods', Good.id) AS [Second image name]
FROM Warehouses AS Warehouse
	, Keeping AS k
	, Goods AS Good
WHERE MATCH(Warehouse-(k)->Good);

 SELECT Customer.id AS IdFirst
	, Customer.ContactInformation AS First
	, CONCAT(N'customers', Customer.id) AS [First image name]
	, Good.id AS IdSecond
	, Good.name AS Second
	, CONCAT(N'goods', Good.id) AS [Second image name]
FROM Customers AS Customer
	, Buying AS b
	, Goods AS Good
WHERE MATCH(Customer-(b)->Good);

select @@servername