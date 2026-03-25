--1. Chèn dữ liệu mới
INSERT INTO students (full_name, gender, birth_year, major, gpa)
VALUES ('Phan Hoàng Nam', 'Nam', 2003, 'CNTT', 3.8);

--2. Cập nhật dữ liệu
UPDATE students
SET gpa = 3.4
WHERE full_name = 'Lê Quốc Cường';

--3. Xóa dữ liệu
DELETE FROM students
WHERE gpa IS NULL;

--4. Hiển thị sinh viên ngành CNTT có gpa >= 3.0, chỉ lấy 3 kết quả đầu tiên
SELECT *
FROM students
WHERE major = 'CNTT' AND gpa >= 3.0
LIMIT 3;

--5. Liệt kê danh sách ngành học duy nhất
SELECT DISTINCT major
FROM students;

--6. Hiển thị sinh viên ngành CNTT, sắp xếp giảm dần theo GPA, sau đó tăng dần theo tên
SELECT *
FROM students
WHERE major = 'CNTT'
ORDER BY gpa DESC, full_name ASC;

--7. Tìm sinh viên có tên bắt đầu bằng “Nguyễn”
SELECT *
FROM students
WHERE full_name LIKE 'Nguyễn%';

--8. Hiển thị sinh viên có năm sinh từ 2001 đến 2003
SELECT *
FROM students
WHERE birth_year BETWEEN 2001 AND 2003;