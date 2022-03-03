use northwind2;

#1 
SELECT * FROM SHIPPERS;

#2
Select CategoryName , Description from Categories ;

#3
Select FirstName, LastName, HireDate from employees where Title = 'Sales Representative';

#4
Select FirstName, LastName, HireDate from employees where Title = 'Sales Representative' and Country ='USA';

#5
select OrderID, orderdate from orders where EmployeeID = 5;

#6
select  SupplierID, ContactName, ContactTitle from Suppliers where ContactTitle <> 'Marketing Manager';

#7
select ProductID, ProductName from products where ProductName like '%queso%';

#8
select OrderID, CustomerID, ShipCountry from Orders where ShipCountry = 'France' or ShipCountry = 'Belgium';

#9
select OrderID, CustomerID, ShipCountry from Orders where ShipCountry in ( 'Brazil', 'Mexico', 'Argentina', 'Venezuela');

#10
select  FirstName, LastName, Title, BirthDate from Employees order by BirthDate;

#11
select  FirstName, LastName, Title, date(BirthDate) as  DateOnlyBirthDate  from Employees order by BirthDate;

#12
select  FirstName, LastName, concat(FirstName," ", LastName) as FullName from Employees;

#13
select  OrderID, ProductID, UnitPrice, Quantity , (UnitPrice * Quantity) as TotalPrice from OrderDetails order by  OrderID , ProductID;

#14
select count(1) from customers;

#15
select min(OrderDate) from orders;
select OrderDate from orders where OrderDate = (select min(OrderDate) from orders);

#16
select country from customers group by country order by country;
select distinct country from customers order by country;
#17
select ContactTitle, count(ContactTitle) as total from customers group by ContactTitle; 
select ContactTitle, count(1) as TotalContactTitle from customers group by ContactTitle order by TotalContactTitle desc;

#18
select ProductID, ProductName, CompanyName from products a, suppliers b where a.supplierid = b.supplierid order by ProductID;
select ProductID,ProductName,CompanyName
from products
join suppliers
on products.SupplierID=suppliers.SupplierID
order by ProductID;

#19
select OrderID, OrderDate, CompanyName from Shippers a, Orders b where a.shipperid = b.shipvia and OrderID < 10300 order by OrderID;
select OrderID, date(OrderDate), CompanyName
from orders
join shippers
on orders.Shipvia=shippers.ShipperID
where orderid<10300
order by orderid;

#20
select CategoryName, count(productid) as TotalProducts from products a, categories b where a.categoryid = b.categoryid group by categoryname order by TotalProducts desc;

#21
select country, city, count(customerid) as TotalCustomers from customers group by country, city order by TotalCustomers desc;

#22
select productid, productname, UnitsInStock, ReorderLevel from products where UnitsInStock < ReorderLevel order by productid;

#23
select productid, productname, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued from products 
where (UnitsInStock + UnitsOnOrder)  <= ReorderLevel and Discontinued = 0 order by productid;

#24
select customerid, companyname, region from customers order by region IS NULL, region, CustomerID ;
#select customerid, companyname, region case  when region is null then 1 else 0 end from customers;
#25
select shipcountry, avg(Freight) as averagefreight from orders group by shipcountry order by averagefreight desc limit 0,3;

#26
select shipcountry, avg(Freight) as averagefreight from orders where year(OrderDate) = 2015 group by shipcountry order by averagefreight desc limit 0,3;

#28
select max(OrderDate) from orders;
select shipcountry, avg(Freight) as averagefreight from orders where TIMESTAMPDIFF(MONTH,OrderDate, '2016-05-06 18:00:00') <12 group by shipcountry order by averagefreight desc limit 0,3;

#29
select EmployeeID, LastName, ProductName, OrderID, Quantity 
from orderdetails a
 join  products c on  a.productid= c.productid 
 join orders b  on a.orderid=b.orderid 
 join employees d on b.EmployeeID = d.EmployeeID;
select d.employeeid, lastname, a.orderid, productname, quantity from orderdetails a, orders b, products c , employees d
where a.OrderID = b.OrderID and a.ProductID = c.ProductID and b.EmployeeID = d.EmployeeID
order by a.orderid, a.productid;

select count(*) from orderdetails a, orders b, products c , employees d
where a.OrderID = b.OrderID and a.ProductID = c.ProductID and b.EmployeeID = d.EmployeeID
order by a.orderid, a.productid;

#30
select a.customerid, b.OrderID
from customers a left join orders b on a.CustomerID = b.CustomerID;
select * from 
(select a.customerid, b.OrderID
from customers a left join orders b on a.CustomerID = b.CustomerID) t
where orderid is null;

#31
select customerid from customers where customerid not in 
(select customerid from orders where EmployeeID = 4) ;

#32
select a.CustomerId, CompanyName, b.OrderID, sum(UnitPrice * Quantity) as TotalOrderAmount
from customers a, orders b, orderdetails c
where a.CustomerID = b.CustomerID and b.OrderID = c.OrderID and year(OrderDate) = 2016
group by CustomerId, CompanyName, OrderID
having TotalOrderAmount >= 10000 
order by TotalOrderAmount desc;

#33
select a.CustomerId, CompanyName, sum(UnitPrice * Quantity) as TotalOrderAmount
from customers a, orders b, orderdetails c
where a.CustomerID = b.CustomerID and b.OrderID = c.OrderID and year(OrderDate) = 2016
group by CustomerId, CompanyName
having TotalOrderAmount >= 15000 
order by TotalOrderAmount desc;

#34
select a.CustomerId, CompanyName, sum(UnitPrice * Quantity) as TotalWithoutDiscount, sum((UnitPrice * Quantity)*(1-Discount)) as TotalWithDiscount
from customers a, orders b, orderdetails c
where a.CustomerID = b.CustomerID and b.OrderID = c.OrderID and year(OrderDate) = 2016
group by CustomerId, CompanyName
having TotalWithDiscount >= 15000 
order by TotalWithDiscount desc;

#35
select EmployeeID, OrderID, OrderDate
from orders
where concat(month(OrderDate),"-", day(OrderDate)) in ('1-31','2-28','2-29','3-31','4-30','5-31','6-30','7-31','8-31','9-30','10-31','11-30','12-31')
Order by EmployeeID , OrderID;

#36
select orderID, count(1) as TotalOrderDetails
from orderdetails
group by orderID
order by TotalOrderDetails desc
limit 10;

#37
select round(0.02*(select count(1) from orders),0);
select orderId from orders limit 17;
 
#38

select orderid, count(1) as countOfOrders
from orderdetails
where Quantity >=60
group by orderid, Quantity
having countOfOrders>1;

#39
#41
 select OrderID,OrderDate,RequiredDate,ShippedDate
 from orders 
 where (RequiredDate-ShippedDate) < "0000-00-00 00:00:00";
 #42 in this question first beacuse 
 #we are using forieng key  in selecting area we should
 #define from which table we meant? seconde for counting total repaeted rows we need us group by
 select count((RequiredDate-ShippedDate) < "0000-00-00 00:00:00")
 as total, b.EmployeeID,LastName
 from orders a
 join employees b
 on  a.EmployeeID=b.EmployeeID
 where (RequiredDate-ShippedDate) <= "0000-00-00 00:00:00"
 group by a.EmployeeID
 order by a.EmployeeID;
 #43
 
 
 
 
 select D.EmployeeID,D.lateorder,C.lastname,C.totalorders from (select a.EmployeeID,
 count("1")
 as lateorder
 from orders a
 where if (ShippedDate>=RequiredDate, "1", "0") 
 group by a.EmployeeID
 order by a.EmployeeID) D
join
 ( select b.EmployeeID,LastName, count(1) as totalorders
 from orders a
 join employees b
 on  a.EmployeeID=b.EmployeeID
 group by a.EmployeeID
 order by a.EmployeeID) C
 on  C.EmployeeID=D.EmployeeID
;