/* 13:Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). 
Display the member's_id, member's name, book title, issue date, and days overdue. /*
SELECT m.member_id, m.member_name, b.book_title, DATEDIFF(CURDATE(), ist.issued_date) AS overdue_days
FROM members m
JOIN issued_status ist ON m.member_id = ist.issued_member_id
JOIN books b ON ist.issued_book_isbn = b.isbn
LEFT JOIN return_status r ON b.isbn = r.return_book_isbn
WHERE r.return_date IS NULL
  AND DATEDIFF(CURDATE(), ist.issued_date) > 30
GROUP BY m.member_id, m.member_name, b.book_title, ist.issued_date
ORDER BY overdue_days DESC;

/* 14: Update Book Status on Return
Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table)./*
SELECT * FROM books
WHERE isbn = '978-0-451-52994-2';

UPDATE books
SET status = 'on'
WHERE isbn = '978-0-451-52994-2';

/* 17: Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch. /*
SELECT e.emp_name, b.branch_id, COUNT(ist.issued_date) AS books_processed
FROM issued_status ist
JOIN employees e ON ist.issued_emp_id = e.emp_id
JOIN branch b ON e.branch_id = b.branch_id
GROUP BY e.emp_name, b.branch_id
ORDER BY books_processed DESC
LIMIT 3;
