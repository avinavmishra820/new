create database library;
use library;
CREATE TABLE Student (
    Stud_no INTEGER PRIMARY KEY,
    Stud_name VARCHAR(100) NOT NULL
);

CREATE TABLE Membership (
    Mem_no INTEGER PRIMARY KEY,
    Stud_no INTEGER,
    FOREIGN KEY (Stud_no) REFERENCES Student(Stud_no)
);

CREATE TABLE Book (
    book_no INTEGER PRIMARY KEY,
    book_name VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL
);

CREATE TABLE Iss_rec (
    iss_no INTEGER PRIMARY KEY,
    iss_date DATE NOT NULL,
    Mem_no INTEGER,
    book_no INTEGER,
    FOREIGN KEY (Mem_no) REFERENCES Membership(Mem_no),
    FOREIGN KEY (book_no) REFERENCES Book(book_no)
);
CREATE TABLE Student (
    Stud_no INTEGER PRIMARY KEY,
    Stud_name VARCHAR(100) NOT NULL
);

CREATE TABLE Membership (
    Mem_no INTEGER PRIMARY KEY,
    Stud_no INTEGER,
    FOREIGN KEY (Stud_no) REFERENCES Student(Stud_no)
);

CREATE TABLE Book (
    book_no INTEGER PRIMARY KEY,
    book_name VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL
);

CREATE TABLE Iss_rec (
    iss_no INTEGER PRIMARY KEY,
    iss_date DATE NOT NULL,
    Mem_no INTEGER,
    book_no INTEGER,
    FOREIGN KEY (Mem_no) REFERENCES Membership(Mem_no),
    FOREIGN KEY (book_no) REFERENCES Book(book_no)
);
CREATE TABLE Student (
    Stud_no INTEGER PRIMARY KEY,
    Stud_name VARCHAR(100) NOT NULL
);

CREATE TABLE Membership (
    Mem_no INTEGER PRIMARY KEY,
    Stud_no INTEGER,
    FOREIGN KEY (Stud_no) REFERENCES Student(Stud_no)
);

CREATE TABLE Book (
    book_no INTEGER PRIMARY KEY,
    book_name VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL
);

CREATE TABLE Iss_rec (
    iss_no INTEGER PRIMARY KEY,
    iss_date DATE NOT NULL,
    Mem_no INTEGER,
    book_no INTEGER,
    FOREIGN KEY (Mem_no) REFERENCES Membership(Mem_no),
    FOREIGN KEY (book_no) REFERENCES Book(book_no)
);

CREATE TABLE Student (
    Stud_no INTEGER PRIMARY KEY,
    Stud_name VARCHAR(100) NOT NULL
);

CREATE TABLE Membership (
    Mem_no INTEGER PRIMARY KEY,
    Stud_no INTEGER,
    FOREIGN KEY (Stud_no) REFERENCES Student(Stud_no)
);

CREATE TABLE Book (
    book_no INTEGER PRIMARY KEY,
    book_name VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL
);

CREATE TABLE Iss_rec (
    iss_no INTEGER PRIMARY KEY,
    iss_date DATE NOT NULL,
    Mem_no INTEGER,
    book_no INTEGER,
    FOREIGN KEY (Mem_no) REFERENCES Membership(Mem_no),
    FOREIGN KEY (book_no) REFERENCES Book(book_no)
);
-- insert records into students
INSERT INTO Student (Stud_no, Stud_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David'),
(5, 'Eve'),
(6, 'Frank'),
(7, 'Grace'),
(8, 'Hank'),
(9, 'Ivy'),
(10, 'Jack');
-- Insert records into Membership
INSERT INTO Membership (Mem_no, Stud_no) VALUES
(101, 1),
(102, 2),
(103, 3),
(104, 4),
(105, 5),
(106, 6),
(107, 7),
(108, 8),
(109, 9),
(110, 10);

-- Insert records into Book
INSERT INTO Book (book_no, book_name, author) VALUES
(1001, 'Introduction to Algorithms', 'Thomas H. Cormen'),
(1002, 'Clean Code', 'Robert C. Martin'),
(1003, 'The Pragmatic Programmer', 'Andrew Hunt'),
(1004, 'Design Patterns', 'Erich Gamma'),
(1005, 'Refactoring', 'Martin Fowler'),
(1006, 'Code Complete', 'Steve McConnell'),
(1007, 'The Mythical Man-Month', 'Frederick P. Brooks Jr.'),
(1008, 'The Art of Computer Programming', 'Donald E. Knuth'),
(1009, 'Structure and Interpretation of Computer Programs', 'Harold Abelson'),
(1010, 'Modern Operating Systems', 'Andrew S. Tanenbaum');

-- Insert records into Iss_rec
INSERT INTO Iss_rec (iss_no, iss_date, Mem_no, book_no) VALUES
(1, '2024-06-18', 101, 1001),
(2, '2024-06-18', 102, 1002),
(3, '2024-06-17', 103, 1003),
(4, '2024-06-16', 104, 1004),
(5, '2024-06-15', 105, 1005),
(6, '2024-06-14', 106, 1006),
(7, '2024-06-13', 107, 1007),
(8, '2024-06-12', 108, 1008),
(9, '2024-06-11', 109, 1009),
(10, '2024-06-10', 110, 1010);

SELECT s.Stud_name, m.Mem_no
FROM Student s
JOIN Membership m ON s.Stud_no = m.Stud_no;

SELECT s.Stud_name, b.book_name
FROM Iss_rec i
JOIN Membership m ON i.Mem_no = m.Mem_no
JOIN Student s ON m.Stud_no = s.Stud_no
JOIN Book b ON i.book_no = b.book_no
WHERE i.iss_date = CURDATE();


SELECT s.Stud_name, COUNT(i.book_no) AS book_count
FROM Student s
JOIN Membership m ON s.Stud_no = m.Stud_no
JOIN Iss_rec i ON m.Mem_no = i.Mem_no
GROUP BY s.Stud_name;

SELECT b.book_name
FROM Iss_rec i
JOIN Membership m ON i.Mem_no = m.Mem_no
JOIN Book b ON i.book_no = b.book_no
WHERE m.Stud_no = 5;

