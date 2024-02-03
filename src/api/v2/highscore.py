from fastapi import APIRouter, Query
from src.app.repositories.highscore import HighscoreLatest

router = APIRouter()


@router.get("/highscore/latest")
async def get_highscore_latest(
    player_id: int,
    label_id: int = None,
    many: bool = False,
    limit: int = Query(default=10, ge=0, le=10_000),
):
    repo = HighscoreLatest()
    if many:
        data = await repo.get_many(start=player_id, limit=limit, label_id=label_id)
    else:
        data = await repo.get(id=player_id)
    return data


# @router.get("/highscore")
# async def get_highscore(
#     player_id: str = None,
#     greater_than: bool = None,
#     limit: int = Query(default=1_000, ge=0, le=10_000),
# ):
#     return {}


# @router.get("/highscore/xp")
# async def get_highscore_xp(
#     player_id: str = None,
#     greater_than: bool = None,
#     limit: int = Query(default=1_000, ge=0, le=10_000),
# ):
#     return {}
