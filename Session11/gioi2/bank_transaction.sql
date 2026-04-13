BEGIN;

-- 1. Kiểm tra số dư
SELECT balance
FROM accounts
WHERE account_id = 1;

-- 2. Trừ tiền
UPDATE accounts
SET balance = balance - 200
WHERE account_id = 1;

-- 3. Ghi log
INSERT INTO transactions (account_id, amount, trans_type)
VALUES (1, 200, 'WITHDRAW');
COMMIT;


--4. Mô phỏng lỗi
BEGIN;

UPDATE accounts
SET balance = balance - 200
WHERE account_id = 1;

INSERT INTO transactions (account_id, amount, trans_type)
VALUES (9999, 200, 'WITHDRAW');  -- lỗi FK

ROLLBACK;
