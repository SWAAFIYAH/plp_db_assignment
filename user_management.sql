-- Creating users 1
CREATE USER 'bookstore_admin'@'localhost' IDENTIFIED BY 'P@ssw0rd@2025';

-- Granting Permission
GRANT ALL PRIVILEGES ON bookstore_db.* TO 'bookstore_admin'@'localhost';


-- Creating User 2
CREATE USER 'report_user'@'localhost' IDENTIFIED BY 'ReportPass@123';

-- Granting Permission
GRANT SELECT ON bookstore_db.book TO 'report_user'@'localhost';
GRANT SELECT ON bookstore_db.author TO 'report_user'@'localhost';
GRANT SELECT ON bookstore_db.customer TO 'report_user'@'localhost';
GRANT SELECT ON bookstore_db.cust_order TO 'report_user'@'localhost';
GRANT SELECT ON bookstore_db.order_line TO 'report_user'@'localhost';


-- Creating User 3
CREATE USER 'data_entry'@'localhost' IDENTIFIED BY 'DataEntry@2025';

-- Granting Permission
GRANT INSERT, UPDATE ON bookstore_db.customer TO 'data_entry'@'localhost';
GRANT INSERT, UPDATE ON bookstore_db.address TO 'data_entry'@'localhost';

-- Revoking Permission
REVOKE UPDATE ON bookstore_db.customer FROM 'data_entry'@'localhost';