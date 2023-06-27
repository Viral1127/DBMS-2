--1. Write a function to print "hello world".
alter Function Fn_helloWorld()
returns varchar(20)
as
begin
	declare @s as varchar(50)
	set @s = 'hello world'
	return @s
end

select dbo.Fn_helloWorld()


--2. Write a function which returns addition of two numbers.

create function fun_addition(@a int , @b int)
returns int
as 
begin
	return @a+@b
end
select dbo.fun_addition(1,1)


--3. Write a function to print cube of given number.

create function fn_cube(@a int)
returns int
as
begin
	return @a*@a*@a
end

select dbo.fn_cube(3)

--4. Write a function to check where given number is ODD or EVEN.
create function fn_OddEven(@a int)
returns varchar(20)
as
begin
declare @str as varchar(50)
if(@a%2=0)
		set @str = 'even'
	else
		set @str = 'odd'
		return @str
end

select dbo.fn_OddEven(5)

--extra
create function fn_PosNeg(@a int)
returns varchar(20)
as
begin
declare @str as varchar(50)
if(@a>0)
		set @str = 'positive'
	else if(@a=0)
		set @str = 'zero'
	else
		set @str = 'negative'
		return @str
end

select dbo.fn_PosNeg(5)

--5. Write a function to compare two integers and returns the comparison result. (Using Case statement)
alter function fn_Compare(@a int , @b int)
returns varchar(20)
as
begin
	return(
	case
		when(@a>@b) then (' a is big')
		when(@a<@b) then ('b is big')
		else 'a=b'
		end
	)
end

select dbo.fn_Compare(2,3)

--6. Write a function to print number from 1 to N. (Using while loop)
	alter function fn_Number(@n int)
	returns varchar(100)
	as 
	begin
		declare @i as int
		set @i = 1
		declare @str as varchar(50)
		set @str = ''

		while @i <= @n
		begin
			set @str = concat(@str,'',cast(@i as varchar))
			set @i = @i+1
			
		end			
		return @str
end		

select dbo.fn_Number(5)

--7. Write a function to print sum of even numbers between 1 to 20.
alter function fn_sum()
returns int
as 
begin
		declare @n as int
		set @n = 20
		declare @i as int
		set @i = 1
		declare @sum as int
		set @sum = 0
		while @i <= @n
		begin
			if @i%2=0
			begin
				set @sum = @sum + @i
			end
			set @i = @i+1
		end			
		return @sum
end

select dbo.fn_sum()

--8. Write a function to check weather given number is prime or not.

	alter function fn_Prime(@n int)
	returns varchar(100)
	as 
	begin
		declare @i as int
		set @i = 2
		declare @count as int
		set @count = 0
		declare @str as varchar(50)
			while @i<=@n
				begin
					if @n%@i=0
					set @count = @count + 1
					set @i = @i + 1
				end
		if @count = 1
		set @str = 'Prime'
		else
		set @str ='not prime'
		return @str
	end

select dbo.fn_Prime(3)
	
--9. Write a function which accepts two parameters start date & end date, and returns a difference in days.
	create function fn_Datediff(@startdate as datetime , @enddate as datetime)
	returns datetime
	as 
	begin
		return datediff(day,@startdate,@enddate)
	end

	select dbo.fn_Datediff()

--10. Write a function which accepts year & month in integer and returns total days in given month & year.