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
    FOREIGN KEY (ClientID, OrderDate) REFERENCES Orders(ClientID, OrderDate),
    FOREIGN KEY (ItemID) REFERENCES MenuItem(ItemID)
);

SELECT * FROM ORGANISATION 
SELECT * FROM CLIENT
SELECT * FROM ORDERS
SELECT * FROM MENUITEM
SELECT * FROM ORDERLINE 