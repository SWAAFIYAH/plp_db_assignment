# plp_db_assignment
Bookstore Database Schema Overview
This database models a simple online bookstore, capturing information about customers, books, orders, authors, addresses, and other related entities. Below is a description of each table and how they relate to one another.

# tables include
1. country
Stores a list of countries used for customer addresses.

Columns: country_id (PK), name

2. address
Holds detailed address information, including a foreign key to the country table.

Columns: address_id (PK), street, city, postal_code, country_id (FK → country)

3. address_status
Defines status labels for customer addresses (e.g. current, old).

Columns: status_id (PK), status_name

4. customer
Contains basic customer information.

Columns: customer_id (PK), name, email

5. customer_address
Maps customers to their addresses and status. Allows tracking multiple addresses per customer.

Columns: cust_addr_id (PK), customer_id (FK → customer), address_id (FK → address), status_id (FK → address_status)

6. publisher
Lists book publishers.

Columns: publisher_id (PK), name

7. book_language
Defines the languages books can be published in.

Columns: language_id (PK), language_name

8. book
Stores information about books, including foreign keys to publisher and language.

Columns: book_id (PK), title, isbn, publisher_id (FK → publisher), language_id (FK → book_language), price

9. author
Holds author data.

Columns: author_id (PK), name

10. book_author
Many-to-many join table associating books with authors.

Columns: book_id (FK → book), author_id (FK → author)

Primary Key: Composite of book_id and author_id

11. shipping_method
Lists available shipping methods for orders.

Columns: shipping_method_id (PK), method_name

12. order_status
Defines various order statuses (e.g. pending, shipped, delivered).

Columns: order_status_id (PK), status_name

13. cust_order
Captures orders placed by customers, including the selected shipping method and current status.

Columns: order_id (PK), customer_id (FK → customer), order_date, shipping_method_id (FK → shipping_method), order_status_id (FK → order_status)

14. order_line
Lists the books and quantities in each order.

Columns: order_line_id (PK), order_id (FK → cust_order), book_id (FK → book), quantity

15. order_history
Tracks the status changes of an order over time.

Columns: history_id (PK), order_id (FK → cust_order), status_id (FK → order_status), status_date

🧩 Relationships Overview
Customers can have multiple addresses through the customer_address table.

Books can be written by multiple authors, and authors can write multiple books (book_author).

Orders are placed by customers and consist of one or more books (order_line).

Each order has a shipping method and status.

Order history logs status changes over time for tracking purposes.

