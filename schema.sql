/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT,
    name TEXT,
    date_of_birth DATE,
    escape_attempts INT, 
    neutered BOOLEAN,
    weight_kg DECIMAL,
);

/* Command to add a species column to the animals table*/
ALTER TABLE animals ADD species TEXT;

/* Command to add an Owners table*/
CREATE TABLE owners( id SERIAL UNIQUE, full_name TEXT, age INT);
ALTER TABLE species ADD CONSTRAINT primary_id_key PRIMARY KEY (id);

/* Command to create a Species table*/
CREATE TABLE species( id SERIAL, name TEXT);
ALTER TABLE species ADD CONSTRAINT primary_id_key PRIMARY KEY (id);

/* Code to remove the null-value id column from Animals and reset the column with auto-incrementing ID values. Removes species, adds instead Species ID and Owner_ID*/
ALTER TABLE animals DROP column IF EXISTS id;
ALTER TABLE animals ADD column IF NOT EXISTS id SERIAL;

alter table animals add column if not exists species_id int;
alter table animals add column if not exists owner_id int;

alter table animals add constraint species_constraint foreign key (species_id) references species (id);
alter table animals add constraint owner_constraint foreign key (owner_id) references owners (id);


