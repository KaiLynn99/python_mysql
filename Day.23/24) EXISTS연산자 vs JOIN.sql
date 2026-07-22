-- 1. = (같다)
SELECT title, rental_rate
FROM film
WHERE rental_rate =
(
    SELECT AVG(rental_rate)
    FROM film
);

-- 2. >, <, >=, <=
SELECT title, rental_rate
FROM film
WHERE rental_rate >
(
    SELECT AVG(rental_rate)
    FROM film
);

-- 3. IN
SELECT film_id, category_id
FROM film_category
WHERE category_id IN
( -- 서브쿼리의 결과셋이 2행 이상
    SELECT category_id
    FROM category
    WHERE name IN ('Action', 'Comedy')
);

-- 4. NOT IN
SELECT film_id, category_id
FROM film_category
WHERE category_id NOT IN
( 
    SELECT category_id
    FROM category
    WHERE name IN ('Action', 'Comedy')
);

-- 5. EXISTS
SELECT *
FROM category c -- 메인쿼리
WHERE EXISTS
(
    SELECT *
    FROM film_category fc -- 서브쿼리
    WHERE fc.category_id = c.category_id -- 메인 서브 조인조건
);

SELECT *
FROM category c INNER JOIN film_category fc
	ON fc.category_id = c.category_id;
    
-- 6. NOT EXISTS
SELECT name
FROM category c
WHERE NOT EXISTS
(
    SELECT *
    FROM film_category fc
    WHERE fc.category_id = c.category_id
);

-- NOT EXISTS를 쓰지 않으면 쿼리가 길어진다
SELECT c.*
FROM category c LEFT JOIN film_category fc
	ON fc.category_id = c.category_id
EXCEPT
SELECT c.*
FROM category c INNER JOIN film_category fc
	ON fc.category_id = c.category_id;