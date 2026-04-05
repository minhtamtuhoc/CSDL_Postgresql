CREATE OR REPLACE PROCEDURE calculate_discount(
    IN p_id INT,
    OUT p_final_price NUMERIC
)
    LANGUAGE plpgsql
AS
$$
DECLARE
    v_price    NUMERIC;
    v_discount INT;
BEGIN

    SELECT price, discount_percent
    INTO v_price, v_discount
    FROM products
    WHERE id = p_id;


    IF v_price IS NULL THEN
        RAISE NOTICE 'Product not found';
        p_final_price := NULL;
        RETURN;
    END IF;


    v_discount := CASE
                      WHEN v_discount > 50 THEN 50
                      ELSE v_discount
        END;

    p_final_price := v_price - (v_price * v_discount / 100);

    UPDATE products
    SET price = p_final_price
    WHERE id = p_id;

END;
$$;

CALL calculate_discount(2, NULL);
SELECT *
FROM products
WHERE id = 2;