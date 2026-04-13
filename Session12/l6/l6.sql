BEGIN;

-- 1. Kiểm tra số dư
SELECT balance
FROM accounts
WHERE account_id = 1;

-- 2. Trừ tiền A
UPDATE accounts
SET balance = balance - 300
WHERE account_id = 1;

-- 3. Cộng tiền B
UPDATE accounts
SET balance = balance + 300
WHERE account_id = 2;

COMMIT;