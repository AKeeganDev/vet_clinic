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

/*Returns the total number of animals in the database*/
SELECT COUNT(*) FROM animals;

/*Counts how many animals have tried to escape*/
SELECT COUNT(*) FROM animals WHERE escape_attempts > 0;

/*Provides the average weight of all animals*/
SELECT AVG(weight_kg) FROM animals;

/*Provides whether neutered or non-neutered animals escape the most and provides the total attempts within the group that escapes the most*/
SELECT neutered, COUNT(escape_attempts) FROM animals WHERE escape_attempts > 0 GROUP BY neutered ORDER BY count DESC LIMIT 1;


/*Provides minimum and maximum weight of each type of animal*/
SELECT species, min(weight_kg), max(weight_kg) FROM animals GROUP BY species;

/*Provides Average number of escape attempts per animal type born between the years 1990 and 2000*/
SELECT species, AVG(escape_attempts) as Average_Escape_Attempts FROM animals WHERE date_of_birth > '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;
