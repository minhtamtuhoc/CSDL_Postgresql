--1. Viết truy vấn hiển thị tổng doanh thu và tổng số đơn hàng của mỗi khách hàng:
SELECT c.customer_id,
       c.customer_name,
       SUM(o.total_price) AS total_revenue,
       COUNT(o.order_id)  AS order_count
FROM customers c
         JOIN orders o
              ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > 2000;

--2. Viết truy vấn con (Subquery) để tìm doanh thu trung bình của tất cả khách hàng
WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(o.total_price) AS total_revenue
    FROM customers c
             JOIN orders o
                  ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT *
FROM customer_revenue
WHERE total_revenue > (
    SELECT AVG(total_revenue)
    FROM customer_revenue
);

--3. Dùng HAVING + GROUP BY để lọc ra thành phố có tổng doanh thu cao nhất
SELECT
    c.city,
    SUM(o.total_price) AS total_revenue
FROM customers c
         JOIN orders o
              ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC
LIMIT 1;

--4. Hãy dùng INNER JOIN giữa customers, orders, order_items để hiển thị chi tiết:
SELECT
    c.customer_name,
    c.city,
    SUM(oi.quantity) AS total_products,
    SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
         JOIN orders o
              ON c.customer_id = o.customer_id
         JOIN order_items oi
              ON o.order_id = oi.order_id
GROUP BY
    c.customer_name, c.city;