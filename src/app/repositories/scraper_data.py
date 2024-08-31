async def select_scraper_data_v3(session, player_name: str):
    sql = """
        SELECT
            sdv.scrape_id ,
            sdv.scrape_ts ,
            sdv.scrape_date,
            sdv.player_id ,
            p.name,
            s.skill_id ,
            s.skill_name ,
            ps.skill_value
        FROM  scraper_data_v3 sdv
        JOIN Players p on sdv.player_id =p.id
        LEFT JOIN scraper_player_skill sps on sdv.scrape_id = sps.scrape_id
        LEFT JOIN player_skill ps on sps.player_skill_id =ps.player_skill_id
        LEFT JOIN skill s on ps.skill_id =s.skill_id
        WHERE 1
            AND p.name = :player_name
            AND sdv.scrape_date = (
                SELECT
                    MAX(scrape_date)
                FROM scraper_data_v3
                WHERE player_id=p.id
                )
        ;
    """
