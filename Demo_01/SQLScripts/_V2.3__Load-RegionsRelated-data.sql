-- ==============================================================================
-- 
-- Script name   :   V2.3__Load-RegionsRelated-data.sql
-- Description   :   SQL migration to load data into Region, Territories, States
-- Author        :   Carlos Robles
-- Email         :   crobles@dbamastery.com
-- Twitter       :   @dbamastery
-- Date          :   20200701
--   
-- Notes         :   N/A
-- 
-- ==============================================================================

-- Load data region table
-- ==============================================================================
INSERT INTO region VALUES (1, 'Eastern');
INSERT INTO region VALUES (2, 'Western');
INSERT INTO region VALUES (3, 'Northern');
INSERT INTO region VALUES (4, 'Southern');

-- Load data territories table
-- ==============================================================================
INSERT INTO territories VALUES ('01581', 'Westboro', 1);
INSERT INTO territories VALUES ('01730', 'Bedford', 1);
INSERT INTO territories VALUES ('01833', 'Georgetow', 1);
INSERT INTO territories VALUES ('02116', 'Boston', 1);
INSERT INTO territories VALUES ('02139', 'Cambridge', 1);
INSERT INTO territories VALUES ('02184', 'Braintree', 1);
INSERT INTO territories VALUES ('02903', 'Providence', 1);
INSERT INTO territories VALUES ('03049', 'Hollis', 3);
INSERT INTO territories VALUES ('03801', 'Portsmouth', 3);
INSERT INTO territories VALUES ('06897', 'Wilton', 1);
INSERT INTO territories VALUES ('07960', 'Morristown', 1);
INSERT INTO territories VALUES ('08837', 'Edison', 1);
INSERT INTO territories VALUES ('10019', 'New York', 1);
INSERT INTO territories VALUES ('10038', 'New York', 1);
INSERT INTO territories VALUES ('11747', 'Mellvile', 1);
INSERT INTO territories VALUES ('14450', 'Fairport', 1);
INSERT INTO territories VALUES ('19428', 'Philadelphia', 3);
INSERT INTO territories VALUES ('19713', 'Neward', 1);
INSERT INTO territories VALUES ('20852', 'Rockville', 1);
INSERT INTO territories VALUES ('27403', 'Greensboro', 1);
INSERT INTO territories VALUES ('27511', 'Cary', 1);
INSERT INTO territories VALUES ('29202', 'Columbia', 4);
INSERT INTO territories VALUES ('30346', 'Atlanta', 4);
INSERT INTO territories VALUES ('31406', 'Savannah', 4);
INSERT INTO territories VALUES ('32859', 'Orlando', 4);
INSERT INTO territories VALUES ('33607', 'Tampa', 4);
INSERT INTO territories VALUES ('40222', 'Louisville', 1);
INSERT INTO territories VALUES ('44122', 'Beachwood', 3);
INSERT INTO territories VALUES ('45839', 'Findlay', 3);
INSERT INTO territories VALUES ('48075', 'Southfield', 3);
INSERT INTO territories VALUES ('48084', 'Troy', 3);
INSERT INTO territories VALUES ('48304', 'Bloomfield Hills', 3);
INSERT INTO territories VALUES ('53404', 'Racine', 3);
INSERT INTO territories VALUES ('55113', 'Roseville', 3);
INSERT INTO territories VALUES ('55439', 'Minneapolis', 3);
INSERT INTO territories VALUES ('60179', 'Hoffman Estates', 2);
INSERT INTO territories VALUES ('60601', 'Chicago', 2);
INSERT INTO territories VALUES ('72716', 'Bentonville', 4);
INSERT INTO territories VALUES ('75234', 'Dallas', 4);
INSERT INTO territories VALUES ('78759', 'Austin', 4);
INSERT INTO territories VALUES ('80202', 'Denver', 2);
INSERT INTO territories VALUES ('80909', 'Colorado Springs', 2);
INSERT INTO territories VALUES ('85014', 'Phoenix', 2);
INSERT INTO territories VALUES ('85251', 'Scottsdale', 2);
INSERT INTO territories VALUES ('90405', 'Santa Monica', 2);
INSERT INTO territories VALUES ('94025', 'Menlo Park', 2);
INSERT INTO territories VALUES ('94105', 'San Francisco', 2);
INSERT INTO territories VALUES ('95008', 'Campbell', 2);
INSERT INTO territories VALUES ('95054', 'Santa Clara', 2);
INSERT INTO territories VALUES ('95060', 'Santa Cruz', 2);
INSERT INTO territories VALUES ('98004', 'Bellevue', 2);
INSERT INTO territories VALUES ('98052', 'Redmond', 2);
INSERT INTO territories VALUES ('98104', 'Seattle', 2);


-- Load data us_states table
-- ==============================================================================
INSERT INTO us_states VALUES (1, 'Alabama', 'AL', 'south');
INSERT INTO us_states VALUES (2, 'Alaska', 'AK', 'north');
INSERT INTO us_states VALUES (3, 'Arizona', 'AZ', 'west');
INSERT INTO us_states VALUES (4, 'Arkansas', 'AR', 'south');
INSERT INTO us_states VALUES (5, 'California', 'CA', 'west');
INSERT INTO us_states VALUES (6, 'Colorado', 'CO', 'west');
INSERT INTO us_states VALUES (7, 'Connecticut', 'CT', 'east');
INSERT INTO us_states VALUES (8, 'Delaware', 'DE', 'east');
INSERT INTO us_states VALUES (9, 'District of Columbia', 'DC', 'east');
INSERT INTO us_states VALUES (10, 'Florida', 'FL', 'south');
INSERT INTO us_states VALUES (11, 'Georgia', 'GA', 'south');
INSERT INTO us_states VALUES (12, 'Hawaii', 'HI', 'west');
INSERT INTO us_states VALUES (13, 'Idaho', 'ID', 'midwest');
INSERT INTO us_states VALUES (14, 'Illinois', 'IL', 'midwest');
INSERT INTO us_states VALUES (15, 'Indiana', 'IN', 'midwest');
INSERT INTO us_states VALUES (16, 'Iowa', 'IO', 'midwest');
INSERT INTO us_states VALUES (17, 'Kansas', 'KS', 'midwest');
INSERT INTO us_states VALUES (18, 'Kentucky', 'KY', 'south');
INSERT INTO us_states VALUES (19, 'Louisiana', 'LA', 'south');
INSERT INTO us_states VALUES (20, 'Maine', 'ME', 'north');
INSERT INTO us_states VALUES (21, 'Maryland', 'MD', 'east');
INSERT INTO us_states VALUES (22, 'Massachusetts', 'MA', 'north');
INSERT INTO us_states VALUES (23, 'Michigan', 'MI', 'north');
INSERT INTO us_states VALUES (24, 'Minnesota', 'MN', 'north');
INSERT INTO us_states VALUES (25, 'Mississippi', 'MS', 'south');
INSERT INTO us_states VALUES (26, 'Missouri', 'MO', 'south');
INSERT INTO us_states VALUES (27, 'Montana', 'MT', 'west');
INSERT INTO us_states VALUES (28, 'Nebraska', 'NE', 'midwest');
INSERT INTO us_states VALUES (29, 'Nevada', 'NV', 'west');
INSERT INTO us_states VALUES (30, 'New Hampshire', 'NH', 'east');
INSERT INTO us_states VALUES (31, 'New Jersey', 'NJ', 'east');
INSERT INTO us_states VALUES (32, 'New Mexico', 'NM', 'west');
INSERT INTO us_states VALUES (33, 'New York', 'NY', 'east');
INSERT INTO us_states VALUES (34, 'North Carolina', 'NC', 'east');
INSERT INTO us_states VALUES (35, 'North Dakota', 'ND', 'midwest');
INSERT INTO us_states VALUES (36, 'Ohio', 'OH', 'midwest');
INSERT INTO us_states VALUES (37, 'Oklahoma', 'OK', 'midwest');
INSERT INTO us_states VALUES (38, 'Oregon', 'OR', 'west');
INSERT INTO us_states VALUES (39, 'Pennsylvania', 'PA', 'east');
INSERT INTO us_states VALUES (40, 'Rhode Island', 'RI', 'east');
INSERT INTO us_states VALUES (41, 'South Carolina', 'SC', 'east');
INSERT INTO us_states VALUES (42, 'South Dakota', 'SD', 'midwest');
INSERT INTO us_states VALUES (43, 'Tennessee', 'TN', 'midwest');
INSERT INTO us_states VALUES (44, 'Texas', 'TX', 'west');
INSERT INTO us_states VALUES (45, 'Utah', 'UT', 'west');
INSERT INTO us_states VALUES (46, 'Vermont', 'VT', 'east');
INSERT INTO us_states VALUES (47, 'Virginia', 'VA', 'east');
INSERT INTO us_states VALUES (48, 'Washington', 'WA', 'west');
INSERT INTO us_states VALUES (49, 'West Virginia', 'WV', 'south');
INSERT INTO us_states VALUES (50, 'Wisconsin', 'WI', 'midwest');
INSERT INTO us_states VALUES (51, 'Wyoming', 'WY', 'west');