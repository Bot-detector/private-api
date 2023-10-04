from fastapi import APIRouter
from . import player

router = APIRouter()
router.include_router(player.router)