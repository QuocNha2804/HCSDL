use Northwind
----
--1. Liệt kê danh sách tất cả các mặt hàng (Products). 
select *
from [dbo].[Products]
--2. Liệt kê danh sách tất cả các mặt hàng (Products). Thông tin bao gồm 
--ProductID, ProductName, UnitPrice. 
SELECT [ProductID], [ProductName], [UnitPrice]
FROM [dbo].[Products]
--3. Liệt kê danh sách các nhân viên (Employees). Thông tin bao gồm 
--EmployeeID, EmployeeName, Phone, Age. Trong đó EmployeeName 
--được ghép từ LastName và FirstName; Age là tuổi được tính dựa trên 
--năm hiện hành (GetDate()) và năm sinh. 
SELECT [EmployeeID], EmployeeName = [FirstName] + ' ' + [LastName], [HomePhone] as Phone, Age = year(getdate()) - year([BirthDate])
FROM [dbo].[Employees]
--4. Liệt kê danh sách các khách hàng (Customers) mà người đại diện có 
--ContactTitle bắt đầu bằng chữ ‘O’. Thông tin bao gồm CustomerID, 
--CompanyName, ContactName, ContactTitle, City, Phone.
SELECT [CustomerID], [CompanyName], [ContactName], [ContactTitle], [City], [Phone]
FROM [dbo].[Customers]
WHERE [ContactTitle] LIKE 'O%'
--5. Liệt kê danh sách khách hàng (Customers) ở thành phố LonDon, Boise 
--và Paris. 
SELECT*
FROM [dbo].[Customers]
WHERE [City] IN ('LonDon', 'Boise', 'Paris')
--6. Liệt kê danh sách khách hàng (Customers) có tên bắt đầu bằng chữ V mà 
--ở thành phố Lyon.
SELECT*
FROM  [dbo].[Customers]
WHERE [ContactName] LIKE 'V%' AND [City] = 'Lyon'
--7. Liệt kê danh sách các khách hàng (Customers) không có số fax.
SELECT *
FROM  [dbo].[Customers]
WHERE [Fax] IS NULL
--8. Liệt kê danh sách các khách hàng (Customers) có số Fax. 
SELECT *
FROM  [dbo].[Customers]
WHERE [Fax] IS NOT NULL
--9. Liệt kê danh sách nhân viên (Employees) có năm sinh <=1960
SELECT*
FROM [dbo].[Employees]
WHERE YEAR([BirthDate]) <= 1960
--10. Liệt kê danh sách các sản phẩm (Products) có chứa chữ ‘Boxes’ trong 
--cột QuantityPerUnit.  
SELECT*
FROM [dbo].[Products]
WHERE [QuantityPerUnit] LIKE '%Boxes%'
--11. Liệt kê danh sách các mặt hàng (Products) có đơn giá (Unitprice) lớn 
--hơn 10 và nhỏ hơn 15.
SELECT*
FROM [dbo].[Products]  
WHERE [UnitPrice] >10 AND [UnitPrice] < 15
--12. Liệt kê danh sách các mặt hàng (Products) có số lượng tồn nhỏ hơn 5. 
SELECT*
FROM [dbo].[Products]
WHERE [UnitsInStock] < 5
--13. Liệt kê danh sách các mặt hàng (Products) ứng với tiền tồn vốn. Thông 
--tin bao gồm ProductId, ProductName, Unitprice, UnitsInStock, Total. 
--Trong đó Total= UnitsInStock*Unitprice. Được sắp xếp theo Total giảm 
--dần. 
SELECT [ProductID], [ProductName],[UnitPrice], [UnitsInStock], Total = [UnitsInStock]*[UnitPrice]
from [dbo].[Products]
ORDER BY Total DESC
--14. Hiển thị thông tin OrderID, OrderDate, CustomerID, EmployeeID của 2 
--hóa đơn có mã OrderID là ‘10248’ và ‘10250’ 
SELECT [OrderID], [OrderDate], [CustomerID], [EmployeeID]
FROM [dbo].[Orders]
WHERE [OrderID] = 10248 OR [OrderID] = 10250
--15. Liệt kê chi tiết của hóa đơn có OrderID là ‘10248’. Thông tin gồm 
--OrderID, ProductID, Quantity, Unitprice, Discount, ToTalLine = 
--Quantity * unitPrice *(1-Discount) 
SELECT [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], ToTalLine = [Quantity]*[UnitPrice]*(1-[Discount])
FROM [dbo].[Order Details]
WHERE [OrderID] = 10248
--16. Liệt kê danh sách các hóa đơn (orders) có OrderDate được lập trong 
--tháng 9 năm 1996. Được sắp xếp theo mã khách hàng, cùng mã khách 
--hàng sắp xếp theo ngày lập hóa đơn giảm dần.
SELECT*
FROM  [dbo].[Orders]
WHERE MONTH([OrderDate]) = 9 AND YEAR([OrderDate]) = 1996
ORDER BY [CustomerID] DESC , [OrderDate] DESC
--17. Liệt kê danh sách các hóa đơn (Orders) được lập trong quý 4 năm 1997. 
--Thông tin gồm OrderID, OrderDate, CustomerID, EmployeeID. Được 
--sắp xếp theo tháng của ngày lập hóa đơn. 
SELECT [OrderID],[OrderDate] , [CustomerID], [EmployeeID]
FROM [dbo].[Orders]
WHERE MONTH([OrderDate]) BETWEEN 10 AND 12 AND YEAR([OrderDate]) = 1997
ORDER BY MONTH([OrderDate]) DESC
--18. Liệt kê danh sách các hóa đơn (Orders) được lập trong trong ngày thứ 7 
--và chủ nhật của tháng 12 năm 1997. Thông tin gồm OrderID, OrderDate, 
--Customerid, EmployeeID, WeekDayOfOrdate (Ngày thứ mấy trong 
--tuần).  
SELECT [OrderID], [OrderDate], [CustomerID], [EmployeeID], WeekDayOfOrdate = DATENAME(WEEKDAY,[OrderDate])
FROM [dbo].[Orders]
WHERE DATENAME(WEEKDAY,[OrderDate]) IN ('Saturday','Sunday') AND MONTH([OrderDate]) = 12 AND YEAR([OrderDate]) = 1997

--19. Liệt kê danh sách 5 customers có city có ký tự bắt đầu  ‘M’. 
SELECT TOP 5 *
FROM [dbo].[Customers]
WHERE [City] LIKE 'M%'
--20. Liệt kê danh sách 2 employees có tuổi lớn nhất. Thông tin bao gồm 
--EmployeeID, EmployeeName, Age. Trong đó, EmployeeName được 
--ghép từ LastName và FirstName; Age là tuổi.
SELECT TOP 2 [EmployeeID], EmployeeName = [FirstName]+ ' '+ [LastName], Age = YEAR(GETDATE()) - YEAR([BirthDate])
FROM [dbo].[Employees]
ORDER BY Age DESC
---
---
--1. Hiển thị thông tin về hóa đơn có mã ‘10248’, bao gồm: OrderID, 
--OrderDate, CustomerID, EmployeeID, ProductID, Quantity, Unitprice, 
--Discount. 
SELECT O.[OrderID], [OrderDate],[CustomerID] , [EmployeeID],[ProductID] , [Quantity], [UnitPrice], [Discount]
FROM [dbo].[Orders] O JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID
WHERE O.OrderID = 10248
--2. Liệt kê các khách hàng có lập hóa đơn trong tháng 7/1997 và 9/1997. 
--Thông tin gồm CustomerID, CompanyName, Address, OrderID, 
--Orderdate. Được sắp xếp theo CustomerID, cùng CustomerID thì sắp xếp 
--theo OrderDate giảm dần.
SELECT C.[CustomerID],[CompanyName] , [Address],[OrderID],[OrderDate] 
FROM  [dbo].[Orders] O JOIN [dbo].[Customers] C ON O.CustomerID = C.CustomerID
WHERE MONTH([OrderDate]) = 7 OR MONTH([OrderDate]) = 9 AND YEAR([OrderDate]) = 1997
--3. Liệt kê danh sách các mặt hàng xuất bán vào ngày 19/7/1996. Thông tin 
--gồm : ProductID, ProductName, OrderID, OrderDate, Quantity. 
SELECT P.[ProductID], [ProductName], O.[OrderID], [OrderDate], [Quantity]
FROM [dbo].[Orders] O JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID JOIN [dbo].[Products] P ON OD.ProductID = P.ProductID
WHERE [OrderDate] = '7-19-1996'
--4. Liệt kê danh sách các mặt hàng từ nhà cung cấp (supplier) có mã 1,3,6 và 
--đã xuất bán trong quý 2 năm 1997. Thông tin gồm : ProductID, 
--ProductName, SupplierID, OrderID, Quantity. Được sắp xếp theo mã 
--nhà cung cấp (SupplierID), cùng mã nhà cung cấp thì sắp xếp theo 
--ProductID.
SELECT P.[ProductID], [ProductName], [SupplierID],O.[OrderID] , [Quantity]
FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID JOIN [dbo].[Orders] O ON O.OrderID = OD.OrderID
WHERE [SupplierID] IN (1, 3, 6) AND DATEPART(q,[ShippedDate]) = 2 AND YEAR( [ShippedDate] ) = 1997
ORDER BY [SupplierID] DESC,[ProductID] DESC
--5. Liệt kê danh sách các mặt hàng có đơn giá bán bằng đơn giá mua. 
SELECT*
FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID
WHERE P.[UnitPrice] = OD.[UnitPrice]
--6. Danh sách các mặt hàng bán trong ngày thứ 7 và chủ nhật của tháng 12 
--năm 1996, thông tin gồm ProductID, ProductName, OrderID, OrderDate, 
--CustomerID, Unitprice, Quantity,  ToTal= Quantity*UnitPrice. Được sắp 
--xếp theo ProductID, cùng ProductID thì sắp xếp theo Quantity giảm dần. 
SELECT P.[ProductID], [ProductName], O.[OrderID], [OrderDate], [CustomerID],OD.[UnitPrice] ,[Quantity] , Total = OD.[UnitPrice]*[Quantity]
FROM [dbo].[Orders] O JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID JOIN [dbo].[Products] P ON OD.ProductID = P.ProductID
WHERE DATENAME(WEEKDAY, [OrderDate]) IN ('Saturday','Monday') AND YEAR([OrderDate]) = 1996 AND MONTH([OrderDate]) = 12
ORDER BY [ProductID] DESC, [Quantity] DESC
--7. Liệt kê danh sách các nhân viên đã lập hóa đơn trong tháng 7 của năm 
--1996. Thông tin gồm : EmployeeID, EmployeeName, OrderID, 
--Orderdate. 
SELECT E.[EmployeeID], EmployeeName = [FirstName]+' '+ [LastName],[OrderID], [OrderDate]
FROM [dbo].[Orders] O JOIN [dbo].[Employees] E ON O.EmployeeID = E.EmployeeID
WHERE MONTH([OrderDate]) = 7 AND YEAR([OrderDate]) = 1996
--8. Liệt kê danh sách các hóa đơn do nhân viên có Lastname là ‘Fuller’ lập. 
--Thông tin gồm : OrderID, Orderdate, ProductID, Quantity, Unitprice. 
SELECT O.[OrderID],[OrderDate] , [ProductID],[Quantity] , [UnitPrice]
FROM [dbo].[Orders] O JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID JOIN [dbo].[Employees] E ON O.EmployeeID = E.EmployeeID
WHERE [LastName] = 'Fuller'
--9. Liệt kê[OrderID] chi tiết bán hàng của mỗi nhân viên theo từng hóa đơn trong năm 
--1996. Thông tin gồm: EmployeeID, EmployName, OrderID, Orderdate, 
--ProductID, quantity, unitprice, ToTalLine=quantity*unitprice.  
SELECT E.[EmployeeID], EmployName =[FirstName] +' '+[LastName], O.[OrderID], [OrderDate], [ProductID], [Quantity], [UnitPrice], ToTalLine = [Quantity]*[UnitPrice]
FROM [dbo].[Orders] O JOIN [dbo].[Employees] E ON O.EmployeeID = E.EmployeeID JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID
WHERE YEAR([OrderDate]) = 1996
--10. Danh sách các đơn hàng sẽ được giao trong các thứ 7 của tháng 12 năm 
--1996.  
SELECT*
FROM [dbo].[Orders]
WHERE DATENAME(WEEKDAY, [RequiredDate]) IN ('Saturday') AND MONTH([RequiredDate]) = 12 AND YEAR([RequiredDate]) = 1996
--11. Liệt kê danh sách các nhân viên chưa lập hóa đơn (dùng LEFT 
--JOIN/RIGHT JOIN). 
SELECT *
FROM [dbo].[Employees] E
LEFT JOIN [dbo].[Orders] O ON E.EmployeeID = O.EmployeeID
WHERE O.EmployeeID IS NULL

--12. Liệt kê danh sách các sản phẩm chưa bán được (dùng LEFT 
--JOIN/RIGHT JOIN). 
SELECT *
FROM [dbo].[Products] P LEFT JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID
WHERE OD.[ProductID] IS NULL
--13. Liệt kê danh sách các khách hàng chưa mua hàng lần nào (dùng LEFT 
--JOIN/RIGHT JOIN). 
SELECT *
FROM [dbo].[Customers] C LEFT JOIN [dbo].[Orders] O ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL
---
---
---
--1. Liệt kê danh sách các orders ứng với tổng tiền của từng hóa đơn. Thông tin 
--bao gồm OrderID, OrderDate, Total. Trong đó Total là Sum của Quantity * 
--Unitprice, kết nhóm theo OrderID.
SELECT O.[OrderID], [OrderDate], Total = SUM([Quantity]* [UnitPrice])
FROM [dbo].[Orders] O JOIN [dbo].[Order Details] OD  ON O.OrderID = OD.OrderID
GROUP BY O.[OrderID], [OrderDate]
--2. Liệt kê danh sách các orders mà địa chỉ nhận hàng ở thành phố  ‘Madrid’ 
--(Shipcity). Thông tin bao gồm OrderID, OrderDate, Total. Trong đó Total 
--là tổng trị giá hóa đơn, kết nhóm theo OrderID.  
SELECT O.[OrderID],[OrderDate] , Total = sum([Quantity]*[UnitPrice])
FROM [dbo].[Orders] O JOIN [dbo].[Order Details] OD ON O.OrderID =  OD.OrderID
WHERE [ShipCity] IN ('Madrid')
GROUP BY O.[OrderID],[OrderDate]
--3. Viết các truy vấn để thống kê số lượng các hóa đơn  :  - 
--Trong mỗi năm. Thông tin hiển thị : Year , CoutOfOrders ? - - 
SELECT YearO= YEAR([OrderDate]), CoutOfOrders = COUNT(*)
FROM [dbo].[Orders]
GROUP BY YEAR([OrderDate])
--Trong mỗi tháng/năm . Thông tin hiển thị : Year , Month,  
--CoutOfOrders ? 
SELECT YearO= YEAR([OrderDate]), MonthO = MONTH([OrderDate]), CoutOfOrders = COUNT(*)
FROM [dbo].[Orders]
GROUP BY YEAR([OrderDate]), MONTH([OrderDate])
--Trong mỗi tháng/năm và ứng với mỗi nhân viên. Thông tin hiển 
--thị : Year, Month, EmployeeID,  CoutOfOrders ? 
SELECT YearO= YEAR([OrderDate]), MonthO = MONTH([OrderDate]),[EmployeeID] , CoutOfOrders = COUNT(*)
FROM [dbo].[Orders]
GROUP BY YEAR([OrderDate]), MONTH([OrderDate]),[EmployeeID]
--4. Cho biết mỗi Employee đã lập bao nhiêu hóa đơn. Thông tin gồm 
--EmployeeID, EmployeeName, CountOfOrder. Trong đó  CountOfOrder là 
--tổng số hóa đơn của từng employee. EmployeeName được ghép từ 
--LastName và FirstName. 
SELECT [EmployeeID], EmployeeName = [FirstName]+' '+[LastName], CountOfOrder = COUNT(*)
FROM [dbo].[Employees]
GROUP BY [EmployeeID],[FirstName]+' '+[LastName]
--5. Cho biết mỗi Employee đã lập được bao nhiêu hóa đơn, ứng với tổng tiền 
--các hóa đơn tương ứng. Thông tin gồm EmployeeID, EmployeeName, 
--CountOfOrder , Total. 
SELECT E.[EmployeeID], EmployeeName = [FirstName]+' '+[LastName], CountOfOrder = COUNT(*), Total = SUM([Quantity]*[UnitPrice])
FROM [dbo].[Employees] E JOIN [dbo].[Orders] O ON E.EmployeeID = O.EmployeeID JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY E.[EmployeeID],[FirstName]+' '+[LastName]
--6. Liệt kê bảng lương của mỗi Employee theo từng tháng trong năm 1996 
--gồm EmployeeID, EmployName, Month_Salary, Salary = 
--sum(quantity*unitprice)*10%. Được sắp xếp theo Month_Salary, cùmg 
--Month_Salary thì sắp xếp theo Salary giảm dần.
SELECT E.[EmployeeID], EmployeeName = [FirstName]+' '+[LastName], Month_Salary = Month([OrderDate]), Salary = Sum([Quantity]*[UnitPrice])*0.1
FROM [dbo].[Orders] O JOIN [dbo].[Employees] E ON O.EmployeeID = E.EmployeeID JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID
WHERE YEAR([OrderDate]) = 1996
GROUP BY E.[EmployeeID],[FirstName]+' '+[LastName], Month([OrderDate])
ORDER BY Month_Salary DESC, Salary DESC
--7. Tính tổng số hóa đơn và tổng tiền  các hóa đơn của mỗi nhân viên đã bán 
--trong tháng 3/1997, có tổng tiền >4000. Thông tin gồm EmployeeID, 
--LastName, FirstName, CountofOrder, Total.
SELECT E.[EmployeeID] , [LastName], [FirstName], CountofOrder = COUNT(*), Total = SUM([UnitPrice]* [Quantity])
FROM [dbo].[Employees] E JOIN [dbo].[Orders] O ON E.EmployeeID = O.EmployeeID JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID
WHERE MONTH([OrderDate]) = 3 AND YEAR([OrderDate]) = 1997
GROUP BY E.[EmployeeID] , [LastName], [FirstName]
HAVING SUM([UnitPrice]* [Quantity]) > 4000

--8. Liệt kê danh sách các customer ứng với tổng số hoá đơn, tổng tiền các hoá 
--đơn, mà các hóa đơn được lập từ 31/12/1996 đến 1/1/1998 và tổng tiền các 
--hóa đơn >20000. Thông tin được sắp xếp theo CustomerID, cùng mã thì 
--sắp xếp theo tổng tiền giảm dần. 
SELECT C.[CustomerID], [CompanyName], Countoforder = COUNT(*), Total = sum([Quantity]*[UnitPrice])
FROM [dbo].[Customers] C JOIN [dbo].[Orders] O ON C.CustomerID = O.CustomerID JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID
WHERE [OrderDate] BETWEEN CONVERT(DATETIME,'12-31-1996') AND CONVERT(DATETIME,'1-1-1998')
GROUP BY C.[CustomerID], [CompanyName]
HAVING sum([Quantity]*[UnitPrice]) > 20000
ORDER BY Total DESC
--
SELECT C.[CustomerID], [CompanyName], Countoforder = COUNT(*), Total = sum([Quantity]*[UnitPrice])
FROM [dbo].[Customers] C JOIN [dbo].[Orders] O ON C.CustomerID = O.CustomerID JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID
WHERE [OrderDate] BETWEEN '12-31-1996' AND '1-1-1998'
GROUP BY C.[CustomerID], [CompanyName]
HAVING sum([Quantity]*[UnitPrice]) > 20000
ORDER BY Total DESC

--9. Liệt kê danh sách các customer ứng với tổng tiền của các hóa đơn ở từng 
--tháng. Thông tin bao gồm CustomerID, CompanyName, Month_Year, 
--Total. Trong đó Month_year là tháng và năm lập hóa đơn, Total là tổng của 
--Unitprice* Quantity. 
SELECT C.[CustomerID], [CompanyName], MONTH_= MONTH([OrderDate]), YEAR_=YEAR([OrderDate]), Total = sum([UnitPrice]*[Quantity])
FROM [dbo].[Customers] C JOIN [dbo].[Orders] O ON C.CustomerID = O.CustomerID JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.[CustomerID], [CompanyName], MONTH([OrderDate]),YEAR([OrderDate])
--10. Liệt kê danh sách các nhóm hàng (category) có tổng số lượng tồn 
--(UnitsInStock) lớn hơn 300, đơn giá trung bình nhỏ hơn 25. Thông tin bao 
--gồm CategoryID, CategoryName, Total_UnitsInStock, Average_Unitprice.
SELECT  C.[CategoryID],[CategoryName] ,Total_UnitsInStock = SUM([UnitsInStock]), Average_Unitprice = AVG([UnitPrice])
FROM [dbo].[Products] P JOIN [dbo].[Categories] C ON P.CategoryID = C.CategoryID
GROUP BY C.[CategoryID],[CategoryName]
HAVING SUM([UnitsInStock]) > 300 AND AVG([UnitPrice]) < 25

--11. Liệt kê danh sách các nhóm hàng (category) có tổng số mặt hàng (product) 
--nhỏ hớn 10. Thông tin kết quả bao gồm CategoryID, CategoryName, 
--CountOfProducts. Được sắp xếp theo CategoryName, cùng CategoryName 
--thì sắp theo CountOfProducts giảm dần.
SELECT C.[CategoryID], [CategoryName], CountOfProducts = COUNT([ProductID])
FROM [dbo].[Categories] C JOIN [dbo].[Products] P ON C.CategoryID = P.CategoryID
GROUP BY C.[CategoryID], [CategoryName]
HAVING COUNT([ProductID])>10
ORDER BY CountOfProducts DESC
--
SELECT C.[CategoryID], [CategoryName], CountOfProducts = COUNT(*)
FROM [dbo].[Categories] C JOIN [dbo].[Products] P ON C.CategoryID = P.CategoryID
GROUP BY C.[CategoryID], [CategoryName]
HAVING COUNT(*)>10
ORDER BY CountOfProducts DESC
--12. Liệt kê danh sách các Product bán trong quý 1 năm 1998 có tổng số lượng 
--bán ra >200, thông tin gồm [ProductID], [ProductName], SumofQuatity
SELECT  P.[ProductID] , [ProductName], SumofQuatity = SUM([Quantity])
FROM [dbo].[Orders] O JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID JOIN [dbo].[Products] P ON OD.ProductID = P.ProductID
WHERE DATEPART(q,[OrderDate]) = 1 AND YEAR([OrderDate]) = 1998
GROUP BY P.[ProductID] , [ProductName]
HAVING SUM([Quantity]) > 200
--13. Cho biết Employee nào bán được nhiều tiền nhất trong tháng 7 năm 1997
SELECT TOP 1 E.[EmployeeID],[FirstName] , [LastName],Total = SUM([UnitPrice]*[Quantity])
FROM [dbo].[Employees] E JOIN [dbo].[Orders] O ON E.EmployeeID = O.EmployeeID JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID
WHERE MONTH([OrderDate]) =7 AND YEAR([OrderDate]) = 1997
GROUP BY E.[EmployeeID],[FirstName] , [LastName]
ORDER BY Total DESC
--14. Liệt kê danh sách 3 Customer có nhiều đơn hàng nhất của năm 1996. 
SELECT TOP 3  C.[CustomerID], [CompanyName], COUNTOFORDER = COUNT(*)
FROM [dbo].[Customers] C JOIN [dbo].[Orders] O ON C.CustomerID = O.CustomerID
GROUP BY C.[CustomerID], [CompanyName]
ORDER BY COUNTOFORDER DESC
--15. Liệt kê danh sách các Products có tổng số lượng lập hóa đơn lớn nhất. 
--Thông tin gồm ProductID, ProductName, CountOfOrders.
SELECT TOP 1  WITH TIES P.[ProductID], [ProductName], CountOfOrders = COUNT(*)
FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY P.[ProductID], [ProductName]
ORDER BY COUNT(*) DESC
---
---
---
--1. Liệt kê các product có đơn giá mua lớn hơn đơn giá mua trung bình của 
--tất cả các product. 
SELECT AVG([UnitPrice])
FROM [dbo].[Products]
--
SELECT *
FROM [dbo].[Products] P
WHERE [UnitPrice] > (SELECT AVG([UnitPrice])
					FROM [dbo].[Products])


--2. Liệt kê các product có đơn giá mua lớn hơn đơn giá mua nhỏ nhất của tất 
--cả các product. 
SELECT MIN([UnitPrice])
FROM [dbo].[Products]
--
SELECT *
FROM [dbo].[Products]
WHERE [UnitPrice] > (SELECT MIN([UnitPrice])
					FROM [dbo].[Products])
--3. Liệt kê các product có đơn giá bán lớn hơn đơn giá bán trung bình của 
--các product. Thông tin gồm ProductID, ProductName, OrderID, 
--Orderdate,  Unitprice . 
SELECT AVG([UnitPrice])
FROM [dbo].[Order Details]

--
SELECT P.[ProductID], [ProductName], O.[OrderID],[OrderDate] , OD.[UnitPrice]
FROM [dbo].[Orders] O JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID  JOIN [dbo].[Products] P ON OD.ProductID = P.ProductID
WHERE OD.[UnitPrice] > (SELECT AVG([UnitPrice])
						FROM [dbo].[Order Details])
--4. Liệt kê các product có đơn giá bán lớn hơn đơn giá bán trung bình của 
--các product có ProductName bắt đầu là ‘N’. 
SELECT AVG(OD.[UnitPrice])
FROM [dbo].[Order Details] OD JOIN [dbo].[Products] P ON OD.ProductID = P.ProductID
WHERE [ProductName] LIKE ('N%')
--
SELECT*
FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID
WHERE OD.[UnitPrice] > (SELECT AVG(OD.[UnitPrice])
						FROM [dbo].[Order Details] OD JOIN [dbo].[Products] P ON OD.ProductID = P.ProductID
						WHERE [ProductName] LIKE ('N%'))
--5. Cho biết những sản phẩm có tên bắt đầu bằng ‘T’ và có đơn giá bán lớn 
--hơn đơn giá bán của (tất cả) những sản phẩm có tên bắt đầu bằng chữ 
--‘V’.
 SELECT [UnitPrice]
 FROM [dbo].[Products]
 WHERE [ProductName] LIKE 'V%'
 --
 SELECT *
 FROM [dbo].[Products]
 WHERE [ProductName] LIKE 'T%' AND [UnitPrice] > ALL(
													SELECT [UnitPrice]
													FROM [dbo].[Products]
													WHERE [ProductName] LIKE 'V%')
--6. Cho biết sản phẩm nào có đơn giá bán cao nhất trong số những sản phẩm 
--có đơn vị tính có chứa chữ ‘box’ . 
SELECT MAX([UnitPrice])
FROM [dbo].[Products]
--
SELECT*
FROM [dbo].[Products]
WHERE [UnitPrice] >= (SELECT MAX([UnitPrice])
						FROM [dbo].[Products])
						AND [QuantityPerUnit] LIKE '%box%'
--7. Liệt kê các product có tổng số lượng bán (Quantity) trong năm 1998 lớn 
--hơn tổng số lượng bán trong năm 1998 của mặt hàng có mã 71 
SELECT [Quantity]
FROM [dbo].[Order Details] OD JOIN [dbo].[Orders] O ON OD.OrderID = O.OrderID
WHERE YEAR([OrderDate]) = 1998 AND [ProductID] = 71
--
SELECT *
FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID JOIN [dbo].[Orders] O ON OD.OrderID = O.OrderID
WHERE YEAR([OrderDate]) = 1998 AND [Quantity] > ALL (SELECT [Quantity]
												FROM [dbo].[Order Details] OD JOIN [dbo].[Orders] O ON OD.OrderID = O.OrderID
												WHERE YEAR([OrderDate]) = 1998 AND [ProductID] = 71)
--8. Thực hiện : - 
--Thống kê tổng số lượng bán ứng với mỗi mặt hàng thuộc nhóm 
--hàng có CategoryID là 4. Thông tin : ProductID, QuantityTotal 
--(tập A)  - - 
SELECT P.[ProductID], QuantityTotal = SUM([Quantity])
INTO #TAP_A
FROM [dbo].[Order Details] OD JOIN [dbo].[Products] P ON OD.ProductID = P.ProductID
WHERE [CategoryID] = 4
GROUP BY P.[ProductID]
--
SELECT*
FROM #TAP_A
--

---

--Thống kê tổng số lượng bán ứng với mỗi mặt hàng thuộc nhóm 
--hàng khác 4 . Thông tin : ProductID, QuantityTotal (tập B) 
SELECT P.[ProductID], QuantityTotal = SUM([Quantity])
INTO #TAP_B
FROM [dbo].[Order Details] OD JOIN [dbo].[Products] P ON OD.ProductID = P.ProductID
WHERE [CategoryID] <> 4
GROUP BY P.[ProductID]
---
SELECT*
FROM #TAP_B
---


--Dựa vào 2 truy vấn trên : Liệt kê danh sách các mặt hàng trong 
--tập A có QuantityTotal lớn hơn tất cả QuantityTotal của tập B 
SELECT*
FROM [dbo].[Products]
WHERE [ProductID] IN (SELECT [ProductID]
					FROM #TAP_A		
					WHERE QuantityTotal > ALL ( SELECT QuantityTotal
												FROM #TAP_B ))
----
DROP TABLE #TAP_A
DROP TABLE #TAP_B
--9. Danh sách các Product có tổng số lượng bán được lớn nhất trong năm 
--1998 
--Lưu ý : Có nhiều phương án thực hiện các truy vấn sau (dùng JOIN hoặc 
--subquery ). Hãy đưa ra phương án sử dụng subquery.
SELECT P.[ProductID], [ProductName]
FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID JOIN [dbo].[Orders] O ON OD.OrderID = O.OrderID
WHERE YEAR([OrderDate]) = 1998
GROUP BY P.[ProductID], [ProductName]
HAVING SUM([Quantity]) >= ALL (SELECT SUM([Quantity])
							FROM  [dbo].[Order Details] OD  JOIN [dbo].[Orders] O ON OD.OrderID = O.OrderID
							WHERE YEAR([OrderDate]) = 1998
							GROUP BY [ProductID])
--10. Danh sách các products đã có khách hàng mua hàng (tức là ProductID có 
--trong [Order Details]). Thông tin bao gồm ProductID, ProductName, 
--Unitprice 
SELECT P.[ProductID], [ProductName], P.[UnitPrice]
FROM [dbo].[Products] P LEFT JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID
WHERE OD.ProductID IS NOT NULL

--11. Danh sách các hóa đơn của những khách hàng ở thành phố LonDon và 
--Madrid. 
SELECT*
FROM [dbo].[Orders]
WHERE [ShipCity] IN ('LonDon','Madrid')
--12. Liệt kê các sản phẩm có trên 20 đơn hàng trong quí 3 năm 1998, thông 
--tin gồm ProductID, ProductName. 
--
SELECT P.[ProductID], [ProductName]
FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID JOIN [dbo].[Orders] O ON OD.OrderID = O.OrderID
WHERE DATEPART(q,[OrderDate]) = 3 AND YEAR([OrderDate]) = 1998
GROUP BY P.[ProductID], [ProductName]
HAVING COUNT(O.[OrderID]) > 20
--13. Liệt kê danh sách các sản phẩm chưa bán được trong tháng 6 năm 1996
SELECT P.*
FROM [dbo].[Products] P
LEFT JOIN (
    SELECT OD.ProductID
    FROM [dbo].[Order Details] OD JOIN [dbo].[Orders] O ON OD.OrderID = O.OrderID
    WHERE MONTH(O.[OrderDate]) = 6 AND YEAR(O.[OrderDate]) = 1996
) AS SoldProducts ON P.ProductID = SoldProducts.ProductID
WHERE SoldProducts.ProductID IS NULL;

--14. Liệt kê danh sách các Employes không lập hóa đơn vào ngày hôm nay 
SELECT*
FROM [dbo].[Employees] E LEFT JOIN [dbo].[Orders] O ON E.EmployeeID = O.EmployeeID
WHERE  [OrderDate]  = GETDATE() AND O.EmployeeID IS NULL
-15. Liệt kê danh sách các Customers chưa mua hàng trong năm 1997 
SELECT [CustomerID]
FROM [dbo].[Orders]
WHERE YEAR([OrderDate]) = 1997
---
SELECT *
FROM [dbo].[Customers] C
WHERE C.[CustomerID] NOT IN (SELECT O.[CustomerID] 
							FROM [dbo].[Orders] O
							WHERE YEAR([OrderDate]) = 1997)

--16. Tìm tất cả các Customers mua các sản phẩm có tên bắt đầu bằng chữ T 
--trong tháng 7 năm 1997 
SELECT [CustomerID]
FROM [dbo].[Orders] O JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID JOIN [dbo].[Products] P ON OD.ProductID = P.ProductID
WHERE [ProductName] LIKE 'T%' AND YEAR([OrderDate]) = 1997 AND MONTH([OrderDate]) = 7
----
SELECT*
FROM [dbo].[Customers]
WHERE [CustomerID] IN (SELECT [CustomerID]
						FROM [dbo].[Orders] O JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID JOIN [dbo].[Products] P ON OD.ProductID = P.ProductID
						WHERE [ProductName] LIKE 'T%' AND YEAR([OrderDate]) = 1997 AND MONTH([OrderDate]) = 7)
--17. Liệt kê danh sách các khách hàng mua các hóa đơn mà các hóa đơn này 
--chỉ mua những sản phẩm có mã >=3  

----
SELECT*
FROM [dbo].[Customers] C
WHERE C.[CustomerID] IN (SELECT DISTINCT O.[CustomerID]
						FROM [dbo].[Orders] O JOIN [dbo].[Order Details] OD ON O.OrderID = OD.OrderID JOIN [dbo].[Products] P ON P.ProductID = OD.ProductID
						WHERE P.ProductID >=3)
--18. Tìm các Customer chưa từng lập hóa đơn (viết bằng ba cách: dùng NOT 
--EXISTS, dùng  LEFT JOIN, dùng NOT IN ) 
SELECT DISTINCT [CustomerID]
FROM [dbo].[Orders]
---
SELECT*
FROM [dbo].[Customers] C
WHERE C.[CustomerID] NOT IN (SELECT DISTINCT [CustomerID]
							FROM [dbo].[Orders])

--
SELECT*
FROM [dbo].[Customers] C LEFT JOIN [dbo].[Orders] O ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS  NULL
---
SELECT*
FROM [dbo].[Customers] C
WHERE NOT EXISTS (SELECT O.[CustomerID] 
				FROM [dbo].[Orders] O
				WHERE O.[CustomerID] = C.[CustomerID])