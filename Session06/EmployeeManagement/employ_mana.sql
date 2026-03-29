--1. Thêm 6 nhân viên mới
INSERT INTO Employee (name, department, salary, hire_date) VALUES
                                                               ('An Nguyen', 'IT', 10000000, '2023-02-01'),
                                                               ('Binh Tran', 'HR', 8000000, '2022-05-10'),
                                                               ('Chi Le', 'IT', 12000000, '2023-07-15'),
                                                               ('Dung Pham', 'Finance', 5000000, '2023-03-20'),
                                                               ('Anh Hoang', 'Marketing', 9000000, '2023-11-01'),
                                                               ('Tuan An', 'IT', 7000000, '2021-12-25');
--2. Cập nhật mức lương tăng 10% cho nhân viên thuộc phòng IT
UPDATE Employee
SET salary = salary * 1.1
WHERE department = 'IT';
--3. Xóa nhân viên có mức lương dưới 6,000,000
DELETE FROM Employee
WHERE salary < 6000000;
--4. Liệt kê các nhân viên có tên chứa chữ “An” (không phân biệt hoa thường)
SELECT *
FROM Employee
WHERE name ILIKE '%an%';
--5. Hiển thị các nhân viên có ngày vào làm việc trong khoảng từ '2023-01-01' đến '2023-12-31'
SELECT *
FROM Employee
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';
