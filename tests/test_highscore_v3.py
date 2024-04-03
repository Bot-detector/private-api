import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_one_hs_id_v3(custom_client):
    endpoint = "/v3/highscore/latest"
    async with custom_client as client:
        client: AsyncClient
        params = {
            "player_id": 1,
        }
        response = await client.get(url=endpoint, params=params)

        assert response.status_code == 200
        assert isinstance(response.json(), list)

        json_response: list[dict] = response.json()
        assert len(json_response) == 1
        assert isinstance(
            json_response[0], dict
        ), f"expected dict, got {type(json_response[0])}, {json_response=}"

        player = json_response[0]
        assert player.get("player_id") == 1, f"expected id: 1 got: {player=}"


@pytest.mark.asyncio
async def test_many_hs_id_v3(custom_client):
    endpoint = "/v3/highscore/latest"
    async with custom_client as client:
        client: AsyncClient
        params = {"player_id": 1, "many": 1}
        response = await client.get(url=endpoint, params=params)

        assert response.status_code == 200
        assert isinstance(response.json(), list)

        json_response: list[dict] = response.json()
        assert len(json_response) >= 1
        assert isinstance(
            json_response[0], dict
        ), f"expected dict, got {type(json_response[0])}, {json_response=}"

        player = json_response[0]
        assert player.get("player_id") == 1, f"expected id: 1 got: {player=}"


@pytest.mark.asyncio
async def test_highscore_latest_v3(custom_client):
    endpoint = "/v3/highscore/latest"
    async with custom_client as client:
        client: AsyncClient
        params = {"player_id": 1}
        response = await client.get(url=endpoint, params=params)

        assert response.status_code == 200
        assert isinstance(response.json(), list)

        json_response: list[dict] = response.json()
        assert len(json_response) == 1
        assert isinstance(
            json_response[0], dict
        ), f"expected dict, got {type(json_response[0])}, {json_response=}"

        player = json_response[0]
        # assert player.get("Player_id") == 1, f"expected Player_id: 1 got: {player=}"

        # List of keys that should be present in the player dictionary
        keys = [
            "id",
            "timestamp",
            "ts_date",
            "Player_id",
            "total",
            "attack",
            "defence",
            "strength",
            "hitpoints",
            "ranged",
            "prayer",
            "magic",
            "cooking",
            "woodcutting",
            "fletching",
            "fishing",
            "firemaking",
            "crafting",
            "smithing",
            "mining",
            "herblore",
            "agility",
            "thieving",
            "slayer",
            "farming",
            "runecraft",
            "hunter",
            "construction",
            "league",
            "bounty_hunter_hunter",
            "bounty_hunter_rogue",
            "cs_all",
            "cs_beginner",
            "cs_easy",
            "cs_medium",
            "cs_hard",
            "cs_elite",
            "cs_master",
            "lms_rank",
            "soul_wars_zeal",
            "abyssal_sire",
            "alchemical_hydra",
            "barrows_chests",
            "bryophyta",
            "callisto",
            "cerberus",
            "chambers_of_xeric",
            "chambers_of_xeric_challenge_mode",
            "chaos_elemental",
            "chaos_fanatic",
            "commander_zilyana",
            "corporeal_beast",
            "crazy_archaeologist",
            "dagannoth_prime",
            "dagannoth_rex",
            "dagannoth_supreme",
            "deranged_archaeologist",
            "general_graardor",
            "giant_mole",
            "grotesque_guardians",
            "hespori",
            "kalphite_queen",
            "king_black_dragon",
            "kraken",
            "kreearra",
            "kril_tsutsaroth",
            "mimic",
            "nex",
            "nightmare",
            "phosanis_nightmare",
            "obor",
            "phantom_muspah",
            "sarachnis",
            "scorpia",
            "skotizo",
            "tempoross",
            "the_gauntlet",
            "the_corrupted_gauntlet",
            "theatre_of_blood",
            "theatre_of_blood_hard",
            "thermonuclear_smoke_devil",
            "tombs_of_amascut",
            "tombs_of_amascut_expert",
            "tzkal_zuk",
            "tztok_jad",
            "venenatis",
            "vetion",
            "vorkath",
            "wintertodt",
            "zalcano",
            "zulrah",
            "rifts_closed",
            "artio",
            "calvarion",
            "duke_sucellus",
            "spindel",
            "the_leviathan",
            "the_whisperer",
            "vardorvis",
        ]
        # these keys should be present in the player dictionary
        player_keys = ["record_date", "scraper_id", "player_id", "created_at"]
        # in the player dictionary there should be a skills dictionary present with 23 skills
        skill_keys = [
            "attack",
            "defence",
            "strength",
            "hitpoints",
            "ranged",
            "prayer",
            "magic",
            "cooking",
            "woodcutting",
            "fletching",
            "fishing",
            "firemaking",
            "crafting",
            "smithing",
            "mining",
            "herblore",
            "agility",
            "thieving",
            "slayer",
            "farming",
            "runecraft",
            "hunter",
            "construction",
        ]
        # in the player dictionary there should be an activity key can be empty, dynamic depending on if player has done the activity, could return none or some or all of the activities
        activity_keys = [
            "league",
            "bounty_hunter_hunter",
            "bounty_hunter_rogue",
            "cs_all",
            "cs_beginner",
            "cs_easy",
            "cs_medium",
            "cs_hard",
            "cs_elite",
            "cs_master",
            "lms_rank",
            "soul_wars_zeal",
            "abyssal_sire",
            "alchemical_hydra",
            "barrows_chests",
            "bryophyta",
            "callisto",
            "cerberus",
            "chambers_of_xeric",
            "chambers_of_xeric_challenge_mode",
            "chaos_elemental",
            "chaos_fanatic",
            "commander_zilyana",
            "corporeal_beast",
            "crazy_archaeologist",
            "dagannoth_prime",
            "dagannoth_rex",
            "dagannoth_supreme",
            "deranged_archaeologist",
            "general_graardor",
            "giant_mole",
            "grotesque_guardians",
            "hespori",
            "kalphite_queen",
            "king_black_dragon",
            "kraken",
            "kreearra",
            "kril_tsutsaroth",
            "mimic",
            "nex",
            "nightmare",
            "phosanis_nightmare",
            "obor",
            "phantom_muspah",
            "sarachnis",
            "scorpia",
            "skotizo",
            "tempoross",
            "the_gauntlet",
            "the_corrupted_gauntlet",
            "theatre_of_blood",
            "theatre_of_blood_hard",
            "thermonuclear_smoke_devil",
            "tombs_of_amascut",
            "tombs_of_amascut_expert",
            "tzkal_zuk",
            "tztok_jad",
            "venenatis",
            "vetion",
            "vorkath",
            "wintertodt",
            "zalcano",
            "zulrah",
            "rifts_closed",
            "artio",
            "calvarion",
            "duke_sucellus",
            "spindel",
            "the_leviathan",
            "the_whisperer",
            "vardorvis",
        ]

        # Check if all player keys are present in the player dictionary
        for key in player_keys:
            assert key in player, f"Player key {key} not found in player dictionary"

        # Check if all skill keys are present in the player dictionary
        for key in skill_keys:
            assert (
                key in player["skills"]
            ), f"Skill key {key} not found in player dictionary"

        # Check if all activity keys are present in the player dictionary
        for key in player["activity"]:
            assert (
                key in activity_keys
            ), f"Activity key {key} not found in player dictionary"

        # Dictionary with expected types
        expected_types = {
            "player_id": int,
            "record_date": str,
            "created_at": str,
            "player_id": int,
            "total": int,
            "attack": int,
            "defence": int,
            "strength": int,
            "hitpoints": int,
            "ranged": int,
            "prayer": int,
            "magic": int,
            "cooking": int,
            "woodcutting": int,
            "fletching": int,
            "fishing": int,
            "firemaking": int,
            "crafting": int,
            "smithing": int,
            "mining": int,
            "herblore": int,
            "agility": int,
            "thieving": int,
            "slayer": int,
            "farming": int,
            "runecraft": int,
            "hunter": int,
            "construction": int,
            "league": int,
            "bounty_hunter_hunter": int,
            "bounty_hunter_rogue": int,
            "cs_all": int,
            "cs_beginner": int,
            "cs_easy": int,
            "cs_medium": int,
            "cs_hard": int,
            "cs_elite": int,
            "cs_master": int,
            "lms_rank": int,
            "soul_wars_zeal": int,
            "abyssal_sire": int,
            "alchemical_hydra": int,
            "barrows_chests": int,
            "bryophyta": int,
            "callisto": int,
            "cerberus": int,
            "chambers_of_xeric": int,
            "chambers_of_xeric_challenge_mode": int,
            "chaos_elemental": int,
            "chaos_fanatic": int,
            "commander_zilyana": int,
            "corporeal_beast": int,
            "crazy_archaeologist": int,
            "dagannoth_prime": int,
            "dagannoth_rex": int,
            "dagannoth_supreme": int,
            "deranged_archaeologist": int,
            "general_graardor": int,
            "giant_mole": int,
            "grotesque_guardians": int,
            "hespori": int,
            "kalphite_queen": int,
            "king_black_dragon": int,
            "kraken": int,
            "kreearra": int,
            "kril_tsutsaroth": int,
            "mimic": int,
            "nex": int,
            "nightmare": int,
            "phosanis_nightmare": int,
            "obor": int,
            "phantom_muspah": int,
            "sarachnis": int,
            "scorpia": int,
            "skotizo": int,
            "tempoross": int,
            "the_gauntlet": int,
            "the_corrupted_gauntlet": int,
            "theatre_of_blood": int,
            "theatre_of_blood_hard": int,
            "thermonuclear_smoke_devil": int,
            "tombs_of_amascut": int,
            "tombs_of_amascut_expert": int,
            "tzkal_zuk": int,
            "tztok_jad": int,
            "venenatis": int,
            "vetion": int,
            "vorkath": int,
            "wintertodt": int,
            "zalcano": int,
            "zulrah": int,
            "rifts_closed": int,
            "artio": int,
            "calvarion": int,
            "duke_sucellus": int,
            "spindel": int,
            "the_leviathan": int,
            "the_whisperer": int,
            "vardorvis": int,
        }

        for key, expected_type in expected_types.items():
            value = player.get(key)
            if value is not None:
                if isinstance(expected_type, list):
                    assert (
                        type(value) in expected_type
                    ), f"Key {key} has incorrect type. Expected: {expected_type}, Got: {type(value)}"
                else:
                    assert (
                        type(value) == expected_type
                    ), f"Key {key} has incorrect type. Expected: {expected_type}, Got: {type(value)}"
