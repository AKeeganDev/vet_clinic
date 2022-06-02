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
SELECT neutered, SUM(escape_attempts) AS Total_Number_of_Escape_Attempts FROM animals WHERE escape_attempts > 0 GROUP BY neutered ORDER BY Total_Number_of_Escape_Attempts DESC LIMIT 1;


/*Provides minimum and maximum weight of each type of animal*/
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

/*Provides Average number of escape attempts per animal type born between the years 1990 and 2000*/
SELECT species, AVG(escape_attempts) AS Average_Escape_Attempts FROM animals WHERE date_of_birth > '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;

/*Provides all animals that Melody owns*/
SELECT name, full_name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';

/*Provides all animals that are Pokemon*/
SELECT animals.name, species.name FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'POKEMON';

/*Provides all registered owners and their corresponding pets (includes owners with no currently registered pets*/
SELECT name AS Pet_name, full_name AS Owner_name FROM animals full JOIN owners ON animals.owner_id = owners.id;

/*Counts the total number of each animal by species*/
SELECT species.name, count(species_id) FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;

/* Provides all Digimon owned by Jennifer Orwell*/
SELECT name, full_name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Jennifer Orwell' AND species_id = 2;

/* Provides all animals that have not tried to escape and that are owned by Dean Winchester */
SELECT name, full_name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

/* Provides all who owns the most animals RESULT: Melody Pond */
SELECT owners.full_name FROM animals JOIN owners ON animals.owner_id = owners.id group by owners.full_name order by count(owner_id) DESC LIMIT 1;
