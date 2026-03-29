--1. Thêm ít nhất 6 khóa học vào bảng
INSERT INTO Course (name, duration, price) VALUES
                                               ('SQL Cơ bản', 20, 500000),
                                               ('SQL Nâng cao', 40, 1200000),
                                               ('Java Programming', 50, 2000000),
                                               ('Web Development', 35, 1800000),
                                               ('Python cho người mới', 25, 900000),
                                               ('SQL Demo Course', 10, 300000);

--2. Cập nhật giá tăng 15% cho các khóa học có thời lượng trên 30 giờ
UPDATE Course
SET price = price * 1.15
WHERE duration > 30;

--3. Xóa khóa học có tên chứa từ khóa “Demo”
DELETE FROM Course
WHERE name ILIKE '%demo%';

--4. Hiển thị các khóa học có tên chứa từ “SQL” (không phân biệt hoa thường)
SELECT *
FROM Course
WHERE name ILIKE '%sql%';

--5. Lấy 3 khóa học có giá nằm giữa 500,000 và 2,000,000, sắp xếp theo giá giảm dần
SELECT *
FROM Course
WHERE price BETWEEN 500000 AND 2000000
ORDER BY price DESC
LIMIT 3;
