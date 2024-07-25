SELECT u.id_user, u.username, GROUP_CONCAT(f.id_movie SEPARATOR ',') AS favorite_movies
FROM user u
LEFT JOIN favorite_movies f ON u.id_user = f.id_user
GROUP BY u.id_user;