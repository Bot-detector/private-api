import asyncio

import httpx
import pytest
from benchmark import Benchmark


@pytest.mark.asyncio
async def test_highscore_v2(benchmark, custom_client):
    player_ids = list(range(1, 101))  # Or any other player IDs you want to use
    async with httpx.AsyncClient() as client:

        async def request(player_id):
            endpoint = f"http://localhost:5000/v2/highscore/latest"
            params = {"player_id": player_id}
            response = await client.get(url=endpoint, params=params)
            return response

        async def run_requests():
            tasks = [
                asyncio.create_task(request(player_id)) for player_id in player_ids
            ]
            return await asyncio.gather(*tasks)

        responses = await benchmark(run_requests)

        for response in responses:
            assert response.status_code == 200
            assert isinstance(response.json(), list)

        json_response: list[dict] = response.json()
        if len(json_response) >= 1:
            assert isinstance(
                json_response[0], dict
            ), f"expected dict, got {type(json_response[0])}, {json_response=}"

            player = json_response[0]
            assert (
                player.get("Player_id") == player_id
            ), f"expected Player_id: {player_id} got: {player=}"


@pytest.mark.asyncio
async def test_highscore_v3(benchmark, custom_client):
    player_ids = list(range(1, 101))  # Or any other player IDs you want to use
    async with httpx.AsyncClient() as client:

        async def request(player_id):
            endpoint = f"http://localhost:5000/v3/highscore/latest"
            params = {"player_id": player_id}
            response = await client.get(url=endpoint, params=params)
            return response

        async def run_requests():
            tasks = [
                asyncio.create_task(request(player_id)) for player_id in player_ids
            ]
            return await asyncio.gather(*tasks)

        responses = await benchmark(run_requests)

        for response in responses:
            assert response.status_code == 200
            assert isinstance(response.json(), list)

        json_response: list[dict] = response.json()
        if len(json_response) >= 1:
            assert isinstance(
                json_response[0], dict
            ), f"expected dict, got {type(json_response[0])}, {json_response=}"

            player = json_response[0]
            assert (
                player.get("player_id") == player_id
            ), f"expected Player_id: {player_id} got: {player=}"
