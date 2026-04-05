CREATE OR REPLACE PROCEDURE calculate_bonus(
    IN p_emp_id INT,
    IN p_percent NUMERIC,
    OUT p_bonus NUMERIC
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

    -- Nếu không tồn tại → lỗi
    IF v_salary IS NULL THEN
        RAISE EXCEPTION 'Employee not found';
    END IF;

    -- Nếu % <= 0 → không thưởng
    IF p_percent <= 0 THEN
        p_bonus := 0;
    ELSE
        p_bonus := v_salary * p_percent / 100;
    END IF;

    -- Cập nhật vào bảng
    UPDATE employees
    SET bonus = p_bonus
    WHERE id = p_emp_id;

END;
$$;
CALL calculate_bonus(2, 10, NULL);
SELECT * FROM employees WHERE id = 2;