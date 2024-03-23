from fastapi.encoders import jsonable_encoder
from sqlalchemy.ext.asyncio import AsyncResult, AsyncSession
from sqlalchemy.orm import aliased
from sqlalchemy.sql.expression import Select

from src.app.repositories.abstract_repo import AbstractAPI
from src.core.database.models import Player, ScraperData, ScraperDataLatest


class ScraperDataRepo(AbstractAPI):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__()
        self.session = session

    async def insert(self, id):
        raise NotImplementedError

    async def select(
        self,
        player_name: str,
        player_id: int,
        label_id: int,
        many: bool,
        limit: int,
        history: bool = False,
    ) -> list[dict]:
        table = (
            aliased(ScraperData, name="sd")
            if history
            else aliased(ScraperDataLatest, name="sdl")
        )
        player = aliased(Player, name="pl")

        sql = Select(table)
        sql = sql.join(player, table.player_id == player.id)

        if player_id:
            if many:
                sql = sql.where(table.player_id >= player_id)
            else:
                sql = sql.where(table.player_id == player_id)

        if player_name:
            sql = sql.where(player.name == player_name)

        if label_id:
            sql = sql.where(player.label_id == label_id)

        sql = sql.limit(limit)

        async with self.session:
            result: AsyncResult = await self.session.execute(sql)
            result = result.scalars().all()
        return jsonable_encoder(result)

    async def select_history(self, player_name: str, player_id: int, many: bool):
        table = ScraperData
        sql = Select(table)

        if player_id:
            if many:
                sql = sql.where(table.player_id >= player_id)
            else:
                sql = sql.where(table.player_id == player_id)

        if player_name:
            sql = sql.join(Player, table.player_id == Player.id)
            sql = sql.where(Player.name == player_name)

        async with self.session:
            result: AsyncResult = await self.session.execute(sql)
            result = result.scalars().all()
        return jsonable_encoder(result)

    async def update(self):
        raise NotImplementedError

    async def delete(self):
        raise NotImplementedError
