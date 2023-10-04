from fastapi import APIRouter, Query
from src.app.models.player import Player

router = APIRouter()


@router.get("/player")
async def get_player(
    player_id: str = None,
    player_name: str = None,
    greater_than: bool = None,
    limit: int = Query(default=1_000, ge=0, le=100_000),
):
    player_model = Player()
    data = await player_model.get_player(
        player_id=player_id,
        player_name=player_name,
        greater_than=greater_than,
        limit=limit,
    )
    return data
