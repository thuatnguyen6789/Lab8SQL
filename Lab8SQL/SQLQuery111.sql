CREATE DATABASE BookInfo
GO

USE BookInfo
GO

CREATE TABLE Customer(
CustomerID int PRIMARY KEY IDENTITY(11, 10),
CustomerName varchar(50),
Address varchar(100),
Phone varchar(12)
)
GO

INSERT INTO Customer(CustomerName, Address, Phone) VALUES('NGUYEN HUY THUAT', 'PHUNG KHOANG HA NOI', 987995271);
INSERT INTO Customer(CustomerName, Address, Phone) VALUES('NGO THI THAO', 'CAM VAN HAI DUONG', 961770326);
INSERT INTO Customer(CustomerName, Address, Phone) VALUES('MYLA NGUYEN', 'TAN HUNG HAI DUONG', 999888777);
INSERT INTO Customer(CustomerName, Address, Phone) VALUES('MYLO NGUYEN', 'SYDNEY AUSTRALIA', 999000999);
INSERT INTO Customer(CustomerName, Address, Phone) VALUES('MINI NGUYEN', 'NEW YORK AMERICA', 999111999);
GO

SELECT * FROM Customer
GO

DROP TABLE Customer
GO

CREATE TABLE Book(
BookCode int,
Category varchar(50),
Author varchar(50),
Publisher varchar(50),
Title varchar(100),
Price int,
InStore int
)
GO

INSERT INTO Book(BookCode, Category, Author, Publisher, Title, Price, InStore) VALUES(111, 'TRUYEN NGAN', 'KIM LAN', 'KIM DONG', 'VO NHAT', 15, 5);
INSERT INTO Book(BookCode, Category, Author, Publisher, Title, Price, InStore) VALUES(222, 'KINH TE', 'PHAM NHAT VUONG', 'HA NOI', 'NGUOI THANH CONG', 100, 1);
INSERT INTO Book(BookCode, Category, Author, Publisher, Title, Price, InStore) VALUES(333, 'XA HOI', 'VU DUC DAM', 'HAI DUONG', 'DICH COVID', 20, 2);
INSERT INTO Book(BookCode, Category, Author, Publisher, Title, Price, InStore) VALUES(444, 'CHINH TRI', 'NGUYEN PHU TRONG', 'QUOC HOI', 'DAI HOI DANG XIII', 35, 6);
INSERT INTO Book(BookCode, Category, Author, Publisher, Title, Price, InStore) VALUES(555, 'DIEN ANH', 'DUC THINH', 'SAI GON', 'TIEC TRANG MAU', 54, 9);
GO

SELECT * FROM Book
GO

CREATE TABLE BookSold(
BookSoldID int PRIMARY KEY,
CustomerID int,
BookCode int,
Date datetime,
Price int,
Amount int,
CONSTRAINT fk FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
CONSTRAINT sk FOREIGN KEY (BookCode) REFERENCES Book(BookCode)
)
GO

DROP TABLE BookSold
GO

