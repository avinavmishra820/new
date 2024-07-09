CREATE DATABASE SailingClub;
USE SailingClub;

CREATE TABLE Sailors (
    sid INTEGER PRIMARY KEY,
    sname VARCHAR(50),
    rating INTEGER,
    age REAL
);

CREATE TABLE Boats (
    bid INTEGER PRIMARY KEY,
    bname VARCHAR(50),
    color VARCHAR(20)
);

CREATE TABLE Reserves (
    sid INTEGER,
    bid INTEGER,
    day DATE,
    PRIMARY KEY (sid, bid, day),
    FOREIGN KEY (sid) REFERENCES Sailors(sid),
    FOREIGN KEY (bid) REFERENCES Boats(bid)
);

-- Inserting records into Sailors
INSERT INTO Sailors (sid, sname, rating, age) VALUES
(1, 'John', 5, 25.0),
(2, 'Sam', 7, 30.0),
(3, 'Tom', 3, 22.5),
(4, 'Bob', 8, 29.0),
(5, 'Alice', 6, 27.0),
(6, 'Cathy', 9, 24.0),
(7, 'Diana', 4, 26.5),
(8, 'Eve', 2, 23.0),
(9, 'Frank', 5, 28.0),
(10, 'Grace', 7, 31.0);

-- Inserting records into Boats
INSERT INTO Boats (bid, bname, color) VALUES
(101, 'Sea Breeze', 'red'),
(102, 'Ocean Wave', 'blue'),
(103, 'Sunny Day', 'green'),
(104, 'Red Dragon', 'red'),
(105, 'Blue Lagoon', 'blue'),
(106, 'Green Turtle', 'green'),
(107, 'Yellow Submarine', 'yellow'),
(108, 'White Pearl', 'white'),
(109, 'Black Pearl', 'black'),
(110, 'Silver Bullet', 'silver');

-- Inserting records into Reserves
INSERT INTO Reserves (sid, bid, day) VALUES
(1, 101, '2024-06-01'),
(2, 103, '2024-06-02'),
(3, 104, '2024-06-03'),
(4, 105, '2024-06-04'),
(5, 106, '2024-06-05'),
(6, 107, '2024-06-06'),
(7, 108, '2024-06-07'),
(8, 109, '2024-06-08'),
(9, 110, '2024-06-09'),
(10, 101, '2024-06-10'),
(3, 102, '2024-06-11'),
(2, 101, '2024-06-12');

SELECT s.sname
FROM Sailors s
JOIN Reserves r ON s.sid = r.sid
WHERE r.bid = 103;

-- Finding the names of sailors who have reserved boat 103

SELECT sname, age
FROM Sailors
ORDER BY age
LIMIT 1;

SELECT rating, AVG(age) AS avg_age
FROM Sailors
GROUP BY rating
HAVING COUNT(*) >= 2;

SELECT s.sname
FROM Sailors s
JOIN Reserves r ON s.sid = r.sid
JOIN Boats b ON r.bid = b.bid
WHERE b.color = 'red'
ORDER BY s.age;
