/* ###########################################################################
    C6ECFE : Enhanced Community FrontEnd for Civilization VI
    Copyright (c) 2023-2024 zzragnar0kzz
    All rights reserved.
########################################################################### */

/* ###########################################################################
    begin C6ECFE configuration
########################################################################### */

-- flags for recognized official and community content
REPLACE INTO ContentFlags 
    (Id, Name, GUID, CityStates, GoodyHuts, Leaders, NaturalWonders, Base, XP1, XP2, Tooltip)
VALUES 
    ('DLC01', 'Aztec', '02A8BDDE-67EA-4D38-9540-26E685E3156E', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_AZTEC_TT'),
    ('DLC02', 'Poland', '3809975F-263F-40A2-A747-8BFB171D821A', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_POLAND_TT'),
    ('DLC03', 'Vikings', '2F6E858A-28EF-46B3-BEAC-B985E52E9BC1', 1, 0, 1, 1, 1, 1, 1, 'LOC_DLC_VIKINGS_TT'),
    ('DLC04', 'Australia', 'E3F53C61-371C-440B-96CE-077D318B36C0', 0, 0, 1, 1, 1, 1, 1, 'LOC_DLC_AUSTRALIA_TT'),
    ('DLC05', 'Persia', 'E2749E9A-8056-45CD-901B-C368C8E83DEB', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_PERSIA_TT'),
    ('DLC06', 'Nubia', '643EA320-8E1A-4CF1-A01C-00D88DDD131A', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_NUBIA_TT'),
    ('DLC07', 'Khmer', '1F367231-A040-4793-BDBB-088816853683', 0, 0, 1, 1, 1, 1, 1, 'LOC_DLC_KHMER_TT'),
    ('DLC08', 'Maya', '9DE86512-DE1A-400D-8C0A-AB46EBBF76B9', 1, 0, 1, 1, 1, 1, 1, 'LOC_DLC_MAYA_TT'),
    ('DLC09', 'Ethiopia', '1B394FE9-23DC-4868-8F0A-5220CB8FB427', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_ETHIOPIA_TT'),
    ('DLC10', 'Byzantium', 'A1100FC4-70F2-4129-AC27-2A65A685ED08', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_BYZANTIUM_TT'),
    ('DLC11', 'Babylon', '8424840C-92EF-4426-A9B4-B4E0CB818049', 1, 0, 1, 0, 1, 1, 1, 'LOC_DLC_BABYLON_STK_TT'),
    ('DLC12', 'Vietnam', 'A3F42CD4-6C3E-4F5A-BC81-BE29E0C0B87C', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_VIETNAM_TT'),
    ('DLC13', 'Portugal', 'FFDF4E79-DEE2-47BB-919B-F5739106627A', 0, 0, 1, 0, 1, 1, 1, 'LOC_DLC_PORTUGAL_TT'),
    ('XP1', 'Expansion1', '1B28771A-C749-434B-9053-D1380C553DE9', 0, 0, 1, 1, 0, 1, 1, 'LOC_XP1_TT'),
    ('XP2', 'Expansion2', '4873eb62-8ccc-4574-b784-dda455e74e68', 1, 1, 1, 1, 0, 0, 1, 'LOC_XP2_TT'),
    ('CCS', 'CIVITAS City-States', '7d0b57ba-6a5c-4de0-ac10-e1e464ac82f6', 1, 0, 0, 0, 1, 1, 1, 'LOC_CCS_TT'),
    ('ENWS', 'Enhanced Natural Wonders Selection', 'd0afae5b-02f8-4d01-bd54-c2bbc3d89858', 0, 0, 0, 0, 1, 1, 1, 'LOC_ENWS_TT'),
    ('EGHV', 'Enhanced Goodies and Hostile Villagers', 'a4b1fac6-8c9e-4873-a1c1-7ddf08dbbf11', 0, 1, 0, 0, 1, 1, 1, 'LOC_EGHV_TT'),
    ('WGH', 'Wondrous Goody Huts', '2d90451f-08c9-47de-bce8-e9b7fdecbe92', 0, 1, 0, 0, 1, 1, 1, 'LOC_WGH_TT');

-- ingamme logging parameter
REPLACE INTO Parameters 
    (ParameterId, Name, Description, Domain, DefaultValue, ConfigurationGroup, ConfigurationId, GroupId, SortIndex)
VALUES
    ('ECFE_Logging', 'LOC_GAME_ECFE_LOGGING_NAME', 'LOC_GAME_ECFE_LOGGING_DESC', 'ECFE_Logging', 2, 'Game', 'GAME_ECFE_LOGGING', 'AdvancedOptions', 2049);

-- ingame logging parameter values
REPLACE INTO DomainValues 
    (Domain, Value, Name, Description, SortIndex)
VALUES
    ('ECFE_Logging', 1, 'LOC_ECFE_LOGGING_MINIMAL_NAME', 'LOC_ECFE_LOGGING_MINIMAL_DESC', 10),
    ('ECFE_Logging', 2, 'LOC_ECFE_LOGGING_NORMAL_NAME', 'LOC_ECFE_LOGGING_NORMAL_DESC', 20),
    ('ECFE_Logging', 3, 'LOC_ECFE_LOGGING_VERBOSE_NAME', 'LOC_ECFE_LOGGING_VERBOSE_DESC', 30);

/* ###########################################################################
    end C6ECFE configuration
########################################################################### */
