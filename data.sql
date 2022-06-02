/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Agumon', '2020-02-03', 10.23, TRUE, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Gabumon', '2018-11-15', 8, TRUE, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Pikachu', '2021-01-07', 15.04, FALSE, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Devimon', '2017-05-12', 11, TRUE, 5);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Charmander', '2020-02-08', -11, FALSE, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Plantmon', '2021-11-15', -5.7, TRUE, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Squirtle', '1993-04-02', -12.13, FALSE, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Angemon', '2005-06-12', -45, TRUE, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Boarmon', '2005-06-07', 20.4, TRUE, 7);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Blossom', '1998-10-13', 17, TRUE, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Ditto', '2022-05-14', 22, TRUE, 4);

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES ('POKEMON'), ('DIGIMON');

/* Transactions */

/* Add 'unspecified' as Species for each animal in the entire table then ROLLBACK the change */
BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

/*Sets Species to DIGIMON for all named animals with 'mon' in the name. Then sets Species to POKEMON for each remaining animal without a species set*. This is a COMMIT Transaction (permanent change)*/
BEGIN;
UPDATE animals SET species = 'DIGIMON' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'DIGIMON' WHERE species IS NULL;
COMMIT;


/*Deletes ALL records in the database, then rolls-back the deletion to bring back all of the data*/
BEGIN;
DELETE FROM animals;
ROLLBACK;

/*Deletes all animals born after January 1st 2022, makes a savepoint after the deletion, updates all animals to the product of their weight_kg * -1, rolls-back to the previous savepoint, multiplies the weight of ONLY animals with negative weight_kg to the product of weightKG * -1. This is a COMMIT Transaction (permanent change). RESULT: All remaining animals have positive weight values*/

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/*Updates species_id for each animal with the correct species type for linking to the species table*/
BEGIN;
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon%';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;
COMMIT;

/*Updates owner_id for each animal with the correct owner for linking to the owner table*/

    OWNER TABLE EXAMPLE
 id |    full_name    | age 
----+-----------------+-----
  1 | Sam Smith       |  34
 13 | Jennifer Orwell |  19
 14 | Bob             |  45
 15 | Melody Pond     |  77
 16 | Dean Winchester |  14
 17 | Jodie Whittaker |  38

UPDATE animals SET owner_id = 1 WHERE name in ('Agumon');
UPDATE animals SET owner_id = 13 WHERE name in ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 14 WHERE name in ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 15 WHERE name in ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 16 WHERE name in ('Angemon', 'Boarmon');
