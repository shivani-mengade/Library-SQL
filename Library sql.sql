/* Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes',
 'Harper Lee', 'J.B. Lippincott & Co.')" /*
 INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

/* Task 2: Update an Existing Member's Address /*
UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101';
SELECT * FROM members;

/* Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table. /*
DELETE FROM issued_status
WHERE issued_id = 'IS121';
SELECT * FROM issued_status;

/* Task 4: Retrieve All Books Issued by a Specific Employee -- 
Objective: Select all books issued by the employee with emp_id = 'E101'. /*
SELECT *
FROM issued_status
WHERE issued_emp_id = 'E101';

/* -- Task 5: List Members Who Have Issued More Than One Book -- 
Objective: Use GROUP BY to find members who have issued more than one book./*
SELECT issued_emp_id, emp_name
FROM issued_status ist
JOIN employees e  ON e.emp_id = ist.issued_emp_id
GROUP BY issued_emp_id, emp_name
HAVING COUNT(ist.issued_id) > 1;

/* CTAS
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt /*
CREATE TABLE book_count AS
SELECT b.isbn, b.book_title, COUNT(isst.issued_id) AS iss_id
FROM books b
JOIN issued_status isst ON isst.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;
SELECT * FROM book_count;

/* Task 7. Retrieve All Books in a Specific Category: /*
SELECT *
FROM books 
WHERE category = 'History'

/*Task 8: Find Total Rental Income by Category: /*
SELECT b.category, SUM(b.rental_price), COUNT(*)
FROM books as b
JOIN
issued_status as ist ON ist.issued_book_isbn = b.isbn
GROUP BY b.category;

/* List Members Who Registered in the Last 180 Days: /*
SELECT *
FROM members
WHERE reg_date >= CURDATE() - INTERVAL 180 DAY;

/* 10 List Employees with Their Branch Manager's Name and their branch details. /*
SELECT e.emp_name, e.position, b.manager_id, b.branch_address
FROM employees e
JOIN branch b ON e.branch_id = b.branch_id

Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:
CREATE TABLE costly_books AS
SELECT *
FROM books
WHERE rental_price >= 7;
SELECT * FROM costly_books;

/* Task 12: Retrieve the List of Books Not Yet Returned /*
SELECT ist.issued_book_name AS books
FROM issued_status ist
LEFT JOIN return_status r ON ist.issued_id = r.issued_id
WHERE r.return_id IS NULL;