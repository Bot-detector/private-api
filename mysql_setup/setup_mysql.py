# script to insert all the data we need
import random
from datetime import datetime, timedelta

from sqlalchemy import (
    Boolean,
    Column,
    DateTime,
    ForeignKey,
    Integer,
    String,
    create_engine,
)
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

Base = declarative_base()


class Players(Base):
    __tablename__ = "Players"

    id = Column(Integer, primary_key=True)
    name = Column(String)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow)
    possible_ban = Column(Boolean, default=True)
    confirmed_ban = Column(Boolean, default=False)
    confirmed_player = Column(Boolean, default=False)
    label_id = Column(Integer)
    label_jagex = Column(Integer)
    ironman = Column(Boolean)
    hardcore_ironman = Column(Boolean)
    ultimate_ironman = Column(Boolean)
    normalized_name = Column(String)


class Reports(Base):
    __tablename__ = "Reports"

    id = Column(Integer, primary_key=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    reportedID = Column(Integer, ForeignKey("Players.id"))
    reportingID = Column(Integer, ForeignKey("Players.id"))
    # Add other columns here


class Predictions(Base):
    __tablename__ = "Predictions"

    id = Column(Integer, primary_key=True)
    name = Column(String)
    created = Column(DateTime, default=datetime.utcnow)
    predicted_confidence = Column(Integer)
    prediction = Column(String)
    # Add other columns here


# Define other SQLAlchemy models for remaining tables in a similar manner

# Create an engine and bind the base
engine = create_engine("mysql+pymysql://root:root_bot_buster@mysql:3306/playerdata")
Base.metadata.create_all(engine)

# Create a session
Session = sessionmaker(bind=engine)
session = Session()


# Define function to generate random date within a year
def random_date():
    return datetime.utcnow() - timedelta(days=random.randint(0, 365))


# Insert data into Players table
for i in range(250):
    player = Players(
        name=f"Player_x_{i}",
        created_at=random_date(),
        updated_at=random_date(),
        possible_ban=random.choice([True, False]),
        confirmed_ban=random.choice([True, False]),
        confirmed_player=random.choice([True, False]),
        label_id=random.randint(0, 2),
        label_jagex=random.randint(0, 2),
        normalized_name=f"Player_x_{i}",
    )
    session.add(player)

# Insert data into other tables similarly

# Commit the session to persist the data
session.commit()
