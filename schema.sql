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

-- create vet table
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    age INTEGER,
    date_of_graduation DATE
);

-- specializations table

CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    vet_id INTEGER,
    specie_name VARCHAR(255),
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN key (specie_name) REFERENCES species(name)
);

-- ADD CONSTRAINT
 ALTER TABLE species ADD CONSTRAINT name_constraint UNIQUE (name);

--
CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    vet_id INTEGER,
    animal_name VARCHAR(255),
     visit_date DATE,
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN key (animal_name) REFERENCES animals(name)
);

-- statements for optimizing the visits and owners tables
CREATE INDEX idx_visits_animal_id ON visits(animal_id);
CREATE INDEX idx_visits_vet_id ON visits(vet_id);
CREATE INDEX idx_owners_email ON owners(email);