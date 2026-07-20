SELECT * FROM film;

SELECT * FROM film_category;

SELECT * 
FROM film_category INNER JOIN category ;
-- 각 영화의 카테고리 모름

INSERT INTO category(name)
VALUES('KContents'); -- 한류 장르 추가

SELECT * FROM category; -- 추가된 장르 확인

SELECT c.name, f.title
FROM category c LEFT JOIN film_category fc
	on c.category_id = fc.category_id
LEFT JOIN film f
	on fc.film_id = f.film_id
WHERE f.title is NULL;