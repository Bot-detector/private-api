from fastapi import APIRouter, Depends, Query

from src.app.repositories.scraper_data import ScraperDataRepo
from src.core.fastapi.dependencies.session import get_session

router = APIRouter()


@router.get("/highscore/latest")
async def get_highscore_latest(
    player_id: int,
    player_name: str = None,
    label_id: int = None,
    many: bool = False,
    limit: int = Query(default=10, ge=0, le=10_000),
    session=Depends(get_session),
):
    repo = ScraperDataRepo(session=session)
    data = await repo.select(
        player_name=player_name,
        player_id=player_id,
        label_id=label_id,
        many=many,
        limit=limit,
    )
    return data
