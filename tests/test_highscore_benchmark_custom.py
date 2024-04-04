import random

import pytest
from benchmark import Benchmark
from httpx import AsyncClient

# Global variable to store the results
benchmark_results = {"v2": [], "v3": []}
player_ids = [random.randint(1, 250) for i in range(10)]


@pytest.mark.asyncio
async def test_highscore_custom_benchmark_v2(custom_client):
    # Clear the results from the previous tests
    Benchmark.results.clear()
    endpoint = "/v2/highscore/latest"
    async with custom_client as client:
        client: AsyncClient

        async def request(player_id):
            params = {"player_id": player_id, "many": 1, "limit": 5000}
            response = await client.get(url=endpoint, params=params)
            return response

        for player_id in player_ids:
            async with Benchmark(
                f"request({player_id})", iterations=1, suppress_logging=True
            ) as b:
                for _ in range(1):
                    await request(player_id)
            benchmark_results["v2"].append((b.name, b.duration))

    total_time = Benchmark.output_results()
    benchmark_results["v2"].append(("total", total_time))


@pytest.mark.asyncio
async def test_highscore_custom_benchmark_v3(custom_client):
    # Clear the results from the previous tests
    Benchmark.results.clear()
    endpoint = "/v3/highscore/latest"
    async with custom_client as client:
        client: AsyncClient

        async def request(player_id):
            params = {"player_id": player_id, "many": 1, "limit": 5000}
            response = await client.get(url=endpoint, params=params)
            return response

        for player_id in player_ids:
            async with Benchmark(
                f"request({player_id})", iterations=1, suppress_logging=True
            ) as b:
                for _ in range(1):
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
