CREATE OR REPLACE FUNCTION manage_stock()
    RETURNS TRIGGER AS
$$
DECLARE
    current_stock INT;
BEGIN
    -- Lấy tồn kho hiện tại
    SELECT stock INTO current_stock
    FROM products
    WHERE id = COALESCE(NEW.product_id, OLD.product_id);

    -- ================= INSERT =================
    IF TG_OP = 'INSERT' THEN
        IF NEW.order_status = 'ACTIVE' THEN
            IF current_stock < NEW.quantity THEN
                RAISE EXCEPTION 'Not enough stock!';
            END IF;

            UPDATE products
            SET stock = stock - NEW.quantity
            WHERE id = NEW.product_id;
        END IF;

        RETURN NEW;

        -- ================= UPDATE =================
    ELSIF TG_OP = 'UPDATE' THEN

        -- Case 1: ACTIVE → ACTIVE (đổi số lượng)
        IF OLD.order_status = 'ACTIVE' AND NEW.order_status = 'ACTIVE' THEN
            IF current_stock + OLD.quantity < NEW.quantity THEN
                RAISE EXCEPTION 'Not enough stock for update!';
            END IF;

            UPDATE products
            SET stock = stock + OLD.quantity - NEW.quantity
            WHERE id = NEW.product_id;

            -- Case 2: ACTIVE → CANCELLED (hoàn kho)
        ELSIF OLD.order_status = 'ACTIVE' AND NEW.order_status = 'CANCELLED' THEN
            UPDATE products
            SET stock = stock + OLD.quantity
            WHERE id = OLD.product_id;

            -- Case 3: CANCELLED → ACTIVE (trừ kho lại)
        ELSIF OLD.order_status = 'CANCELLED' AND NEW.order_status = 'ACTIVE' THEN
            IF current_stock < NEW.quantity THEN
                RAISE EXCEPTION 'Not enough stock to reactivate!';
            END IF;

            UPDATE products
            SET stock = stock - NEW.quantity
            WHERE id = NEW.product_id;
        END IF;

        RETURN NEW;

        -- ================= DELETE =================
    ELSIF TG_OP = 'DELETE' THEN
        IF OLD.order_status = 'ACTIVE' THEN
            UPDATE products
            SET stock = stock + OLD.quantity
            WHERE id = OLD.product_id;
        END IF;

        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_manage_stock
    AFTER INSERT OR UPDATE OR DELETE
    ON orders
    FOR EACH ROW
EXECUTE FUNCTION manage_stock();

INSERT INTO products(name, stock)
VALUES ('iPhone', 50);

INSERT INTO orders(product_id, quantity, order_status)
VALUES (1, 10, 'ACTIVE');

UPDATE orders
SET quantity = 20
WHERE id = 1;

UPDATE orders
SET order_status = 'CANCELLED'
WHERE id = 1;

UPDATE orders
SET order_status = 'ACTIVE'
WHERE id = 1;

DELETE FROM orders WHERE id = 1;