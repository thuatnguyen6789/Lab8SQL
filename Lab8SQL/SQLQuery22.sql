--Tao mot CSDL co ten la Lab11
CREATE DATABASE Lab11
GO 

USE Lab11 
GO

--Tao mot khung nhin co ten la ProductList, khung nhin nay su dung cac cot ProductID va Name cua bang Production.Product cua CSDL AdventureWorks.
CREATE VIEW ProductList
AS
	SELECT ProductID, Name FROM AdventureWorks2019.Production.Product

--Su dung khung nhin vua tao bang mot cau lenh truy van don gian
SELECT * FROM ProductList
GO

--Nhan xet: Ta co the truy cap den du lieu cua bang Production.Product cua CSDL AdventureWorks thong qua khung nhin ProductList

CREATE VIEW SalesOrderDetail
AS
	SELECT pr.ProductID, pr.Name, od.UnitPrice, od.OrderQty,
od.UnitPrice*od.OrderQty as [Total Price]
	FROM AdventureWorks2019.Sales.SalesOrderDetail od
	JOIN AdventureWorks2019.Production.Product pr
	ON od.ProductID=pr.ProductID

SELECT * FROM SalesOrderDetail
GO

--Code theo hinh

--Tao khung nhin lay ra thong tin co ban trong bang Person.Contact
USE AdventureWorks2019
GO

CREATE VIEW V_Contact_Info AS
SELECT FirstName, MiddleName, LastName
FROM Person.Person
GO

--Tao khung nhin lay ra thong tin nhan vien
CREATE VIEW V_Employee_Contact AS
SELECT p.FirstName, p.LastName, e.BusinessEntityID, e.HireDate
FROM HumanResources.Employee e
JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID;
GO

--Xem mot khung nhin
SELECT * FROM V_Employee_Contact
GO

--Thay doi khung nhin V_Employee_Contact bang cach viet them cot Birthdate
ALTER VIEW V_Employee_Contact AS
SELECT p.FirstName, p.LastName, e.BusinessEntityID, e.HireDate, e.Birthdate
FROM HumanResources.Employee e
JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID
WHERE p.FirstName like '%B%';
GO

--Xoa mot khung nhin
DROP VIEW V_Contact_Info
GO

--Xem dinh nghia khung nhin V_Employee_Contact
EXECUTE sp_helptext 'V_Employee_Contact'
GO

--Xem cac thanh phan ma khung nhin phu thuoc
EXECUTE sp_depends 'V_Employee_Contact'
GO

--Tao khung nhin an ma dinh nghia bi an di (khong xem duoc dinh nghia khung nhin)
CREATE VIEW OrderRejects
WITH ENCRYPTION
AS
SELECT PurchaseOrderID, ReceivedQty, RejectedQty,
	RejectedQty / ReceivedQty AS RejectRatio, DueDate
FROM Purchasing.PurchaseOrderDetail
WHERE RejectedQty / ReceivedQty > 0
AND DueDate > CONVERT(DATETIME, '20010630', 101);

--Khong xem duoc dinh nghia khung nhin V_Contact_Info
sp_helptext 'OrderRejects'
GO

--Thay doi khung nhin them tuy chon CHECK OPTION
ALTER VIEW V_Employee_Contact AS
SELECT p.FirstName, p.LastName, e.BusinessEntityID, e.HireDate
FROM HumanResources.Employee e
JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID
WHERE p.FirstName like 'A%'
WITH CHECK OPTION
GO

SELECT * FROM V_Employee_Contact

--Cap nhat duoc khung nhin khi FirstName bat dau bang ki ty 'A'
UPDATE V_Employee_Contact SET FirstName='Atest' WHERE LastName='Amy'

--Khong cap nhat duoc khung nhin khi FirstName bat dau bang ky tu khac 'A'
UPDATE V_Employee_Contact SET FirstName='BCD' WHERE LastName='Atest'
GO

--Phai xoa khung nhin truoc
DROP VIEW V_Contact_Info
GO

--Tao khung nhin co gian do
CREATE VIEW V_Contact_Info WITH SCHEMABINDING AS
SELECT FirstName, MiddleName, LastName, EmailAddress
FROM Person.Contact
GO

--Khong the truy van duoc khung nhin co ten la V_Contact_Info
SELECT * FROM V_Contact_Info
GO

--Tao chi muc duy nhat tren cot EmailAddress tren khung nhin V_Contact_Info
CREATE UNIQUE CLUSTERED INDEX IX_Contact_Email
ON V_Contact_Info(EmailAddress)
GO

--Thuc hien doi ten khung nhin
EXEC sp_rename V_Contact_Info, V_Contact_Infomation

--Truy van khung nhin
SELECT * FROM V_Contact_Infomation

--Khong the them ban ghi vao khung nhin
--Vi co cot khong cho phep NULL trong bang Contact
INSERT INTO V_Contact_Infomation VALUES ('ABC', 'DEF', 'GHI', 'abc@yahoo.com')

--Khong the xoa ban ghi cua khung nhin V_Contact_Infomation
--Vi bang Person.Contact con co cac khoa ngoai
DELETE FROM V_Contact_Infomation WHERE LastName='Gilbert' and FirstName='Guy'

