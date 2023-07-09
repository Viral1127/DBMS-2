-- CREATE DATABASE
CREATE DATABASE Worker_Info_ROLLNO

-- CREATE TABLE Department
CREATE TABLE Department(
DepartmentID Int Primary Key,
DepartmentName Varchar(100)	Not Null Unique)

-- CREATE TABLE Designation
CREATE TABLE Designation(
DesignationID Int Primary Key,
DesignationName	Varchar(100) Not Null Unique)

-- CREATE TABLE Person
CREATE TABLE Person(
WorkerID Int IDENTITY(101,1) PRIMARY KEY,
FirstName Varchar(100) Not Null,
LastName Varchar(100) Not Null,
Salary Decimal(8,2)	Not Null,
JoiningDate	Datetime Not Null,	
DepartmentID Int Null FOREIGN KEY REFERENCES Department(DepartmentID),
DesignationID Int Null FOREIGN KEY REFERENCES Designation(DesignationID))

------------Query-------------

--11(lab-4)
create function fn_firstnamewithb()
returns table
as 
return(select * from person where FirstName like 'b%')

select * from dbo.fn_firstnamewithb()


--12(lab-4). Write a function which returns a table with unique first names from person table.

create function fn_uniquefirstname()
returns table
as
return(select distinct firstname from person)

select * from dbo.fn_uniquefirstname()

--13(lab-4). Write a function which accepts department ID as a parameter & returns a detail of the persons.

create function fn_findfromdep(@departmentID int)
returns table
as
return(select * from person where departmentID = @departmentID)

select * from dbo.fn_findfromdep(2)


-------------------------------------------------------------------------------------------

--1. All tables Insert

create proc pr_insert_dep
	@departmentID int,
	@departmentName varchar(100)
as
begin
	insert into Department
	(
		DepartmentID,
		DepartmentName
	)
	values
	(
	@departmentID,
	@departmentName
	)
end

exec pr_insert_dep 1 ,'Admin'
exec pr_insert_dep 2 , 'IT'
exec pr_insert_dep 3 , 'HR'
exec pr_insert_dep 4, 'Account'

select * from Department
 

 ---------------------------------

 create proc pr_insert_designation
	@designationID int,
	@designationName varchar(100)
as
begin
	insert into Designation
	(
		designationID,
		DesignationName
	)
	values
	(
	@designationID,
	@designationName
	)
end

pr_insert_designation 11 , 'Jobber'
pr_insert_designation 12 , 'Welder'
pr_insert_designation 13 , 'Clerk'
pr_insert_designation 14 , 'Manager'
pr_insert_designation 15 , 'CEO'

select * from Designation

------------------------------------------

create procedure pr_insert_person
	@firstname varchar(100),
	@LastName Varchar (100),
	@Salary Decimal (8,2),
	@JoiningDate Datetime,
	@DepartmentID Int,
	@DesignationID Int 
 as 
 begin
	insert into Person
	(
	FirstName,
	LastName,
	Salary,
	JoiningDate,
	DepartmentID,
	DesignationID
	)

	values
	(
	@FirstName,
	@LastName,
	@Salary,
	@JoiningDate,
	@DepartmentID,
	@DesignationID
	)
end

exec pr_insert_person 'Rahul' , 'Anshu' , 56000 ,  '01-01-1990'  , 1 , 12
exec pr_insert_person 'Hardik' ,'Hinsu' ,18000 ,'25-sep-1990', 2, 11
exec pr_insert_person 'Bhavin', 'Kamani', 25000, '14-may-1991', NULL ,11
exec pr_insert_person 'Bhoomi', 'Patel', 39000, '20-feb-2014' ,1, 13
exec pr_insert_person 'Rohit' ,'Rajgor', 17000 ,'23-july-1990', 2, 15
exec pr_insert_person 'Priya', 'Mehta', 25000 ,'18-october-1990', 2 ,NULL
exec pr_insert_person 'Neha' ,'Trivedi', 18000, '20-feb-2014', 3, 15

select * from person

--------------------------------------------
--------------------------------------------

--2. All tables Update

create proc pr_update_person
	@workerID int,
	@firstname varchar(100),
	@LastName Varchar (100),
	@Salary Decimal (8,2),
	@JoiningDate Datetime,
	@DepartmentID Int,
	@DesignationID Int 
as
begin
	update person
	set

	FirstName = @FirstName,
	LastName = @Lastname,
	Salary = @Salary,
	JoiningDate = @JoiningDate,
	DepartmentID = @DepartmentID,
	DesignationID = @DesignationID

	where
	WorkerID = @WorkerID
end

-------------------------------------------------------------

create proc pr_upate_department
	@departmentID int,
	@departmentName varchar(100)
as
begin
	update Department

	set
	departmentName = @departmentName
	where 
	DepartmentID = @departmentID
end

exec pr_upate_department 2 , 'vc'

------------------------------------------------

create proc pr_upate_designation
	@designationID int,
	@designationName varchar(100)
as
begin
	update Designation

	set
	@designationName = @designationName
	where 
	DesignationID = @designationID
end

exec pr_upate_designation 13 , 'vc'

---------------------------------------------------
---------------------------------------------------

--3. All tables Delete

create proc pr_delete_department
	@departmentID int
as
begin
	delete Department
	where 
	departmentID = @departmentID
end

execute pr_delete_department 4

--------------------------------------------------

create proc pr_delete_designation
	@designationID int
as
begin
	delete Designation
	where 
	DesignationID = @designationID
end

pr_delete_designation 


