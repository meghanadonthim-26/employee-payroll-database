-- =========================================================
-- EMPLOYEE PAYROLL DATABASE
-- =========================================================

-- Create Database
CREATE DATABASE employee_payroll;
USE employee_payroll;


-- =========================================================
-- 1. DEPARTMENT TABLE
-- =========================================================

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);


-- Insert Department Data
INSERT INTO Department (department_id, department_name) VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing'),
(5, 'Sales');


-- =========================================================
-- 2. EMPLOYEE TABLE
-- =========================================================

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    email VARCHAR(100),
    phone VARCHAR(15),
    department_id INT,
    designation VARCHAR(50),
    joining_date DATE,
    FOREIGN KEY (department_id)
        REFERENCES Department(department_id)
);


-- Insert Employee Data
INSERT INTO Employee
(employee_id, employee_name, gender, email, phone, department_id, designation, joining_date)
VALUES
(101, 'Rahul', 'Male', 'rahul@gmail.com', '9876543210', 3, 'Software Developer', '2023-06-15'),
(102, 'Priya', 'Female', 'priya@gmail.com', '9876543211', 1, 'HR Executive', '2022-08-20'),
(103, 'Arjun', 'Male', 'arjun@gmail.com', '9876543212', 2, 'Accountant', '2021-04-10'),
(104, 'Sneha', 'Female', 'sneha@gmail.com', '9876543213', 4, 'Marketing Executive', '2023-01-05'),
(105, 'Kiran', 'Male', 'kiran@gmail.com', '9876543214', 5, 'Sales Executive', '2022-11-12');


-- =========================================================
-- 3. PAYROLL TABLE
-- =========================================================

CREATE TABLE Payroll (
    payroll_id INT PRIMARY KEY,
    employee_id INT,
    basic_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    deductions DECIMAL(10,2),
    payroll_month VARCHAR(20),
    FOREIGN KEY (employee_id)
        REFERENCES Employee(employee_id)
);


-- Insert Payroll Data
INSERT INTO Payroll
(payroll_id, employee_id, basic_salary, bonus, deductions, payroll_month)
VALUES
(1, 101, 50000, 5000, 2000, 'January'),
(2, 102, 35000, 3000, 1500, 'January'),
(3, 103, 45000, 4000, 1800, 'January'),
(4, 104, 40000, 3500, 1600, 'January'),
(5, 105, 30000, 2500, 1200, 'January');


-- =========================================================
-- 4. DISPLAY ALL DEPARTMENTS
-- =========================================================

SELECT * FROM Department;


-- =========================================================
-- 5. DISPLAY ALL EMPLOYEES
-- =========================================================

SELECT * FROM Employee;


-- =========================================================
-- 6. DISPLAY ALL PAYROLL RECORDS
-- =========================================================

SELECT * FROM Payroll;


-- =========================================================
-- 7. CALCULATE NET SALARY
-- Net Salary = Basic Salary + Bonus - Deductions
-- =========================================================

SELECT
    employee_id,
    basic_salary,
    bonus,
    deductions,
    (basic_salary + bonus - deductions) AS net_salary
FROM Payroll;


-- =========================================================
-- 8. DISPLAY COMPLETE EMPLOYEE PAYROLL DETAILS
-- =========================================================

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name,
    e.designation,
    p.basic_salary,
    p.bonus,
    p.deductions,
    (p.basic_salary + p.bonus - p.deductions) AS net_salary
FROM Employee e
JOIN Department d
    ON e.department_id = d.department_id
JOIN Payroll p
    ON e.employee_id = p.employee_id;


-- =========================================================
-- 9. FIND HIGHEST-PAID EMPLOYEE
-- =========================================================

SELECT
    e.employee_name,
    (p.basic_salary + p.bonus - p.deductions) AS net_salary
FROM Employee e
JOIN Payroll p
    ON e.employee_id = p.employee_id
ORDER BY net_salary DESC
LIMIT 1;


-- =========================================================
-- 10. FIND AVERAGE BASIC SALARY
-- =========================================================

SELECT
    AVG(basic_salary) AS average_basic_salary
FROM Payroll;


-- =========================================================
-- 11. FIND TOTAL BASIC SALARY BY DEPARTMENT
-- =========================================================

SELECT
    d.department_name,
    SUM(p.basic_salary) AS total_basic_salary
FROM Department d
JOIN Employee e
    ON d.department_id = e.department_id
JOIN Payroll p
    ON e.employee_id = p.employee_id
GROUP BY d.department_name;


-- =========================================================
-- 12. FIND EMPLOYEES WITH BASIC SALARY ABOVE 40000
-- =========================================================

SELECT
    e.employee_name,
    p.basic_salary
FROM Employee e
JOIN Payroll p
    ON e.employee_id = p.employee_id
WHERE p.basic_salary > 40000;


-- =========================================================
-- 13. DISPLAY EMPLOYEES IN DESCENDING SALARY ORDER
-- =========================================================

SELECT
    e.employee_name,
    p.basic_salary,
    (p.basic_salary + p.bonus - p.deductions) AS net_salary
FROM Employee e
JOIN Payroll p
    ON e.employee_id = p.employee_id
ORDER BY net_salary DESC;


-- =========================================================
-- 14. FIND TOTAL BONUS PAID
-- =========================================================

SELECT
    SUM(bonus) AS total_bonus
FROM Payroll;


-- =========================================================
-- 15. FIND TOTAL DEDUCTIONS
-- =========================================================

SELECT
    SUM(deductions) AS total_deductions
FROM Payroll;


-- =========================================================
-- 16. COUNT EMPLOYEES IN EACH DEPARTMENT
-- =========================================================

SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM Department d
LEFT JOIN Employee e
    ON d.department_id = e.department_id
GROUP BY d.department_name;


-- =========================================================
-- 17. DISPLAY EMPLOYEE NAME WITH JOINING DATE
-- =========================================================

SELECT
    employee_name,
    designation,
    joining_date
FROM Employee
ORDER BY joining_date;
