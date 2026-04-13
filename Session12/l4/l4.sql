CREATE OR REPLACE FUNCTION calculate_total_amount()
    RETURNS TRIGGER AS $$
DECLARE
    product_price NUMERIC(10,2);
BEGIN
    -- Lấy giá sản phẩm
    SELECT price INTO product_price
    FROM products
    WHERE product_id = NEW.product_id;

    -- Nếu không có sản phẩm
    IF product_price IS NULL THEN
        RAISE EXCEPTION 'Product not found!';
    END IF;

    -- Tính tổng tiền
    NEW.total_amount := NEW.quantity * product_price;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_calculate_total
    BEFORE INSERT ON orders
    FOR EACH ROW
EXECUTE FUNCTION calculate_total_amount();