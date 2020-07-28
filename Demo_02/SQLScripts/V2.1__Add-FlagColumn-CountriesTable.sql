-- ==============================================================================
-- 
-- Script name   :   V2.1__Add-FlagColumn-CountriesTable.sql
-- Description   :   SQL migration to add country flag column to countries table
-- Author        :   Carlos Robles
-- Email         :   crobles@dbamastery.com
-- Twitter       :   @dbamastery
-- Date          :   20200701
--   
-- Notes         :   N/A
-- 
-- ==============================================================================

-- Add flag column to countries table
ALTER TABLE countries ADD flag VARCHAR(2048) NULL;