CREATE DATABASE Customer_Info_EXCEPTION_HANDLING

CREATE TABLE Customers(
Customer_id	Int	Primary Key,
Customer_Name	Varchar(250) Not Null,
Email Varchar(50) Unique)


CREATE TABLE Orders
(
Order_id	Int	Primary Key,
Customer_id	Int	REFERENCES Customers(Customer_id) ,
Order_date	date	Not Null
)


--Part – A
--1. Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error.

declare @a int
declare @b int
set @a = 10;
set @b = 0

begin try
	select @a/@b
end try
begin catch
	select 'Error occurs that is'+ ERROR_MESSAGE() as Error_msg
end catch

--2. Try to convert string to integer and handle the error using try…catch block.
declare @str as varchar(200);
begin try
	set @str = 'Viral'
	set @str = cast(@str as int)
end try
begin catch
	select 'Error occurs that is '+ ERROR_MESSAGE() as Error_msg
end catch
	
--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle 
--exception with all error functions if any one enters string value in numbers otherwise print result.

create proc pr_sum
	@b varchar(200),
	@a int
as
begin
	begin try
		print @a+@b
	end try
	begin catch
		select ERROR_NUMBER() as [error_num]
		select ERROR_SEVERITY() as [error_severity]
		select ERROR_PROCEDURE() as [error_procedure]
		select ERROR_MESSAGE() as [error_msg]
		select ERROR_LINE() as [error_line]
	end catch
end

exec pr_sum a,10

--4-. Handle a Primary Key Violation while inserting data into customers table and print the error details 
--such as the error message, error number, severity, and state.

create proc insert_customer_pk
@cust_id int,
@cust_name varchar(200),
@Email varchar(50)
as 
begin
	begin try
		insert into Customers 
		values(@cust_id , @cust_name , @Email)
	end try
	begin catch
		select ERROR_NUMBER() as [error_num]
		select ERROR_SEVERITY() as [error_severity]
		select ERROR_PROCEDURE() as [error_procedure]
		select ERROR_MESSAGE() as [error_msg]
		select ERROR_LINE() as [error_line]
	end catch
end 

exec insert_customer_pk 1,vc,chauhan
exec insert_customer_pk 1,viral,chauhan

--5. Throw custom exception using stored procedure which accepts Customer_id as input & that throws 
--Error like no Customer_id is available in database.

create proc custid_insert
	@cust_id int
as 
begin
	if exists(
		select * from Customers
		where Customer_id = @cust_id
		)
		print 'Customer_id is available in database.'
	else
		throw 50005 , 'Error!!! No Customer_id with this database' ,1
end

exec custid_insert 8
--Part – B
--6. Handle a Foreign Key Violation while inserting data into Orders table and print appropriate error 
--message.

alter proc insert_order
	@order_id int,
	@cust_id int,
	@order_date datetime
as 
begin
	begin try
		insert into Orders
		values(@order_id , @cust_id , @order_date)
	end try
	begin catch
		throw
	end catch
end

exec insert_order 8,5,25

--7. Throw custom exception that throws error if the data is invalid.
create proc customer_id_invalid
@cust_id int,
@cust_name varchar(200),
@Email varchar(50)
as 
begin
	if @cust_id>0
		insert into Customers
		values(@cust_id , @cust_name  ,@Email)
	else
		throw 50001 , 'Error!!!! Customer id cannot be negative' , 1
end 

exec customer_id_invalid -2 , 'vc' , 'chauhan'

--8. Create a procedure which prints the error message that “The Customer_id is already taken. Try another one”.

create proc customer_id_error
@cust_id int,
@cust_name varchar(200),
@Email varchar(50)
as 
begin
	begin try
		insert into Customers 
		values(@cust_id , @cust_name , @Email)
	end try
	begin catch
		select 'The Customer_id is already taken. Try another one' + ERROR_MESSAGE() as error_msg
	end catch
end

exec customer_id_error 1 , 'vc', 'chauhan'




