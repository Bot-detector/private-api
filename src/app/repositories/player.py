from src.core.database.models.player import Player as dbPlayer
from src.core.database.database import SessionFactory
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncResult
from sqlalchemy.sql.expression import Select
from fastapi.encoders import jsonable_encoder


class Player:
    def __init__(self) -> None:
        pass

    async def get_player(
        self,
        player_id: int,
        player_name: str,
        label_id: int,
        greater_than: bool,
        limit: int = 1_000,
    ):
        table = dbPlayer
        sql: Select = select(table)
        sql = sql.limit(limit)

        if player_name:
            sql = sql.where(dbPlayer.name >= player_name)

        if label_id:
            sql = sql.where(dbPlayer.label_id >= label_id)

        comparison = (
            (dbPlayer.id >= player_id) if greater_than else (dbPlayer.id == player_id)
        )
        sql = sql.where(comparison)
        sql = sql.order_by(dbPlayer.id.asc())

        async with SessionFactory() as session:
            session: AsyncSession

            result: AsyncResult = await session.execute(sql)
            result = result.scalars().all()
        return jsonable_encoder(result)
