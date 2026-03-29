--1. Hiển thị danh sách nhân viên gồm: Tên nhân viên, Phòng ban, Lương
-- dùng bí danh bảng ngắn (employees as e,departments as d).
SELECT e.emp_name  AS "Tên nhân viên",
       d.dept_name AS "Phòng ban",
       e.salary    AS "Lương"
FROM employees e
         JOIN departments d ON e.dept_id = d.dept_id;

--2. Tính: Tổng quỹ lương toàn công ty, Mức lương trung bìnhLương cao nhất,
-- thấp nhất, Số nhân viên
SELECT SUM(salary)   AS total_salary,
       AVG(salary)   AS avg_salary,
       MAX(salary)   AS max_salary,
       MIN(salary)   AS min_salary,
       COUNT(emp_id) AS total_employees
FROM employees;

--3. Tính mức lương trung bình của từng phòng ban
-- chỉ hiển thị những phòng ban có lương trung bình > 15.000.000
SELECT d.dept_name,
       AVG(e.salary) AS avg_salary
FROM employees e
         JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING AVG(e.salary) > 15000000;

--4. Liệt kê danh sách dự án (project) cùng với phòng ban phụ trách và nhân viên thuộc phòng ban đó
SELECT p.project_name,
       d.dept_name,
       e.emp_name
FROM projects p
         JOIN departments d ON p.dept_id = d.dept_id
         JOIN employees e ON d.dept_id = e.dept_id;

--5. Tìm nhân viên có lương cao nhất trong mỗi phòng ban
SELECT e.emp_name,
       d.dept_name,
       e.salary
FROM employees e
         JOIN departments d ON e.dept_id = d.dept_id
WHERE (e.dept_id, e.salary) IN (SELECT dept_id,
                                       MAX(salary)
                                FROM employees
                                GROUP BY dept_id);
