/*
1.	What is a result set?
1) Result set is a set of data, could be empty or not, returned by a select statement, 
or a stored procedure, that is saved in RAM or displayed on the screen.
2) A TSQL script can have 0 to multiple result sets.

2.	What is the difference between Union and Union All?
1) Union removes the duplicated rows and Union All returns all the rows including duplicated rows.
2) Union returns the result more slowly than Union all.

3.	What are the other Set Operators SQL Server has?
INTERSECT, EXCEPT

4.	What is the difference between Union and Join?
Both joins and unions can be used to combine data from one or more tables into a single result. ... Whereas 
a join is used to combine columns from different tables, the union is used to combine rows.

5.	What is the difference between INNER JOIN and FULL JOIN?
Inner join returns only the matching rows between both the tables, non-matching rows are eliminated. 
Full Join returns all rows from both the tables (left & right tables), 
including non-matching rows from both the tables.

6.	What is difference between left join and outer join?
In a left join, all rows from the left table will be returned 
plus the rows that the right table had in common.
In an outer join, unmatched rows in one or both tables can be returned.

7.	What is cross join?
Create a Cartesiasn product for two tables

8.	What is the difference between WHERE clause and HAVING clause?
1) both used as filters, having applies only to groups as a whole, where applies to individual rows
2) where goes before aggregation, having after the aggregation
3) WHERE can be used with SELECT/UPDATE, HAVING only SELECT

9.	Can there be multiple group by columns?
Yes, there can.
*/

use AdventureWorks2019
go
--1.	How many products can you find in the Production.Product table?
select count(distinct Name)
from Production.Product

--2.	Write a query that retrieves the number of products in the Production.Product table 
--that are included in a subcategory. The rows that have NULL in 
--column ProductSubcategoryID are considered to not be a part of any subcategory.
select ProductSubcategoryID, count(ProductSubcategoryID) as NumberofProducts
from Production.Product
where ProductSubcategoryID is not null
group by ProductSubcategoryID

/*3.	How many Products reside in each SubCategory? 
Write a query to display the results with the following titles.
ProductSubcategoryID CountedProducts
-------------------- ---------------*/
select ProductSubcategoryID, count(*) as CountedProducts
from Production.Product
group by ProductSubcategoryID

--4.	How many products that do not have a product subcategory. 
select count(*)
from Production.Product
where ProductSubcategoryID is null

--5.	Write a query to list the sum of products quantity in the Production.ProductInventory table.
select sum(Quantity) as Sumofproductsquantity
from Production.ProductInventory

/*6.	 Write a query to list the sum of products in the Production.ProductInventory table 
and LocationID set to 40 and limit the result to include just summarized quantities less than 100.
              ProductID    TheSum
-----------        ----------*/
select ProductID, sum(quantity) as TheSum
from Production.ProductInventory
where LocationID = 40
group by ProductID
having sum(quantity) < 100

/*7.	Write a query to list the sum of products with the shelf information 
in the Production.ProductInventory table and LocationID set to 40 
and limit the result to include just summarized quantities less than 100
Shelf      ProductID    TheSum
---------- -----------        -----------*/
select Shelf, ProductID, sum(quantity) as TheSum
from Production.ProductInventory
where LocationID = 40
group by Shelf, ProductID
having sum(quantity) < 100

--8.	Write the query to list the average quantity for products 
--where column LocationID has the value of 10 from the table Production.ProductInventory table.
select ProductID, avg(quantity) as AverageQuantityforProducts
from Production.ProductInventory
where LocationID = 10
group by ProductID

/*9.	Write query  to see the average quantity  of  products by shelf  
from the table Production.ProductInventory
ProductID   Shelf      TheAvg
----------- ---------- -----------*/
select ProductID, shelf, avg(quantity) as TheAvg
from Production.ProductInventory
group by ProductID, Shelf

/*10.	Write query  to see the average quantity  of  products by shelf 
excluding rows that has the value of N/A in the column Shelf 
from the table Production.ProductInventory
ProductID   Shelf      TheAvg
----------- ---------- -----------*/
select ProductID, shelf, avg(quantity) as TheAvg
from Production.ProductInventory
where Shelf != 'N/A'
group by ProductID, Shelf

/*11.	List the members (rows) and average list price in the Production.Product table. 
This should be grouped independently over the Color and the Class column. 
Exclude the rows where Color or Class are null.
Color           	Class 	TheCount   	 AvgPrice
--------------	- ----- 	----------- 	---------------------*/
select Color, Class, count(ListPrice) as TheCount, avg(ListPrice) as avgPrice
from Production.Product
where color is not null and class is not null
group by color, class

/*Joins:
12.	  Write a query that lists the country and province names from person. CountryRegion 
and person. StateProvince tables. 
Join them and produce a result set similar to the following. 
Country                        Province
---------                          ----------------------*/
select pc.name as Country, ps.name as Province
from person. CountryRegion pc
join person. StateProvince ps on pc.CountryRegionCode = ps.CountryRegionCode

/*13.	Write a query that lists the country and province names from person. CountryRegion 
and person. StateProvince tables and list the countries filter them by Germany and Canada. 
Join them and produce a result set similar to the following.

Country                        Province
---------                          ----------------------*/
select pc.name as Country, ps.name as Province
from person. CountryRegion pc
join person. StateProvince ps on pc.CountryRegionCode = ps.CountryRegionCode
where pc.name in ('Germany', 'Canada')

/*       Using Northwnd Database: (Use aliases for all the Joins)
14.	List all Products that has been sold at least once in last 25 years.*/
use Northwind
go
select distinct od.productID
from Orders o
join [Order Details] od on o.orderID = od.orderID
where datediff(yy, o.orderdate, getdate()) <= 25

--15.	List top 5 locations (Zip Code) where the products sold most.
select top 5 c.PostalCode, sum(od.Quantity) as TheSum
from Customers c
join orders o on c.CustomerID = o.customerID
join [Order Details] od on o.Orderid = od.orderid
where c.PostalCode is not null
group by c.PostalCode
order by 2 desc

--16.	List top 5 locations (Zip Code) where the products sold most in last 25 years.
select top 5 c.PostalCode, sum(od.Quantity) as TheSum
from Customers c
join orders o on c.CustomerID = o.customerID
join [Order Details] od on o.Orderid = od.orderid
where datediff(yy, o.orderdate, getdate()) <= 25 and c.PostalCode is not null
group by c.PostalCode
order by 2 desc

--17.	 List all city names and number of customers in that city.   
select city, count(CustomerID) as NumberofCustomers
from Customers
group by city

--18.	List city names which have more than 2 customers, and number of customers in that city
select city, count(CustomerID) as NumberofCustomers
from Customers
group by city
having count(CustomerID) > 2

--19.	List the names of customers who placed orders after 1/1/98 with order date.
select distinct c.ContactName as NameofCustomers
from orders o 
join customers c on o.customerid = c.customerid
where o.orderdate > '1998-01-01'

--20.	List the names of all customers with most recent order dates 
select c.ContactName as Customers, max(o.orderdate) as MostRecentOrderDates
from orders o 
join customers c on o.customerid = c.customerid
group by c.ContactName

--21.	Display the names of all customers  along with the  count of products they bought 
select c.ContactName as Customers, sum(od.Quantity) as countofproducts
from Customers c 
join orders o on c.CustomerID = o.customerID
join [Order Details] od on o.orderID = od.orderID
group by c.ContactName

--22.	Display the customer ids who bought more than 100 Products with count of products.
select o.CustomerID
from orders o 
join [Order Details] od on o.orderid = od.orderid
group by o.customerid
having sum(od.quantity) > 100

/*23.	List all of the possible ways that suppliers can ship their products. 
Display the results as below
Supplier Company Name   	Shipping Company Name
---------------------------------            ----------------------------------*/
select Suppliers.CompanyName as [Supplier Company Name], 
Shippers.CompanyName as [Shipping Company Name]
from Suppliers
cross join Shippers

--24.	Display the products order each day. Show Order date and Product Name.
select o.OrderDate, p.ProductName
from orders o 
join [Order Details] od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID

--25.	Displays pairs of employees who have the same job title.
select e1.FirstName + ' ' + e1.LastName as Employee1, e2.FirstName + ' ' + e2.LastName as Employee2
from Employees e1 
join Employees e2 on e1.title = e2.title
where e1.EmployeeID != e2.EmployeeID

--26.	Display all the Managers who have more than 2 employees reporting to them.
select m.EmployeeID as Managers
from Employees m
join Employees e on m.EmployeeID = e.ReportsTo
group by m.EmployeeID
having count(m.EmployeeID) > 2

/*27.	Display the customers and suppliers by city. 
The results should have the following columns
City 
Name 
Contact Name,
Type (Customer or Supplier) */
select City, CompanyName as [Name], ContactName, 'Customer' as [Type]
from Customers
union
select City, CompanyName as [Name], ContactName, 'Supplier' as [Type]
from Suppliers

/*28. Have two tables T1 and T2
F1	F2
1	2
2	3
3	4
Please write a query to inner join these two tables and write down the result of this query.*/
create table T1(F1 int)
insert into T1 values (1), (2), (3)
create table T2(F2 int)
insert into T2 values (2), (3), (4)
select F1 
from T1
inner join T2 on T1.F1 = T2.F2
/* result
F1 F2
2  2
3  3
*/

/*29. Based on above two table, Please write a query to left outer join these two tables 
and write down the result of this query.*/
select * 
from T1
left outer join T2 on T1.F1 = T2.F2
/* result
F1  F2
1   NULL
2   2
3   3
*/
