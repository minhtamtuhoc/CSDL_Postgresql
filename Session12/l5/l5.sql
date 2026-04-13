CREATE OR REPLACE FUNCTION log_employee_update()
    RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employee_log (emp_name, action_time)
    VALUES (NEW.name, NOW());

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_update_employee
    AFTER UPDATE ON employees
    FOR EACH ROW
EXECUTE FUNCTION log_employee_update();