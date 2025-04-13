-- Get books by a specific author
SELECT b.title
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
WHERE a.name = 'Jane Author';

-- List orders made
SELECT o.order_id, o.order_date
FROM cust_order o
WHERE o.customer_id = 1;

-- Show total sales per customer
SELECT c.name, ol.quantity AS total_sales
FROM customer c
JOIN cust_order co ON c.customer_id = co.customer_id
JOIN order_line ol ON co.order_id = ol.order_id
GROUP BY c.customer_id, c.name
ORDER BY total_sales DESC;

-- Most used shipping methods
SELECT sm.method_name, COUNT(co.shipping_method_id) AS usage_count
FROM shipping_method sm
JOIN cust_order co ON sm.shipping_method_id = co.shipping_method_id
GROUP BY sm.method_name
ORDER BY usage_count DESC
LIMIT 5;

-- Order status history
SELECT oh.status_date, os.status_name
FROM order_history oh
JOIN order_status os ON oh.status_id = os.order_status_id
WHERE oh.order_id = 1
ORDER BY oh.status_date ASC;

-- Find the titles of all books published by a specific publisher
SELECT b.title
FROM book b
JOIN publisher p ON b.publisher_id = p.publisher_id
WHERE p.name = 'Pearson';


-- List all customers along number of orders placed
SELECT c.name, COUNT(co.order_id) AS number_of_orders
FROM customer c
LEFT JOIN cust_order co ON c.customer_id = co.customer_id
GROUP BY c.customer_id, c.name
ORDER BY number_of_orders DESC;