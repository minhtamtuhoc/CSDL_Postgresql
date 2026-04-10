--Viết Transaction thực hiện toàn bộ quy trình đặt hàng cho khách
-- "Nguyen Van A" gồm:
--Mua 2 sản phẩm:
--product_id = 1, quantity = 2
--product_id = 2, quantity = 1
--Nếu một trong hai sản phẩm không đủ hàng, toàn bộ giao dịch phải bị ROLLBACK
--Nếu thành công, COMMIT và cập nhật chính xác số lượng tồn kho

--1. Kiểm tra tồn kho product 1
begin;

select *
from products
where product_id = 1
  and stock >= 2
    for update;

--2. Kiểm tra tồn kho product 2
select *
from products
where product_id = 2
  and stock >= 1 for update;

-- 3. Trừ tồn kho
update products
set stock = stock - 2
where product_id = 1;

update products
set stock = stock - 1
where product_id = 2;

-- 4.Tạo order
insert into orders(customer_name, total_amount)
values('Nguyen Van A', 0)
returning order_id;

-- 5. Thêm order_items

INSERT INTO order_items (order_id, product_id, quantity, subtotal)
SELECT 1, product_id, 2, price * 2
FROM products
WHERE product_id = 1;

INSERT INTO order_items (order_id, product_id, quantity, subtotal)
SELECT 1, product_id, 1, price * 1
FROM products
WHERE product_id = 2;

--------------------------------------------------

-- 6. Cập nhật tổng tiền
UPDATE orders
SET total_amount = (
    SELECT SUM(subtotal)
    FROM order_items
    WHERE order_id = 1
)
WHERE order_id = 1;

--------------------------------------------------

COMMIT;
select * from orders;
select * from order_items;
select * from products;

UPDATE products
SET stock = 0
WHERE product_id = 1;

rollback;