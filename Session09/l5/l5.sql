CREATE OR REPLACE PROCEDURE calculate_total_sales(
    IN start_date DATE,
    IN end_date DATE,
    OUT total NUMERIC
)
    LANGUAGE plpgsql
AS $$

BEGIN
    SELECT SUM(amount)
    INTO total
    FROM Sales
    WHERE sale_date BETWEEN start_date AND end_date;
END;
$$;


CALL calculate_total_sales('2024-01-01', '2024-12-31', NULL);