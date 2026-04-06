CREATE INDEX idx_orders_customer_id
    ON Orders(customer_id);

EXPLAIN ANALYZE
SELECT * FROM Orders WHERE customer_id = 10;