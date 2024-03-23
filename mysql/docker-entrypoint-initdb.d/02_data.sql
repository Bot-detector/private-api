USE playerdata;

-- Insert data into the Players table

INSERT INTO
    Players (
        name,
        created_at,
        updated_at,
        possible_ban,
        confirmed_ban,
        confirmed_player,
        label_id,
        label_jagex,
        ironman,
        hardcore_ironman,
        ultimate_ironman,
        normalized_name
    )
SELECT
    CONCAT('Player', id) AS name,
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS created_at,
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS updated_at,
    1 AS possible_ban,
    0 AS confirmed_ban,
    0 AS confirmed_player,
    0 AS label_id,
    ROUND(RAND() * 1) AS label_jagex,
    -- Random label_jagex between 0 and 2 (inclusive)
    null ironman,
    null AS hardcore_ironman,
    null AS ultimate_ironman,
    CONCAT('player', id) AS normalized_name
FROM (
        SELECT (a.N + b.N * 10) AS id
        FROM (
                SELECT 0 AS N
                UNION
                SELECT 1
                UNION
                SELECT 2
                UNION
                SELECT 3
                UNION
                SELECT 4
                UNION
                SELECT 5
                UNION
                SELECT 6
                UNION
                SELECT 7
                UNION
                SELECT 8
                UNION
                SELECT
                    9
            ) AS a, (
                SELECT 0 AS N
                UNION
                SELECT 1
                UNION
                SELECT 2
                UNION
                SELECT 3
                UNION
                SELECT 4
                UNION
                SELECT 5
                UNION
                SELECT 6
                UNION
                SELECT 7
                UNION
                SELECT 8
                UNION
                SELECT
                    9
            ) AS b
    ) AS numbers
union
SELECT
    CONCAT('Player', id) AS name,
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS created_at,
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS updated_at,
    1 AS possible_ban,
    -- 50% chance of possible_ban being true
    1 AS confirmed_ban,
    -- 30% chance of confirmed_ban being true, with possible_ban and label_jagex=2
    0 AS confirmed_player,
    -- 80% chance of confirmed_player being true
    0 AS label_id,
    -- Random label_id between 0 and 2 (inclusive)
    2 AS label_jagex,
    -- Random label_jagex between 0 and 2 (inclusive)
    null ironman,
    null AS hardcore_ironman,
    null AS ultimate_ironman,
    CONCAT('player', id) AS normalized_name
FROM (
        SELECT (a.N + b.N * 10 + 100) AS id
        FROM (
                SELECT 0 AS N
                UNION
                SELECT 1
                UNION
                SELECT 2
                UNION
                SELECT 3
                UNION
                SELECT 4
                UNION
                SELECT 5
                UNION
                SELECT 6
                UNION
                SELECT 7
                UNION
                SELECT 8
                UNION
                SELECT
                    9
            ) AS a, (
                SELECT 0 AS N
                UNION
                SELECT 1
                UNION
                SELECT 2
                UNION
                SELECT 3
                UNION
                SELECT 4
                UNION
                SELECT 5
                UNION
                SELECT 6
                UNION
                SELECT 7
                UNION
                SELECT 8
                UNION
                SELECT
                    9
            ) AS b
    ) AS numbers
union
SELECT
    CONCAT('Player', id) AS name,
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS created_at,
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS updated_at,
    0 AS possible_ban,
    -- 50% chance of possible_ban being true
    0 AS confirmed_ban,
    -- 30% chance of confirmed_ban being true, with possible_ban and label_jagex=2
    1 AS confirmed_player,
    -- 80% chance of confirmed_player being true
    0 AS label_id,
    -- Random label_id between 0 and 2 (inclusive)
    0 AS label_jagex,
    -- Random label_jagex between 0 and 2 (inclusive)
    null ironman,
    null AS hardcore_ironman,
    null AS ultimate_ironman,
    CONCAT('player', id) AS normalized_name
FROM (
        SELECT (a.N + b.N * 10 + 200) AS id
        FROM (
                SELECT 0 AS N
                UNION
                SELECT 1
                UNION
                SELECT 2
                UNION
                SELECT 3
                UNION
                SELECT 4
                UNION
                SELECT 5
                UNION
                SELECT 6
                UNION
                SELECT 7
                UNION
                SELECT 8
                UNION
                SELECT
                    9
            ) AS a, (
                SELECT 0 AS N
                UNION
                SELECT 1
                UNION
                SELECT 2
                UNION
                SELECT 3
                UNION
                SELECT 4
                UNION
                SELECT 5
                UNION
                SELECT 6
                UNION
                SELECT 7
                UNION
                SELECT 8
                UNION
                SELECT
                    9
            ) AS b
    ) AS numbers;

-- Insert data into the Reports table

INSERT INTO
    Reports (
        created_at,
        reportedID,
        reportingID,
        region_id,
        x_coord,
        y_coord,
        z_coord,
        timestamp,
        manual_detect,
        on_members_world,
        on_pvp_world,
        world_number,
        equip_head_id,
        equip_amulet_id,
        equip_torso_id,
        equip_legs_id,
        equip_boots_id,
        equip_cape_id,
        equip_hands_id,
        equip_weapon_id,
        equip_shield_id,
        equip_ge_value
    )
SELECT
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS created_at,
    p1.id AS reportedID,
    p2.id AS reportingID,
    ROUND(RAND() * 1000) AS region_id,
    -- Random region_id
    ROUND(RAND() * 1000) AS x_coord,
    -- Random x_coord
    ROUND(RAND() * 1000) AS y_coord,
    -- Random y_coord
    ROUND(RAND() * 1000) AS z_coord,
    -- Random z_coord
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS timestamp,
    ROUND(RAND()) AS manual_detect,
    -- Random manual_detect (0 or 1)
    ROUND(RAND() * 1000) AS on_members_world,
    -- Random on_members_world
    ROUND(RAND()) AS on_pvp_world,
    -- Random on_pvp_world (0 or 1)
    ROUND(RAND() * 100) AS world_number,
    -- Random world_number
    ROUND(RAND() * 1000) AS equip_head_id,
    -- Random equip_head_id
    ROUND(RAND() * 1000) AS equip_amulet_id,
    -- Random equip_amulet_id
    ROUND(RAND() * 1000) AS equip_torso_id,
    -- Random equip_torso_id
    ROUND(RAND() * 1000) AS equip_legs_id,
    -- Random equip_legs_id
    ROUND(RAND() * 1000) AS equip_boots_id,
    -- Random equip_boots_id
    ROUND(RAND() * 1000) AS equip_cape_id,
    -- Random equip_cape_id
    ROUND(RAND() * 1000) AS equip_hands_id,
    -- Random equip_hands_id
    ROUND(RAND() * 1000) AS equip_weapon_id,
    -- Random equip_weapon_id
    ROUND(RAND() * 1000) AS equip_shield_id,
    -- Random equip_shield_id
    ROUND(RAND() * 10000) AS equip_ge_value -- Random equip_ge_value
FROM Players p1
    CROSS JOIN Players p2
WHERE
    p1.id <> p2.id -- Ensure reportedID and reportingID are different
ORDER BY
    RAND() -- Randomize the order of the combinations
LIMIT
    10000 -- Limit the number of combinations to insert
;

DELIMITER $$

CREATE PROCEDURE INSERTROWS(NUM INT) BEGIN
	DECLARE i INT;
	SET i = 1;
	WHILE i <= num DO SET @rand = FLOOR(1 + RAND() * 25);
	SET @multiplier = FLOOR(51 + RAND() * 50);
	INSERT INTO Predictions
	SET
	    name = CONCAT('Player', i),
	    created = NOW() - INTERVAL FLOOR(RAND() * 365) DAY,
	    predicted_confidence = @multiplier,
	    prediction = CASE @rand
	        WHEN 1 THEN 'real_player'
	        WHEN 2 THEN 'pvm_melee_bot'
	        WHEN 3 THEN 'smithing_bot'
	        WHEN 4 THEN 'magic_bot'
	        WHEN 5 THEN 'fishing_bot'
	        WHEN 6 THEN 'mining_bot'
	        WHEN 7 THEN 'crafting_bot'
	        WHEN 8 THEN 'pvm_ranged_magic_bot'
	        WHEN 9 THEN 'pvm_ranged_bot'
	        WHEN 10 THEN 'hunter_bot'
	        WHEN 11 THEN 'fletching_bot'
	        WHEN 12 THEN 'clue_scroll_bot'
	        WHEN 13 THEN 'lms_bot'
	        WHEN 14 THEN 'agility_bot'
	        WHEN 15 THEN 'wintertodt_bot'
	        WHEN 16 THEN 'runecrafting_bot'
	        WHEN 17 THEN 'zalcano_bot'
	        WHEN 18 THEN 'woodcutting_bot'
	        WHEN 19 THEN 'thieving_bot'
	        WHEN 20 THEN 'soul_wars_bot'
	        WHEN 21 THEN 'cooking_bot'
	        WHEN 22 THEN 'vorkath_bot'
	        WHEN 23 THEN 'barrows_bot'
	        WHEN 24 THEN 'herblore_bot'
	        ELSE 'unknown_bot'
	    END,
	    real_player = IF(@rand = 1, 1, 0) * @multiplier,
	    pvm_melee_bot = IF(@rand = 2, 1, 0) * @multiplier,
	    smithing_bot = IF(@rand = 3, 1, 0) * @multiplier,
	    magic_bot = IF(@rand = 4, 1, 0) * @multiplier,
	    fishing_bot = IF(@rand = 5, 1, 0) * @multiplier,
	    mining_bot = IF(@rand = 6, 1, 0) * @multiplier,
	    crafting_bot = IF(@rand = 7, 1, 0) * @multiplier,
	    pvm_ranged_magic_bot = IF(@rand = 8, 1, 0) * @multiplier,
	    pvm_ranged_bot = IF(@rand = 9, 1, 0) * @multiplier,
	    hunter_bot = IF(@rand = 10, 1, 0) * @multiplier,
	    fletching_bot = IF (@rand = 11, 1, 0) * @multiplier,
	    clue_scroll_bot = IF (@rand = 12, 1, 0) * @multiplier,
	    lms_bot = IF (@rand = 13, 1, 0) * @multiplier,
	    agility_bot = IF (@rand = 14, 1, 0) * @multiplier,
	    wintertodt_bot = IF (@rand = 15, 1, 0) * @multiplier,
	    runecrafting_bot = IF (@rand = 16, 1, 0) * @multiplier,
	    zalcano_bot = IF (@rand = 17, 1, 0) * @multiplier,
	    woodcutting_bot = IF (@rand = 18, 1, 0) * @multiplier,
	    thieving_bot = IF (@rand = 19, 1, 0) * @multiplier,
	    soul_wars_bot = IF (@rand = 20, 1, 0) * @multiplier,
	    cooking_bot = IF (@rand = 21, 1, 0) * @multiplier,
	    vorkath_bot = IF (@rand = 22, 1, 0) * @multiplier,
	    barrows_bot = IF (@rand = 23, 1, 0) * @multiplier,
	    herblore_bot = IF (@rand = 24, 1, 0) * @multiplier,
	    unknown_bot = IF (@rand = 25, 1, 0) * @multiplier;
	SET i = i + 1;
	END WHILE;
	END$$


DELIMITER ;

CALL InsertRows(250);

-- Inserting 10 records starting from id 1
INSERT INTO playerHiscoreDataLatest (id, timestamp, ts_date, Player_id, total, attack, defence, strength, hitpoints, ranged, prayer)
VALUES
(1, NOW(), CURDATE(), 1, 1000, 70, 60, 80, 75, 65, 70),
(2, NOW(), CURDATE(), 2, 1200, 80, 70, 90, 85, 75, 80),
(3, NOW(), CURDATE(), 3, 800, 60, 50, 70, 65, 55, 60),
(4, NOW(), CURDATE(), 4, 1500, 90, 80, 100, 95, 85, 90),
(5, NOW(), CURDATE(), 5, 1100, 75, 65, 85, 80, 70, 75),
(6, NOW(), CURDATE(), 6, 1300, 85, 75, 95, 90, 80, 85),
(7, NOW(), CURDATE(), 7, 950, 65, 55, 75, 70, 60, 65),
(8, NOW(), CURDATE(), 8, 1700, 95, 85, 105, 100, 90, 95),
(9, NOW(), CURDATE(), 9, 1000, 70, 60, 80, 75, 65, 70),
(10, NOW(), CURDATE(), 10, 1200, 80, 70, 90, 85, 75, 80);


INSERT INTO skills (skill_id, skill_name) VALUES
	(2, 'attack'),
	(3, 'defence'),
	(4, 'strength'),
	(5, 'hitpoints'),
	(6, 'ranged'),
	(7, 'prayer'),
	(8, 'magic'),
	(9, 'cooking'),
	(10, 'woodcutting'),
	(11, 'fletching'),
	(12, 'fishing'),
	(13, 'firemaking'),
	(14, 'crafting'),
	(15, 'smithing'),
	(16, 'mining'),
	(17, 'herblore'),
	(18, 'agility'),
	(19, 'thieving'),
	(20, 'slayer'),
	(21, 'farming'),
	(22, 'runecraft'),
	(23, 'hunter'),
	(24, 'construction')
;


INSERT INTO activities (activity_id, activity_name) VALUES
	(1, 'abyssal_sire'),
	(2, 'alchemical_hydra'),
	(3, 'artio'),
	(4, 'barrows_chests'),
	(5, 'bounty_hunter_hunter'),
	(6, 'bounty_hunter_rogue'),
	(7, 'bryophyta'),
	(8, 'callisto'),
	(9, 'calvarion'),
	(10, 'cerberus'),
	(11, 'chambers_of_xeric'),
	(12, 'chambers_of_xeric_challenge_mode'),
	(13, 'chaos_elemental'),
	(14, 'chaos_fanatic'),
	(15, 'commander_zilyana'),
	(16, 'corporeal_beast'),
	(17, 'crazy_archaeologist'),
	(18, 'cs_all'),
	(19, 'cs_beginner'),
	(20, 'cs_easy'),
	(21, 'cs_elite'),
	(22, 'cs_hard'),
	(23, 'cs_master'),
	(24, 'cs_medium'),
	(25, 'dagannoth_prime'),
	(26, 'dagannoth_rex'),
	(27, 'dagannoth_supreme'),
	(28, 'deranged_archaeologist'),
	(29, 'duke_sucellus'),
	(30, 'general_graardor'),
	(31, 'giant_mole'),
	(32, 'grotesque_guardians'),
	(33, 'hespori'),
	(34, 'kalphite_queen'),
	(35, 'king_black_dragon'),
	(36, 'kraken'),
	(37, 'kreearra'),
	(38, 'kril_tsutsaroth'),
	(39, 'league'),
	(40, 'lms_rank'),
	(41, 'mimic'),
	(42, 'nex'),
	(43, 'nightmare'),
	(44, 'obor'),
	(45, 'phantom_muspah'),
	(46, 'phosanis_nightmare'),
	(47, 'rifts_closed'),
	(48, 'sarachnis'),
	(49, 'scorpia'),
	(50, 'skotizo'),
	(51, 'soul_wars_zeal'),
	(52, 'spindel'),
	(53, 'tempoross'),
	(54, 'the_corrupted_gauntlet'),
	(55, 'the_gauntlet'),
	(56, 'the_leviathan'),
	(57, 'the_whisperer'),
	(58, 'theatre_of_blood'),
	(59, 'theatre_of_blood_hard'),
	(60, 'thermonuclear_smoke_devil'),
	(61, 'tombs_of_amascut'),
	(62, 'tombs_of_amascut_expert'),
	(63, 'tzkal_zuk'),
	(64, 'tztok_jad'),
	(65, 'vardorvis'),
	(66, 'venenatis'),
	(67, 'vetion'),
	(68, 'vorkath'),
	(69, 'wintertodt'),
	(70, 'zalcano'),
	(71, 'zulrah')
;

insert into scraper_data (scraper_id, created_at, player_id) VALUES
	(4941843,'2024-03-18 02:13:46',1),
	(7147825,'2024-03-19 00:49:45',1),
	(9462081,'2024-03-20 00:48:29',1),
	(12935727,'2024-03-21 00:11:55',1),
	(14602384,'2024-03-22 04:40:49',1),
	(15121534,'2024-03-23 00:10:05',1),
	(1940168,'2024-03-17 00:05:17',8),
	(4941785,'2024-03-18 02:13:46',8),
	(7005058,'2024-03-19 00:05:31',8),
	(9529321,'2024-03-20 00:48:31',8),
	(13210211,'2024-03-21 00:46:29',8),
	(14377161,'2024-03-22 00:28:25',8),
	(15114040,'2024-03-23 00:10:04',8)
;
insert into scraper_data_latest (scraper_id, created_at, player_id) VALUES
	(15121534,'2024-03-23 00:10:05',1),
	(15114040,'2024-03-23 00:10:04',8)
;

INSERT INTO player_activities (scraper_id, activity_id, activity_value) VALUES
	(4941843,4,13),
	(4941843,30,8),
	(4941843,48,50),
	(4941843,69,52),
	(7147825,4,13),
	(7147825,30,8),
	(7147825,48,50),
	(7147825,69,52),
	(9462081,4,13),
	(9462081,30,8),
	(9462081,48,50),
	(9462081,69,52),
	(12935727,4,13),
	(12935727,30,8),
	(12935727,48,50),
	(12935727,69,52),
	(14602384,4,13),
	(14602384,30,8),
	(14602384,48,50),
	(14602384,69,52),
	(15121534,4,13),
	(15121534,30,8),
	(15121534,48,50),
	(15121534,69,52),
	(1940168,4,51),
	(1940168,7,10),
	(1940168,11,56),
	(1940168,13,25),
	(1940168,14,56),
	(1940168,16,24),
	(1940168,17,51),
	(1940168,18,127),
	(1940168,20,4),
	(1940168,21,3),
	(1940168,22,2),
	(1940168,24,118),
	(1940168,28,50),
	(1940168,30,30),
	(1940168,31,433),
	(1940168,33,25),
	(1940168,35,56),
	(1940168,40,535),
	(1940168,42,21),
	(1940168,43,55),
	(1940168,44,10),
	(1940168,47,22),
	(1940168,48,58),
	(1940168,50,10),
	(1940168,51,835),
	(1940168,53,72),
	(1940168,64,10),
	(1940168,68,114),
	(1940168,69,73),
	(1940168,71,1256),
	(4941785,4,51),
	(4941785,7,10),
	(4941785,11,56),
	(4941785,13,25),
	(4941785,14,56),
	(4941785,16,24),
	(4941785,17,51),
	(4941785,18,127),
	(4941785,20,4),
	(4941785,21,3),
	(4941785,22,2),
	(4941785,24,118),
	(4941785,28,50),
	(4941785,30,30),
	(4941785,31,433),
	(4941785,33,25),
	(4941785,35,56),
	(4941785,40,535),
	(4941785,42,21),
	(4941785,43,55),
	(4941785,44,10),
	(4941785,47,22),
	(4941785,48,58),
	(4941785,50,10),
	(4941785,51,835),
	(4941785,53,72),
	(4941785,64,10),
	(4941785,68,114),
	(4941785,69,73),
	(4941785,71,1256),
	(7005058,4,51),
	(7005058,7,10),
	(7005058,11,56),
	(7005058,13,25),
	(7005058,14,56),
	(7005058,16,24),
	(7005058,17,51),
	(7005058,18,127),
	(7005058,20,4),
	(7005058,21,3),
	(7005058,22,2),
	(7005058,24,118),
	(7005058,28,50),
	(7005058,30,30),
	(7005058,31,433),
	(7005058,33,25),
	(7005058,35,56),
	(7005058,40,535),
	(7005058,42,21),
	(7005058,43,55),
	(7005058,44,10),
	(7005058,47,22),
	(7005058,48,58),
	(7005058,50,10),
	(7005058,51,835),
	(7005058,53,72),
	(7005058,64,10),
	(7005058,68,114),
	(7005058,69,73),
	(7005058,71,1256),
	(9529321,4,51),
	(9529321,7,10),
	(9529321,11,56),
	(9529321,13,25),
	(9529321,14,56),
	(9529321,16,24),
	(9529321,17,51),
	(9529321,18,127),
	(9529321,20,4),
	(9529321,21,3),
	(9529321,22,2),
	(9529321,24,118),
	(9529321,28,50),
	(9529321,30,30),
	(9529321,31,433),
	(9529321,33,25),
	(9529321,35,56),
	(9529321,40,535),
	(9529321,42,21),
	(9529321,43,55),
	(9529321,44,10),
	(9529321,47,22),
	(9529321,48,58),
	(9529321,50,10),
	(9529321,51,835),
	(9529321,53,72),
	(9529321,64,10),
	(9529321,68,114),
	(9529321,69,73),
	(9529321,71,1256),
	(13210211,4,51),
	(13210211,7,10),
	(13210211,11,56),
	(13210211,13,25),
	(13210211,14,56),
	(13210211,16,24),
	(13210211,17,51),
	(13210211,18,127),
	(13210211,20,4),
	(13210211,21,3),
	(13210211,22,2),
	(13210211,24,118),
	(13210211,28,50),
	(13210211,30,30),
	(13210211,31,433),
	(13210211,33,25),
	(13210211,35,56),
	(13210211,40,535),
	(13210211,42,21),
	(13210211,43,55),
	(13210211,44,10),
	(13210211,47,22),
	(13210211,48,58),
	(13210211,50,10),
	(13210211,51,835),
	(13210211,53,72),
	(13210211,64,10),
	(13210211,68,114),
	(13210211,69,73),
	(13210211,71,1256),
	(14377161,4,51),
	(14377161,7,10),
	(14377161,11,56),
	(14377161,13,25),
	(14377161,14,56),
	(14377161,16,24),
	(14377161,17,51),
	(14377161,18,127),
	(14377161,20,4),
	(14377161,21,3),
	(14377161,22,2),
	(14377161,24,118),
	(14377161,28,50),
	(14377161,30,30),
	(14377161,31,433),
	(14377161,33,25),
	(14377161,35,56),
	(14377161,40,535),
	(14377161,42,21),
	(14377161,43,55),
	(14377161,44,10),
	(14377161,47,22),
	(14377161,48,58),
	(14377161,50,10),
	(14377161,51,835),
	(14377161,53,72)
;

INSERT INTO player_skills (scraper_id, skill_id, skill_value) VALUES
	(4941843,2,2231),
	(4941843,3,321),
	(4941843,4,456),
	(4941843,5,5),
	(4941843,6,6),
	(4941843,7,7),
	(4941843,8,8),
	(4941843,9,9),
	(4941843,10,10),
	(4941843,11,11),
	(4941843,12,12),
	(4941843,13,13),
	(4941843,14,14),
	(4941843,15,15),
	(4941843,16,16),
	(4941843,17,17),
	(4941843,18,18),
	(4941843,19,19),
	(4941843,20,20),
	(4941843,21,21),
	(4941843,22,22),
	(4941843,23,23),
	(4941843,24,24),
	(7147825,2,25646),
	(7147825,3,3),
	(7147825,4,4454),
	(7147825,5,5),
	(7147825,6,6),
	(7147825,7,7),
	(7147825,8,8),
	(7147825,9,9),
	(7147825,10,10),
	(7147825,11,11),
	(7147825,12,12),
	(7147825,13,13),
	(7147825,14,14),
	(7147825,15,15),
	(7147825,16,16),
	(7147825,17,17),
	(7147825,18,18),
	(7147825,19,19),
	(7147825,20,20),
	(7147825,21,21),
	(7147825,22,22),
	(7147825,23,23),
	(7147825,24,24),
	(9462081,2,2),
	(9462081,3,3544),
	(9462081,4,4),
	(9462081,5,564464),
	(9462081,6,6),
	(9462081,7,7),
	(9462081,8,8),
	(9462081,9,9),
	(9462081,10,10),
	(9462081,11,11),
	(9462081,12,12),
	(9462081,13,13),
	(9462081,14,14),
	(9462081,15,15),
	(9462081,16,16),
	(9462081,17,17),
	(9462081,18,18),
	(9462081,19,19),
	(9462081,20,20),
	(9462081,21,21),
	(9462081,22,22),
	(9462081,23,23),
	(9462081,24,24),
	(12935727,2,2),
	(12935727,3,346465),
	(12935727,4,46665),
	(12935727,5,5),
	(12935727,6,6),
	(12935727,7,7),
	(12935727,8,8),
	(12935727,9,9),
	(12935727,10,10),
	(12935727,11,11),
	(12935727,12,12),
	(12935727,13,13),
	(12935727,14,1454),
	(12935727,15,15),
	(12935727,16,16),
	(12935727,17,17),
	(12935727,18,18),
	(12935727,19,19),
	(12935727,20,20),
	(12935727,21,21),
	(12935727,22,22),
	(12935727,23,23),
	(12935727,24,24),
	(14602384,2,2),
	(14602384,3,36545),
	(14602384,4,424),
	(14602384,5,5454),
	(14602384,6,654564),
	(14602384,7,7),
	(14602384,8,8),
	(14602384,9,9),
	(14602384,10,10),
	(14602384,11,11),
	(14602384,12,12),
	(14602384,13,13),
	(14602384,14,14),
	(14602384,15,15),
	(14602384,16,16),
	(14602384,17,17),
	(14602384,18,18),
	(14602384,19,19),
	(14602384,20,20),
	(14602384,21,21),
	(14602384,22,22),
	(14602384,23,23),
	(14602384,24,24),
	(15121534,2,2564),
	(15121534,3,35454),
	(15121534,4,4),
	(15121534,5,55132),
	(15121534,6,6),
	(15121534,7,7),
	(15121534,8,8),
	(15121534,9,9),
	(15121534,10,10),
	(15121534,11,11),
	(15121534,12,12),
	(15121534,13,13),
	(15121534,14,14),
	(15121534,15,15),
	(15121534,16,16),
	(15121534,17,17),
	(15121534,18,18),
	(15121534,19,19),
	(15121534,20,20),
	(15121534,21,21),
	(15121534,22,22),
	(15121534,23,23),
	(15121534,24,24),
	(1940168,2,21212),
	(1940168,3,3),
	(1940168,4,4),
	(1940168,5,5),
	(1940168,6,6),
	(1940168,7,7),
	(1940168,8,8),
	(1940168,9,9),
	(1940168,10,10),
	(1940168,11,11),
	(1940168,12,12),
	(1940168,13,13),
	(1940168,14,14),
	(1940168,15,15),
	(1940168,16,16),
	(1940168,17,17),
	(1940168,18,18),
	(1940168,19,19),
	(1940168,20,20),
	(1940168,21,21),
	(1940168,22,22),
	(1940168,23,23),
	(1940168,24,24),
	(4941785,2,2),
	(4941785,3,3),
	(4941785,4,41221),
	(4941785,5,5),
	(4941785,6,6),
	(4941785,7,7),
	(4941785,8,8),
	(4941785,9,9),
	(4941785,10,10),
	(4941785,11,11),
	(4941785,12,12),
	(4941785,13,13),
	(4941785,14,14),
	(4941785,15,15),
	(4941785,16,16),
	(4941785,17,17),
	(4941785,18,18),
	(4941785,19,19),
	(4941785,20,20),
	(4941785,21,21),
	(4941785,22,22),
	(4941785,23,23),
	(4941785,24,24),
	(7005058,2,2),
	(7005058,3,3),
	(7005058,4,4454),
	(7005058,5,5),
	(7005058,6,6),
	(7005058,7,74454),
	(7005058,8,8),
	(7005058,9,9),
	(7005058,10,10),
	(7005058,11,11),
	(7005058,12,12),
	(7005058,13,13),
	(7005058,14,14),
	(7005058,15,15),
	(7005058,16,16),
	(7005058,17,17),
	(7005058,18,18),
	(7005058,19,19),
	(7005058,20,20),
	(7005058,21,21),
	(7005058,22,22),
	(7005058,23,23),
	(7005058,24,24),
	(9529321,2,2464),
	(9529321,3,34554),
	(9529321,4,4),
	(9529321,5,5544),
	(9529321,6,6),
	(9529321,7,7),
	(9529321,8,8),
	(9529321,9,9),
	(9529321,10,10),
	(9529321,11,11),
	(9529321,12,12),
	(9529321,13,13),
	(9529321,14,14),
	(9529321,15,15),
	(9529321,16,16),
	(9529321,17,17),
	(9529321,18,18),
	(9529321,19,19),
	(9529321,20,20),
	(9529321,21,21),
	(9529321,22,22),
	(9529321,23,23),
	(9529321,24,24),
	(13210211,2,24465),
	(13210211,3,34454),
	(13210211,4,4),
	(13210211,5,5),
	(13210211,6,6),
	(13210211,7,7),
	(13210211,8,8),
	(13210211,9,9),
	(13210211,10,10),
	(13210211,11,11),
	(13210211,12,12),
	(13210211,13,13),
	(13210211,14,14),
	(13210211,15,15),
	(13210211,16,16),
	(13210211,17,17),
	(13210211,18,18),
	(13210211,19,19),
	(13210211,20,20),
	(13210211,21,21),
	(13210211,22,22),
	(13210211,23,23),
	(13210211,24,24),
	(14377161,2,4545),
	(14377161,3,3),
	(14377161,4,4),
	(14377161,5,5),
	(14377161,6,656455),
	(14377161,7,7),
	(14377161,8,8),
	(14377161,9,9),
	(14377161,10,10),
	(14377161,11,11),
	(14377161,12,12),
	(14377161,13,13),
	(14377161,14,14),
	(14377161,15,15),
	(14377161,16,16),
	(14377161,17,17),
	(14377161,18,18),
	(14377161,19,19),
	(14377161,20,20),
	(14377161,21,21),
	(14377161,22,22),
	(14377161,23,23),
	(14377161,24,24),
	(15114040,2,2),
	(15114040,3,3),
	(15114040,4,4),
	(15114040,5,54655656),
	(15114040,6,6445),
	(15114040,7,7),
	(15114040,8,8),
	(15114040,9,9),
	(15114040,10,10),
	(15114040,11,11),
	(15114040,12,12),
	(15114040,13,13),
	(15114040,14,14),
	(15114040,15,15),
	(15114040,16,16),
	(15114040,17,17),
	(15114040,18,18),
	(15114040,19,19),
	(15114040,20,20455),
	(15114040,21,21),
	(15114040,22,22),
	(15114040,23,23),
	(15114040,24,24)
;
