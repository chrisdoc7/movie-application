SELECT m.id_movie, m.title, m.release_date, m.duration, m.description,
JSON_OBJECT('id_file', f.id_file, 'file_name', f.file_name, 'mime_type', f.mime_type, 'key_file', f.key_file, 'file_url', f.file_url, 'created_at', f.created_at, 'updated_at', f.updated_at) AS poster,
JSON_OBJECT('id_director', p.id_person, 'firtname', p.firstname, 'lastname', p.lastname) AS director
FROM movie m
LEFT JOIN file f ON m.id_poster = f.id_file
INNER JOIN person p ON m.id_director = p.id_person
INNER JOIN movie_genre mg ON m.id_movie = mg.id_movie
INNER JOIN genre g ON mg.id_genre = g.id_genre
WHERE m.id_country = 1 AND m.release_date >= '2022-01-01' AND m.duration > '02:15:00' AND (g.name = 'Action' OR g.name = 'Drama');