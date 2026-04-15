-- Customer
CREATE TABLE Customer
(
    customer_id        VARCHAR(5) PRIMARY KEY,
    customer_full_name VARCHAR(100)        NOT NULL,
    customer_email     VARCHAR(100) UNIQUE NOT NULL,
    customer_phone     VARCHAR(15)         NOT NULL,
    customer_address   VARCHAR(255)        NOT NULL
);

-- Room
CREATE TABLE Room
(
    room_id     VARCHAR(5) PRIMARY KEY,
    room_type   VARCHAR(50)    NOT NULL,
    room_price  DECIMAL(10, 2) NOT NULL,
    room_status VARCHAR(20)    NOT NULL,
    room_area   INT            NOT NULL
);

-- Booking
CREATE TABLE Booking
(
    booking_id     SERIAL PRIMARY KEY,
    customer_id    VARCHAR(5) NOT NULL,
    room_id        VARCHAR(5) NOT NULL,
    check_in_date  DATE       NOT NULL,
    check_out_date DATE       NOT NULL,
    total_amount   DECIMAL(10, 2),

    FOREIGN KEY (customer_id) REFERENCES Customer (customer_id),
    FOREIGN KEY (room_id) REFERENCES Room (room_id)
);

-- Payment
CREATE TABLE Payment
(
    payment_id     SERIAL PRIMARY KEY,
    booking_id     INT            NOT NULL,
    payment_method VARCHAR(50)    NOT NULL,
    payment_date   DATE           NOT NULL,
    payment_amount DECIMAL(10, 2) NOT NULL,

    FOREIGN KEY (booking_id) REFERENCES Booking (booking_id)
);

-- Customer
INSERT INTO Customer
VALUES ('C001', 'Nguyen Anh Tu', 'tu.nguyen@example.com', '0912345678', 'Hanoi, Vietnam'),
       ('C002', 'Tran Thi Mai', 'mai.tran@example.com', '0923456789', 'Ho Chi Minh, Vietnam'),
       ('C003', 'Le Minh Hoang', 'hoang.le@example.com', '0934567890', 'Danang, Vietnam'),
       ('C004', 'Pham Hoang Nam', 'nam.pham@example.com', '0945678901', 'Hue, Vietnam'),
       ('C005', 'Vu Minh Thu', 'thu.vu@example.com', '0956789012', 'Hai Phong, Vietnam'),
       ('C006', 'Nguyen Thi Lan', 'lan.nguyen@example.com', '0967890123', 'Quang Ninh, Vietnam'),
       ('C007', 'Bui Minh Tuan', 'tuan.bui@example.com', '0978901234', 'Bac Giang, Vietnam'),
       ('C008', 'Pham Quang Hieu', 'hieu.pham@example.com', '0989012345', 'Quang Nam, Vietnam'),
       ('C009', 'Le Thi Lan', 'lan.le@example.com', '0990123456', 'Da Lat, Vietnam'),
       ('C010', 'Nguyen Thi Mai', 'mai.nguyen@example.com', '0901234567', 'Can Tho, Vietnam');

-- Room
INSERT INTO Room
VALUES ('R001', 'Single', 100, 'Available', 25),
       ('R002', 'Double', 150, 'Booked', 40),
       ('R003', 'Suite', 250, 'Available', 60),
       ('R004', 'Single', 120, 'Booked', 30),
       ('R005', 'Double', 160, 'Available', 35);

-- Booking
INSERT INTO Booking
VALUES (1, 'C001', 'R001', '2025-03-01', '2025-03-05', 400),
       (2, 'C002', 'R002', '2025-03-02', '2025-03-06', 600),
       (3, 'C003', 'R003', '2025-03-03', '2025-03-07', 1000),
       (4, 'C004', 'R004', '2025-03-04', '2025-03-08', 480),
       (5, 'C005', 'R005', '2025-03-05', '2025-03-09', 800),
       (6, 'C006', 'R001', '2025-03-06', '2025-03-10', 400),
       (7, 'C007', 'R002', '2025-03-07', '2025-03-11', 600),
       (8, 'C008', 'R003', '2025-03-08', '2025-03-12', 1000),
       (9, 'C009', 'R004', '2025-03-09', '2025-03-13', 480),
       (10, 'C010', 'R005', '2025-03-10', '2025-03-14', 800);

-- Payment
INSERT INTO Payment
VALUES (1, 1, 'Cash', '2025-03-05', 400),
       (2, 2, 'Credit Card', '2025-03-06', 600),
       (3, 3, 'Bank Transfer', '2025-03-07', 1000),
       (4, 4, 'Cash', '2025-03-08', 480),
       (5, 5, 'Credit Card', '2025-03-09', 800),
       (6, 6, 'Bank Transfer', '2025-03-10', 400),
       (7, 7, 'Cash', '2025-03-11', 600),
       (8, 8, 'Credit Card', '2025-03-12', 1000),
       (9, 9, 'Bank Transfer', '2025-03-13', 480),
       (10, 10, 'Cash', '2025-03-14', 800);


---------------------------------------------------------------------------------------------
--3. Cập nhật dữ liệu
UPDATE Booking b
SET total_amount = r.room_price * (b.check_out_date - b.check_in_date)
FROM Room r
WHERE b.room_id = r.room_id
  AND r.room_status = 'Booked'
  AND b.check_in_date < CURRENT_DATE;

--4. Xóa dữ liệu
Select *
From Payment;
DELETE
FROM Payment
WHERE payment_method = 'Cash'
  AND payment_amount < 500;

--5. Lấy thông tin khách hàng gồm mã khách hàng, họ tên, email, số điện thoại và
-- địa chỉ được sắp xếp theo họ tên khách hàng tăng dần.
SELECT *
FROM Customer
ORDER BY customer_full_name ASC;

--6. Lấy thông tin các phòng khách sạn gồm mã phòng, loại phòng,
-- giá phòng và diện tích phòng, sắp xếp theo giá phòng giảm dần.
SELECT room_id, room_type, room_price, room_area
FROM Room
ORDER BY room_price DESC;

--7. Lấy thông tin khách hàng và phòng khách sạn đã đặt, gồm mã khách hàng,
-- họ tên khách hàng, mã phòng, ngày nhận phòng và ngày trả phòng.
SELECT c.customer_id,
       c.customer_full_name,
       b.room_id,
       b.check_in_date,
       b.check_out_date
FROM Customer c
         JOIN Booking b ON c.customer_id = b.customer_id;

--8. Lấy danh sách khách hàng và tổng tiền đã thanh toán khi đặt phòng, gồm mã khách hàng, họ tên khách hàng,
-- phương thức thanh toán và số tiền thanh toán, sắp xếp theo số tiền thanh toán giảm dần.
SELECT c.customer_id,
       c.customer_full_name,
       p.payment_method,
       p.payment_amount
FROM Customer c
         JOIN Booking b ON c.customer_id = b.customer_id
         JOIN Payment p ON b.booking_id = p.booking_id
ORDER BY p.payment_amount DESC;

--9. Lấy thông tin khách hàng từ vị trí thứ 2 đến thứ 4 trong bảng Customer được sắp xếp theo tên khách hàng.
SELECT *
FROM Customer
ORDER BY customer_full_name
LIMIT 3 OFFSET 1;

--10. Lấy danh sách khách hàng đã đặt ít nhất 2 phòng và có tổng số tiền thanh toán trên 1000,
-- gồm mã khách hàng, họ tên khách hàng và số lượng phòng đã đặt.
SELECT c.customer_id,
       c.customer_full_name,
       COUNT(b.booking_id) AS total_rooms
FROM Customer c
         JOIN Booking b ON c.customer_id = b.customer_id
         JOIN Payment p ON b.booking_id = p.booking_id
GROUP BY c.customer_id, c.customer_full_name
HAVING COUNT(b.booking_id) >= 2
   AND SUM(p.payment_amount) > 1000;

--11. Lấy danh sách các phòng có tổng số tiền thanh toán dưới 1000 và có ít nhất 3 khách hàng đặt,
-- gồm mã phòng, loại phòng, giá phòng và tổng số tiền thanh toán.
SELECT r.room_id,
       r.room_type,
       r.room_price,
       SUM(p.payment_amount) AS total_payment
FROM Room r
         JOIN Booking b ON r.room_id = b.room_id
         JOIN Payment p ON b.booking_id = p.booking_id
GROUP BY r.room_id, r.room_type, r.room_price
HAVING SUM(p.payment_amount) < 1000
   AND COUNT(DISTINCT b.customer_id) >= 3;

--12. Lấy danh sách các khách hàng có tổng số tiền thanh toán lớn hơn 1000, gồm mã khách hàng,
-- họ tên khách hàng, mã phòng, tổng số tiền thanh toán.
SELECT c.customer_id,
       c.customer_full_name,
       b.room_id,
       SUM(p.payment_amount) AS total_payment
FROM Customer c
         JOIN Booking b ON c.customer_id = b.customer_id
         JOIN Payment p ON b.booking_id = p.booking_id
GROUP BY c.customer_id, c.customer_full_name, b.room_id
HAVING SUM(p.payment_amount) > 1000;

--13. Lấy danh sách các khách hàng Mmã KH, Họ tên, Email, SĐT) có họ tên chứa chữ "Minh" hoặc địa chỉ (address)
-- ở "Hanoi". Sắp xếp kết quả theo họ tên tăng dần.
SELECT *
FROM Customer
WHERE customer_full_name ILIKE '%Minh%'
   OR customer_address ILIKE '%Hanoi%'
ORDER BY customer_full_name;

--14. Lấy danh sách tất cả các phòng (Mã phòng, Loại phòng, Giá), sắp xếp theo giá phòng giảm dần.
-- Hiển thị 5 phòng tiếp theo sau 5 phòng đầu tiên (tức là lấy kết quả của trang thứ 2, biết mỗi trang có 5 phòng).
SELECT room_id, room_type, room_price
FROM Room
ORDER BY room_price DESC
LIMIT 5 OFFSET 5;

--15.  Hãy tạo một view để lấy thông tin các phòng và khách hàng đã đặt, với điều kiện
-- ngày nhận phòng nhỏ hơn ngày 2025-03-10. Cần hiển thị các thông tin sau:
-- Mã phòng, Loại phòng, Mã khách hàng, họ tên khách hàng
CREATE VIEW view_booking_before_0310 AS
SELECT r.room_id,
       r.room_type,
       c.customer_id,
       c.customer_full_name
FROM Booking b
         JOIN Room r ON b.room_id = r.room_id
         JOIN Customer c ON b.customer_id = c.customer_id
WHERE b.check_in_date < '2025-03-10';

--16. Hãy tạo một view để lấy thông tin khách hàng và phòng đã đặt, với điều kiện diện tích phòng lớn hơn 30 m².
-- Cần hiển thị các thông tin sau: Mã khách hàng, Họ tên khách hàng, Mã phòng, Diện tích phòng
CREATE VIEW view_room_area_over_30 AS
SELECT c.customer_id,
       c.customer_full_name,
       r.room_id,
       r.room_area
FROM Booking b
         JOIN Room r ON b.room_id = r.room_id
         JOIN Customer c ON b.customer_id = c.customer_id
WHERE r.room_area > 30;

--17. Hãy tạo một trigger check_insert_booking để kiểm tra dữ liệu mối khi chèn vào bảng Booking.
-- Kiểm tra nếu ngày đặt phòng mà sau ngày trả phòng thì thông báo lỗi với nội dung
-- “Ngày đặt phòng không thể sau ngày trả phòng được !” và hủy thao tác chèn dữ liệu vào bảng.
CREATE OR REPLACE FUNCTION check_booking_date()
    RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.check_in_date > NEW.check_out_date THEN
        RAISE EXCEPTION 'Ngày đặt phòng không thể sau ngày trả phòng được !';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_insert_booking
    BEFORE INSERT
    ON Booking
    FOR EACH ROW
EXECUTE FUNCTION check_booking_date();

--18. Hãy tạo một trigger có tên là update_room_status_on_booking để tự động cập nhật trạng thái phòng thành "Booked"
-- khi một phòng được đặt (khi có bản ghi được INSERT vào bảng Booking).
CREATE OR REPLACE FUNCTION update_room_status()
    RETURNS TRIGGER AS
$$
BEGIN
    UPDATE Room
    SET room_status = 'Booked'
    WHERE room_id = NEW.room_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_room_status_on_booking
    AFTER INSERT
    ON Booking
    FOR EACH ROW
EXECUTE FUNCTION update_room_status();
