/* ###########################################################################
    C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 zzragnar0kzz
    All rights reserved.
########################################################################### */

/* ###########################################################################
    begin C6ECFE configuration schema
########################################################################### */

-- flags for recognized official and community content
CREATE TABLE IF NOT EXISTS ContentFlags (
	'Id' TEXT NOT NULL,
    'Name' TEXT NOT NULL,
	'Tooltip' TEXT NOT NULL,
	'Frontend' BOOLEAN NOT NULL CHECK (Frontend IN (0,1)) DEFAULT 0,
	'CityStates' BOOLEAN NOT NULL CHECK (CityStates IN (0,1)) DEFAULT 0,
	'GoodyHuts' BOOLEAN NOT NULL CHECK (GoodyHuts IN (0,1)) DEFAULT 0,
    'Leaders' BOOLEAN NOT NULL CHECK (Leaders IN (0,1)) DEFAULT 0,
	'NaturalWonders' BOOLEAN NOT NULL CHECK (NaturalWonders IN (0,1)) DEFAULT 0,
    'RULESET_STANDARD' BOOLEAN NOT NULL CHECK (RULESET_STANDARD IN (0,1)) DEFAULT 0,
	'RULESET_EXPANSION_1' BOOLEAN NOT NULL CHECK (RULESET_EXPANSION_1 IN (0,1)) DEFAULT 0,
	'RULESET_EXPANSION_2' BOOLEAN NOT NULL CHECK (RULESET_EXPANSION_2 IN (0,1)) DEFAULT 0,
	PRIMARY KEY('Id')
);

/* ###########################################################################
    end C6ECFE configuration schema
########################################################################### */
