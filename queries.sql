/* Queries that provide answers to the questions from all projects. */

SELECT * from animals WHERE name = 'Luna';
-- Find all animals whose name ends in "mon":
SELECT * from animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT * from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts
SELECT * from animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * from animals WHERE neutered = true;

-- Find all animals not named Gabumon
SELECT * from animals WHERE name <> 'Gabuwon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;  -- Verify changes
ROLLBACK;               -- Roll back changes
SELECT * FROM animals;  -- Verify changes reverted


-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;  -- Verify changes
COMMIT;                 -- Commit changes
SELECT * FROM animals;  -- Verify changes persisted

--  Inside a transaction delete all records in the animals table, then roll back the transaction.
-- After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;)
BEGIN;
DELETE FROM animals;
ROLLBACK;               -- Roll back changes
SELECT * FROM animals;  -- Verify data still exists

-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT weight_update;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO weight_update;
UPDATE animals SET weight_kg = -weight_kg WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) from animals;

-- Who escapes the most, neutered or not-neitered?
SELECT neutered, SUM(escape_attempts) AS total_escapes FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS avg_num_of_escape FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- What animals belong to Melody Pond?
SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';


-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON o.id  = a.owner_id;

-- How many animals are there per species?
SELECT s.name, COUNT(*)
FROM species s
JOIN animals a ON s.id = a.species_id
GROUP BY s.name;
-- OR
SELECT s.name, COUNT(*) as num_of_animals
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT o.full_name, COUNT(*)
FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY count DESC
LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT a.name, vi.visit_date
FROM visits vi
JOIN animals a ON vi.animal_name = a.name
JOIN vets v ON vi.vet_id = v.id
WHERE v.name = 'William Tatcher'
ORDER BY vi.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT DISTINCT vi.animal_name
FROM visits vi
JOIN vets v ON vi.vet_id = v.id
WHERE V.NAME = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name AS vet_name, COALESCE(s.specie_name, 'No Specialization') AS specialty
FROM vets v
LEFT JOIN specializations s ON v.id = s.vet_id
ORDER BY vet_name;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT DISTINCT a.name AS animal_name
FROM visits vi
JOIN vets v ON vi.vet_id = v.id
JOIN animals a ON vi.animal_name = a.name
WHERE v.name = 'Stephanie Mendez'
AND vi.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT a.name AS animal_name, COUNT(vi.vet_id) AS num_visits
FROM visits vi
JOIN animals a ON vi.animal_name = a.name
GROUP BY a.name
ORDER BY num_visits DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT a.name AS animal_name, vi.visit_date
FROM visits vi
JOIN animals a ON vi.animal_name = a.name
JOIN vets v ON vi.vet_id = v.id
WHERE a.owner_id = (SELECT id FROM owners WHERE full_name = 'Maisy Smith')
ORDER BY vi.visit_date ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name AS animal_name, v.name AS vet_name, vi.visit_date
FROM visits vi
JOIN animals a ON vi.animal_name = a.name
JOIN vets v ON vi.vet_id = v.id
ORDER BY vi.visit_date DESC
LIMIT 1;


-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS num_visits_without_specialization
FROM visits vi
JOIN animals a ON vi.animal_name = a.name
JOIN vets v ON vi.vet_id = v.id
LEFT JOIN specializations s ON v.id = s.vet_id
WHERE (s.vet_id IS NULL) OR (s.specie_name <> a.species_id::VARCHAR);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.specie_name, COUNT(*) AS num_owned
FROM animals a
JOIN owners o ON a.owner_id = o.id
LEFT JOIN specializations s ON a.species_id = s.id
WHERE o.full_name = 'Maisy Smith'
GROUP BY s.specie_name
ORDER BY num_owned DESC
LIMIT 1;

-- QUERIS TO CHECK PERFORMANCE
SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';
