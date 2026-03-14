-- Problem : 175. Combine Two Tables
-- Difficulty: Easy
-- Tags      : join, left_join
-- Date      : 
-- URL       : https://leetcode.com/problems/combine-two-tables/
--
-- Task: Report first name, last name, city, state for every person.
--       Include people with no address (NULL for city/state).
--
-- Approach: LEFT JOIN from Person to Address so all persons appear
--           even when there is no matching Address row.

-- ── Setup ────────────────────────────────────────────────────────
DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Person;

CREATE TABLE Person  (personId INT, firstName VARCHAR(50), lastName VARCHAR(50));
CREATE TABLE Address (addressId INT, personId INT, city VARCHAR(50), state VARCHAR(50));

INSERT INTO Person  VALUES (1,'Wang','Allen'), (2,'Alice','Bob');
INSERT INTO Address VALUES (1, 2,'New York City','New York'), (2, 3,'Leetcode','California');

-- ── Solution ─────────────────────────────────────────────────────
SELECT
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person p
LEFT JOIN Address a ON p.personId = a.personId;

-- Expected:
-- +----------+---------+---------------+----------+
-- | firstName| lastName| city          | state    |
-- +----------+---------+---------------+----------+
-- | Wang     | Allen   | NULL          | NULL     |
-- | Alice    | Bob     | New York City | New York |
-- +----------+---------+---------------+----------+
