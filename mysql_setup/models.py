# script to insert all the data we need
import random
from datetime import datetime, timedelta

from sqlalchemy import (
    TIMESTAMP,
    BigInteger,
    Boolean,
    Column,
    Date,
    DateTime,
    ForeignKey,
    Integer,
    SmallInteger,
    String,
    create_engine,
    func,
)
from sqlalchemy.dialects.mysql import BIGINT, SMALLINT, TINYINT
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

Base = declarative_base()
random.seed(42)

# Define other SQLAlchemy models for remaining tables in a similar manner

# Create an engine and bind the base
engine = create_engine("mysql+pymysql://root:root_bot_buster@mysql:3306/playerdata")
Base.metadata.create_all(engine)

# Create a session
Session = sessionmaker(bind=engine)
session = Session()


class Labels(Base):
    __tablename__ = "Labels"

    id = Column(Integer, primary_key=True)
    label = Column(String)


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


class Report(Base):
    __tablename__ = "Reports"

    ID = Column(BigInteger, primary_key=True, autoincrement=True)
    created_at = Column(TIMESTAMP)
    reportedID = Column(Integer)
    reportingID = Column(Integer)
    region_id = Column(Integer)
    x_coord = Column(Integer)
    y_coord = Column(Integer)
    z_coord = Column(Integer)
    timestamp = Column(TIMESTAMP)
    manual_detect = Column(SmallInteger)
    on_members_world = Column(Integer)
    on_pvp_world = Column(SmallInteger)
    world_number = Column(Integer)
    equip_head_id = Column(Integer)
    equip_amulet_id = Column(Integer)
    equip_torso_id = Column(Integer)
    equip_legs_id = Column(Integer)
    equip_boots_id = Column(Integer)
    equip_cape_id = Column(Integer)
    equip_hands_id = Column(Integer)
    equip_weapon_id = Column(Integer)
    equip_shield_id = Column(Integer)
    equip_ge_value = Column(BigInteger)
