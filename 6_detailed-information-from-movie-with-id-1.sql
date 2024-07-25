SELECT m.id_movie, m.title, m.release_date, m.duration, m.description,
JSON_OBJECT('id_file', f.id_file, 'file_name', f.file_name, 'mime_type', f.mime_type, 'key_file', f.key_file, 'file_url', f.file_url, 'created_at', f.created_at, 'updated_at', f.updated_at) AS poster,
JSON_OBJECT('id_director', p.id_person, 'firtname', p.firstname, 'lastname', p.lastname, 'photo', JSON_OBJECT('id_file', fd.id_file, 'file_name', fd.file_name, 'mime_type', fd.mime_type, 'key_file', fd.key_file, 'file_url', fd.file_url, 'created_at', fd.created_at, 'updated_at', fd.updated_at)) AS director,
JSON_MERGE_PRESERVE(
	(SELECT IF(COUNT(p.id_person) = 0, JSON_ARRAY(), JSON_ARRAYAGG(JSON_OBJECT('id_person', p.id_person, 'firstname', p.firstname, 'lastname', p.lastname, 'photo',
	JSON_OBJECT('id_file', f.id_file, 'file_name', f.file_name, 'mime_type', f.mime_type, 'key_file', f.key_file, 'file_url', f.file_url, 'created_at', f.created_at, 'updated_at', f.updated_at))))
	FROM person p
	INNER JOIN movie_actor ma ON ma.id_person = p.id_person AND ma.id_movie = 1
	LEFT JOIN file f ON p.id_primary_photo = f.id_file),
	(SELECT IF(COUNT(p.id_person) = 0, JSON_ARRAY(), JSON_ARRAYAGG(JSON_OBJECT('id_person', p.id_person, 'firstname', p.firstname, 'lastname', p.lastname, 'photo',
	JSON_OBJECT('id_file', f.id_file, 'file_name', f.file_name, 'mime_type', f.mime_type, 'key_file', f.key_file, 'file_url', f.file_url, 'created_at', f.created_at, 'updated_at', f.updated_at))))
	FROM person p
	LEFT JOIN file f ON p.id_primary_photo = f.id_file
	INNER JOIN personage pg ON p.id_person = pg.id_person
	INNER JOIN movie_personage mp ON pg.id_personage = mp.id_personage AND mp.id_movie = 1)) AS actors,
JSON_ARRAYAGG(JSON_OBJECT('id_genre', g.id_genre, 'name', g.name)) AS genres
FROM movie m
LEFT JOIN file f ON m.id_poster = f.id_file
INNER JOIN person p ON m.id_director = p.id_person
LEFT JOIN file fd ON p.id_primary_photo = fd.id_file
LEFT JOIN movie_genre mg ON m.id_movie = mg.id_movie
LEFT JOIN genre g ON mg.id_genre = g.id_genre
WHERE m.id_movie = 1;