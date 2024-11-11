from typing import Annotated

import sqlalchemy as sqla
from fastapi import APIRouter, Depends, Query
from fastapi.encoders import jsonable_encoder
from pydantic.fields import Field
from sqlalchemy.ext.asyncio import AsyncResult, AsyncSession

from src.app.repositories.player import PlayerRepo
from src.core.fastapi.dependencies.session import get_session

router = APIRouter()


@router.get("/player")
async def get_player(
    player_id: str = None,
    player_name: str = None,
    label_id: int = None,
    greater_than: bool = False,
    limit: int = Query(default=1_000, ge=0, le=100_000),
    session=Depends(get_session),
):
    # TODO: make use of abstract base class
    repo = PlayerRepo(session=session)

    data = await repo.select(
        player_id=player_id,
        player_name=player_name,
        greater_than=greater_than,
        label_id=label_id,
        limit=limit,
    )
    return data


@router.get("/player/report/exp")
async def get_player_report_exp(
    name: list[Annotated[str, Field(..., min_length=1, max_length=13)]] = Query(
        ...,
        min_length=1,
        max_length=5,
        description="Name of the player",
        examples=["Player1", "Player2"],
    ),
    session: AsyncSession = Depends(get_session),
):
    # TODO: revert back to original data model for highscores
    sql = sqla.text("""

    """)

    async with session:
        result: AsyncResult = await session.execute(sql)
        result = result.scalars().all()
    return jsonable_encoder(result)
