--1. Thêm 5 sản phẩm
INSERT INTO Product (name, category, price, stock)
VALUES ('Laptop Dell', 'Điện tử', 15000000, 10),
       ('iPhone 13', 'Điện tử', 20000000, 5),
       ('Chuột Logitech', 'Phụ kiện', 500000, 50),
       ('Bàn phím cơ', 'Phụ kiện', 1500000, 20),
       ('Tai nghe Sony', 'Điện tử', 3000000, 15);

--2. Hiển thị danh sách toàn bộ sản phẩm
SELECT *
FROM Product;
--3. Hiển thị 3 sản phẩm có giá cao nhất
SELECT *
FROM Product
ORDER BY price DESC
LIMIT 3;

--4. Hiển thị các sản phẩm thuộc danh mục “Điện tử” có giá nhỏ hơn 10,000,000
SELECT *
FROM Product
WHERE category = 'Điện tử'
  AND price < 10000000;

--5. Sắp xếp sản phẩm theo số lượng tồn kho tăng dần
SELECT *
FROM Product
WHERE category = 'Điện tử'
  AND price < 10000000;