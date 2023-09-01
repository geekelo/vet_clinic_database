/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    species VARCHAR(255)
);

CREATE TABLE owners (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name VARCHAR(255),
    age INT
);

CREATE TABLE species (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255)
);
