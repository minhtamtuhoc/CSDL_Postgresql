
--Thực hiện giao dịch chuyển tiền hợp lệ
--Dùng BEGIN; để bắt đầu transaction
--Cập nhật giảm số dư của A, tăng số dư của B
--Dùng COMMIT; để hoàn tất
--Kiểm tra số dư mới của cả hai tài khoản

begin;

update accounts
set balance = balance - 100
where owner_name = 'A';

update accounts
set balance = balance + 100
where owner_name = 'B';

commit;

--Thử mô phỏng lỗi và Rollback
--Lặp lại quy trình trên, nhưng cố ý nhập sai account_id của người nhận
--Gọi ROLLBACK; khi xảy ra lỗi
--Kiểm tra lại số dư, đảm bảo không có thay đổi

begin;

update accounts
set balance = balance - 100
where owner_name = 'A';

update accounts
set balance = balance + 100
where account_id = 700;

commit;
rollback;