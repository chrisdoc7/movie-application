SELECT p.id_person, CONCAT(p.firstname, ' ', p.lastname) as director_name, AVG(m.budget) as average_budget
FROM person p
INNER JOIN movie m ON p.id_person = m.id_director
GROUP BY p.id_person;