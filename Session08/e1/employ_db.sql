CREATE OR REPLACE PROCEDURE update_employee_status(
    IN p_emp_id INT,
    OUT p_status TEXT
)
    LANGUAGE plpgsql
AS $$
DECLARE
    v_salary NUMERIC;
BEGIN
    -- Lấy lương
    SELECT salary
    INTO v_salary
    FROM employees
    WHERE id = p_emp_id;

    -- Nếu không tồn tại → ném lỗi
    IF v_salary IS NULL THEN
        RAISE EXCEPTION 'Employee not found';
    END IF;

    -- Xác định status
    IF v_salary < 5000 THEN
        p_status := 'Junior';
    ELSIF v_salary <= 10000 THEN
        p_status := 'Mid-level';
    ELSE
        p_status := 'Senior';
    END IF;

    -- Cập nhật vào bảng
    UPDATE employees
    SET status = p_status
    WHERE id = p_emp_id;

END;
$$;

CALL update_employee_status(5, NULL);
SELECT * FROM employees WHERE id = 5;