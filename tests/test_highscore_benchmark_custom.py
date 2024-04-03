import asyncio

import httpx
import pytest
from benchmark import Benchmark

# Global variable to store the results
benchmark_results = {"v2": [], "v3": []}


@pytest.mark.asyncio
async def test_highscore_custom_benchmark_v2(custom_client):
    player_ids = list(range(1, 101))  # Or any other player IDs you want to use
    async with httpx.AsyncClient() as client:

        async def request(player_id):
            endpoint = f"http://localhost:5000/v2/highscore/latest"
            params = {"player_id": player_id}
            response = await client.get(url=endpoint, params=params)
            return response

        for player_id in player_ids:
            async with Benchmark(
                f"request({player_id})", iterations=10, suppress_logging=True
            ) as b:
                for _ in range(10):
                    await request(player_id)
            benchmark_results["v2"].append((b.name, b.duration))

    total_time = Benchmark.output_results()
    benchmark_results["v2"].append(("total", total_time))


@pytest.mark.asyncio
async def test_highscore_custom_benchmark_v3(custom_client):
    player_ids = list(range(1, 101))  # Or any other player IDs you want to use
    async with httpx.AsyncClient() as client:

        async def request(player_id):
            endpoint = f"http://localhost:5000/v3/highscore/latest"
            params = {"player_id": player_id}
            response = await client.get(url=endpoint, params=params)
            return response

        for player_id in player_ids:
            async with Benchmark(
                f"request({player_id})", iterations=10, suppress_logging=True
            ) as b:
                for _ in range(10):
                    await request(player_id)
            benchmark_results["v2"].append((b.name, b.duration))

    total_time = Benchmark.output_results()
    benchmark_results["v3"].append(("total", total_time))


def test_output_results():
    print("v2 results:")
    total_time_v2 = 0
    for name, duration in benchmark_results["v2"]:
        print(f"{name} took {duration:.3f} seconds")
        assert duration > 0
        if name == "total":
            total_time_v2 = duration

    print("v3 results:")
    total_time_v3 = 0
    for name, duration in benchmark_results["v3"]:
        print(f"{name} took {duration:.3f} seconds")
        assert duration > 0
        if name == "total":
            total_time_v3 = duration

    print(f"Total time for v2: {total_time_v2:.3f} seconds")
    print(f"Total time for v3: {total_time_v3:.3f} seconds")
