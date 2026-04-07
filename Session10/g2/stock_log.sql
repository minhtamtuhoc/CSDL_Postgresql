CREATE OR REPLACE FUNCTION update_stock()
    RETURNS TRIGGER AS
$$
BEGIN
    -- INSERT: trừ tồn kho
    IF TG_OP = 'INSERT' THEN
        UPDATE products
        SET stock = stock - NEW.quantity
        WHERE id = NEW.product_id;

        RETURN NEW;

        -- UPDATE: điều chỉnh lại tồn kho
    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE products
        SET stock = stock + OLD.quantity - NEW.quantity
        WHERE id = NEW.product_id;

        RETURN NEW;

        -- DELETE: trả lại tồn kho
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE products
        SET stock = stock + OLD.quantity
        WHERE id = OLD.product_id;

        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_update_stock
    AFTER INSERT OR UPDATE OR DELETE
    ON orders
    FOR EACH ROW
EXECUTE FUNCTION update_stock();

INSERT INTO products(name, stock)
VALUES ('Laptop', 100);

INSERT INTO orders(product_id, quantity)
VALUES (1, 10);

UPDATE orders
SET quantity = 20
WHERE id = 1;