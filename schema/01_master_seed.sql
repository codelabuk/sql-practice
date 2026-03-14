
-- ─── Employees / Departments ─────────────────────────────────

DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department (
    id   INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Employee (
    id           INT PRIMARY KEY,
    name         VARCHAR(50),
    salary       INT,
    managerId    INT,
    departmentId INT,
    FOREIGN KEY (departmentId) REFERENCES Department(id)
);

INSERT INTO Department VALUES (1, 'IT'), (2, 'Sales'), (3, 'HR');

INSERT INTO Employee VALUES
    (1, 'Joe',   85000, 4, 1),
    (2, 'Henry', 80000, 4, 2),
    (3, 'Sam',   60000, NULL, 2),
    (4, 'Max',   90000, NULL, 1),
    (5, 'Janet', 69000, 4, 1),
    (6, 'Randy', 85000, 4, 1),
    (7, 'Will',  70000, 4, 2);

-- ─── Person / Address (q175) ──────────────────────────────────

DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Person;

CREATE TABLE Person (
    personId  INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName  VARCHAR(50)
);

CREATE TABLE Address (
    addressId INT PRIMARY KEY,
    personId  INT,
    city      VARCHAR(50),
    state     VARCHAR(50)
);

INSERT INTO Person VALUES (1, 'Wang', 'Allen'), (2, 'Alice', 'Bob');
INSERT INTO Address VALUES (1, 2, 'New York City', 'New York'), (2, 3, 'Leetcode', 'California');

-- ─── Orders / Customers ───────────────────────────────────────

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    id   INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Orders (
    id         INT PRIMARY KEY,
    customerId INT,
    amount     INT,
    orderDate  DATE
);

INSERT INTO Customers VALUES (1, 'Joe'), (2, 'Henry'), (3, 'Sam'), (4, 'Max');
INSERT INTO Orders VALUES
    (1, 3, 500,  '2024-01-10'),
    (2, 1, 200,  '2024-01-15'),
    (3, 1, 800,  '2024-02-01'),
    (4, 2, 300,  '2024-02-14'),
    (5, 3, 1200, '2024-03-01');

-- ─── Scores (for ranking problems) ───────────────────────────

DROP TABLE IF EXISTS Scores;

CREATE TABLE Scores (
    id    INT PRIMARY KEY,
    score DECIMAL(5,2)
);

INSERT INTO Scores VALUES
    (1, 3.50), (2, 3.65), (3, 4.00),
    (4, 3.85), (5, 4.00), (6, 3.65);

-- ─── Logs (for consecutive/gap problems) ─────────────────────

DROP TABLE IF EXISTS Logs;

CREATE TABLE Logs (
    id  INT PRIMARY KEY,
    num INT
);

INSERT INTO Logs VALUES (1,1),(2,1),(3,1),(4,2),(5,1),(6,2),(7,2);

-- ─── Activity (for window function practice) ─────────────────

DROP TABLE IF EXISTS Activity;

CREATE TABLE Activity (
    player_id   INT,
    device_id   INT,
    event_date  DATE,
    games_played INT
);

INSERT INTO Activity VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);

SELECT 'Schema loaded OK' AS status;
