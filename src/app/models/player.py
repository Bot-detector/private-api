from src.core.database.models.player import Player as dbPlayer
from src.core.database.database import SessionFactory
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import delete, insert, select, update
from sqlalchemy.ext.asyncio import AsyncResult, AsyncSession
from sqlalchemy.sql.expression import Delete, Insert, Select, Update, and_
from fastapi.encoders import jsonable_encoder


class Player:
    def __init__(self) -> None:
        pass

    async def get_player(
        self, player_id: int, player_name: str, greater_than: bool, limit: int = 1_000
    ):
        table = dbPlayer
        sql_select: Select = select(table)
        sql_select = sql_select.limit(limit)

        if player_name:
            sql_select = sql_select.where(dbPlayer.name >= player_name)

        if greater_than:
            sql_select = sql_select.where(dbPlayer.id >= player_id)
        elif player_id:
            sql_select = sql_select.where(dbPlayer.id == player_id)

        async with SessionFactory() as session:
            session: AsyncSession

            result: AsyncResult = await session.execute(sql_select)
            result = result.scalars().all()
        return jsonable_encoder(result)
