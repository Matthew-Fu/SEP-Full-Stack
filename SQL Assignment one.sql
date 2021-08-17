use AdventureWorks2019
go
--1.	Write a query that retrieves the columns ProductID, Name, Color 
--and ListPrice from the Production.Product table, with no filter. 
select ProductID, Name, Color, ListPrice
from Production.Product

--2.	Write a query that retrieves the columns ProductID, Name, Color and ListPrice 
--from the Production.Product table, exclude the rows that are 0 for the column ListPrice
select ProductID, Name, Color, ListPrice
from Production.Product
where ListPrice != 0

--3.	Write a query that retrieves the columns ProductID, Name, Color and ListPrice from 
--the Production.Product table, the rows that are rows that are NULL for the Color column.
select ProductID, Name, Color, ListPrice
from Production.Product
where Color is null

--4.	Write a query that retrieves the columns ProductID, Name, Color and ListPrice from 
--the Production.Product table, the rows that are not NULL for the Color column.
select ProductID, Name, Color, ListPrice
from Production.Product
where Color is not null

--5.	Write a query that retrieves the columns ProductID, Name, Color and ListPrice 
--from the Production.Product table, the rows that are not NULL for the column Color, 
--and the column ListPrice has a value greater than zero.
select ProductID, Name, Color, ListPrice
from Production.Product
where Color is not null and ListPrice > 0

--6.	Generate a report that concatenates the columns Name and Color 
--from the Production.Product table by excluding the rows that are null for color.
select Name + ' ' + color as [Name and Color]
from Production.Product
where Color is not null

/*7.	Write a query that generates the following result set  from Production.Product:
Name And Color
--------------------------------------------------
NAME: LL Crankarm  --  COLOR: Black
NAME: ML Crankarm  --  COLOR: Black
NAME: HL Crankarm  --  COLOR: Black
NAME: Chainring Bolts  --  COLOR: Silver
NAME: Chainring Nut  --  COLOR: Silver
NAME: Chainring  --  COLOR: Black
    ………*/
select 'Name: ' + Name + '  --  ' + 'COLOR: ' + Color as [Name And Color]
from Production.Product
where Color is not null

--8.	Write a query to retrieve the to the columns ProductID and Name 
--from the Production.Product table filtered by ProductID from 400 to 500
select ProductID, Name
from Production.Product
where ProductID between 400 and 500

--9.	Write a query to retrieve the to the columns  ProductID, Name and color 
--from the Production.Product table restricted to the colors black and blue
select ProductID, Name, Color
from Production.Product
where ProductID between 400 and 500

--10.	Write a query to generate a report on products that begins with the letter S. 
select Name
from Production.Product
where Name like 'S%'

/*11.	Write a query that retrieves the columns Name and ListPrice 
from the Production.Product table. Your result set should look something like the following. 
Order the result set by the Name column. 
 
Name                                               ListPrice
-------------------------------------------------- -----------
Seat Lug                                           0,00
Seat Post                                          0,00
Seat Stays                                         0,00
Seat Tube                                          0,00
Short-Sleeve Classic Jersey, L                     53,99
Short-Sleeve Classic Jersey, M                     53,99*/
select Name, ListPrice
from Production.Product
where Name like 'S%'
order by Name
 
/*12.	 Write a query that retrieves the columns Name and ListPrice 
from the Production.Product table. Your result set should look something like the following.
Order the result set by the Name column. 
The products name should start with either 'A' or 'S'
 
Name                                               ListPrice
-------------------------------------------------- ----------
Adjustable Race                                    0,00
All-Purpose Bike Stand                             159,00
AWC Logo Cap                                       8,99
Seat Lug                                           0,00
Seat Post                                          0,00 
               ………*/
select Name, ListPrice
from Production.Product
where Name like '[A, S]%'
order by Name

--13.	Write a query so you retrieve rows that have a Name that begins with the letters SPO, 
--but is then not followed by the letter K. After this zero or more letters can exists. 
--Order the result set by the Name column.
select Name
from Production.Product
where Name like 'SPO[^K]%'
order by Name

--14.	Write a query that retrieves unique colors from the table Production.Product. 
--Order the results  in descending  manner (how to understand unique colors?)
select distinct Color
from Production.Product
order by Color desc

select Color
from Production.Product
group by color
having count(color) = 1
order by Color desc

--15.	Write a query that retrieves the unique combination of columns ProductSubcategoryID 
--and Color from the Production.Product table. 
--Format and sort so the result set accordingly to the following. 
--We do not want any rows that are NULL.in any of the two columns in the result.
select distinct (str(ProductSubcategoryID) + ' ' + Color) as [ID and Color]
from Production.Product
where ProductSubcategoryID is not null and Color is not null

/*16.	Something is “wrong” with the WHERE clause in the following query. 
We do not want any Red or Black products from any SubCategory than 
those with the value of 1 in column ProductSubCategoryID, 
unless they cost between 1000 and 2000.
Note:
The LEFT() function will be covered in a forthcoming module.
SELECT ProductSubCategoryID
      , LEFT([Name],35) AS [Name]
      , Color, ListPrice 
FROM Production.Product
WHERE Color IN ('Red','Black') 
      OR ListPrice BETWEEN 1000 AND 2000 
      AND ProductSubCategoryID = 1
ORDER BY ProductID  */

SELECT ProductSubCategoryID
      , LEFT([Name],35) AS [Name]
      , Color, ListPrice 
FROM Production.Product
WHERE Color not IN ('Red','Black') 
      OR ProductSubCategoryID = 1
      OR ListPrice BETWEEN 1000 AND 2000
ORDER BY ProductID


