import logging
from time import perf_counter


class Benchmark:
    results = []

    def __init__(self, name, iterations=1, suppress_logging=False):
        self.name = name
        self.iterations = iterations
        self.suppress_logging = suppress_logging
        if suppress_logging:
            self.original_level = self.set_logging_level("httpcore", logging.INFO)

    async def __aenter__(self):
        self.time_start = perf_counter()
        return self

    async def __aexit__(self, exc_type, exc, tb):
        self.time_end = perf_counter()
        self.duration = (self.time_end - self.time_start) / self.iterations
        self.results.append((self.name, self.duration))
        if self.suppress_logging:
            self.set_logging_level("httpcore", self.original_level)
        return False

    @classmethod
    def output_results(cls):
        total_time = 0
        for name, duration in cls.results:
            print(f"{name} took {duration:.3f} seconds")
            total_time += duration
        print(f"Total time: {total_time:.3f} seconds")
        return total_time

    @staticmethod
    def set_logging_level(logger_name, level):
        logger = logging.getLogger(logger_name)
        original_level = logger.level
        logger.setLevel(level)
        return original_level
