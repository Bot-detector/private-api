import logging

from fastapi import APIRouter, Depends, Query

from src.app.repositories import PlayerActivityRepo, PlayerSkillsRepo, ScraperDataRepo
from src.core.fastapi.dependencies.session import get_session

logger = logging.getLogger(__name__)

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
    repo_skills = PlayerSkillsRepo(session=session)
    repo_activities = PlayerActivityRepo(session=session)

    data = await repo.select(
        player_name=player_name,
        player_id=player_id,
        label_id=label_id,
        many=many,
        limit=limit,
    )

    for d in data:
        skills = await repo_skills.select(scraper_id=d.get("scraper_id"))

        d["skills"] = {
            skill.get("skill_name"): skill.get("skill_value") for skill in skills
        }
        activities = await repo_activities.select(scraper_id=d.get("scraper_id"))
        d["activity"] = {
            activity.get("activity_name"): activity.get("activity_value")
            for activity in activities
        }
    return data
