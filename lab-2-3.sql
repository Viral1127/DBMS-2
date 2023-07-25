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

------------Query-----------------------------

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
 

 ------------------------------------------

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

----------------------------------------------

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

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

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

------------------------------------------------------------------------------

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

-----------------------------------------------------------------------------

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

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

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

--------------------------------------------------------------------------------

create proc pr_delete_designation
	@designationID int
as
begin
	delete Designation
	where 
	DesignationID = @designationID
end

pr_delete_designation 

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--4 All tables SelectPK
CREATE PROC sp_SELECTDEPT
@DEPARTMENTID INT
AS
BEGIN
SELECT DepartmentName FROM Department
where DepartmentID = @DEPARTMENTID
end

exec sp_SELECTDEPT 3

--------------------------------------------------------------------------------

create proc sp_selectdesig
@designationID int
as
begin
select DesignationName from Designation
where DesignationID = @designationID
end

exec sp_selectdesig 11

---------------------------------------------------------------------------------

create proc sp_selectperson
@personID int
as
begin
select WorkerID , FirstName , LastName , Salary,JoiningDate,DepartmentID,DesignationID from person
where WorkerID = @personID
end

exec sp_selectperson 103

------------------------------------------------------------------------------------
--5. All tables SelectAll (If foreign key is available than do write join and take columns on select list

create proc Sp_SelectAllTables
as
begin
select 
	Person.WorkerID,
	Person.FirstName,
	Person.LastName,
	Person.Salary,
	Person.JoiningDate,
	Department.DepartmentName,
	Designation.DesignationName
from person
left outer join Department
on person.DepartmentID = Department.DepartmentID 
left outer join Designation
on person.DesignationID = Designation.DesignationID
end

Sp_SelectAllTables


----------------------------------------------------------------------------------------
-------------------------LAB-3----------------------------------------------------------

--1. Create Procedure that show detail of first 3 persons.
create proc sp_SelectPersonDetails
as
begin
select 
	top 3
	Person.WorkerID,
	Person.FirstName,
	Person.LastName,
	Person.Salary,
	Person.JoiningDate,
	Department.DepartmentName,
	Designation.DesignationName
from person
left outer join Department
on person.DepartmentID = Department.DepartmentID 
left outer join Designation
on person.DesignationID = Designation.DesignationID
end

sp_SelectPersonDetails

--2. Create Procedure that takes department dame as input and returns a table with all workers working in 
--that department.

create proc sp_AllWorkerInDept
@DepartmentName varchar(100)
as
begin
	select
	Department.DepartmentName,
	person.FirstName,
	Person.LastName
	from person
	left outer join Department
	on Person.DepartmentID = Department.DepartmentID
	where Department.DepartmentName = @DepartmentName
end
sp_AllWorkerInDept HR

--3. Create Procedure that takes department name & designation name as input and returns a table with 
--worker’s first name, salary, joining date & department name.
create proc sp_WorkerDetails
@DepartmentName varchar(100),
@DesignationName varchar(100)
as
begin
	select
	Department.DepartmentName,
	Designation.DesignationName,
	person.FirstName,
	Person.Salary,
	Person.JoiningDate
	from person
	left outer join Department
	on Person.DepartmentID = Department.DepartmentID
	left outer join Designation
	on person.DesignationID = Designation.DesignationID
	where Department.DepartmentName = @DepartmentName
	and Designation.DesignationName = @DesignationName
end
sp_WorkerDetails HR , Jobber

--4. Create Procedure that takes first name as an input parameter and display all the details of the worker 
--with their department & designation name.
create proc Sp_InputFirstName
@Firstname varchar(100)
as
begin
select 
	Person.WorkerID,
	Person.FirstName,
	Person.LastName,
	Person.Salary,
	Person.JoiningDate,
	Department.DepartmentName,
	Designation.DesignationName
from person
left outer join Department
on person.DepartmentID = Department.DepartmentID 
left outer join Designation
on person.DesignationID = Designation.DesignationID
where FirstName = @Firstname
end

Sp_InputFirstName Hardik

--5. Create Procedure which displays department wise maximum, minimum & total salaries.
create proc sp_DepartmentWiseMax
as
begin
select
	Department.DepartmentName,
	max(Person.Salary) as Maximum,
	min(Person.Salary)as Minimum,
	sum(Person.Salary) as Total
	from person
	inner join Department
	on Person.DepartmentID = Department.DepartmentID
	group by Department.DepartmentName
end

sp_DepartmentWiseMax

--6. Create Procedure which displays designation wise maximum, minimum & total salaries.
create proc sp_DesignationWiseMax
as
begin
select
	Designation.DesignationName,
	max(Person.Salary) as Maximum,
	min(Person.Salary)as Minimum,
	sum(Person.Salary) as Total
	from person
	inner join Designation
	on Person.DesignationID = Designation.DesignationID
	group by Designation.DesignationName
end

sp_DesignationWiseMax

