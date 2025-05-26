-- create ranger table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);


-- ranger data insert

INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');



-- create species table
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(150) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
        CHECK (conservation_status IN (
            'Endangered',
            'Vulnerable',
            'Critically Endangered',
            'Least Concern'
        ))
);

-- species data insert 

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

-- create sighting table
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT NOT NULL REFERENCES rangers(ranger_id),
    species_id INT NOT NULL REFERENCES species(species_id),
    sighting_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    location VARCHAR(150) NOT NULL,
    notes TEXT
);

-- some data insert for sighting

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge',        '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area',     '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass',     '2024-05-18 18:30:00', NULL);



-- problem 1 

INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');


-- problem 2 

SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;


-- problem 3

SELECT *
FROM sightings
WHERE location ILIKE '%Pass%';


-- problem 4 

SELECT name, COUNT(sighting_id) AS total_sightings
FROM rangers
JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY name;


-- problem 5

SELECT common_name
FROM species
WHERE species_id NOT IN (
  SELECT DISTINCT species_id FROM sightings
);

-- problem 6 

SELECT *
FROM sightings
ORDER BY sighting_time DESC
LIMIT 2;


-- problem 7 



SELECT * FROM species WHERE discovery_date < '1800-01-01';

UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

-- problem 8 

