/* Returns all data for Agumon, Gabumon, & Devimon*/
SELECT * FROM animals WHERE name LIKE '%mon%';

/*Returns Gabumon & Devimon who were born between the years 2016 & 2019*/
SELECT name FROM animals WHERE '[2016-01-01, 2019-12-31]'::daterange @> date_of_birth;

/*Returns Agumon & Gabumon*/
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

/* Returns 2020-02-03 & 2021-01-07*/
SELECT date_of_birth FROM animals WHERE name in ('Agumon', 'Pikachu');

/* Returns  Pikachu | 1 & Devimon | 5*/
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/* Returns all data for Agumon, Gabumon, & Devimon*/
SELECT * FROM animals WHERE neutered = TRUE;

/* Returns all data for Agumon, Pikachu, & Devimon*/
SELECT * from animals WHERE name != 'Gabumon';

/* Returns all data for Pikachu, & Devimon*/
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3; 
