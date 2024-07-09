create database flightdatabase;
use flightdatabase;
CREATE TABLE Employees (
    eid INTEGER PRIMARY KEY,
    ename VARCHAR(50),
    salary INTEGER
);

CREATE TABLE Aircraft (
    aid INTEGER PRIMARY KEY,
    aname VARCHAR(50),
    cruisingrange INTEGER
);

CREATE TABLE Certified (
    eid INTEGER,
    aid INTEGER,
    PRIMARY KEY (eid, aid),
    FOREIGN KEY (eid) REFERENCES Employees(eid),
    FOREIGN KEY (aid) REFERENCES Aircraft(aid)
);

CREATE TABLE Flights (
    flno INTEGER PRIMARY KEY,
    from_city VARCHAR(50),
    to_city VARCHAR(50),
    distance INTEGER,
    departs TIME,
    arrives TIME,
    price INTEGER
);

-- Insert records into Employees
INSERT INTO Employees (eid, ename, salary) VALUES 
(1, 'John Doe', 90000),
(2, 'Jane Smith', 85000),
(3, 'Robert Brown', 80000),
(4, 'Michael Johnson', 95000),
(5, 'Emily Davis', 70000),
(6, 'Linda Martinez', 78000),
(7, 'David Wilson', 88000),
(8, 'Susan Anderson', 82000),
(9, 'James Taylor', 91000),
(10, 'Barbara Thomas', 75000);

-- Insert records into Aircraft
INSERT INTO Aircraft (aid, aname, cruisingrange) VALUES 
(1, 'Boeing 737', 3000),
(2, 'Airbus A320', 3500),
(3, 'Boeing 747', 8000),
(4, 'Concorde', 4000),
(5, 'Cessna 172', 800),
(6, 'Boeing 777', 9000),
(7, 'Airbus A380', 15000),
(8, 'Gulfstream G650', 13000),
(9, 'Embraer E190', 4000),
(10, 'Boeing 787', 14000);

-- Insert records into Certified
INSERT INTO Certified (eid, aid) VALUES 
(1, 1),
(1, 2),
(1, 3),
(2, 2),
(2, 3),
(2, 4),
(3, 1),
(3, 4),
(4, 5),
(4, 6),
(5, 7),
(5, 8),
(5, 9),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Insert records into Flights
INSERT INTO Flights (flno, from_city, to_city, distance, departs, arrives, price) VALUES 
(1, 'Los Angeles', 'New York', 2451, '08:00:00', '16:00:00', 300),
(2, 'New York', 'London', 3451, '09:00:00', '17:00:00', 500),
(3, 'Chicago', 'Los Angeles', 1745, '10:00:00', '14:00:00', 250),
(4, 'Los Angeles', 'Honolulu', 2555, '11:00:00', '15:00:00', 450),
(5, 'San Francisco', 'Tokyo', 5141, '12:00:00', '20:00:00', 700),
(6, 'Miami', 'Los Angeles', 2345, '13:00:00', '17:00:00', 350),
(7, 'Houston', 'Chicago', 1085, '14:00:00', '16:00:00', 200),
(8, 'Dallas', 'Denver', 650, '15:00:00', '17:00:00', 150),
(9, 'Seattle', 'San Francisco', 679, '16:00:00', '18:00:00', 200),
(10, 'Atlanta', 'Orlando', 438, '17:00:00', '19:00:00', 120);

SELECT aname
FROM Aircraft A
WHERE NOT EXISTS (
    SELECT 1
    FROM Certified C
    JOIN Employees E ON C.eid = E.eid
    WHERE C.aid = A.aid AND E.salary >= 80000
);

SELECT C.eid, MAX(A.cruisingrange) AS max_cruisingrange
FROM Certified C
JOIN Aircraft A ON C.aid = A.aid
GROUP BY C.eid
HAVING COUNT(C.aid) > 3;

SELECT E.ename
FROM Employees E
WHERE E.salary < (
    SELECT MIN(F.price)
    FROM Flights F
    WHERE F.from_city = 'Los Angeles' AND F.to_city = 'Honolulu'
);
SELECT MAX(salary) AS second_highest_salary
FROM Employees
WHERE salary < (SELECT MAX(salary) FROM Employees);
