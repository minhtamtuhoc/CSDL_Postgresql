--1. Xóa các bản ghi trùng lặp hoàn toàn về title, author và publish_year
DELETE
FROM books a
    USING books b
WHERE a.id > b.id
  AND a.title = b.title
  AND a.author = b.author
  AND a.publish_year = b.publish_year;

--2. Tăng giá 10% cho những sách xuất bản từ năm 2021 trở đi và có price < 200000
UPDATE books
SET price = price * 1.1
WHERE publish_year >= 2021
  AND price < 200000;

--3. Với những sách có stock IS NULL, cập nhật stock = 0
UPDATE books
SET stock = 0
WHERE stock IS NULL;

--4. Liệt kê danh sách sách thuộc chủ đề CNTT hoặc AI có giá trong khoảng 100000 - 250000
--  Sắp xếp giảm dần theo price, rồi tăng dần theo title
SELECT *
FROM books
WHERE category IN ('CNTT', 'AI')
  AND price BETWEEN 100000 AND 250000
ORDER BY price DESC, title ASC;


--5. Tìm các sách có tiêu đề chứa từ “học” (không phân biệt hoa thường)
SELECT *
FROM books
WHERE title ILIKE '%học%';

--6. Liệt kê các thể loại duy nhất (DISTINCT) có ít nhất một cuốn sách xuất bản sau năm 2020
SELECT DISTINCT category
FROM books
WHERE publish_year > 2020;

--7. Chỉ hiển thị 2 kết quả đầu tiên, bỏ qua 1 kết quả đầu tiên (dùng LIMIT + OFFSET)
SELECT *
FROM books
ORDER BY price DESC
LIMIT 2 OFFSET 1;