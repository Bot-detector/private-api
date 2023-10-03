from fastapi import APIRouter, Query
from src.app.models.player import Player

router = APIRouter()


@router.get("/player")
async def get_player(
    player_id: str,
    player_name: str,
    greater: bool = None,
    limit: int = Query(default=1_000, ge=0, le=100_000),
):
    player_model = Player()
    data = await player_model.get_player(pl)
    return
