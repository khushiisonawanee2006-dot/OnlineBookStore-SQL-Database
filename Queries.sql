--1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books
WHERE Genre = 'Fiction';

--2) Find books published after the year 1950:
SELECT * FROM Books
WHERE Published_Year > 1950;

--3) List all customers from the Canada:
SELECT * FROM Customers
WHERE Country = 'Canada'; 

--4) Show orders placed in November 2023:
SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

--5) Retrieve the total stock of books available:
SELECT SUM(Stock) FROM Books;

--6) Find the details of the most expensive book:
SELECT * FROM Books
WHERE Price = (SELECT MAX(Price) FROM Books);

--7) Show all customers who ordered more than 1 quantity of a book:
SELECT c.*, o.Quantity FROM customers c
INNER JOIN orders o
ON c.customer_ID = o.customer_ID
WHERE o.Quantity > 1;

--8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders
WHERE Total_Amount > 20;

--9) List all genres avaliable in the books table:
SELECT DISTINCT Genre 
FROM Books;

--10) Find the book with the lowest stock.
SELECT * FROM Books 
WHERE Stock = (SELECT MIN(Stock) FROM Books);

--11) Calculate the total revenue generated from all orders:
SELECT SUM(Total_Amount) FROM Orders;

--12) Retrieve the total number of books sold for each genre:
SELECT b.Genre, SUM(o.Quantity)
AS Total_Books_Sold
FROM Books b
INNER JOIN Orders o
ON b.Book_ID = o.Book_ID
GROUP BY b.Genre;

--13) Find the average price of books in the "Fantasy" Genre:
SELECT AVG(Price) FROM Books
WHERE Genre = "Fantasy";

--14) List customers who have placed atleast 2 orders:
SELECT c.Customer_ID, c.Name,
COUNT(o.Order_ID) AS Total_Orders
FROM Customers c
INNER JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2;

--15) Find the most frequently ordered book:
SELECT b.Title, COUNT(o.Book_ID) 
AS Total_Orders
FROM books b
INNER JOIN Orders o
ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY Total_Orders DESC
LIMIT 1;

--16) Show the top 3 most expensive books of "Fantasy" Genre:
SELECT * FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

--17) Retrieve the total quantity of books sold by each author:
SELECT b.Title, b.Author, SUM(o.Quantity) AS Total_Quantity
FROM Books b
INNER JOIN Orders o
ON b.Book_ID = o.Book_ID
GROUP BY b.Title, b.Author;

--18) List the cities where customers whospent over $30 are located:
SELECT DISTINCT c.City FROM Customers c
INNER JOIN Orders o
ON c.Customer_ID = o.Customer_ID
WHERE o.Total_Amount > 30;

--19) Find the customer who spent the most on orders:
SELECT c.Customer_ID, c.Name 
FROM Customers c
INNER JOIN Orders o
ON c.Customer_ID = o.Customer_ID
WHERE o.Total_Amount = 
(SELECT MAX(Total_Amount) FROM orders);

--20) Calculate the stock remaining after fulfiling all orders:
SELECT b.Book_ID ,b.Title, b.Stock - SUM(o.Quantity) 
AS Remaining_stock FROM Books b
INNER JOIN Orders o
ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock;