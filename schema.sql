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

