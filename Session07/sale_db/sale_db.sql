--1. Tạo một View tên v_order_summary hiển thị:
--full_name, total_amount, order_date
--(ẩn thông tin email và phone)
CREATE VIEW v_order_summary AS
SELECT c.full_name,
       o.total_amount,
       o.order_date
FROM customer c
         JOIN orders o ON c.customer_id = o.customer_id;

--2. Viết truy vấn để xem tất cả dữ liệu từ View
SELECT * FROM v_high_value_orders;

--3. Tạo 1 view lấy về thông tin của tất cả các đơn hàng với điều kiện total_amount ≥ 1 triệu .
--Sau đó bạn hãy cập nhật lại thông tin 1 bản ghi trong view đó nhé .
CREATE VIEW v_high_value_orders AS
SELECT *
FROM orders
WHERE total_amount >= 1000000
        WITH CHECK OPTION;

UPDATE v_high_value_orders
SET total_amount = 1200000
WHERE order_id = 1;
--4. Tạo một View thứ hai v_monthly_sales thống kê tổng doanh thu mỗi tháng
CREATE VIEW v_monthly_sales AS
SELECT DATE_TRUNC('month', order_date) AS month,
       SUM(total_amount) AS total_sales
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

SELECT * FROM v_monthly_sales;
--5. Thử DROP View và ghi chú sự khác biệt giữa DROP VIEW và DROP MATERIALIZED VIEW trong PostgreSQL
DROP VIEW v_order_summary;