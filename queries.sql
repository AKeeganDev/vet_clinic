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

/* Provides the last animal seen by William Tatcher */
SELECT animals.name, vets.name, visits.date FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'William Tatcher' ORDER BY visits.date DESC LIMIT 1;

/* Provides the number of different animals that Stephanie Mendez saw*/
SELECT vets.name, COUNT(DISTINCT animal_id) FROM visits JOIN vets ON visits.vet_id = vets.id  WHERE vet_id = 7 GROUP BY vets.name;

/* Provides all vets with their specialties*/
SELECT vets.name, specializations.species_id FROM vets FULL JOIN specializations ON vets.id = specializations.vet_id;

/* Provides pet names who visited Stephanie Mendez between April 1st - August 30th 2020*/
SELECT visits.date, visits.animal_id, animals.name, vets.name FROM visits JOIN animals on visits.animal_id = animals.id join vets ON visits.vet_id = vets.id WHERE '[2020-04-01, 2020-08-30]'::daterange @> date AND vets.name = 'Stephanie Mendez'; 

/* Provides the animal with the most visits*/
SELECT COUNT(animal_id) AS visits, animals.name FROM visits JOIN animals ON visits.animal_id = animals.id GROUP BY animals.name ORDER BY COUNT(animal_id) DESC LIMIT 1;

SELECT visits.animal_id FROM visits JOIN animals ON visits.animal_id = animals.id GROUP BY animals.name;

/* Provides all data for visits number of different animals*/
SELECT visits.date as Date_Visited, animals.name as Pet, species.name as Species, owners.full_name as owner_name, vets.name as Vet, vets.id, specializations.species_id FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id join owners on animals.owner_id = owners.id join species on animals.species_id = species.id join specializations on vets.id = specializations.vet_id;

/* Provides the first pet seen by Maisy Smith*/
SELECT animals.name as pet_name, vets.name as vet_seen, visits.date as date_visited from visits JOIN vets on visits.vet_id = vets.id JOIN animals ON visits.animal_id = animals.id WHERE vets.name = 'Maisy Smith' ORDER BY visits.date LIMIT 1;

/* Provides the number of visits where the vet did not have a specialty with the animal they saw*/
SELECT COUNT(*) FROM visits JOIN vets ON visits.vet_id = vets.id JOIN animals ON visits.animal_id = animals.id WHERE vets.id NOT IN (SELECT vets.id FROM vets JOIN specializations ON vets.id = specializations.vet_id WHERE specializations.species_id = animals.species_id);

/* Provides the number of times Maisy has encountered a specific species. This could be used to decide what specialty she could go for based on how often she sees these species*/
SELECT species.name, COUNT(*) FROM visits JOIN vets ON vets.id = visits.vet_id JOIN animals ON animals.id = visits.animal_id JOIN species ON species.id = animals.species_id WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY count DESC LIMIT 1;