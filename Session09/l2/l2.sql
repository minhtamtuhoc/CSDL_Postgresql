CREATE INDEX idx_users_email_hash
    ON Users USING HASH (email);


SELECT *
FROM Users
WHERE email = 'example@example.com';

EXPLAIN
SELECT *
FROM Users
WHERE email = 'example@example.com';