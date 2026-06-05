CREATE DATABASE index_btree_practice;

\c index_btree_practice

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL
);

INSERT INTO Orders (customer_id, order_date, total_amount)
SELECT
    (RANDOM() * 1000)::INT,
    CURRENT_DATE - ((RANDOM() * 365)::INT),
    ROUND((RANDOM() * 10000)::NUMERIC, 2)
FROM generate_series(1, 100000);

EXPLAIN ANALYZE
SELECT *
FROM Orders
WHERE customer_id = 500;

CREATE INDEX idx_orders_customer_id
ON Orders USING BTREE (customer_id);

EXPLAIN ANALYZE
SELECT *
FROM Orders
WHERE customer_id = 500;