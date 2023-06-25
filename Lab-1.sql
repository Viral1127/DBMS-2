-- CREATE DEPARTMENT TABLE
CREATE TABLE Department(
DepartmentID Int Primary Key,
DepartmentName	Varchar (100) Not Null Unique,
DepartmentCode	Varchar (50) Not Null Unique,
Location Varchar (50) Not Null)

--INSERT DATA INTO DEPARTMENT
INSERT INTO Department VALUES(1,'Admin','Adm','A-Block')
INSERT INTO Department VALUES(2,'Computer','CE','C-Block')
INSERT INTO Department VALUES(3,'Civil','CI','G-Block')
INSERT INTO Department VALUES(4,'Electrical','EE','E-Block')
INSERT INTO Department VALUES(5,'Mechanical','ME','B-Block')

--CREATE Person TABLE
CREATE TABLE Person(
PersonID Int Primary Key,
PersonName Varchar(100) Not Null,
DepartmentID Int Null FOREIGN KEY REFERENCES Department(DepartmentID),
Salary Decimal(8,2) Not Null,
JoiningDate	Datetime Not Null,
City Varchar(100) Not Null)

-- INSERT DATA INTO PERSON
INSERT INTO Person VALUES(101,'Rahul Tripathi',2,56000,'01-01-2000','Rajkot')
INSERT INTO Person VALUES(102,'Hardik Pandya',3,18000,'25-sep-2001','Ahmedabad')
INSERT INTO Person VALUES(103,'Bhavin Kanani',4,25000,'14-may-2000','Baroda')
INSERT INTO Person VALUES(104,'Bhoomi Vaishnav',1,39000,'08-feb-2005','Rajkot')
INSERT INTO Person VALUES(105,'Rohit Topiya',2,17000,'23-jul-2001','Jamnagar')
INSERT INTO Person VALUES(106,'Priya Menpara',NULL,9000,'18-oct-2000','Ahmedabad')
INSERT INTO Person VALUES(107,'Neha Sharma',2,34000,'25-dec-2002','Rajkot')
INSERT INTO Person VALUES(108,'Nayan Goswami',3,25000,'01-jul-2001','Rajkot')
INSERT INTO Person VALUES(109,'Mehul Bhundiya',4,13500,'09-jan-2005','Baroda')
INSERT INTO Person VALUES(110,'Mohit Maru',5,14000,'25-may-2000','Jamnagar')

----------------------------Queries-------------------------------

--1. Find all persons with their department name & code.
	select 
	Person.PersonName,
	Department.DepartmentName,
	Department.DepartmentCode
	from Person inner join Department
	on Person.DepartmentID = Department.DepartmentID

--2. Find person's name whose department located in C-Block.
	select 
	Person.PersonName
	from Person inner join Department
	on Person.DepartmentID = Department.DepartmentID
	where Department.Location = 'C-Block'

--3. Retrieve person name, salary & department name who belongs to Jamnagar city.
	select
	Person.PersonName,
	Person.Salary,
	Department.DepartmentName
	from Person inner join Department
	on Person.DepartmentID = Department.DepartmentID
	where Person.City = 'Jamnagar'

--4. Retrieve person name, salary & department name who does not belongs to Rajkot city.
	select
	Person.PersonName,
	Person.Salary,
	Department.DepartmentName
	from Person inner join Department
	on Person.DepartmentID = Department.DepartmentID
	where Person.City <> 'Rajkot'

--5. Find detail of all persons who belongs Computer department.
	select 
	Person.PersonName
	from Person inner join Department
	on Person.DepartmentID = Department.DepartmentID
	where Department.DepartmentName = 'Computer'

--6. Find all persons who does not belongs to any department.
	select 
	Person.PersonName from person
	where DepartmentID is NULL

--7. Retrieve person’s name who joined Civil department after 1-Aug-2001.
	select
	Person.PersonName
	from Person inner join Department
	on Person.DepartmentID = Department.DepartmentID
	where Person.JoiningDate > '1-Aug-2001' and DepartmentName = 'Civil'

--8. Display all the person's name with department whose joining dates difference with current date is 
     --more than 365 days.
	select
	Person.PersonName,
	Department.DepartmentName
	from Person inner join Department
	on Person.DepartmentID = Department.DepartmentID
	where Datediff(day , Person.JoiningDate , getdate())>365

--9. Find department wise person counts.
	select 
	Department.DepartmentName,
	count(Person.PersonName) as Count
	from Person inner join Department
	on Person.DepartmentID = Department.DepartmentID
	group by Department.DepartmentName

--10. Give department wise maximum & minimum salary with department name.
	select 
	Department.DepartmentName,
	max(Person.Salary) as MaxSalary,
	min(Person.Salary) as MinSalary
	from Person inner join Department
	on Person.DepartmentID = Department.DepartmentID
	group by Department.DepartmentName
	
--11. Find city wise total, average, maximum and minimum salary.
	select city , max(salary) as maximum, min(salary) as minimum , avg(salary) as average from person
	group by city

--12. Find all departments whose total salary is exceeding 100000.
	select Department.DepartmentName 
	from person
	inner join Department
	on Person.departmentID = Department.DepartmentID
	Group by Department.DepartmentName
	having sum(salary) > 100000

--13. Find average salary of person who belongs to Ahmedabad city.
	select city , avg(salary) as average from person
	where city = 'Ahmedabad' 
	group by city
	
--14. List all departments who have no person.
	select Department.DepartmentName 
	from person
	inner join Department
	on Person.departmentID = Department.DepartmentID
	Group by Department.DepartmentName
	having count(personName) = 0

--15. List out department names in which more than two persons are working.
	select Department.DepartmentName from Person
	inner Join Department 
	on Person.departmentID = Department.DepartmentID
	Group by Department.DepartmentName
	having count(PersonID) > 2	

--16. Produce Output Like: <PersonName> lives in <City> and works in <DepartmentName> Department. (In 
      --single column)
	select Person.PersonName + ' Lives in ' + Person.City + ' and works in ' + Department.DepartmentName + ' Department '
	from person
	inner Join Department 
	on Person.departmentID = Department.DepartmentID

--17. Produce Output Like: <PersonName> earns <Salary> from department <DepartmentName> monthly. 
      --(In single column)
	select Person.PersonName + ' Earns ' + Person.Salary + ' from department ' + Department.DepartmentName + ' monthly '
	from person
	inner Join Department 
	on Person.departmentID = Department.DepartmentID

--18. Find city & department wise total, average & maximum salaries.
	select
	Person.City, 
	Department.DepartmentName,
	max(Person.Salary) as MaxSalary,
	sum(Person.Salary) as MinSalary,
	avg(person.salary) as average
	from Person inner join Department
	on Person.DepartmentID = Department.DepartmentID
	group by Department.DepartmentName ,Person.City

--19. Give 10% increment in Computer department employee’s salary. (Use Update