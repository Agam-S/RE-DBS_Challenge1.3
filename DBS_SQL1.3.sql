/*   Name: Agampreet Singh
    Student ID: 103615452

    DONE: Task 1 | Rational Scehema

Organisation(OrgID, OrganisationName)
Primary Key (OrgID)

Client(ClientID, Name, Phone, OrgID)
Primary Key (ClientID)
Foreign Key (OrgID) references Organisation(OrgID)

MenuItem(ItemID, Description, ServesPerUnit, UnitPrice)
Primary Key (ItemID)

Order(ClientID, DateTimePlaced, DeliveryAddress)
Primary Key (ClientID, DateTimePlaced)
Foreign Key (ClientID) references Client(ClientID)

OrderLine(ItemId, ClientID, DateTimePlaced, Qty)
Primary Key (ItemID, ClientID, DateTimePlaced)
Foreign Key (ClientID, DateTimePlaced) references Order(ClientID, DateTimePlaced)
Foreign Key (ItemID) references Item(ItemID)

*/

-- Task 2

IF OBJECT_ID('Organisation') IS NOT NULL
	DROP TABLE Organisation;
GO

CREATE TABLE Organisation(

    OrgID NVARCHAR(4),
    OrganisationName NVARCHAR(200) NOT NULL UNIQUE,
    PRIMARY KEY (OrgID)
);

IF OBJECT_ID('Client') IS NOT NULL
	DROP TABLE Client;
GO

CREATE TABLE Client (
    ClientID INT,
    Name NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(15) NOT NULL UNIQUE,
    OrgID NVARCHAR(4),
    PRIMARY KEY (ClientID),
    FOREIGN KEY (OrgID) REFERENCES Organisation(OrgID)
);


IF OBJECT_ID('MenuItem') IS NOT NULL
	DROP TABLE MenuItem;
GO

CREATE TABLE MenuItem (
    ItemID INT,
    Description NVARCHAR(100) NOT NULL UNIQUE,
    ServesPerUnit INT NOT NULL CHECK(ServesPerUnit > 0),
    UnitPrice MONEY NOT NULL,
    PRIMARY KEY (ItemID)
);


IF OBJECT_ID('Orders') IS NOT NULL
	DROP TABLE Orders;
GO

CREATE TABLE Orders (
    ClientID INT,
    OrderDate DATE,
    DeliveryAddress NVARCHAR(MAX) NOT NULL,
    PRIMARY KEY (ClientID, OrderDate),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
);

IF OBJECT_ID('OrderLine') IS NOT NULL
	DROP TABLE OrderLine;
GO

CREATE TABLE OrderLine (
    ItemID INT,
    ClientID INT,
    OrderDate DATE,
    Qty INT NOT NULL CHECK(Qty > 0),
    PRIMARY KEY (ItemID, ClientID, OrderDate),
    FOREIGN KEY (ItemID) REFERENCES MenuItem(ItemID),
    FOREIGN KEY (ClientID, OrderDate) REFERENCES Orders(ClientID, OrderDate)
    
);

SELECT * FROM ORGANISATION 
SELECT * FROM CLIENT
SELECT * FROM MENUITEM
SELECT * FROM ORDERS
SELECT * FROM ORDERLINE 

-- ===================Task 3===================================

INSERT INTO Organisation(OrgID, OrganisationName) VALUES
 ('DODG', 'Dod & Gy Widget Importers'),
 ('SWUT', 'Swinburne University of Technology');

INSERT INTO CLIENT(ClientID, Name, Phone, OrgID) VALUES
(12, 'James Hallinan', '(03)5555-1234', 'SWUT'),
(15, 'Anh Nguyen', '(03)5555-2345', 'DODG'),
(18, 'Karen Mok', '(03)5555-3456', 'SWUT'),
(21, 'Tim Baird', '(03)5555-4567', 'DODG'),
(28, 'Agampreet Singh', '(03)5555-4012', 'SWUT');

INSERT INTO MENUITEM(ItemId, Description, ServesPerUnit, UnitPrice) VALUES
(3214, 'Tropical Pizza - Large', 2,	$16.00),
(3216, 'Tropical Pizza - Small', 1, $12.00),
(3218, 'Tropical Pizza - Family', 4, $23.00),
(4325, 'Can - Coke Zero', 1, $2.50),
(4326, 'Can - Lemonade', 1, $2.50), 
(4327, 'Can - Harden Up', 1, $7.50);

INSERT INTO ORDERS(ClientID, OrderDate, DeliveryAddress) VALUES
(12, '2021-09-20', 'Room TB225 - SUT - 1 John Street, Hawthorn, 3122'),
(21, '2021-09-14', 'Room ATC009 - SUT - 1 John Street, Hawthorn, 3122'),
(21, '2021-09-27', 'Room TB225 - SUT - 1 John Street, Hawthorn, 3122'),
(28, '2021-09-20', 'Room TD224 - SUT - 1 John Street, Hawthorn, 3122'),
(15, '2021-09-20', 'The George - 1 John Street, Hawthorn, 3122'),
(18, '2021-09-30', 'Room TB225 - SUT - 1 John Street, Hawthorn, 3122');

INSERT INTO ORDERLINE(ItemID, ClientID, OrderDate, Qty) VALUES
(3216, 12, '2021-09-20', 2),
(4326, 12, '2021-09-20', 1),
(3218, 21, '2021-09-14', 1),
(3214, 21, '2021-09-14', 1),
(4325, 21, '2021-09-14', 4),
(4327, 21, '2021-09-14', 2),
(3216, 21, '2021-09-27', 1),
(4327, 21, '2021-09-27', 1),
(3218, 21, '2021-09-27', 2),
(3216, 15, '2021-09-20', 2),
(4326, 15, '2021-09-20', 1),
(3216, 18, '2021-09-30', 1),
(4327, 18, '2021-09-30', 1);


-- ==========================Task 4=============================

-- Query 1:

Select OG.OrganisationName, C.Name, OL.OrderDate, O.DeliveryAddress, M.Description, OL.Qty 
FROM ORDERS O
INNER JOIN CLIENT C ON O.ClientID = C.ClientID
INNER JOIN Organisation OG ON OG.OrgID = C.OrgID
INNER JOIN ORDERLINE OL ON O.ClientID = OL.ClientID AND O.OrderDate = OL.OrderDate
INNER JOIN MENUITEM M ON OL.ItemID = M.ItemID

-- Query 2:
SELECT OG.OrgID, M.Description, SUM(QTY) AS 'Total QTY Ordered'
FROM MenuItem M
INNER JOIN OrderLine OL ON OL.ITEMID = M.ItemID
INNER JOIN Client C ON OL.ClientID = C.ClientID
INNER JOIN Organisation OG ON C.OrgID = OG.OrgID
GROUP BY OG.OrgID, M.Description
ORDER BY OrgId ASC

-- Query 3: 
SELECT OL.ItemID, OL.ClientID, OL.OrderDate, OL.Qty , M.UnitPrice, M.Description 
from OrderLine OL
INNER JOIN MenuItem M ON OL.ITEMID = M.ItemID
where (UnitPrice = (
    SELECT MAX(UnitPrice)
    FROM MenuItem M 
)
)
