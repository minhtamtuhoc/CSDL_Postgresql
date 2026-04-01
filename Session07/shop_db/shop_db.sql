--1. Thêm dữ liệu mẫu (ít nhất 5 khách hàng, 5 sản phẩm, 10 đơn hàng)
INSERT INTO customers (full_name, email, city)
VALUES ('Nguyen Van A', 'a@gmail.com', 'HCM'),
       ('Tran Thi B', 'b@gmail.com', 'Hanoi'),
       ('Le Van C', 'c@gmail.com', 'Danang'),
       ('Pham Thi D', 'd@gmail.com', 'HCM'),
       ('Hoang Van E', 'e@gmail.com', 'Can Tho');

INSERT INTO products (product_name, category, price)
VALUES ('Laptop', ARRAY ['Electronics','Computers'], 900),
       ('Phone', ARRAY ['Electronics','Mobile'], 700),
       ('Shoes', ARRAY ['Fashion'], 120),
       ('Watch', ARRAY ['Accessories','Fashion'], 300),
       ('TV', ARRAY ['Electronics','Home'], 1000);

INSERT INTO orders (customer_id, product_id, order_date, quantity)
VALUES (1, 1, '2024-01-01', 1),
       (2, 2, '2024-01-02', 2),
       (3, 3, '2024-01-03', 1),
       (1, 2, '2024-01-04', 3),
       (4, 5, '2024-01-05', 1),
       (5, 1, '2024-01-06', 2),
       (2, 3, '2024-01-07', 1),
       (3, 4, '2024-01-08', 2),
       (4, 2, '2024-01-09', 1),
       (5, 5, '2024-01-10', 1);

--2. Tối ưu truy vấn tìm kiếm khách hàng và sản phẩm:
CREATE INDEX idx_customers_email
    ON customers(email);

CREATE INDEX idx_customers_city_hash
    ON customers USING HASH(city);

CREATE INDEX idx_products_category_gin
    ON products USING GIN(category);

CREATE INDEX idx_products_price_gist
    ON products USING GiST (price);

--3. Thực hiện một số truy vấn trước và sau khi có Index:
EXPLAIN ANALYZE
SELECT * FROM customers
WHERE email = 'a@gmail.com';

EXPLAIN ANALYZE
SELECT * FROM products
WHERE category @> ARRAY['Electronics'];

EXPLAIN ANALYZE
SELECT * FROM products
WHERE price BETWEEN 500 AND 1000;

--4. Thực hiện Clustered Index trên bảng orders theo cột order_date
CLUSTER orders USING orders_pkey;

CREATE INDEX idx_orders_date
    ON orders(order_date);

CLUSTER orders USING idx_orders_date;

--5. Sử dụng View để:
--Xem top 3 khách hàng mua nhiều nhất
--Xem tổng doanh thu theo từng sản phẩm

CREATE VIEW v_top_customers AS
SELECT c.customer_id, c.full_name, SUM(o.quantity) AS total
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY total DESC
LIMIT 3;

CREATE VIEW v_product_revenue AS
SELECT p.product_name,
       SUM(o.quantity * p.price) AS revenue
FROM products p
         JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name;

--6. Thực hành cập nhật dữ liệu qua View có thể ghi:
UPDATE v_customer_city
SET city = 'Hue'
WHERE customer_id = 1;