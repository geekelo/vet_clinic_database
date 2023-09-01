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
    id INTEGER PRIMARY KEY,
    full_name VARCHAR(255),
    age INT
);

CREATE TABLE species (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255)
);

-- Add a new serial column
ALTER TABLE animals ADD COLUMN id_serial SERIAL;

-- Copy data from the existing id to the new serial column
UPDATE animals SET id_serial = id;

-- Drop the old id column
ALTER TABLE animals DROP COLUMN id;

-- Rename the new column to id
ALTER TABLE animals RENAME COLUMN id_serial TO id;

-- Set it as the primary key
ALTER TABLE animals ADD PRIMARY KEY (id);

-- drop col specied
ALTER TABLE animals DROP COLUMN species;

-- create foreign keys
ALTER TABLE animals ADD COLUMN species_id INTEGER;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owners_id INTEGER;
ALTER TABLE animals ADD FOREIGN KEY (owners_id) REFERENCES owners(id);


