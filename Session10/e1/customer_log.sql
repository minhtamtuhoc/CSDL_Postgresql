CREATE OR REPLACE FUNCTION log_customer_changes()
    RETURNS TRIGGER AS
$$
BEGIN
    -- INSERT
    IF TG_OP = 'INSERT' THEN
        INSERT INTO customers_log(customer_id, operation, old_data, new_data, changed_by)
        VALUES (
                   NEW.id,
                   'INSERT',
                   NULL,
                   row_to_json(NEW),
                   current_user
               );
        RETURN NEW;

        -- UPDATE
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO customers_log(customer_id, operation, old_data, new_data, changed_by)
        VALUES (
                   NEW.id,
                   'UPDATE',
                   row_to_json(OLD),
                   row_to_json(NEW),
                   current_user
               );
        RETURN NEW;

        -- DELETE
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO customers_log(customer_id, operation, old_data, new_data, changed_by)
        VALUES (
                   OLD.id,
                   'DELETE',
                   row_to_json(OLD),
                   NULL,
                   current_user
               );
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_log_customer
    AFTER INSERT OR UPDATE OR DELETE
    ON customers
    FOR EACH ROW
EXECUTE FUNCTION log_customer_changes();

INSERT INTO customers(name, email, phone, address)
VALUES ('Tâm', 'tam@gmail.com', '0901234567', 'HCM');

UPDATE customers
SET address = 'Hà Nội'
WHERE id = 1;

DELETE FROM customers
WHERE id = 1;

SELECT * FROM customers_log;