psql --username=freecodecamp --dbname=postgres
CREATE DATABASE universe;
\c universe
You are now connected to database "universe" as user "freecodecamp".
CREATE TABLE galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  galaxy_type TEXT,
  distance_from_earth NUMERIC,
  has_life BOOLEAN NOT NULL,
  age_in_millions_of_years INT
);
CREATE TABLE star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  galaxy_id INT REFERENCES galaxy(galaxy_id),
  temperature INT NOT NULL,
  is_spherical BOOLEAN NOT NULL,
  description TEXT
);
CREATE TABLE planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  star_id INT REFERENCES star(star_id),
  has_life BOOLEAN NOT NULL,
  mass NUMERIC,
  age_in_millions_of_years INT NOT NULL
);
CREATE TABLE moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  planet_id INT REFERENCES planet(planet_id),
  radius INT NOT NULL,
  is_spherical BOOLEAN NOT NULL,
  description TEXT
);
CREATE TABLE planet_type (
  planet_type_id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  description TEXT,
  average_temperature INT NOT NULL
);
INSERT INTO galaxy (name, galaxy_type, distance_from_earth, has_life, age_in_millions_of_years)
VALUES 
('Milky Way', 'Spiral', 0, TRUE, 13600),
('Andromeda', 'Spiral', 2537000, FALSE, 10000),
('Triangulum', 'Spiral', 3000000, FALSE, 12000),
('Whirlpool', 'Spiral', 23000000, FALSE, 14000),
('Sombrero', 'Elliptical', 31000000, FALSE, 12000),
('Cartwheel', 'Lenticular', 500000000, FALSE, 20000);
pg_dump -cC --inserts -U freecodecamp universe > universe.sql
psql -U postgres < universe.sql
SELECT * FROM galaxy;
INSERT INTO star (name, galaxy_id, temperature, is_spherical, description)
VALUES
('Sun', 1, 5800, TRUE, 'Our solar star'),
('Proxima Centauri', 1, 3042, TRUE, 'Nearest known star'),
('Sirius', 1, 9940, TRUE, 'Brightest in the night sky'),
('Andromeda Star 1', 2, 6200, TRUE, 'In Andromeda galaxy'),
('Andromeda Star 2', 2, 7500, TRUE, 'Also in Andromeda'),
('Whirlpool Star', 4, 5800, TRUE, 'In Whirlpool galaxy');
SELECT * FROM star;
INSERT INTO planet (name, star_id, has_life, mass, age_in_millions_of_years)
VALUES
('Earth', 1, TRUE, 5.97, 4500),
('Mars', 1, FALSE, 0.64, 4600),
('Proxima b', 2, FALSE, 1.27, 4800),
('Sirius A1', 3, FALSE, 6.1, 6000),
('Andro-1', 4, FALSE, 7.3, 5500),
('Andro-2', 5, FALSE, 4.2, 5000),
('Whirl-1', 6, FALSE, 3.8, 4800);
SELECT * FROM planet;
INSERT INTO moon (name, planet_id, radius, is_spherical, description)
VALUES
('Moon', 1, 1737, TRUE, 'Earth’s moon'),
('Phobos', 2, 11, TRUE, 'Mars moon'),
('Deimos', 2, 6, TRUE, 'Mars moon'),
('ProxMoon', 3, 500, TRUE, 'Proxima b moon'),
('AndroMoon1', 5, 400, TRUE, 'Andromeda planet moon'),
('WhirlMoon', 7, 350, TRUE, 'Whirlpool planet moon');
SELECT s.name AS star, g.name AS galaxy
FROM star s
JOIN galaxy g ON s.galaxy_id = g.galaxy_id;

SELECT p.name AS planet, s.name AS star
FROM planet p
JOIN star s ON p.star_id = s.star_id;

SELECT m.name AS moon, p.name AS planet
FROM moon m
JOIN planet p ON m.planet_id = p.planet_id;
-- GALAXY TABLE (6 rows)
INSERT INTO galaxy (name, galaxy_type, distance_from_earth, has_life, age_in_millions_of_years)
VALUES
('Milky Way', 'Spiral', 0, TRUE, 13600),
('Andromeda', 'Spiral', 2537000, FALSE, 10000),
('Triangulum', 'Spiral', 3000000, FALSE, 12000),
('Whirlpool', 'Spiral', 23000000, FALSE, 14000),
('Sombrero', 'Elliptical', 31000000, FALSE, 12000),
('Cartwheel', 'Lenticular', 500000000, FALSE, 20000);

-- STAR TABLE (6 rows)
INSERT INTO star (name, galaxy_id, temperature, is_spherical, description)
VALUES
('Sun', 1, 5800, TRUE, 'Main sequence star'),
('Proxima Centauri', 1, 3042, TRUE, 'Nearest known star'),
('Sirius', 1, 9940, TRUE, 'Brightest in the night sky'),
('Andromeda Star 1', 2, 6200, TRUE, 'Located in Andromeda galaxy'),
('Andromeda Star 2', 2, 7500, TRUE, 'Second Andromeda star'),
('Whirlpool Star', 4, 5800, TRUE, 'Located in Whirlpool galaxy');

-- PLANET TABLE (12 rows)
INSERT INTO planet (name, star_id, has_life, mass, age_in_millions_of_years)
VALUES
('Earth', 1, TRUE, 5.97, 4500),
('Mars', 1, FALSE, 0.64, 4600),
('Venus', 1, FALSE, 4.87, 4600),
('Proxima b', 2, FALSE, 1.27, 4800),
('Sirius A1', 3, FALSE, 6.1, 6000),
('Sirius A2', 3, FALSE, 7.3, 6000),
('Andro-1', 4, FALSE, 5.8, 5500),
('Andro-2', 4, FALSE, 4.2, 5000),
('Andro-3', 5, FALSE, 3.9, 4800),
('Whirl-1', 6, FALSE, 3.8, 4800),
('Whirl-2', 6, FALSE, 4.1, 4900),
('Whirl-3', 6, FALSE, 4.0, 4950);

-- MOON TABLE (20 rows)
INSERT INTO moon (name, planet_id, radius, is_spherical, description)
VALUES
('Moon', 1, 1737, TRUE, 'Earth’s moon'),
('Phobos', 2, 11, TRUE, 'Mars moon'),
('Deimos', 2, 6, TRUE, 'Mars moon'),
('Aphrodite', 3, 100, TRUE, 'Venus moon (fictional)'),
('ProxMoon1', 4, 500, TRUE, 'Proxima b moon'),
('SiriusMoon1', 5, 300, TRUE, 'Sirius A1 moon'),
('SiriusMoon2', 6, 280, TRUE, 'Sirius A2 moon'),
('AndroMoon1', 7, 350, TRUE, 'Andromeda planet moon'),
('AndroMoon2', 8, 330, TRUE, 'Andromeda planet moon'),
('AndroMoon3', 9, 310, TRUE, 'Andromeda planet moon'),
('WhirlMoon1', 10, 250, TRUE, 'Whirlpool planet moon'),
('WhirlMoon2', 10, 260, TRUE, 'Whirlpool planet moon'),
('WhirlMoon3', 11, 240, TRUE, 'Whirlpool planet moon'),
('WhirlMoon4', 12, 230, TRUE, 'Whirlpool planet moon'),
('WhirlMoon5', 12, 210, TRUE, 'Another Whirlpool moon'),
('WhirlMoon6', 11, 220, TRUE, 'Small Whirlpool moon'),
('WhirlMoon7', 10, 270, TRUE, 'Whirlpool minor moon'),
('WhirlMoon8', 8, 290, TRUE, 'Andromeda extra moon'),
('WhirlMoon9', 7, 280, TRUE, 'Extra moon'),
('WhirlMoon10', 3, 200, TRUE, 'Extra Venus moon');
SELECT COUNT(*) FROM galaxy;
SELECT COUNT(*) FROM star;
SELECT COUNT(*) FROM planet;
SELECT COUNT(*) FROM moon;
INSERT INTO planet (name, star_id, has_life, mass, age_in_millions_of_years)
VALUES
('Neptune', 1, FALSE, 17.1, 4600),
('Jupiter', 1, FALSE, 317.8, 4600),
('Saturn', 1, FALSE, 95.2, 4600),
('Kepler-22b', 2, FALSE, 8.7, 4800),
('AndroPrime', 4, FALSE, 5.3, 5200);
SELECT COUNT(*) FROM planet;

-- 1) List all user tables and their row counts (run to see which tables have < 3 rows)
SELECT
  nspname AS schema,
  relname AS table_name,
  reltuples::bigint AS approx_row_count
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE relkind = 'r'
  AND nspname = 'public'
ORDER BY relname;

-- 2) Create a helpful 5th table if you don't already have one (planet_type)
CREATE TABLE IF NOT EXISTS planet_type (
  planet_type_id SERIAL PRIMARY KEY,
  name VARCHAR(80) UNIQUE NOT NULL,
  description TEXT,
  average_temperature INT NOT NULL DEFAULT 0
);

-- Ensure planet_type has at least 3 rows (will fail harmlessly if duplicates exist)
INSERT INTO planet_type (name, description, average_temperature)
VALUES
  ('Terrestrial', 'Rocky world', 300),
  ('Gas Giant', 'Large gaseous planet', -150),
  ('Ice Giant', 'Cold, icy giant', -200)
ON CONFLICT (name) DO NOTHING;

-- 3) Add 14 more moons to bring moon count up to at least 20.
-- We assume planet_id values 1..12 exist (you reported 12 planets). If your planet ids differ, change the numbers accordingly.
INSERT INTO moon (name, planet_id, radius, is_spherical, description) VALUES
  ('ExtraMoon01', 1, 100, TRUE, 'Additional moon'),
  ('ExtraMoon02', 2, 120, TRUE, 'Additional moon'),
  ('ExtraMoon03', 3, 90, TRUE, 'Additional moon'),
  ('ExtraMoon04', 4, 110, TRUE, 'Additional moon'),
  ('ExtraMoon05', 5, 130, TRUE, 'Additional moon'),
  ('ExtraMoon06', 6, 95, TRUE, 'Additional moon'),
  ('ExtraMoon07', 7, 140, TRUE, 'Additional moon'),
  ('ExtraMoon08', 8, 85, TRUE, 'Additional moon'),
  ('ExtraMoon09', 9, 150, TRUE, 'Additional moon'),
  ('ExtraMoon10', 10, 80, TRUE, 'Additional moon'),
  ('ExtraMoon11', 11, 170, TRUE, 'Additional moon'),
  ('ExtraMoon12', 12, 75, TRUE, 'Additional moon'),
  ('ExtraMoon13', 1, 65, TRUE, 'Spare moon'),
  ('ExtraMoon14', 2, 60, TRUE, 'Spare moon')
ON CONFLICT (name) DO NOTHING;

-- 4) Re-check counts so you can confirm
SELECT 'galaxy' AS table_name, COUNT(*) FROM galaxy
UNION ALL
SELECT 'star', COUNT(*) FROM star
UNION ALL
SELECT 'planet', COUNT(*) FROM planet
UNION ALL
SELECT 'moon', COUNT(*) FROM moon
UNION ALL
SELECT 'planet_type', COUNT(*) FROM planet_type;
SELECT planet_id, name FROM planet ORDER BY planet_id;
INSERT INTO planet (name, star_id, has_life, mass, age_in_millions_of_years)
VALUES
('Andro-2', 4, FALSE, 4.2, 5000),
('Andro-3', 5, FALSE, 3.9, 4800),
('Whirl-1', 6, FALSE, 3.8, 4800),
('Whirl-2', 6, FALSE, 4.1, 4900),
('Whirl-3', 6, FALSE, 4.0, 4950);
SELECT planet_id, name FROM planet ORDER BY planet_id;
INSERT INTO moon (name, planet_id, radius, is_spherical, description) VALUES
  ('Moon_1', 1, 1737, TRUE, 'Earth moon'),
  ('Moon_2', 2, 11, TRUE, 'Mars moon Phobos'),
  ('Moon_3', 2, 6, TRUE, 'Mars moon Deimos'),
  ('Moon_4', 3, 500, TRUE, 'Proxima b moon 1'),
  ('Moon_5', 4, 300, TRUE, 'Sirius A1 moon 1'),
  ('Moon_6', 5, 280, TRUE, 'Andro-1 moon 1'),
  ('Moon_7', 6, 350, TRUE, 'Andro-2 moon 1'),
  ('Moon_8', 7, 330, TRUE, 'Whirl-1 moon 1'),
  ('Moon_9', 9, 150, TRUE, 'Neptune moon 1'),
  ('Moon_10', 10, 80, TRUE, 'Jupiter moon 1'),
  ('Moon_11', 11, 240, TRUE, 'Saturn moon 1'),
  ('Moon_12', 12, 230, TRUE, 'Kepler-22b moon 1'),
  ('Moon_13', 13, 200, TRUE, 'AndroPrime moon 1'),
  ('Moon_14', 1, 250, TRUE, 'Earth moon 2'),
  ('Moon_15', 2, 260, TRUE, 'Mars moon 2'),
  ('Moon_16', 3, 270, TRUE, 'Proxima b moon 2'),
  ('Moon_17', 4, 280, TRUE, 'Sirius A1 moon 2'),
  ('Moon_18', 5, 290, TRUE, 'Andro-1 moon 2'),
  ('Moon_19', 6, 300, TRUE, 'Andro-2 moon 2'),
  ('Moon_20', 7, 310, TRUE, 'Whirl-1 moon 2');
SELECT COUNT(*) FROM moon;

