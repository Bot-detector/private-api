import logging

from fastapi import APIRouter, Depends, Query

from src.app.repositories import PlayerActivityRepo, PlayerSkillsRepo, ScraperDataRepo
from src.app.views.response import ActivityView, ScraperDataView, SkillView
from src.core.fastapi.dependencies.session import get_session

logger = logging.getLogger(__name__)

router = APIRouter()


@router.get("/highscore/latest", response_model=list[ScraperDataView])
async def get_highscore_latest(
    player_id: int,
    player_name: str = None,
    label_id: int = None,
    many: bool = False,
    limit: int = Query(default=10, ge=0, le=10_000),
    session=Depends(get_session),
):
    repo = ScraperDataRepo(session=session)
    repo_skills = PlayerSkillsRepo(session=session)
    repo_activities = PlayerActivityRepo(session=session)

    data = await repo.select(
        player_name=player_name,
        player_id=player_id,
        label_id=label_id,
        many=many,
        limit=limit,
        history=False,
    )

    results = []
    for d in data:
        skills = await repo_skills.select(scraper_id=d.get("scraper_id"))
        skills = [SkillView(**s) for s in skills]

        activities = await repo_activities.select(scraper_id=d.get("scraper_id"))
        activities = [ActivityView(**a) for a in activities]

        results.append(
            ScraperDataView(
                created_at=d.get("created_at"),
                record_date=d.get("record_date"),
                scraper_id=d.get("scraper_id"),
                player_id=d.get("player_id"),
                skills=skills,
                activities=activities,
            )
        )
    return results
