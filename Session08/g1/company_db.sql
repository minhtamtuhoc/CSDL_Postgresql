CREATE OR REPLACE PROCEDURE adjust_salary(
    IN p_emp_id INT,
    OUT p_new_salary NUMERIC
)
    LANGUAGE plpgsql
AS
$$
DECLARE
    v_job_level INT;
    v_salary    NUMERIC;
BEGIN
    SELECT job_level, salary
    INTO v_job_level, v_salary
    FROM employees
    WHERE emp_id = p_emp_id;

    IF v_job_level IS NULL THEN
        RAISE NOTICE 'Employee not found';
        p_new_salary := NULL;
        RETURN;
    END IF;

    IF v_job_level = 1 THEN
        v_salary := v_salary * 1.05;
    ELSIF v_job_level = 2 THEN
        v_salary := v_salary * 1.10;
    ELSIF v_job_level = 3 THEN
        v_salary := v_salary * 1.15;
    END IF;

    UPDATE employees
    SET salary = v_salary
    WHERE emp_id = p_emp_id;

    p_new_salary := v_salary;
END;
$$;

CALL adjust_salary(3, NULL);
SELECT * FROM employees WHERE emp_id = 3;
