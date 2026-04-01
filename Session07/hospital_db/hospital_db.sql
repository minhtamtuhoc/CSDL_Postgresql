--1. Thêm dữ liệu mẫu
-- Patients
INSERT INTO patients (full_name, phone, city, symptoms)
VALUES ('Nguyen Van A', '0901111111', 'HCM', ARRAY ['fever','cough']),
       ('Tran Thi B', '0902222222', 'Hanoi', ARRAY ['headache']),
       ('Le Van C', '0903333333', 'Danang', ARRAY ['fever','fatigue']),
       ('Pham Thi D', '0904444444', 'HCM', ARRAY ['cough']),
       ('Hoang Van E', '0905555555', 'Can Tho', ARRAY ['stomachache']);

-- Doctors
INSERT INTO doctors (full_name, department)
VALUES ('Dr. An', 'Cardiology'),
       ('Dr. Binh', 'Neurology'),
       ('Dr. Cuong', 'General'),
       ('Dr. Dung', 'Pediatrics'),
       ('Dr. Em', 'Orthopedics');

-- Appointments
INSERT INTO appointments (patient_id, doctor_id, appointment_date, diagnosis, fee)
VALUES (1, 1, '2024-01-01', 'Flu', 200),
       (2, 2, '2024-01-02', 'Migraine', 300),
       (3, 3, '2024-01-03', 'Fever', 150),
       (1, 3, '2024-01-04', 'Checkup', 100),
       (4, 4, '2024-01-05', 'Cold', 120),
       (5, 5, '2024-01-06', 'Stomach pain', 250),
       (2, 1, '2024-01-07', 'Heart check', 400),
       (3, 2, '2024-01-08', 'Headache', 180),
       (4, 3, '2024-01-09', 'Flu', 160),
       (5, 4, '2024-01-10', 'General check', 220);

--2. Tạo index
CREATE INDEX idx_patients_phone
    ON patients(phone);
SELECT * FROM patients WHERE phone = '0901111111';

CREATE INDEX idx_patients_city_hash
    ON patients USING HASH(city);
SELECT * FROM patients WHERE city = 'HCM';

CREATE INDEX idx_patients_symptoms_gin
    ON patients USING GIN(symptoms);
SELECT * FROM patients
WHERE symptoms @> ARRAY['fever'];

CREATE INDEX idx_appointments_fee
    ON appointments(fee);
SELECT * FROM appointments
WHERE fee BETWEEN 100 AND 300;

--3. Tạo Clustered Index trên bảng appointments theo ngày khám
CREATE INDEX idx_appointments_date
    ON appointments(appointment_date);

CLUSTER appointments USING idx_appointments_date;


--4. Thực hiện các truy vấn trên View:
--Tìm top 3 bệnh nhân có tổng phí khám cao nhất

CREATE VIEW v_top_patients AS
SELECT p.patient_id, p.full_name,
       SUM(a.fee) AS total_fee
FROM patients p
         JOIN appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.full_name
ORDER BY total_fee DESC
LIMIT 3;

SELECT * FROM v_top_patients;
--Tính tổng số lượt khám theo bác sĩ
CREATE VIEW v_doctor_appointments AS
SELECT d.full_name,
       COUNT(a.appointment_id) AS total_visits
FROM doctors d
         LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.full_name;

--5. Tạo View có thể cập nhật để thay đổi city của bệnh nhân:
--Thử cập nhật thành phố của 1 bệnh nhân qua View và kiểm tra lại bảng patients
CREATE VIEW v_patient_city AS
SELECT patient_id, full_name, city
FROM patients
        WITH CHECK OPTION;
select * from v_patient_city
UPDATE v_patient_city
SET city = 'Hue'
WHERE patient_id = 1;