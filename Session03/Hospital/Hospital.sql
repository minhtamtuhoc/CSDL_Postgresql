CREATE TABLE hospital.Departments
(
    department_id   SERIAL PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);
CREATE TABLE hospital.Patients
(
    patient_id SERIAL PRIMARY KEY,
    name       VARCHAR(255) NOT NULL,
    dob        DATE,
    gender     VARCHAR(10),
    address    VARCHAR(255)
);
CREATE TABLE hospital.Doctors
(
    doctor_id      SERIAL PRIMARY KEY,
    name           VARCHAR(255) NOT NULL,
    specialization VARCHAR(255),
    department_id  INT,
    FOREIGN KEY (department_id)
        REFERENCES hospital.Departments (department_id)
);
CREATE TABLE hospital.MedicalRecords
(
    record_id  SERIAL PRIMARY KEY,
    patient_id INT,
    doctor_id  INT,
    diagnosis  TEXT,
    treatment  TEXT,
    visit_date DATE,
    FOREIGN KEY (patient_id)
        REFERENCES hospital.Patients (patient_id),
    FOREIGN KEY (doctor_id)
        REFERENCES hospital.Doctors (doctor_id)
);