USE playerdata;

CREATE TABLE Players (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    possible_ban BOOLEAN,
    confirmed_ban BOOLEAN,
    confirmed_player BOOLEAN,
    label_id INTEGER,
    label_jagex INTEGER,
    ironman BOOLEAN,
    hardcore_ironman BOOLEAN,
    ultimate_ironman BOOLEAN,
    normalized_name TEXT
);

CREATE TABLE Reports (
    ID BIGINT PRIMARY KEY AUTO_INCREMENT,
    created_at TIMESTAMP,
    reportedID INT,
    reportingID INT,
    region_id INT,
    x_coord INT,
    y_coord INT,
    z_coord INT,
    timestamp TIMESTAMP,
    manual_detect SMALLINT,
    on_members_world INT,
    on_pvp_world SMALLINT,
    world_number INT,
    equip_head_id INT,
    equip_amulet_id INT,
    equip_torso_id INT,
    equip_legs_id INT,
    equip_boots_id INT,
    equip_cape_id INT,
    equip_hands_id INT,
    equip_weapon_id INT,
    equip_shield_id INT,
    equip_ge_value BIGINT,
    CONSTRAINT FK_Reported_Players_id FOREIGN KEY (reportedID) REFERENCES Players (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT FK_Reporting_Players_id FOREIGN KEY (reportingID) REFERENCES Players (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);


CREATE TABLE Predictions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(12),
    prediction VARCHAR(50),
    created TIMESTAMP,
    predicted_confidence DECIMAL(5, 2),
    real_player DECIMAL(5, 2) DEFAULT 0,
    pvm_melee_bot DECIMAL(5, 2) DEFAULT 0,
    smithing_bot DECIMAL(5, 2) DEFAULT 0,
    magic_bot DECIMAL(5, 2) DEFAULT 0,
    fishing_bot DECIMAL(5, 2) DEFAULT 0,
    mining_bot DECIMAL(5, 2) DEFAULT 0,
    crafting_bot DECIMAL(5, 2) DEFAULT 0,
    pvm_ranged_magic_bot DECIMAL(5, 2) DEFAULT 0,
    pvm_ranged_bot DECIMAL(5, 2) DEFAULT 0,
    hunter_bot DECIMAL(5, 2) DEFAULT 0,
    fletching_bot DECIMAL(5, 2) DEFAULT 0,
    clue_scroll_bot DECIMAL(5, 2) DEFAULT 0,
    lms_bot DECIMAL(5, 2) DEFAULT 0,
    agility_bot DECIMAL(5, 2) DEFAULT 0,
    wintertodt_bot DECIMAL(5, 2) DEFAULT 0,
    runecrafting_bot DECIMAL(5, 2) DEFAULT 0,
    zalcano_bot DECIMAL(5, 2) DEFAULT 0,
    woodcutting_bot DECIMAL(5, 2) DEFAULT 0,
    thieving_bot DECIMAL(5, 2) DEFAULT 0,
    soul_wars_bot DECIMAL(5, 2) DEFAULT 0,
    cooking_bot DECIMAL(5, 2) DEFAULT 0,
    vorkath_bot DECIMAL(5, 2) DEFAULT 0,
    barrows_bot DECIMAL(5, 2) DEFAULT 0,
    herblore_bot DECIMAL(5, 2) DEFAULT 0,
    unknown_bot DECIMAL(5, 2) DEFAULT 0
);

CREATE TABLE playerHiscoreData (
  id bigint NOT NULL AUTO_INCREMENT,
  timestamp datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ts_date date DEFAULT NULL,
  Player_id int NOT NULL,
  total bigint DEFAULT '0',
  attack int DEFAULT '0',
  defence int DEFAULT '0',
  strength int DEFAULT '0',
  hitpoints int DEFAULT '0',
  ranged int DEFAULT '0',
  prayer int DEFAULT '0',
  magic int DEFAULT '0',
  cooking int DEFAULT '0',
  woodcutting int DEFAULT '0',
  fletching int DEFAULT '0',
  fishing int DEFAULT '0',
  firemaking int DEFAULT '0',
  crafting int DEFAULT '0',
  smithing int DEFAULT '0',
  mining int DEFAULT '0',
  herblore int DEFAULT '0',
  agility int DEFAULT '0',
  thieving int DEFAULT '0',
  slayer int DEFAULT '0',
  farming int DEFAULT '0',
  runecraft int DEFAULT '0',
  hunter int DEFAULT '0',
  construction int DEFAULT '0',
  league int DEFAULT '0',
  bounty_hunter_hunter int DEFAULT '0',
  bounty_hunter_rogue int DEFAULT '0',
  cs_all int DEFAULT '0',
  cs_beginner int DEFAULT '0',
  cs_easy int DEFAULT '0',
  cs_medium int DEFAULT '0',
  cs_hard int DEFAULT '0',
  cs_elite int DEFAULT '0',
  cs_master int DEFAULT '0',
  lms_rank int DEFAULT '0',
  soul_wars_zeal int DEFAULT '0',
  abyssal_sire int DEFAULT '0',
  alchemical_hydra int DEFAULT '0',
  barrows_chests int DEFAULT '0',
  bryophyta int DEFAULT '0',
  callisto int DEFAULT '0',
  cerberus int DEFAULT '0',
  chambers_of_xeric int DEFAULT '0',
  chambers_of_xeric_challenge_mode int DEFAULT '0',
  chaos_elemental int DEFAULT '0',
  chaos_fanatic int DEFAULT '0',
  commander_zilyana int DEFAULT '0',
  corporeal_beast int DEFAULT '0',
  crazy_archaeologist int DEFAULT '0',
  dagannoth_prime int DEFAULT '0',
  dagannoth_rex int DEFAULT '0',
  dagannoth_supreme int DEFAULT '0',
  deranged_archaeologist int DEFAULT '0',
  general_graardor int DEFAULT '0',
  giant_mole int DEFAULT '0',
  grotesque_guardians int DEFAULT '0',
  hespori int DEFAULT '0',
  kalphite_queen int DEFAULT '0',
  king_black_dragon int DEFAULT '0',
  kraken int DEFAULT '0',
  kreearra int DEFAULT '0',
  kril_tsutsaroth int DEFAULT '0',
  mimic int DEFAULT '0',
  nex int DEFAULT '0',
  nightmare int DEFAULT '0',
  phosanis_nightmare int DEFAULT '0',
  obor int DEFAULT '0',
  phantom_muspah int DEFAULT '0',
  sarachnis int DEFAULT '0',
  scorpia int DEFAULT '0',
  skotizo int DEFAULT '0',
  tempoross int DEFAULT '0',
  the_gauntlet int DEFAULT '0',
  the_corrupted_gauntlet int DEFAULT '0',
  theatre_of_blood int DEFAULT '0',
  theatre_of_blood_hard int DEFAULT '0',
  thermonuclear_smoke_devil int DEFAULT '0',
  tombs_of_amascut int DEFAULT '0',
  tombs_of_amascut_expert int DEFAULT '0',
  tzkal_zuk int DEFAULT '0',
  tztok_jad int DEFAULT '0',
  venenatis int DEFAULT '0',
  vetion int DEFAULT '0',
  vorkath int DEFAULT '0',
  wintertodt int DEFAULT '0',
  zalcano int DEFAULT '0',
  zulrah int DEFAULT '0',
  rifts_closed int DEFAULT '0',
  artio int DEFAULT '0',
  calvarion int DEFAULT '0',
  duke_sucellus int DEFAULT '0',
  spindel int DEFAULT '0',
  the_leviathan int DEFAULT '0',
  the_whisperer int DEFAULT '0',
  vardorvis int DEFAULT '0',
  PRIMARY KEY (id),
  UNIQUE KEY idx_playerHiscoreData_Player_id_timestamp (Player_id,timestamp),
  UNIQUE KEY Unique_player_date (Player_id,ts_date),
  CONSTRAINT FK_Players_id FOREIGN KEY (Player_id) REFERENCES Players (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE playerHiscoreDataLatest (
  id bigint NOT NULL AUTO_INCREMENT,
  timestamp datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ts_date date DEFAULT NULL,
  Player_id int NOT NULL,
  total bigint DEFAULT NULL,
  attack int DEFAULT NULL,
  defence int DEFAULT NULL,
  strength int DEFAULT NULL,
  hitpoints int DEFAULT NULL,
  ranged int DEFAULT NULL,
  prayer int DEFAULT NULL,
  magic int DEFAULT NULL,
  cooking int DEFAULT NULL,
  woodcutting int DEFAULT NULL,
  fletching int DEFAULT NULL,
  fishing int DEFAULT NULL,
  firemaking int DEFAULT NULL,
  crafting int DEFAULT NULL,
  smithing int DEFAULT NULL,
  mining int DEFAULT NULL,
  herblore int DEFAULT NULL,
  agility int DEFAULT NULL,
  thieving int DEFAULT NULL,
  slayer int DEFAULT NULL,
  farming int DEFAULT NULL,
  runecraft int DEFAULT NULL,
  hunter int DEFAULT NULL,
  construction int DEFAULT NULL,
  league int DEFAULT NULL,
  bounty_hunter_hunter int DEFAULT NULL,
  bounty_hunter_rogue int DEFAULT NULL,
  cs_all int DEFAULT NULL,
  cs_beginner int DEFAULT NULL,
  cs_easy int DEFAULT NULL,
  cs_medium int DEFAULT NULL,
  cs_hard int DEFAULT NULL,
  cs_elite int DEFAULT NULL,
  cs_master int DEFAULT NULL,
  lms_rank int DEFAULT NULL,
  soul_wars_zeal int DEFAULT NULL,
  abyssal_sire int DEFAULT NULL,
  alchemical_hydra int DEFAULT NULL,
  barrows_chests int DEFAULT NULL,
  bryophyta int DEFAULT NULL,
  callisto int DEFAULT NULL,
  cerberus int DEFAULT NULL,
  chambers_of_xeric int DEFAULT NULL,
  chambers_of_xeric_challenge_mode int DEFAULT NULL,
  chaos_elemental int DEFAULT NULL,
  chaos_fanatic int DEFAULT NULL,
  commander_zilyana int DEFAULT NULL,
  corporeal_beast int DEFAULT NULL,
  crazy_archaeologist int DEFAULT NULL,
  dagannoth_prime int DEFAULT NULL,
  dagannoth_rex int DEFAULT NULL,
  dagannoth_supreme int DEFAULT NULL,
  deranged_archaeologist int DEFAULT NULL,
  general_graardor int DEFAULT NULL,
  giant_mole int DEFAULT NULL,
  grotesque_guardians int DEFAULT NULL,
  hespori int DEFAULT NULL,
  kalphite_queen int DEFAULT NULL,
  king_black_dragon int DEFAULT NULL,
  kraken int DEFAULT NULL,
  kreearra int DEFAULT NULL,
  kril_tsutsaroth int DEFAULT NULL,
  mimic int DEFAULT NULL,
  nex int DEFAULT NULL,
  nightmare int DEFAULT NULL,
  phosanis_nightmare int DEFAULT NULL,
  obor int DEFAULT NULL,
  phantom_muspah int DEFAULT NULL,
  sarachnis int DEFAULT NULL,
  scorpia int DEFAULT NULL,
  skotizo int DEFAULT NULL,
  Tempoross int NOT NULL,
  the_gauntlet int DEFAULT NULL,
  the_corrupted_gauntlet int DEFAULT NULL,
  theatre_of_blood int DEFAULT NULL,
  theatre_of_blood_hard int DEFAULT NULL,
  thermonuclear_smoke_devil int DEFAULT NULL,
  tombs_of_amascut int DEFAULT NULL,
  tombs_of_amascut_expert int DEFAULT NULL,
  tzkal_zuk int DEFAULT NULL,
  tztok_jad int DEFAULT NULL,
  venenatis int DEFAULT NULL,
  vetion int DEFAULT NULL,
  vorkath int DEFAULT NULL,
  wintertodt int DEFAULT NULL,
  zalcano int DEFAULT NULL,
  zulrah int DEFAULT NULL,
  rifts_closed int DEFAULT '0',
  artio int DEFAULT '0',
  calvarion int DEFAULT '0',
  duke_sucellus int DEFAULT '0',
  spindel int DEFAULT '0',
  the_leviathan int DEFAULT '0',
  the_whisperer int DEFAULT '0',
  vardorvis int DEFAULT '0',
  PRIMARY KEY (id),
  UNIQUE KEY Unique_player (Player_id) USING BTREE,
  UNIQUE KEY idx_playerHiscoreDataLatest_Player_id_timestamp (Player_id,timestamp),
  UNIQUE KEY idx_playerHiscoreDataLatest_Player_id_ts_date (Player_id,ts_date),
  CONSTRAINT FK_latest_player FOREIGN KEY (Player_id) REFERENCES Players (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE TABLE playerHiscoreDataXPChange (
  id bigint NOT NULL AUTO_INCREMENT,
  timestamp datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ts_date date DEFAULT NULL,
  Player_id int NOT NULL,
  total bigint DEFAULT NULL,
  attack int DEFAULT NULL,
  defence int DEFAULT NULL,
  strength int DEFAULT NULL,
  hitpoints int DEFAULT NULL,
  ranged int DEFAULT NULL,
  prayer int DEFAULT NULL,
  magic int DEFAULT NULL,
  cooking int DEFAULT NULL,
  woodcutting int DEFAULT NULL,
  fletching int DEFAULT NULL,
  fishing int DEFAULT NULL,
  firemaking int DEFAULT NULL,
  crafting int DEFAULT NULL,
  smithing int DEFAULT NULL,
  mining int DEFAULT NULL,
  herblore int DEFAULT NULL,
  agility int DEFAULT NULL,
  thieving int DEFAULT NULL,
  slayer int DEFAULT NULL,
  farming int DEFAULT NULL,
  runecraft int DEFAULT NULL,
  hunter int DEFAULT NULL,
  construction int DEFAULT NULL,
  league int DEFAULT NULL,
  bounty_hunter_hunter int DEFAULT NULL,
  bounty_hunter_rogue int DEFAULT NULL,
  cs_all int DEFAULT NULL,
  cs_beginner int DEFAULT NULL,
  cs_easy int DEFAULT NULL,
  cs_medium int DEFAULT NULL,
  cs_hard int DEFAULT NULL,
  cs_elite int DEFAULT NULL,
  cs_master int DEFAULT NULL,
  lms_rank int DEFAULT NULL,
  soul_wars_zeal int DEFAULT NULL,
  abyssal_sire int DEFAULT NULL,
  alchemical_hydra int DEFAULT NULL,
  barrows_chests int DEFAULT NULL,
  bryophyta int DEFAULT NULL,
  callisto int DEFAULT NULL,
  cerberus int DEFAULT NULL,
  chambers_of_xeric int DEFAULT NULL,
  chambers_of_xeric_challenge_mode int DEFAULT NULL,
  chaos_elemental int DEFAULT NULL,
  chaos_fanatic int DEFAULT NULL,
  commander_zilyana int DEFAULT NULL,
  corporeal_beast int DEFAULT NULL,
  crazy_archaeologist int DEFAULT NULL,
  dagannoth_prime int DEFAULT NULL,
  dagannoth_rex int DEFAULT NULL,
  dagannoth_supreme int DEFAULT NULL,
  deranged_archaeologist int DEFAULT NULL,
  general_graardor int DEFAULT NULL,
  giant_mole int DEFAULT NULL,
  grotesque_guardians int DEFAULT NULL,
  hespori int DEFAULT NULL,
  kalphite_queen int DEFAULT NULL,
  king_black_dragon int DEFAULT NULL,
  kraken int DEFAULT NULL,
  kreearra int DEFAULT NULL,
  kril_tsutsaroth int DEFAULT NULL,
  mimic int DEFAULT NULL,
  nex int DEFAULT NULL,
  nightmare int DEFAULT NULL,
  obor int DEFAULT NULL,
  phantom_muspah int DEFAULT NULL,
  phosanis_nightmare int DEFAULT NULL,
  sarachnis int DEFAULT NULL,
  scorpia int DEFAULT NULL,
  skotizo int DEFAULT NULL,
  Tempoross int DEFAULT NULL,
  the_gauntlet int DEFAULT NULL,
  the_corrupted_gauntlet int DEFAULT NULL,
  theatre_of_blood int DEFAULT NULL,
  theatre_of_blood_hard int DEFAULT NULL,
  thermonuclear_smoke_devil int DEFAULT NULL,
  tzkal_zuk int DEFAULT NULL,
  tztok_jad int DEFAULT NULL,
  venenatis int DEFAULT NULL,
  vetion int DEFAULT NULL,
  vorkath int DEFAULT NULL,
  wintertodt int DEFAULT NULL,
  zalcano int DEFAULT NULL,
  zulrah int DEFAULT NULL,
  rifts_closed int DEFAULT '0',
  artio int DEFAULT '0',
  calvarion int DEFAULT '0',
  duke_sucellus int DEFAULT '0',
  spindel int DEFAULT '0',
  the_leviathan int DEFAULT '0',
  the_whisperer int DEFAULT '0',
  vardorvis int DEFAULT '0',
  PRIMARY KEY (id),
  KEY IDX_xpChange_Player_id_timestamp (Player_id,timestamp) USING BTREE,
  KEY IDX_xpChange_Player_id_ts_date (Player_id,ts_date) USING BTREE,
  CONSTRAINT fk_phd_xp_pl FOREIGN KEY (Player_id) REFERENCES Players (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);
