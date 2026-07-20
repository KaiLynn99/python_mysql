-- COUNT(), SUM(), AVG(), MAX(), MIN()

SELECT COUNT(*) FROM film;
SELECT avg(length) FROM film; -- 평균
SELECT sum(length) FROM film; -- 합계
SELECT max(length) FROM film; -- 최대

-- subquery : SELECT안에 SELECT
-- 1)
SELECT round(avg(length)) FROM film;
SELECT  title, length, 115 전체평균 FROM film;

-- 2)
SELECT  
	title, 
    length, 
    (SELECT round(avg(length)) FROM film) 전체평균 
FROM film;

-- 단일값 X)
SELECT  
	title, 
    length, 
    (SELECT avg(length), sum(length) FROM film)  
FROM film;

-- 단일값 O)
SELECT  
	title, 
    length, 
    (SELECT avg(length) FROM film)  
FROM film; -- 스칼라 서브 쿼리(단일값)

SELECT t.title
FROM (SELECT * FROM film WHERE length > 120) t -- 인라인 뷰
WHERE t.title LIKE 'b%';

SELECT title
FROM film WHERE title LIKE 'b%' AND length > 120;

SELECT *
FROM film
WHERE length > (SELECT avg(length) FROM film);

-- SELECT절(스칼라 서브쿼리)
-- FROM절(인라인 뷰)
-- WHERE절(서브쿼리)

-- 1. 스칼라 서브쿼리
SELECT title,
       rental_rate,
       (SELECT AVG(rental_rate) FROM film) AS avg_rate
FROM film;

-- 2. 인라인 뷰
SELECT *
FROM (
    SELECT title, rental_rate
    FROM film
) AS f
WHERE rental_rate >= 4.99;

-- 3. 서브쿼리
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);

SELECT *
FROM film
WHERE rating in 
	(SELECT rating from film
	WHERE title = 'ADAPTATION HOLES' 
	or title = 'ACE GOLDFINGER'); -- G, NC17
    
SELECT *
FROM film
WHERE (rating, rental_rate) = 
	(SELECT rating, rental_rate from film
	WHERE title = 'ACE GOLDFINGER'); 
-- 2열 이상 -> 하나의 행은 스칼라 -> 열은 의미가 없다
-- 2행 이상 -> 여거개 값 -> 벡터 연산 -> in, not in