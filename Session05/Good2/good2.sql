--1. Hiển thị danh sách tất cả các đơn hàng với các cột:
SELECT c.customer_name AS customer_name,
       o.order_date    AS order_date,
       o.total_amount  AS total_amount
FROM orders o
         JOIN customers c ON o.customer_id = c.customer_id;

--2. Tính các thông tin tổng hợp: doanh thu, trung bình giá trị, đơn hàng lớn nhất, nhỏ nhất, số lượng đơn hàng
SELECT SUM(total_amount) AS total_revenue,
       AVG(total_amount) AS avg_order_value,
       MAX(total_amount) AS max_order,
       MIN(total_amount) AS min_order,
       COUNT(order_id)   AS total_orders
FROM orders;

--3. Tính tổng doanh thu theo từng thành phố
--chỉ hiển thị những thành phố có tổng doanh thu lớn hơn 10.000
SELECT c.city,
       SUM(o.total_amount) AS total_revenue
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 10000;

--4. Liệt kê tất cả các sản phẩm đã bán, kèm:
-- Tên khách hàng, Ngày đặt hàng, Số lượng và giá
SELECT c.customer_name,
       o.order_date,
       oi.product_name,
       oi.quantity,
       oi.price
FROM order_items oi
         JOIN orders o ON oi.order_id = o.order_id
         JOIN customers c ON o.customer_id = c.customer_id;

--5. Tìm tên khách hàng có tổng doanh thu cao nhất.
SELECT c.customer_name
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) = (SELECT MAX(total_revenue)
                              FROM (SELECT SUM(total_amount) AS total_revenue
                                    FROM orders
                                    GROUP BY customer_id) sub);