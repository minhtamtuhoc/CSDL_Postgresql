--1. Thêm 5 đơn hàng mẫu với tổng tiền khác nhau
INSERT INTO OrderInfo (customer_name, order_date, total_amount, status)
VALUES ('An Nguyen', '2024-10-01', 600000, 'Completed'),
       ('Binh Tran', '2024-10-05', 400000, 'Pending'),
       ('Chi Le', '2024-09-28', 800000, 'Completed'),
       ('Dung Pham', '2024-10-15', 300000, 'Cancelled'),
       ('Em Hoang', '2024-10-20', 1000000, 'Pending');

--2. Truy vấn các đơn hàng có tổng tiền lớn hơn 500,000
SELECT *
FROM OrderInfo
WHERE total_amount > 500000;

--3. Truy vấn các đơn hàng có ngày đặt trong tháng 10 năm 2024
SELECT *
FROM OrderInfo
WHERE order_date BETWEEN '2024-10-01' AND '2024-10-31';

--4. Liệt kê các đơn hàng có trạng thái khác “Completed”
SELECT *
FROM OrderInfo
WHERE status <> 'Completed';

--5. Lấy 2 đơn hàng mới nhất
SELECT *
FROM OrderInfo
ORDER BY order_date DESC
LIMIT 2;