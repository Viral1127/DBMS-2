--Lab 7 Cursor

-- Create Table
CREATE DATABASE Product_Info_Rollno

CREATE TABLE Product_Info
(
Product_id	Int	Primary Key,
Product_Name Varchar(250) Not Null,
Price Decimal(10,2)	Not Null
)
CREATE TABLE NewProducts
(
Product_id	Int	Primary Key,
Product_Name Varchar(250) Not Null,
Price Decimal(10,2)	Not Null
)
INSERT INTO Product_Info VALUES(1,'Smatphone',35000);
INSERT INTO Product_Info VALUES(2,'Laptop',65000);
INSERT INTO Product_Info VALUES(3,'Headphones',5500);
INSERT INTO Product_Info VALUES(4,'Television',85000);
INSERT INTO Product_Info VALUES(5,'Gaming Console',32000);


Select * From Product_Info
Select * From NewProducts


--PART - A

--1. Create a cursor Product_Cursor to fetch all the rows from a products table.

Declare @Product_id	Int,
		@Product_Name Varchar(250),
		@Price Decimal(10,2);

Declare Product_Cursor Cursor
For Select
		Product_id,
		Product_Name,
		Price
	From Product_Info

Open Product_Cursor

FETCH NEXT FROM Product_Cursor
INTO @Product_id, @Product_Name, @Price

While @@FETCH_STATUS = 0
Begin 
	Select
		@Product_id,
		@Product_Name,
		@Price;
	FETCH NEXT FROM Product_Cursor
	INTO @Product_id, @Product_Name, @Price
End

Close Product_Cursor

Deallocate Product_Cursor


--2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName.
--(Example: 1_Smartphone)

Declare @Product_id	Int,
		@Product_Name Varchar(250);

Declare Product_Cursor_Fetch Cursor
For Select
		Product_id,
		Product_Name
	From Product_info

Open Product_Cursor_Fetch

FETCH NEXT FROM Product_Cursor_Fetch
INTO @Product_id, @Product_Name

WHILE @@FETCH_STATUS = 0
Begin
	print CONCAT(@Product_id,'_',@Product_Name)
	FETCH NEXT FROM Product_Cursor_Fetch
	INTO @Product_id, @Product_Name
End

Close Product_Cursor_Fetch

Deallocate Product_Cursor_Fetch


--3. Create a cursor Product_CursorDelete that deletes all the data from the Products table.

Declare @Product_id	Int,
		@Product_Name Varchar(250),
		@Price Decimal(10,2);

Declare Product_CursorDelete Cursor
For Select
		Product_id
	From Product_info

Open Product_CursorDelete

FETCH NEXT FROM Product_CursorDelete
INTO @Product_id

While @@FETCH_STATUS = 0
Begin
	Delete From Product_Info Where Product_id = @Product_id
	FETCH NEXT FROM Product_CursorDelete INTO @Product_id
End

Close Product_CursorDelete

Deallocate Product_CursorDelete


--PART - B


--4. Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases
--the price by 10%.


Declare @Product_id	Int,
		@Price Decimal(10,2);

Declare Product_CursorUpdate Cursor
For Select
		Product_id,
		Price
	From Product_Info

Open Product_CursorUpdate

FETCH NEXT FROM Product_CursorUpdate
INTO @Product_id, @Price

While @@FETCH_STATUS = 0
Begin 
	Update Product_Info
	Set Price = @Price + (@Price)*0.1
	where Product_id = @Product_id
	FETCH NEXT FROM Product_CursorUpdate
	INTO @Product_id, @Price
End

Close Product_CursorUpdate

Deallocate Product_CursorUpdate


--PART - C

--5. Create a cursor to insert details of Products into the NewProducts table if the product is “Laptop” 
--(Note: Create NewProducts table first with same fields as Products table)


Declare @Product_id	Int,
		@Product_Name Varchar(250),
		@Price Decimal(10,2);

Declare NewProducts_Cursor Cursor
For Select
		Product_id,
		Product_Name,
		Price
	From Product_Info

Open NewProducts_Cursor

FETCH NEXT FROM NewProducts_Cursor
INTO @Product_id, @Product_Name, @Price

While @@FETCH_STATUS = 0
Begin 
	If @Product_Name = 'Laptop'
	Insert Into NewProducts
	Values(@Product_id, @Product_Name, @Price)

	FETCH NEXT FROM NewProducts_Cursor
	INTO @Product_id, @Product_Name, @Price
End

Close NewProducts_Cursor

Deallocate NewProducts_Cursor

