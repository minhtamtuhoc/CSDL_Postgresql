--1.
--Tạo Transaction đặt vé thành công
--Bắt đầu transaction bằng BEGIN;
--Giảm số ghế của chuyến bay 'VN123' đi 1
--Thêm bản ghi đặt vé của khách hàng 'Nguyen Van A'
--Kết thúc bằng COMMIT;
--Kiểm tra lại dữ liệu bảng flights và bookings
select * from bookings;
select * from flights;

begin;

update flights
set available_seats = available_seats - 1
where flight_name = 'VN123';

insert into bookings(flight_id, customer_name)
values((select flight_id from flights where flight_name = 'VN123'), 'Nguyen Van A');

commit;

--2.
--Mô phỏng lỗi và Rollback
--Thực hiện lại các bước trên nhưng nhập sai flight_id trong bảng bookings
--Gọi ROLLBACK; để hủy toàn bộ thay đổi
--Kiểm tra lại dữ liệu và chứng minh rằng số ghế không thay đổi
begin;

update flights
set available_seats = available_seats - 1
where flight_name = 'VN123';

insert into bookings(flight_id, customer_name)
values(999, 'Nguyen Van A');

commit;

rollback;

