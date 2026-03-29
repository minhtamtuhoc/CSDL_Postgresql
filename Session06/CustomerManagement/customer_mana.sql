--1. Thêm 7 khách hàng (trong đó có 1 người không có email)
INSERT INTO Customer (name, email, points) VALUES
                                               ('An Nguyen', 'an@gmail.com', 100),
                                               ('Binh Tran', 'binh@gmail.com', 200),
                                               ('Chi Le', 'chi@gmail.com', 150),
                                               ('Dung Pham', NULL, 80),           -- không có email
                                               ('Em Hoang', 'em@gmail.com', 300),
                                               ('An Nguyen', 'an2@gmail.com', 120), -- trùng tên
                                               ('Tuan Le', 'tuan@gmail.com', 250);

--2. Truy vấn danh sách tên khách hàng duy nhất (DISTINCT)
SELECT DISTINCT name
FROM Customer;

--3. Tìm các khách hàng chưa có email (IS NULL)
SELECT *
FROM Customer
WHERE email IS NULL;

--4. Hiển thị 3 khách hàng có điểm thưởng cao nhất, bỏ qua khách hàng cao điểm nhất (gợi ý: dùng OFFSET)
SELECT *
FROM Customer
ORDER BY points DESC
LIMIT 3 OFFSET 1;

--5. Sắp xếp danh sách khách hàng theo tên giảm dần
SELECT *
FROM Customer
ORDER BY name DESC;