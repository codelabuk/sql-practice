-- Topic     : Window Functions
-- Covers    : ROW_NUMBER, RANK, DENSE_RANK, NTILE,
--             LAG, LEAD, SUM/AVG OVER, FIRST_VALUE
-- Tags      : window_function, partition_by, order_by, frame
-- Reference : https://www.postgresql.org/docs/current/tutorial-window.html

-- ── Setup ────────────────────────────────────────────────────────
DROP TABLE IF EXISTS Sales;
CREATE TABLE Sales (
    id         INT,
    rep        VARCHAR(30),
    region     VARCHAR(20),
    sale_date  DATE,
    amount     INT
);

INSERT INTO Sales VALUES
    (1,  'Alice', 'North', '2024-01-05', 500),
    (2,  'Bob',   'North', '2024-01-10', 300),
    (3,  'Alice', 'North', '2024-02-01', 700),
    (4,  'Carol', 'South', '2024-01-08', 900),
    (5,  'Dave',  'South', '2024-01-20', 400),
    (6,  'Carol', 'South', '2024-02-15', 600),
    (7,  'Bob',   'North', '2024-03-01', 800),
    (8,  'Dave',  'South', '2024-03-10', 550),
    (9,  'Alice', 'North', '2024-03-15', 200),
    (10, 'Carol', 'South', '2024-04-01', 750);

-- ── 1. ROW_NUMBER  (unique rank, no ties) ────────────────────────
-- Use case: pick exactly the latest 1 row per rep
SELECT rep, region, amount, sale_date,
       ROW_NUMBER() OVER (PARTITION BY rep ORDER BY sale_date DESC) AS rn
FROM Sales;

-- ── 2. RANK vs DENSE_RANK (ties) ─────────────────────────────────
-- RANK     : ties get same rank, next rank skips  (1,1,3)
-- DENSE_RANK: ties get same rank, next rank is +1 (1,1,2)
SELECT rep, region, amount,
       RANK()       OVER (PARTITION BY region ORDER BY amount DESC) AS rnk,
       DENSE_RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS dense_rnk
FROM Sales;

-- ── 3. Running total (SUM OVER) ──────────────────────────────────
SELECT rep, sale_date, amount,
       SUM(amount) OVER (PARTITION BY rep ORDER BY sale_date
                         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
                        ) AS running_total
FROM Sales;

-- ── 4. Moving average (3-row window) ─────────────────────────────
SELECT rep, sale_date, amount,
       ROUND(AVG(amount) OVER (PARTITION BY rep ORDER BY sale_date
                               ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
                              ), 2) AS moving_avg_3
FROM Sales;

-- ── 5. LAG / LEAD (access previous/next row) ─────────────────────
-- LAG: how much did each sale change from the previous one?
SELECT rep, sale_date, amount,
       LAG(amount,  1, 0) OVER (PARTITION BY rep ORDER BY sale_date) AS prev_amount,
       amount - LAG(amount, 1, 0) OVER (PARTITION BY rep ORDER BY sale_date) AS delta
FROM Sales;

-- ── 6. NTILE (bucket into N equal groups) ────────────────────────
-- Split reps into top/mid/bottom tercile by total sales
SELECT rep,
       SUM(amount) AS total,
       NTILE(3) OVER (ORDER BY SUM(amount) DESC) AS tercile
FROM Sales
GROUP BY rep;

-- ── 7. FIRST_VALUE / LAST_VALUE ──────────────────────────────────
SELECT rep, sale_date, amount,
       FIRST_VALUE(amount) OVER (PARTITION BY rep ORDER BY sale_date) AS first_sale,
       LAST_VALUE(amount)  OVER (PARTITION BY rep ORDER BY sale_date
                                 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                                ) AS last_sale
FROM Sales;
