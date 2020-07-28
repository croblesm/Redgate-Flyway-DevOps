-- ==============================================================================
-- 
-- Script name   :   V1.3__Create-RegionsRelated-Tables.sql
-- Description   :   SQL migration to create Region, Territories, States tables
-- Author        :   Carlos Robles
-- Email         :   crobles@dbamastery.com
-- Twitter       :   @dbamastery
-- Date          :   20200701
--   
-- Notes         :   N/A
-- 
-- ==============================================================================

-- Create region table
CREATE TABLE region (
    region_id smallint NOT NULL,
    region_description bpchar NOT NULL
);

-- Create territories table
CREATE TABLE territories (
    territory_id character varying(20) NOT NULL,
    territory_description bpchar NOT NULL,
    region_id smallint NOT NULL
);

-- Create us_states table
CREATE TABLE us_states (
    state_id smallint NOT NULL,
    state_name character varying(100),
    state_abbr character varying(2),
    state_region character varying(50)
);