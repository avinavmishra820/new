create database studentdatabase;
use studentdatabase;
CREATE TABLE GUIDE (
    Guide_No INTEGER PRIMARY KEY,
    Guide_name VARCHAR(100),
    Guide_reserach_domain VARCHAR(100) ,
    Contact_No INTEGER ,
    Email_Id VARCHAR(100) 
);

CREATE TABLE STUDENT (
    Rollno INTEGER PRIMARY KEY,
    Name VARCHAR(100),
    Sem INTEGER,
    Degree VARCHAR(50) ,
    Contact_no VARCHAR(50) ,
    Guide_No INTEGER,
    FOREIGN KEY (Guide_No) REFERENCES GUIDE(Guide_No)
);

CREATE TABLE PROJECT (
    Project_No INTEGER PRIMARY KEY,
    Project_title VARCHAR(200) ,
    Project_Area VARCHAR(100) ,
    Start_dt DATE ,
    Guide_No INTEGER,
    FOREIGN KEY (Guide_No) REFERENCES GUIDE(Guide_No)
);

CREATE TABLE STUDENT_GROUP (
    Group_Code INTEGER,
    Roll_No INTEGER,
    PRIMARY KEY (Group_Code, Roll_No),
    FOREIGN KEY (Roll_No) REFERENCES STUDENT(Rollno)
);

CREATE TABLE PROJECT_GROUP (
    Group_Code INTEGER,
    Project_No INTEGER,
    no_of_students INTEGER,
    PRIMARY KEY (Group_Code, Project_No),
    FOREIGN KEY (Group_Code) REFERENCES STUDENT_GROUP(Group_Code),
    FOREIGN KEY (Project_No) REFERENCES PROJECT(Project_No)
);

-- Insert records into GUIDE
INSERT INTO GUIDE (Guide_No, Guide_name, Guide_reserach_domain, Contact_No, Email_Id) VALUES
(1, 'Dr. Smith', 'Data Base', 1234567890, 'smith@example.com'),
(2, 'Dr. Johnson', 'Machine Learning', 1234567891, 'johnson@example.com'),
(3, 'Dr. Williams', 'Data Base', 1234567892, 'williams@example.com'),
(4, 'Dr. Brown', 'Networking', 1234567893, 'brown@example.com');

ALTER TABLE STUDENT MODIFY Contact_no varchar(100);


-- Insert records into STUDENT
INSERT INTO STUDENT (Rollno, Name, Sem, Degree, Contact_no, Guide_No) VALUES
(1, 'Alice', 6, 'B.Tech', 9876543210, 1),
(2, 'Bob', 6, 'B.Tech', 9876543211, 2),
(3, 'Charlie', 6, 'B.Tech', 9876543212, 1),
(4, 'David', 6, 'B.Tech', 9876543213, 3),
(5, 'Eve', 6, 'B.Tech', 9876543214, 1),
(6, 'Frank', 6, 'B.Tech', 9876543215, 4),
(7, 'Grace', 6, 'B.Tech', 9876543216, 2),
(8, 'Hank', 6, 'B.Tech', 9876543217, 3),
(9, 'Ivy', 6, 'B.Tech', 9876543218, 1),
(10, 'Jack', 6, 'B.Tech', 9876543219, 4);

-- Insert records into PROJECT
INSERT INTO PROJECT (Project_No, Project_title, Project_Area, Start_dt, Guide_No) VALUES
(1, 'Database Optimization', 'Data Base', '2023-01-01', 1),
(2, 'AI in Healthcare', 'Machine Learning', '2023-02-01', 2),
(3, 'Network Security', 'Networking', '2023-03-01', 4),
(4, 'Big Data Analytics', 'Data Base', '2023-04-01', 3),
(5, 'Deep Learning Models', 'Machine Learning', '2023-05-01', 2);

-- Insert records into STUDENT_GROUP
INSERT INTO STUDENT_GROUP (Group_Code, Roll_No) VALUES
(1, 1), (1, 2), (2, 3), (2, 4), (3, 5), (3, 6), (4, 7), (4, 8), (5, 9), (5, 10);

-- Insert records into PROJECT_GROUP
INSERT INTO PROJECT_GROUP (Group_Code, Project_No, no_of_students) VALUES
(1, 1, 2),
(2, 2, 2),
(3, 3, 2),
(4, 4, 2),
(5, 5, 2);

SELECT g.Guide_name
FROM GUIDE g
JOIN PROJECT p ON g.Guide_No = p.Guide_No
JOIN PROJECT_GROUP pg ON p.Project_No = pg.Project_No
GROUP BY g.Guide_name
HAVING COUNT(DISTINCT pg.Group_Code) > 2;

SELECT p.Project_No, p.Project_title, g.Guide_name
FROM PROJECT p
JOIN GUIDE g ON p.Guide_No = g.Guide_No
WHERE p.Project_Area = 'Data Base';

CREATE VIEW student_project_details AS
SELECT s.Name AS Student_Name, p.Project_title AS Project_Name, g.Guide_name AS Guide_Name
FROM STUDENT s
JOIN STUDENT_GROUP sg ON s.Rollno = sg.Roll_No
JOIN PROJECT_GROUP pg ON sg.Group_Code = pg.Group_Code
JOIN PROJECT p ON pg.Project_No = p.Project_No
JOIN GUIDE g ON p.Guide_No = g.Guide_No;

SELECT * FROM student_project_details;
