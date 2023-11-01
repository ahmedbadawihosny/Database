-- BRO CODE Video Examples --

-- 1-DATABASES

CREATE DATABASE mydb;

USE mydb;

ALTER DATABASE mydb READ ONLY = 1;
-- THAT CASE TO MAKE THE DATABASE TO ONLY READ 
-- AND DON'T DEOB IT OR CHANGE IT  
-- CAN WRITE LIKE TAHT READ ONLY = 0 

DROP DATABASE mydb; -- TO DELETE THE DATABASE

-- 2-TABLES

CREATE TABLE employees (
    employee_id   INT PRIMARY KEY,
    first_name    VARCHAR(50),
    last_name     VARCHAR(50), 
    hourly_pay    DECIMAL(5, 2),
    hire_date     DATE
);

RENAME TABLE employees TO workers;

DROP TABLE employees;

ALTER TABLE employees
ADD phone_number VARCHAR(15);

ALTER TABLE employees
RENAME COLUMN phone_number TO email;

ALTER TABLE employees
MODIFY COLUMN email VARCHAR(15);

ALTER TABLE employees 
MODIFY email VARCHAR(100) 
AFTER last_name;

ALTER TABLE employees 
MODIFY email VARCHAR(100) 
FIRST;

ALTER TABLE employees
DROP COLUMN email;

SELECT * FROM employees;

-- 3-INSERT ROWS

INSERT INTO employees
VALUES (1, "Eugene", "Krabs", 25.50, "2023-01-02");
SELECT * FROM employees;

INSERT INTO employees
VALUES  (2, "Squidward", "Tentacles", 15.00, "2023-01-03"), 
                (3, "Spongebob", "Squarepants", 12.50, "2023-01-04"), 
                (4, "Patrick", "Star", 12.50, "2023-01-05"), 
                (5, "Sandy", "Cheeks", 17.25, "2023-01-06");
SELECT * FROM employees;

INSERT INTO employees (employee_id, first_name, last_name)
VALUES  (6, "Sheldon", "Plankton");
SELECT * FROM employees;

-- 4-SELECT

SELECT * FROM employees;

SELECT first_name, last_name FROM employees;

SELECT last_name, first_name FROM employees;

SELECT *
FROM employees
WHERE employee_id = 1;  -- or employee_id = 2, employee_id = 3, employee_id = 4 , employee_id = 5, employee_id = 6

SELECT *
FROM employees
WHERE first_name = "Spongebob";

SELECT *
FROM employees
WHERE hourly_pay >= 15;

SELECT hire_date, first_name
FROM employees
WHERE hire_date <= "2023-01-03";

SELECT *
FROM employees
WHERE employee_id != 1;

SELECT *
FROM employees
WHERE hire_date IS NULL;  -- NOT WRITE ( = NULL )

SELECT *
FROM employees
WHERE hire_date IS NOT NULL;

-- 5-UPDATE & DELETE

UPDATE employees
SET hourly_pay = 10.25
    hire_date = "2023-01-07"
WHERE employee_id = 6;

SELECT * FROM employees;

DELETE FROM employees
WHERE employee_id = 6;
SELECT * FROM employees;


-- 6-AUTOCOMMIT, COMMIT, ROLLBACK

-- IF WE WRITE LIKE TAHT AND DROP THE TABLE 
DELETE FROM employees;
SELECT * FROM employees;

-- WE CAN FIX THAT USING :
SET AUTOCOMMIT = OFF;

COMMIT;

SELECT * FROM employees;

DELETE FROM employees;
SELECT * FROM employees;  -- THE TABLE WILL BE DELETED BUT WE HAVE COMMIT IT

ROLLBACK;

SELECT * FROM employees;  -- THE TABLE WILL BACK AGAIN

DELETE FROM employees;  -- NOW WE DELETE THE TABLE 
SELECT * FROM employees;
COMMIT;  -- AND WE COMMIT IT NOW THE TABLE IS DELETED AND WE CAN'T BACK IT


-- 7-CURRENT_DATE() & CURRENT_TIME()

CREATE TABLE test(
	my_date        DATE,
    my_time      TIME,
    my_datetime  DATETIME
);

INSERT INTO test
VALUES (
	CURRENT_DATE() + 1,
    CURRENT_TIME(),
    NOW()
);

SELECT * FROM test;

DROP TABLE test;

-- 8-UNIQUE

CREATE TABLE products (
	product_id      INT,
    product_name  VARCHAR(25) UNIQUE,
    price         DECIMAL(4,2)
);

-- WE CAN GIVE products_name UNIQUE LIKE THAT
ALTER TABLE products
ADD CONSTRAINT
UNIQUE(products_name);

INSERT INTO products
VALUES  (100, "hamburger", 5.99),
        (101, "fries", 6.55),
        (102, "soda", 4.12),
        (103, "ice cream", 2.55);

SELECT * FROM products;

-- 9-NOT NULL

CREATE TABLE products (
	  product_id    INT,
    product_name  VARCHAR(25) UNIQUE,
    price         DECIMAL(4,2) NOT NULL
    -- THAT WILL MAKE THIS COLUMN DON'T HAVE NULL VALUES
);

ALTER TABLE products
MODIFY price DECIMAL(4, 2) NOT NULL;

SELECT * FROM products;

-- 10-CHECK

ALTER TABLE employees
ADD CONSTRAINT chk_hourly_pay CHECK(hourly_pay >= 100.00);

INSERT INTO employees
VALUES (7 , "Sheldon", "Plankton", 120.00, "2023-01-07");
-- IF I BUT VALUE 90.00 AND DON'T PUT 120.00 THAT GIVE US ERROR

SELECT * FROM employees;

ALTER TABLE employees
DROP CHECK chk_hourly_pay;

-- 11-DEFAULT

SELECT * FROM products;

INSERT INTO products
VALUES  (104, "straw", 0.00),
        (105, "napkin", 0.00),
        (106, "fork", 0.00),
        (107, "spoon", 0.00);

SELECT * FROM products;

DELETE FROM products
WHERE product_id >= 104;
SELECT * FROM products;

-- CREATE TABLE products
-- (
--     product_id     INT,
--     product_name   VARCHAR(25),
--     price          DECIMAL(4, 2) DEFAULT 0
-- );

-- OR WE CAN DO THAT :

ALTER TABLE products
ALTER price SET DEFAULT 0;
SELECT * FROM products;

INSERT INTO products (product_id, product_name)
VALUES  (104, "straw"),
        (105, "napkin"),
        (106, "fork"),
        (107, "spoon");

SELECT * FROM products;

CREATE TABLE transactions
(
    transactions_id   INT,
    amount            DECIMAL(5, 2),
    transactions_date DATETIME DEFAULT NOW()
);

SELECT * FROM transactions;

INSERT INTO transactions (transactions_id, amount)
VALUES  (1, 4.99),
        (2, 2.89),
        (3, 8.37);

INSERT INTO transactions (transactions_id, amount)
VALUES (4, 5.25);

SELECT * FROM transactions;


DROP TABLE transactions;
-- 12-PRIMARY KEYS

CREATE TABLE transactions
(
    transactions_id   INT,
    amount            DECIMAL(5, 2)
);

ALTER TABLE transactions
ADD CONSTRAINT 
PRIMARY KEY(transactions_id);

-- OR WE CAN WRITE LIKE THAT
CREATE TABLE transactions
(
    transactions_id   INT  PRIMARY KEY,
    amount            DECIMAL(5, 2),
);

SELECT * FROM transactions;

INSERT INTO transactions (transactions_id, amount)
VALUES  (1000, 4.99),
        (1001, 2.89),
        (1002, 8.37);

-- NOTE THAT COLUMN transactions_id CANNOT BE NULL

SELECT * FROM transactions;

-- 13-AUTO_INCREMENT

CREATE TABLE transactions
(
    transactions_id   INT  PRIMARY KEY AUTO_INCREMENT,
    amount            DECIMAL(5, 2)
);

INSERT INTO transactions (amount)
VALUES  (4.99),
        (2.89),
        (8.37);

DELETE FROM transactions;

ALTER TABLE transactions
AUTO_INCREMENT = 1000;

INSERT INTO transactions (amount)
VALUES  (4.99),
        (2.89),
        (8.37);

SELECT * FROM transactions;

-- 14-FOREIGN KEYS

CREATE TABLE customers
(
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

SELECT * FROM customers;

INSERT INTO customers (first_name , last_name)
VALUES  ("Fred", "Fish"),
        ("Larry", "Lobster"),
        ("Bubble", "Bass");

SELECT * FROM customers;

DROP TABLE transactions;

CREATE TABLE transactions
(
    transactions_id   INT  PRIMARY KEY AUTO_INCREMENT,
    amount            DECIMAL(5, 2),
    customer_id       INT,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

SELECT * FROM transactions;

-- TO DELETE THE FOREIGN KEY WE DO THAT
ALTER TABLE transactions
DROP FOREIGN KEY transactions_ibfk_1;

-- TO ADD ANOTHER FOREIGN KEY WITH NEW NAME WE DO THAT

ALTER TABLE transactions
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

SELECT * FROM transactions;

DELETE FROM transactions;

ALTER TABLE transactions
AUTO_INCREMENT = 100;

SELECT * FROM transactions;

INSERT INTO transactions (amount, customer_id)
VALUES  (4.99, 3),
        (5.25, 2),
        (6.54, 3),
        (4.99, 1);
SELECT * FROM transactions;

-- DELETE FROM customers
-- WHERE customer_id = 3;  -- Cannot delete or update a parent row: a foreign key constraint fails

SELECT * FROM transactions;

-- 15-JOINS

-- 16-FUNCTIONS

-- 17-AND, OR, NOT

-- 18-WILD CARDS

-- 19-ORDER BY

-- 20-LIMIT

-- 21-UNIONS

-- 22-SELF JOINS

-- 23-VIEWS

-- 24-INDEXES

-- 25-SUBQUERIES

-- 26-GROUP BY

-- 27-ROLLUP

-- 28-ON DELETE

-- 29-STORED PROCEDURES

-- 30-TRIGGERS