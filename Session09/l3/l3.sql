CREATE INDEX idx_products_category
    ON Products(category_id);

CLUSTER Products USING idx_products_category;

CREATE INDEX idx_products_price
    ON Products(price);

SELECT *
FROM Products
WHERE category_id = 10
ORDER BY price;