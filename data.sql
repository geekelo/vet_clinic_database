/* Populate database with sample data. */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Agumon', '2020-02-03', 0, true, 10.23),
       ('Gabumon', '2018-11-15', 2, true, 8.00),
       ('Pikachu', '2021-02-07', 1, false, 15.04),
       ('Devimon', '2017-05-12', 5, true, 11.00),
       ('Charmander', '2020-02-08', 0, false, -11, NULL),
       ('Plantmon', '2021-11-15', 2, true, -5.7, NULL),
       ('Squirtle', '1993-04-02', 3, false, -12.13, NULL),
       ('Angemon', '2005-06-12', 1, true, -45, NULL),
       ('Boarmon', '2005-06-07', 7, true, 20.4, NULL),
       ('Blossom', '1998-10-13', 3, true, 17, NULL),
       ('Ditto', '2022-05-14', 4, true, 22, NULL);


INSERT INTO owners (id, full_name, age) VALUES
    (1, 'Sam Smith', 34),
    (2, 'Jennifer Orwell', 19),
    (3, 'Bob', 45),
    (4, 'Melody Pond', 77),
    (5, 'Dean Winchester', 14),
    (6, 'Jodie Whittaker', 38);

-- Assuming your "animals" table has some data with names as placeholders.
-- Modify these inserts based on your actual data.

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id IS NULL;

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');


INSERT INTO species (id, name) VALUES
    (1, 'Pokemon'),
    (2, 'Digimon');
