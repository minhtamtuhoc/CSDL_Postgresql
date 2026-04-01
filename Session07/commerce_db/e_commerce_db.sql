--1. Tạo View tổng hợp doanh thu theo khu vực:
CREATE VIEW v_revenue_by_region AS
SELECT c.region,
       SUM(o.total_amount) AS total_revenue
FROM customer c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region;
-- Viết truy vấn xem top 3 khu vực có doanh thu cao nhất
SELECT *
FROM v_revenue_by_region
ORDER BY total_revenue DESC
LIMIT 3;

--2. Tạo View phức hợp (Nested View):
--Từ v_revenue_by_region, tạo View mới v_revenue_above_avg chỉ hiển thị khu vực có doanh thu > trung bình toàn quốc
CREATE VIEW v_revenue_above_avg AS
SELECT *
FROM v_revenue_by_region
WHERE total_revenue > (
    SELECT AVG(total_revenue)
    FROM v_revenue_by_region
);
SELECT * FROM v_revenue_above_avg;