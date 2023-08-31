/* Queries that provide answers to the questions from all projects. */

SELECT * from animals WHERE name = 'Luna';
-- Find all animals whose name ends in "mon":
SELECT * from animals WHERE name LIKE '%mon';