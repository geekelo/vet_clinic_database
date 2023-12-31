-- create patients
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
CREATE TABLE invoices (
id INT PRIMARY KEY,
total_amount DECIAML(5,2),
generated_at TIMESTAMP,
payed_at TIMESTAMP,
medical_history_id INT
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
-- create many to many relationship between treatments and medical_histories using a table.
CREATE TABLE medical_history_treatments(
id INT PRIMARY KEY,
medical_history_id INT,
treatment_id INT,
FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE INDEX idx_medical_history_id ON invoices(medical_history_id);
CREATE INDEX idx_medical_history_id ON invoices(medical_history_id);
CREATE INDEX idx_invoice_id ON invoice_items(invoice_id);
CREATE INDEX idx_treatment_id ON invoice_items(treatment_id);
CREATE INDEX idx_treatment_id_2 ON medical_history_treatments(treatment_id);
CREATE INDEX idx_medical_history_id_2 ON medical_history_treatments(medical_history_id);