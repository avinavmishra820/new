-- Create the database
CREATE DATABASE CompanyDB;

-- Use the newly created database
USE CompanyDB;

-- Create Department Table without foreign key constraint
CREATE TABLE Department (
    D_name VARCHAR(50),
    D_no INT PRIMARY KEY,
    D_Mgr_id INT,
    Mgr_start_date DATE
);

-- Create Employee Table
CREATE TABLE Employee (
    F_name VARCHAR(50),
    L_name VARCHAR(50),
    Emp_id INT PRIMARY KEY,
    Bdate DATE,
    Address VARCHAR(255),
    Gender VARCHAR(10),
    Salary INT,
    Super_Emp_id INT,
    D_no INT,
    FOREIGN KEY (Super_Emp_id) REFERENCES Employee(Emp_id),
    FOREIGN KEY (D_no) REFERENCES Department(D_no)
);

-- Add foreign key constraint to Department Table
ALTER TABLE Department
ADD CONSTRAINT fk_D_Mgr_id
FOREIGN KEY (D_Mgr_id) REFERENCES Employee(Emp_id);

-- Create Dept_Location Table
CREATE TABLE Dept_Location (
    D_no INT,
    D_location VARCHAR(50),
    PRIMARY KEY (D_no, D_location),
    FOREIGN KEY (D_no) REFERENCES Department(D_no)
);

-- Create Project Table
CREATE TABLE Project (
    P_name VARCHAR(50),
    P_number INT PRIMARY KEY,
    P_location VARCHAR(50),
    D_no INT,
    FOREIGN KEY (D_no) REFERENCES Department(D_no)
);

-- Create Works_on Table
CREATE TABLE Works_on (
    Emp_id INT,
    P_no INT,
    Hours INT,
    PRIMARY KEY (Emp_id, P_no),
    FOREIGN KEY (Emp_id) REFERENCES Employee(Emp_id),
    FOREIGN KEY (P_no) REFERENCES Project(P_number)
);

-- Create Dependent Table
CREATE TABLE Dependent (
    Emp_id INT,
    Dependent_name VARCHAR(50),
    Gender VARCHAR(10),
    Bdate DATE,
    Relationship VARCHAR(50),
    PRIMARY KEY (Emp_id, Dependent_name),
    FOREIGN KEY (Emp_id) REFERENCES Employee(Emp_id)
);

-- Insert into Department Table
INSERT INTO Department (D_name, D_no, D_Mgr_id, Mgr_start_date) VALUES
('HR', 1, NULL, '2010-01-01'),
('Finance', 2, NULL, '2011-02-01'),
('IT', 3, NULL, '2012-03-01'),
('Marketing', 4, NULL, '2013-04-01'),
('Sales', 5, NULL, '2014-05-01');

-- Insert into Employee Table
INSERT INTO Employee (F_name, L_name, Emp_id, Bdate, Address, Gender, Salary, Super_Emp_id, D_no) VALUES
('John', 'Doe', 1, '1980-01-01', '123 Elm St', 'M', 50000, NULL, 1),
('Jane', 'Smith', 2, '1985-02-02', '456 Oak St', 'F', 60000, 1, 1),
('Mike', 'Johnson', 3, '1990-03-03', '789 Pine St', 'M', 55000, 1, 2),
('Sara', 'Connor', 4, '1982-04-04', '101 Maple St', 'F', 70000, 2, 2),
('Chris', 'Evans', 5, '1988-05-05', '202 Birch St', 'M', 75000, 3, 3),
('Anna', 'Taylor', 6, '1992-06-06', '303 Cedar St', 'F', 65000, 4, 3),
('Tom', 'Hanks', 7, '1983-07-07', '404 Walnut St', 'M', 72000, 5, 4),
('Emma', 'Watson', 8, '1989-08-08', '505 Cherry St', 'F', 80000, 6, 4),
('Robert', 'Downey', 9, '1991-09-09', '606 Ash St', 'M', 85000, 7, 5),
('Natalie', 'Portman', 10, '1987-10-10', '707 Spruce St', 'F', 90000, 8, 5);

-- Update Department Table to set D_Mgr_id
UPDATE Department SET D_Mgr_id = 1 WHERE D_no = 1;
UPDATE Department SET D_Mgr_id = 3 WHERE D_no = 2;
UPDATE Department SET D_Mgr_id = 5 WHERE D_no = 3;
UPDATE Department SET D_Mgr_id = 7 WHERE D_no = 4;
UPDATE Department SET D_Mgr_id = 9 WHERE D_no = 5;

-- Insert into Dept_Location Table
INSERT INTO Dept_Location (D_no, D_location) VALUES
(1, 'New York'),
(2, 'Los Angeles'),
(3, 'Chicago'),
(4, 'Houston'),
(5, 'Phoenix');

-- Insert into Project Table
INSERT INTO Project (P_name, P_number, P_location, D_no) VALUES
('Project A', 1, 'New York', 1),
('Project B', 2, 'Los Angeles', 2),
('Project C', 3, 'Chicago', 3),
('Project D', 4, 'Houston', 4),
('Project E', 5, 'Phoenix', 5),
('Project F', 6, 'New York', 1),
('Project G', 7, 'Los Angeles', 2),
('Project H', 8, 'Chicago', 3),
('Project I', 9, 'Houston', 4),
('Project J', 10, 'Phoenix', 5);

-- Insert into Works_on Table
INSERT INTO Works_on (Emp_id, P_no, Hours) VALUES
(1, 1, 10),
(2, 1, 20),
(3, 2, 15),
(4, 2, 25),
(5, 3, 30),
(6, 3, 10),
(7, 4, 20),
(8, 4, 15),
(9, 5, 25),
(10, 5, 30);

-- Insert into Dependent Table
INSERT INTO Dependent (Emp_id, Dependent_name, Gender, Bdate, Relationship) VALUES
(1, 'Alice', 'F', '2005-01-01', 'Daughter'),
(2, 'Bob', 'M', '2007-02-02', 'Son'),
(3, 'Charlie', 'M', '2009-03-03', 'Son'),
(4, 'Daisy', 'F', '2011-04-04', 'Daughter'),
(5, 'Ella', 'F', '2013-05-05', 'Daughter'),
(6, 'Frank', 'M', '2015-06-06', 'Son'),
(7, 'Grace', 'F', '2017-07-07', 'Daughter'),
(8, 'Henry', 'M', '2019-08-08', 'Son'),
(9, 'Ivy', 'F', '2021-09-09', 'Daughter'),
(10, 'Jack', 'M', '2023-10-10', 'Son');

-- Query to find names and addresses of all employees who work in the same department
SELECT E1.F_name, E1.L_name, E1.Address
FROM Employee E1
JOIN Employee E2 ON E1.D_no = E2.D_no
WHERE E1.Emp_id <> E2.Emp_id;

-- Query to retrieve a list of employees and the projects they are working on, ordered by department and, within each department, ordered alphabetically by last name, then first name
SELECT E.F_name, E.L_name, P.P_name
FROM Employee E
JOIN Works_on W ON E.Emp_id = W.Emp_id
JOIN Project P ON W.P_no = P.P_number
ORDER BY E.D_no, E.L_name, E.F_name;

-- Create view Dept_info
CREATE VIEW Dept_info AS
SELECT D.D_name, COUNT(E.Emp_id) AS Num_Employees, SUM(E.Salary) AS Total_Salary
FROM Department D
LEFT JOIN Employee E ON D.D_no = E.D_no
GROUP BY D.D_name;
select * from Dept_info;
