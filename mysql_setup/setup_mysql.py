# script to insert all the data we need
import random
from datetime import datetime, timedelta

from sqlalchemy import (
    Boolean,
    Column,
    Date,
    DateTime,
    ForeignKey,
    Integer,
    String,
    create_engine,
    func,
)
from sqlalchemy.dialects.mysql import BIGINT, SMALLINT, TINYINT
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

Base = declarative_base()
random.seed(42)


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
    # ironman = Column(Boolean)
    # hardcore_ironman = Column(Boolean)
    # ultimate_ironman = Column(Boolean)
    normalized_name = Column(String)


class ScraperData(Base):
    __tablename__ = "scraper_data"

    scraper_id = Column(BIGINT, primary_key=True, autoincrement=True)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    player_id = Column(SMALLINT, nullable=False)
    record_date = Column(Date, nullable=True, server_default=func.current_date())


class ScraperDataLatest(Base):
    __tablename__ = "scraper_data_latest"

    scraper_id = Column(BIGINT)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    player_id = Column(BIGINT, primary_key=True)
    record_date = Column(Date, nullable=True, server_default=func.current_date())


class Skills(Base):
    __tablename__ = "skills"

    skill_id = Column(TINYINT, primary_key=True, autoincrement=True)
    skill_name = Column(String(50), nullable=False)


class PlayerSkills(Base):
    __tablename__ = "player_skills"

    scraper_id = Column(
        BIGINT,
        ForeignKey("scraper_data.scraper_id", ondelete="CASCADE"),
        primary_key=True,
    )
    skill_id = Column(
        TINYINT,
        ForeignKey("skills.skill_id", ondelete="CASCADE"),
        primary_key=True,
    )
    skill_value = Column(Integer, nullable=False, default=0)


class Activities(Base):
    __tablename__ = "activities"

    activity_id = Column(TINYINT, primary_key=True, autoincrement=True)
    activity_name = Column(String(50), nullable=False)


class PlayerActivities(Base):
    __tablename__ = "player_activities"

    scraper_id = Column(
        BIGINT,
        ForeignKey("scraper_data.scraper_id", ondelete="CASCADE"),
        primary_key=True,
    )
    activity_id = Column(
        TINYINT,
        ForeignKey("activities.activity_id", ondelete="CASCADE"),
        primary_key=True,
    )
    activity_value = Column(Integer, nullable=False, default=0)


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


class Labels(Base):
    __tablename__ = "labels"

    id = Column(Integer, primary_key=True)
    label = Column(String)


# Insert 'request_highscores' and 'verify_ban' into the labels table
labels_to_insert = ["request_highscores", "verify_ban"]
for label_name in labels_to_insert:
    # Check if the label already exists
    existing_label = session.query(Labels).filter_by(label=label_name).first()
    if not existing_label:
        label = Labels(label=label_name)
        session.add(label)
session.commit()

# Query the labels table to get all id values
label_ids = session.query(Labels.id).all()
label_ids = [id[0] for id in label_ids]  # Convert list of tuples to list of ids

# Insert data into Players table
len_players = 250
for i in range(250):
    print(f"Player_{i}")
    # Check if the player already exists
    existing_player = session.query(Players).filter_by(name=f"Player_{i}").first()
    if not existing_player:
        player = Players(
            name=f"Player_{i}",
            created_at=random_date(),
            updated_at=random_date(),
            possible_ban=random.choice([True, False]),
            confirmed_ban=random.choice([True, False]),
            confirmed_player=random.choice([True, False]),
            label_id=random.choice(label_ids),  # Select a random id from label_ids
            label_jagex=random.randint(0, 2),
            normalized_name=f"Player_{i}",
        )
        session.add(player)
session.commit()

# Insert data into Activities table before PlayerActivities
activity_names = [f"Activity_{i}" for i in range(1, 71)]
for activity_name in activity_names:
    # Check if the activity already exists
    existing_activity = (
        session.query(Activities).filter_by(activity_name=activity_name).first()
    )
    if not existing_activity:
        activity = Activities(activity_name=activity_name)
        session.add(activity)
session.commit()

skill_list = list(range(2, 24))
activity_list = list(range(1, 71))

len_scraper_data = len_players * 3

# Insert data into Skills table before PlayerSkills
skill_names = [f"Skill_{i}" for i in range(1, 24)]
for skill_name in skill_names:
    # Check if the skill already exists
    existing_skill = session.query(Skills).filter_by(skill_name=skill_name).first()
    if not existing_skill:
        skill = Skills(skill_name=skill_name)
        session.add(skill)
session.commit()

# Query the skills table to get all id values
skill_ids = session.query(Skills.skill_id).all()
skill_ids = [id[0] for id in skill_ids]  # Convert list of tuples to list of ids

for i in range(1, len_scraper_data + 1):
    print(f"scraper_data_{i}")
    # pick random player
    player_id = random.randint(1, len_players)

    # pick random amount of skills
    amount_skills = random.randint(0, len(skill_ids))
    random.shuffle(skill_ids)
    skills = skill_ids[:amount_skills]

    # pick random amount of activities
    amount_activities = random.randint(0, len(activity_list))
    random.shuffle(activity_list)
    activities = activity_list[:amount_activities]

    # scraper data
    try:
        session.add(
            ScraperData(scraper_id=i, player_id=player_id, created_at=random_date())
        )
        session.commit()
        for skill in skills:
            session.add(
                PlayerSkills(
                    scraper_id=i,
                    skill_id=skill,
                    skill_value=random.randint(1, 200_000_000),
                )
            )
        for activity in activities:
            session.add(
                PlayerActivities(
                    scraper_id=i,
                    activity_id=activity,
                    activity_value=random.randint(1, 65_000),
                )
            )
    except IntegrityError:
        session.rollback()  # Rollback the transaction if a duplicate entry is encountered
    finally:
        session.commit()
