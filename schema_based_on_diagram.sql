CREATE DATABASE hospital;
-- creaate patients
CREATE TABLE patients (
id INT PRIMARY KEY,
name VARCHAR(255),
date_of_birth DATE );


-- creaate patients
CREATE TABLE patients (
id INT PRIMARY KEY,
name VARCHAR(255),
date_of_birth DATE );

-- create medical histories
CREATE TABLE medical_histories (
id INT PRIMARY KEY,
admitted_at TIMESTAMP,
patient_id INT,
status VARCHAR(60),
FOREIGN KEY (patient_id) REFERENCES patients(id)
);

-- create invoices
CREATE TABLE medical_histories (
id INT PRIMARY KEY,
total_amount DECIMAL(5,2),
generated_at TIMESTAMP,
payed_at TIMESTAMP,
medical_history_id INT,
FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

-- create treatments
CREATE TABLE treatments (
id INT PRIMARY KEY,
type VARCHAR(50),
name VARCHAR(50)
);

-- create invoice items
CREATE TABLE invoice_items(
id INT PRIMARY KEY,
unit_price DECIMAL(7,2),
quantity INT,
total_price DECIMAL(12,2),
invoice_id INT,
treatment_id INT,
FOREIGN KEY (invoice_id) REFERENCES invoices(id),
FOREIGN KEY (treatment_id)  REFERENCES treatments(id), 
);

