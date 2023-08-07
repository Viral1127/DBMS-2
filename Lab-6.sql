CREATE TABLE Person(
PersonID Int Primary Key,
PersonName Varchar(100) Not Null,
Salary Decimal(8,2)	Not Null,
JoiningDate	Datetime Not Null,
City Varchar(100) Not Null,
Age	Int	Null,
BirthDate Datetime Not Null
)

CREATE TABLE PersonLog(
PLogID	Int	Primary Key Identity(1,1), 
PersonID Int Not Null,
PersonName Varchar(250)	Not Null,
Operation Varchar(50) Not Null,
UpdateDate Datetime	Not Null)


--------------------------------------------------------Queries--------------------------------------

--1. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the Person table to display a message “Record is Affected.”

create trigger tr_person_InsertUpdateDelete
on person
after insert , update , delete
as 
begin
 print('record is affected')
 end

insert into person
values(102,'viral',300000,'2023-11-27','rajkot',19,'2004-11-27')


insert into person
values(103,'viral',300000,'2023-11-27','rajkot',19,'2004-11-27')

update person
set PersonID = 104
where PersonID = 103

---------------------------------------------------------------------------------------------
--2. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the Person table. For that, log all operations performed on the person table into PersonLog.

create trigger tr_person_insert
on person
after insert
as 
begin
	declare @personid as int
	declare @personname as varchar(300)

	select @personid = personid from inserted
	select @personname = personname from inserted

	insert into PersonLog values(@personid , @personname , 'Insert' , cast(getdate() as varchar(50)))                                                                                                                                                                                                                                                                                                                         
end

insert into person values(11,'vc',3000,'2023-12-27','rajkot',19,'2004-11-27')

select * from PersonLog

-----------------------------------------------------------------------------------------------------------

alter trigger tr_person_update
on person
after update
as 
begin
	declare @personid as int
	declare @personname as varchar(300)

	select @personid = personid from inserted
	select @personname = personname from inserted

	insert into PersonLog values(@personid , @personname , 'delete' , cast(getdate() as varchar(50)))                                                                                                                                                                                                                                                                                                                         
end

update person 
set PersonName = 'viral'
where PersonID = 11

select * from PersonLog

-----------------------------------------------------------------------------------------------------------
create trigger tr_person_delete1
on person
after delete
as 
begin
	declare @personid as int
	declare @personname as varchar(300)

	select @personid = personid from deleted
	select @personname = personname from deleted

	insert into PersonLog values(@personid , @personname , 'delete' , cast(getdate() as varchar(50)))                                                                                                                                                                                                                                                                                                                         
end

delete person
where PersonID = 11

select * from PersonLog

----------------------------------------------------------------------------------------------------------

--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Person table. For that, log all operations performed on the person table into PersonLog.

create trigger tr_person_insertInsteadOf
on person
instead of insert
as 
begin
	declare @personid as int
	declare @personname as varchar(300)

	select @personid = personid from inserted
	select @personname = personname from inserted

	insert into PersonLog values(@personid , @personname , 'Insert' , cast(getdate() as varchar(50)))                                                                                                                                                                                                                                                                                                                         
end

insert into person values(12,'mayur',2000,'2023-12-27','rajkot',21,'2004-11-27')

select * from person

select * from PersonLog

--------------------------------------------------------------------------------------------------------------------

create trigger tr_person_updateInsteadOf
on person
instead of update
as 
begin
	declare @personid as int
	declare @personname as varchar(300)

	select @personid = personid from inserted
	select @personname = personname from inserted

	insert into PersonLog values(@personid , @personname , 'delete' , cast(getdate() as varchar(50)))                                                                                                                                                                                                                                                                                                                         
end

update person 
set PersonName = 'deep'
where PersonID = 102

select * from person

select * from PersonLog

-----------------------------------------------------------------------------------------------------------------

create trigger tr_person_deleteInsteadOf
on person
instead of delete
as 
begin
	declare @personid as int
	declare @personname as varchar(300)

	select @personid = personid from deleted
	select @personname = personname from deleted

	insert into PersonLog values(@personid , @personname , 'delete' , cast(getdate() as varchar(50)))                                                                                                                                                                                                                                                                                                                         
end

delete person
where PersonID = 102

select * from PersonLog

-------------------------------------------------------------------------------------------------------------------------

drop trigger tr_person_InsertUpdateDelete
drop trigger tr_person_insert
drop trigger tr_person_update
drop trigger tr_person_delete1
drop trigger tr_person_insertInsteadOf
drop trigger tr_person_updateInsteadOf
drop trigger tr_person_deleteInsteadOf

--4. Create a trigger that fires on INSERT operation on the Person table to convert person name into uppercase whenever the record is inserted.

create trigger tr_insert_Uppercase
on person
after insert
as 
begin
	declare @upper as varchar(200)
	declare @personid as int

	select @upper = personname from inserted
	select @personid = personid from inserted

	update person
	set PersonName = UPPER(@upper)
	where PersonID = @personid
end

insert into person values(12,'mayur',2000,'2023-12-27','rajkot',21,'2004-11-27')

select * from person

-----------------------------------------------------------------------------------------
--5. Create a trigger that fires on INSERT operation on person table, which calculates the age and update that age in Person table.

create trigger tr_insert_calculatAge
on person
after insert
as
begin
	declare @date as datetime
	declare @personid as int

	select @date = BirthDate from inserted
	select @personid = personid from inserted

	update person
	set age = convert(int , DATEDIFF(year ,@date , getdate()))
	where personid = @personid
end


insert into person values(105 , 'viral' , 250000 , '2023-4-14' , 'jnd' , 45 , '2004-11-27')

select * from person

-------------------------------------------------------------------------------------------------------------------------
--6. Create DELETE trigger on PersonLog table, when we delete any record of PersonLog table it prints ‘Record deleted successfully from PersonLog’.

create trigger tr_person_delete
on person
after delete
as 
begin
	PRINT('Record deleted successfully from PersonLog')                                                                                                                                                                                                                                                                                                                        
end
