from abc import ABC, abstractmethod

class AbstractAPI(ABC):
    @abstractmethod
    def get(self, id):
        raise NotImplementedError

    @abstractmethod
    def get_many(self, start, limit):
        raise NotImplementedError

    @abstractmethod
    def update(self, id, data):
        raise NotImplementedError

    @abstractmethod
    def delete(self, id):
        raise NotImplementedError
