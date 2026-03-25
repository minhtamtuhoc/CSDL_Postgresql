select *
from employees

--1. Xóa các bản ghi trùng nhau hoàn toàn về tên, phòng ban và vị trí
DELETE FROM employees a
USING employees b
WHERE a.id > b.id
AND a.full_name = b.full_name
AND a.department = b.department
AND a.position = b.position;

--2a. Tăng 10% lương cho những nhân viên làm trong phòng IT có mức lương dưới 18,000,000
UPDATE employees
SET salary = salary * 1.1
WHERE department = 'IT' AND salary < 18000000;

--2b. Với nhân viên có bonus IS NULL, đặt giá trị bonus = 500000
UPDATE employees
SET bonus = 500000
WHERE bonus IS NULL;

--3a. Hiển thị danh sách nhân viên thuộc phòng IT hoặc HR, gia nhập sau năm 2020, và có tổng thu nhập (salary + bonus) lớn hơn 15,000,000
--3b. Chỉ lấy 3 nhân viên đầu tiên sau khi sắp xếp giảm dần theo tổng thu nhập
SELECT *,
       (salary + bonus) AS total_income
FROM employees
WHERE department IN ('IT', 'HR')
  AND join_year > 2020
  AND (salary + bonus) > 15000000
ORDER BY total_income DESC
LIMIT 3;


--4. Tìm tất cả nhân viên có tên bắt đầu bằng “Nguyễn” hoặc kết thúc bằng “Hân”
SELECT *
FROM employees
WHERE full_name LIKE 'Nguyễn%'
   OR full_name LIKE '%Hân';

--5. Liệt kê các phòng ban duy nhất có ít nhất một nhân viên có bonus IS NOT NULL
SELECT DISTINCT department
FROM employees
WHERE bonus IS NOT NULL;

--6. Hiển thị nhân viên gia nhập trong khoảng từ 2019 đến 2022 (BETWEEN)
SELECT *
FROM employees
WHERE join_year BETWEEN 2019 AND 2022;