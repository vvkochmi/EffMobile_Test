CREATE DATABASE TestBD

GO
USE TestBD

CREATE TABLE Districts
(
	ID INT PRIMARY KEY IDENTITY,
	DisName NVARCHAR(100)
);

CREATE TABLE Orders
(
	Number INT PRIMARY KEY IDENTITY,
	Width FLOAT NOT NULL CHECK(Width > 0),
	DistrictID INT REFERENCES Districts(ID) NOT NULL,
	OrderTime DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE OrderLog
(
	ID INT PRIMARY KEY IDENTITY,
	FormTime DATETIME NOT NULL DEFAULT GETDATE(),
	DistrictID INT REFERENCES Districts(ID) NOT NULL,
	OrderTime DATETIME NOT NULL,
	CountOrders INT NOT NULL
);

CREATE TABLE Result
(
	ID INT PRIMARY KEY IDENTITY,
	DistrictID INT REFERENCES Districts(ID) NOT NULL,
	FirstTime DATETIME NOT NULL
);

INSERT INTO Districts (DisName) 
VALUES 
(N'Северный'),
(N'Южный'),
(N'Индустриальный'),
(N'Заречье')

DECLARE @count INT
SET @count = 1

WHILE @count < 500
BEGIN
	INSERT INTO Orders (Width, DistrictID, OrderTime)
	VALUES 
	(CAST(RAND() * (21 - 1) + 1 AS decimal(10,2)), 
	CAST(RAND() * 4 + 1 AS int), 
	DATEADD(HOUR, CAST(RAND() * 24 AS int), DATEADD(MINUTE, CAST(RAND() * 59 AS int) ,DATEADD(SECOND, CAST(RAND() * 59 AS int), '20241028 00:00:00'))))
	SET @count = @count + 1
END