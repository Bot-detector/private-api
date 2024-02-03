from src.core.database.models.highscore import (
    # playerHiscoreData,
    PlayerHiscoreDataLatest,
    # PlayerHiscoreDataXPChange,
)
from src.core.database.models.player import Player
from src.core.database.database import SessionFactory
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncResult
from sqlalchemy.sql.expression import Select
from fastapi.encoders import jsonable_encoder
from src.app.repositories.abstract_repo import AbstractAPI


class HighscoreLatest(AbstractAPI):
    def __init__(self) -> None:
        super().__init__()
        self.table = PlayerHiscoreDataLatest

    async def _simple_execute(self, sql) -> dict:
        async with SessionFactory() as session:
            session: AsyncSession

            result: AsyncResult = await session.execute(sql)
            result = result.scalars().all()
        return jsonable_encoder(result)

    async def get(self, id: int):
        sql: Select = select(self.table, Player.name)
        sql = sql.join(target=Player, onclause=self.table.Player_id == Player.id)
        sql = sql.where(self.table.Player_id == id)
        return await self._simple_execute(sql)

    async def get_many(self, start: int, limit: int = 5000):
        sql: Select = select(self.table, Player.name)
        sql = sql.join(target=Player, onclause=self.table.Player_id == Player.id)
        sql = sql.where(self.table.Player_id > start)
        sql = sql.limit(limit)
        return await self._simple_execute(sql)

    async def delete(self, id):
        pass

    async def update(self, id, data):
        pass
