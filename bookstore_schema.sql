-- Drop and create the database
DROP DATABASE IF EXISTS bookstore_db;
CREATE DATABASE bookstore_db;
USE bookstore_db;

-- Table: country
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO country (name) VALUES ('Kenya'), ('USA'), ('UK');

-- Table: address
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

INSERT INTO address (street, city, postal_code, country_id) VALUES
('Moi Avenue', 'Nairobi', '00100', 1),
('5th Ave', 'New York', '10001', 2);

-- Table: address_status
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

INSERT INTO address_status (status_name) VALUES ('current'), ('old');

-- Table: customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO customer (name, email) VALUES ('John Doe', 'john@example.com'), ('Alice Smith', 'alice@example.com');

-- Table: customer_address
CREATE TABLE customer_address (
    cust_addr_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    address_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1, 1, 1),
(2, 2, 1);

-- Table: publisher
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO publisher (name) VALUES ('Pearson'), ('Oxford Press');

-- Table: book_language
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50)
);

INSERT INTO book_language (language_name) VALUES ('English'), ('Swahili');

-- Table: book
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150),
    isbn VARCHAR(20),
    publisher_id INT,
    language_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

INSERT INTO book (title, isbn, publisher_id, language_id, price) VALUES
('Learn SQL', '1234567890', 1, 1, 29.99),
('Advanced Python', '0987654321', 2, 1, 49.99);

-- Table: author
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO author (name) VALUES ('Jane Author'), ('Mark Developer');

-- Table: book_author
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

INSERT INTO book_author (book_id, author_id) VALUES (1, 1), (2, 2);

-- Table: shipping_method
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50)
);

INSERT INTO shipping_method (method_name) VALUES ('Standard'), ('Express');

-- Table: order_status
CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

INSERT INTO order_status (status_name) VALUES ('pending'), ('shipped'), ('delivered');

-- Table: cust_order
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    order_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

INSERT INTO cust_order (customer_id, order_date, shipping_method_id, order_status_id) VALUES
(1, '2025-04-10', 1, 1),
(2, '2025-04-11', 2, 2);

-- Table: order_line
CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

INSERT INTO order_line (order_id, book_id, quantity) VALUES
(1, 1, 2),
(2, 2, 1);

-- Table: order_history
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    status_date DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(order_status_id)
);

INSERT INTO order_history (order_id, status_id, status_date) VALUES
(1, 1, '2025-04-10 10:00:00'),
(1, 2, '2025-04-11 08:00:00'),
(2, 1, '2025-04-11 09:30:00');


-- Show the tables created
SHOW TABLES;

-- Show the data in each table
SELECT * FROM country;
SELECT * FROM address;
SELECT * FROM address_status;
SELECT * FROM customer;
SELECT * FROM customer_address;
SELECT * FROM publisher;
SELECT * FROM book_language;
SELECT * FROM book;
SELECT * FROM author;
SELECT * FROM book_author;
SELECT * FROM shipping_method;
SELECT * FROM order_status;
SELECT * FROM cust_order;   

-- Describe a specific table
DESCRIBE book;
DESCRIBE customer;
DESCRIBE cust_order;
DESCRIBE order_line;

--Test a join query
SELECT
    co.order_id,
    c.name AS customer_name,
    co.order_date,
    os.status_name
FROM cust_order co
JOIN customer c ON co.customer_id = c.customer_id
JOIN order_status os ON co.order_status_id = os.order_status_id;

-- View which book is ordered by which customer
SELECT
    c.name AS customer,
    b.title AS book,
    ol.quantity
FROM order_line ol
JOIN cust_order co ON ol.order_id = co.order_id
JOIN customer c ON co.customer_id = c.customer_id
JOIN book b ON ol.book_id = b.book_id;
