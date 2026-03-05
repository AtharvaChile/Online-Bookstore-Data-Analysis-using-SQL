-- Create Database
Create Database OnlineBookstore;

use OnlineBookstore;

-- Create Tables

Drop Table If exists Books;
Create Table Books (
Book_ID Serial Primary Key,
Title varchar(100),
Author varchar(100),
Genre varchar(50),
Published_Year int,
Price numeric(10,2),
Stock int
);

Select * From Books;

Drop Table if exists customers;
Create Table Customers(
Customer_ID serial primary key,
Name varchar(100),
Email varchar(100),
Phone varchar (15),
City varchar(50),
Country varchar(150)
);

Select * From Customers;

Drop Table if exists orders;
Create Table Orders(
Orders_ID serial primary key,
Customer_ID int references Customers(Customer_ID),
Book_ID int references Books(Book_ID),
Order_Date Date,
Quantity int,
Total_Amount numeric(10,2)
);

select * from orders;


-- 1. Retrieve all Books in the "Fiction" genre
Select * From Books
Where Genre='Fiction';


-- 2. Find books Published after the year 1950
Select * From Books
Where Published_year>1950;


-- 3. List all Customers from Canada
Select * from Customers
Where country='Canada';


-- 4.Show orders placed in nov 2023
Select * From Orders
where order_date between'2023-11-01' and '2023-11-30';


-- 5. Retrieve the total stock of books avaliable
Select sum(stock)as Toatl_Stock
From Books;


-- 6. Find the details of the most expensive book:
Select * from Books
Order by Price desc
limit 1;


-- 7. Show all customers who ordered more than 1 quantity of a book:
select * from Orders 
Where quantity>1;


-- 8. Retrieve all orders where the total amount exceeds $20:
select * from Orders
where total_amount>20;


-- 9.  List all genres available in the Books table:
select distinct genre from Books;


-- 10. Find the book with the lowest stock:
select * from Books
order by stock 
limit 1;


-- 11. Calculate the total revenue generated from all orders:
select sum(total_amount) as revenue
from orders;


-- 12. Retrieve the total number of books sold for each genre:
Select * from orders;
select b.Genre,sum(o.Quantity)as Total_Books_sold
from Orders o
join Books b on o.book_id =b.book_id
Group by b.Genre;


-- 13. Find the average price of books in the "Fantasy" genre:
select avg(price)as average_price
from books
where Genre='Fantasy';


-- 14.  List customers who have placed at least 2 orders:
SELECT o.customer_id, c.name, COUNT(o.Orders_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Orders_id) >=2;


-- 15.  Find the most frequently ordered book:
SELECT o.Book_id, b.title, COUNT(o.orders_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;


-- 16.  Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;


-- 17.  Retrieve the total quantity of books sold by each author:
SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;


-- 18. List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;


-- 19. Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;


-- 20. Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id; 

