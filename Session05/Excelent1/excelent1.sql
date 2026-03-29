--1. Liệt kê danh sách sinh viên cùng tên môn học và điểm
-- dùng bí danh bảng ngắn (vd. s, c, e)
-- và bí danh cột như Tên sinh viên, Môn học, Điểm
SELECT s.full_name   AS "Tên sinh viên",
       c.course_name AS "Môn học",
       e.score       AS "Điểm"
FROM students s
         JOIN enrollments e ON s.student_id = e.student_id
         JOIN courses c ON e.course_id = c.course_id;

--2. Tính cho từng sinh viên:
-- Điểm trung bình
-- Điểm cao nhất
-- Điểm thấp nhất
SELECT s.full_name,
       AVG(e.score) AS avg_score,
       MAX(e.score) AS max_score,
       MIN(e.score) AS min_score
FROM students s
         JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name;


--3. Tìm ngành học (major) có điểm trung bình cao hơn 7.5
SELECT s.major,
       AVG(e.score) AS avg_score
FROM students s
         JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.major
HAVING AVG(e.score) > 7.5;

--4. Liệt kê tất cả sinh viên, môn học, số tín chỉ và điểm (JOIN 3 bảng)

SELECT s.full_name,
       c.course_name,
       c.credit,
       e.score
FROM students s
         JOIN enrollments e ON s.student_id = e.student_id
         JOIN courses c ON e.course_id = c.course_id;
--5. Tìm sinh viên có điểm trung bình cao hơn điểm trung bình toàn trường

SELECT s.full_name,
       AVG(e.score) AS avg_score
FROM students s
         JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name
HAVING AVG(e.score) > (SELECT AVG(score)
                       FROM enrollments);
