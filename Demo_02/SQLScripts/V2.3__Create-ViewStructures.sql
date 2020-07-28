-- ==============================================================================
-- 
-- Script name   :   V2.3__Create-ViewStructures
-- Description   :   SQL migration to create geokids database views
--                   vw_continents, vw_regions, vw_countries and composed views
-- Author        :   Carlos Robles
-- Email         :   crobles@dbamastery.com
-- Twitter       :   @dbamastery
-- Date          :   20200701
--   
-- Notes         :   N/A
-- 
-- ==============================================================================

-- Create continent view
CREATE VIEW vw_continents AS 
    SELECT * FROM continents;

-- Create regions view
CREATE VIEW vw_regions AS 
    SELECT * FROM regions;

-- Create countries view
CREATE VIEW vw_countries AS 
    SELECT * FROM countries;

-- Creating compose views
-- Create regions by continent view
CREATE VIEW vw_regions_continent AS 
    SELECT
        a.region
        ,b.continent
    FROM 
        regions a 
        INNER JOIN continents b ON a.continent_id = b.continent_id;

-- Create countries by continent view
CREATE VIEW vw_countries_continent AS 
    SELECT
        a.country
        ,c.continent
    FROM 
        countries a 
        INNER JOIN regions b ON a.region_id = b.region_id
        INNER JOIN continents c ON b.continent_id = c.continent_id;

-- Create countries by region view
CREATE VIEW vw_countries_region AS 
    SELECT
        a.country
        ,b.region
    FROM 
        countries a 
        INNER JOIN regions b ON a.region_id = b.region_id;

-- Create countries by continent and region view
CREATE VIEW vw_countries_continent_region AS 
    SELECT
        a.country
        ,c.continent
        ,b.region
    FROM 
        countries a 
        INNER JOIN regions b ON a.region_id = b.region_id
        INNER JOIN continents c ON b.continent_id = c.continent_id;

-- Create countries by continent and region including code view
CREATE VIEW vw_countries_continent_region_code AS 
    SELECT
        a.country_id country_code
        ,a.un_m49 m49_code
        ,a.country
        ,c.continent
        ,b.region
    FROM 
        countries a 
        INNER JOIN regions b ON a.region_id = b.region_id
        INNER JOIN continents c ON b.continent_id = c.continent_id;