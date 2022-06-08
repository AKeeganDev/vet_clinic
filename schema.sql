/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT UNIQUE,
    name TEXT,
    date_of_birth DATE,
    escape_attempts INT, 
    neutered BOOLEAN,
    weight_kg DECIMAL,
);

alter table animals add unique (id);


/* Command to add a species column to the animals table*/
ALTER TABLE animals ADD species TEXT;

/* Command to add an Owners table*/
CREATE TABLE owners( id SERIAL UNIQUE, full_name TEXT, age INT);
ALTER TABLE species ADD CONSTRAINT primary_id_key PRIMARY KEY (id);

/* Command to create a Species table*/
CREATE TABLE species( id SERIAL, name TEXT);
ALTER TABLE species ADD CONSTRAINT primary_id_key PRIMARY KEY (id);

/* Command to create a vets table*/
CREATE TABLE vets( id SERIAL UNIQUE, name TEXT, age INT, date_of_graduation DATE, PRIMARY KEY(id));

/* Command to create a specializations join table*/
CREATE TABLE specializations ( vet_id INT REFERENCES vets(id), species_id INT REFERENCES species(id));

/* Command to create a visits join table*/
CREATE TABle visits ( animal_id INT REFERENCES animals(id), vet_id INT REFERENCES vets(id), date DATE);


/* Code to remove the null-value id column from Animals and reset the column with auto-incrementing ID values. Removes species, adds instead Species ID and Owner_ID*/
ALTER TABLE animals DROP column IF EXISTS id;
ALTER TABLE animals ADD column IF NOT EXISTS id SERIAL;

alter table animals add column if not exists species_id int;
alter table animals add column if not exists owner_id int;

alter table animals add constraint species_constraint foreign key (species_id) references species (id);
alter table animals add constraint owner_constraint foreign key (owner_id) references owners (id);

/*commands to update database*/
BEGIN;
alter table owners add column email varchar(120);
INSERT INTO visits (animal_id, vet_id, date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp; >>>>Do this 10 times
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com'; >>>>Do this 10 times

create index visits_animalID_asc on visits(animal_id asc);
create index visits_vetID_asc on visits(vet_id asc);
create index owners_email_asc on visits(vet_id asc);


