CREATE OR REPLACE FUNCTION log_employee_changes()
    RETURNS TRIGGER AS $$
BEGIN
    -- INSERT
    IF TG_OP = 'INSERT' THEN
        INSERT INTO employees_log(employee_id, operation, old_data, new_data)
        VALUES (
                   NEW.id,
                   'INSERT',
                   NULL,
                   row_to_json(NEW)
               );
        RETURN NEW;

        -- UPDATE
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO employees_log(employee_id, operation, old_data, new_data)
        VALUES (
                   NEW.id,
                   'UPDATE',
                   row_to_json(OLD),
                   row_to_json(NEW)
               );
        RETURN NEW;

        -- DELETE
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO employees_log(employee_id, operation, old_data, new_data)
        VALUES (
                   OLD.id,
                   'DELETE',
                   row_to_json(OLD),
                   NULL
               );
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_employee
    AFTER INSERT OR UPDATE OR DELETE
    ON employees
    FOR EACH ROW
EXECUTE FUNCTION log_employee_changes();

INSERT INTO employees(name, position, salary)
VALUES ('Tuan', 'Developer', 1000);

UPDATE employees
SET salary = 1500
WHERE id = 1;

DELETE FROM employees
WHERE id = 1;
select * from employees_log