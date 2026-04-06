CREATE OR REPLACE PROCEDURE update_product_price(
    IN p_category_id INT,
    IN p_increase_percent NUMERIC
)
    LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    new_price NUMERIC;
BEGIN
    FOR rec IN
        SELECT product_id, price
        FROM Products
        WHERE category_id = p_category_id
        LOOP
            -- Tính giá mới
            new_price := rec.price * (1 + p_increase_percent / 100);

            -- Cập nhật lại bảng
            UPDATE Products
            SET price = new_price
            WHERE product_id = rec.product_id;
        END LOOP;
END;
$$;

CALL update_product_price(1, 10);
SELECT * FROM Products WHERE category_id = 1;