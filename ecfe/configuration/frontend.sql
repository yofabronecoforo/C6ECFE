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
    (Id, Name, Tooltip, Frontend, CityStates, GoodyHuts, Leaders, NaturalWonders, RULESET_STANDARD, RULESET_EXPANSION_1, RULESET_EXPANSION_2)
VALUES 
    -- official content
    ('02A8BDDE-67EA-4D38-9540-26E685E3156E', 'DLC01', 'LOC_DLC_AZTEC_TT', 0, 0, 0, 1, 0, 1, 1, 1),
    ('3809975F-263F-40A2-A747-8BFB171D821A', 'DLC02', 'LOC_DLC_POLAND_TT', 0, 0, 0, 1, 0, 1, 1, 1),
    ('2F6E858A-28EF-46B3-BEAC-B985E52E9BC1', 'DLC03', 'LOC_DLC_VIKINGS_TT', 0, 1, 0, 1, 1, 1, 1, 1),
    ('E3F53C61-371C-440B-96CE-077D318B36C0', 'DLC04', 'LOC_DLC_AUSTRALIA_TT', 0, 0, 0, 1, 1, 1, 1, 1),
    ('E2749E9A-8056-45CD-901B-C368C8E83DEB', 'DLC05', 'LOC_DLC_PERSIA_TT', 0, 0, 0, 1, 0, 1, 1, 1),
    ('643EA320-8E1A-4CF1-A01C-00D88DDD131A', 'DLC06', 'LOC_DLC_NUBIA_TT', 0, 0, 0, 1, 0, 1, 1, 1),
    ('1F367231-A040-4793-BDBB-088816853683', 'DLC07', 'LOC_DLC_KHMER_TT', 0, 0, 0, 1, 1, 1, 1, 1),
    ('9DE86512-DE1A-400D-8C0A-AB46EBBF76B9', 'DLC08', 'LOC_DLC_MAYA_TT', 0, 1, 0, 1, 1, 1, 1, 1),
    ('1B394FE9-23DC-4868-8F0A-5220CB8FB427', 'DLC09', 'LOC_DLC_ETHIOPIA_TT', 0, 0, 0, 1, 0, 1, 1, 1),
    ('A1100FC4-70F2-4129-AC27-2A65A685ED08', 'DLC10', 'LOC_DLC_BYZANTIUM_TT', 0, 0, 0, 1, 0, 1, 1, 1),
    ('8424840C-92EF-4426-A9B4-B4E0CB818049', 'DLC11', 'LOC_DLC_BABYLON_STK_TT', 0, 1, 0, 1, 0, 1, 1, 1),
    ('A3F42CD4-6C3E-4F5A-BC81-BE29E0C0B87C', 'DLC12', 'LOC_DLC_VIETNAM_TT', 0, 0, 0, 1, 0, 1, 1, 1),
    ('FFDF4E79-DEE2-47BB-919B-F5739106627A', 'DLC13', 'LOC_DLC_PORTUGAL_TT', 0, 0, 0, 1, 0, 1, 1, 1),
    ('1B28771A-C749-434B-9053-D1380C553DE9', 'XP1', 'LOC_XP1_TT', 0, 0, 0, 1, 1, 0, 1, 1),      -- Rise and Fall
    ('4873eb62-8ccc-4574-b784-dda455e74e68', 'XP2', 'LOC_XP2_TT', 0, 1, 1, 1, 1, 0, 0, 1),      -- Gathering Storm
    -- enhanced series
    ('29dfeca5-042a-4259-853d-61f554851af7', 'ECFE', 'LOC_ECFE_TT', 1, 0, 0, 0, 0, 1, 1, 1),    -- Enhanced Community FrontEnd
    ('772960cc-ddaf-4432-870c-e97d698d7011', 'ECSS', 'LOC_ECSS_TT', 1, 0, 0, 0, 0, 1, 1, 1),    -- Enhanced City-States Selection
    ('a4b1fac6-8c9e-4873-a1c1-7ddf08dbbf11', 'EGHV', 'LOC_EGHV_TT', 1, 0, 1, 0, 0, 1, 1, 1),    -- Enhanced Goodies and Hostile Villagers
    ('d0afae5b-02f8-4d01-bd54-c2bbc3d89858', 'ENWS', 'LOC_ENWS_TT', 1, 0, 0, 0, 0, 1, 1, 1),    -- Enhanced Natural Wonders Selection
    -- community content
    ('72F3FEBC-64DF-9B21-3706-29C485D2523D', 'BFE', 'LOC_BFE_TT', 1, 0, 0, 0, 0, 1, 1, 1),      -- Better FrontEnd (UI)
    ('7d0b57ba-6a5c-4de0-ac10-e1e464ac82f6', 'CCS', 'LOC_CCS_TT', 0, 1, 0, 0, 0, 1, 1, 1),      -- CIVITAS City-States
    ('c185a48b-75d0-4897-9134-83308c5fe5ae', 'GCM', 'LOC_GCM_TT', 1, 0, 0, 0, 0, 1, 1, 1),      -- Game Config Manager
    ('619ac86e-d99d-4bf3-b8f0-8c5b8c402176', 'MPH', 'LOC_MPH_TT', 1, 0, 0, 0, 0, 1, 1, 1),      -- Multiplayer Helper
    ('60092bdd-ce39-4319-aef6-baea505c7c45', 'SCSS', 'LOC_SCSS_TT', 1, 0, 0, 0, 0, 1, 1, 1),    -- Sukritact's Civ Selection Screen
    ('2d90451f-08c9-47de-bce8-e9b7fdecbe92', 'WGH', 'LOC_WGH_TT', 0, 0, 1, 0, 0, 1, 1, 1),      -- Wondrous Goody Huts
    ('36e88483-48fe-4545-b85f-bafc50dde315', 'YNAMP', 'LOC_YNAMP_TT', 1, 0, 0, 0, 0, 1, 1, 1);  -- Yet (not) Another Maps Pack

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
