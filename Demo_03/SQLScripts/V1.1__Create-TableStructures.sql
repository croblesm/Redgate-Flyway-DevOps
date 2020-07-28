-- ==============================================================================
-- 
-- Script name   :   V1.1__Create-GeoKids-TableStructures.sql
-- Description   :   SQL migration to create geokids database tables
--                   continents, regions, countries
-- Author        :   Carlos Robles
-- Email         :   crobles@dbamastery.com
-- Twitter       :   @dbamastery
-- Date          :   20200701
--   
-- Notes         :   N/A
-- 
-- ==============================================================================

-- Create sequence for continents table
CREATE SEQUENCE continents_seq;

-- Create continents table
CREATE TABLE continents (
	continent_id INT DEFAULT NEXTVAL ('continents_seq') NOT NULL,
	continent VARCHAR(64) NULL,
    PRIMARY KEY (continent_id)
);

-- Create sequence for regions table
CREATE SEQUENCE regions_seq;

-- Create regions table
CREATE TABLE regions (
	region_id INT DEFAULT NEXTVAL ('regions_seq') NOT NULL,
	region VARCHAR(64) NULL,
    continent_id INT NOT NULL,
    PRIMARY KEY (region_id),
    FOREIGN KEY (continent_id) REFERENCES continents (continent_id)
);

 -- Create countries table
CREATE TABLE countries (
	country_id CHAR(2) NOT NULL,
	country VARCHAR(64) NULL,
    un_m49 INT NOT NULL,
	region_id INT NOT NULL,
    PRIMARY KEY (country_id),
    FOREIGN KEY (region_id) REFERENCES regions (region_id)
);