CREATE TABLE PaymentDetails (
    
	PaymentID INT IDENTITY(1, 1) NOT NULL PRIMARY KEY CLUSTERED,
	PaymentNum INT NULL,
    CardNumber VARCHAR(100) MASKED WITH (FUNCTION = 'partial(0, "xxxxx", 4)') NULL,
	PaymentType VARCHAR(100)NULL,
    ExpiryDate Date MASKED WITH (FUNCTION = 'default()') NULL

);

-- inserting sample data
INSERT INTO PaymentDetails (PaymentID, PaymentNum, CardNumber, PaymentType, ExpiryDate)
VALUES
( 1, '555.123.4567', 'Card', '2027-09-30'),
(2, '555.123.4568', 'Card', '2030-08-30'),
(3,  '555.123.4570', 'Card', '2029-01-30'),
(4,  '', 'Cash','');
GO