CREATE OR REPLACE FUNCTION update_stock_after_sale()
    RETURNS TRIGGER AS $$
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_stock
    AFTER INSERT ON sales
    FOR EACH ROW
EXECUTE FUNCTION update_stock_after_sale();