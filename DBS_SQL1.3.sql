/*   Name: Agampreet Singh
    Student ID: 103615452

    Task 1 | Rational Scehema

Organisation(OrgID, OrganisationName)
Primary Key (OrgID)

Client(ClientID, Name, Phone)
Primary Key (ClientID)

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

