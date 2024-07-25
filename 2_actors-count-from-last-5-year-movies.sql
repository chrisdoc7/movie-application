SELECT m.id_movie, m.title, COUNT(pg.id_person) + COUNT(ma.id_person) as actors_count
FROM movie m
LEFT JOIN movie_personage mp ON m.id_movie = mp.id_movie
LEFT JOIN personage pg ON mp.id_personage = pg.id_personage
LEFT JOIN movie_actor ma ON m.id_movie = ma.id_movie
WHERE YEAR(m.release_date) >= YEAR(curdate()) - 5
GROUP BY m.id_movie;