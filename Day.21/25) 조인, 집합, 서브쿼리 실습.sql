-- 1. Action 영화 중 평균 길이보다 긴 영화, Comedy 영화중 rating이 'NC-17'인 영화 조회

SELECT title,
	category,
    length,
    rating
FROM film;




SELECT title,
       rental_rate,
       (SELECT AVG(rental_rate) FROM film) AS avg_rate
FROM film;



SELECT *
FROM (
    SELECT title, rental_rate
    FROM film
) AS f
WHERE rental_rate >= 4.99;