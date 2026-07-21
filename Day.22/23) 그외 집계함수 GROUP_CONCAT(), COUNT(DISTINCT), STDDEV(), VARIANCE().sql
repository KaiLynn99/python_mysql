-- 실행 순서
SELECT actor_id, first_name -- 3
FROM actor -- 1 
WHERE actor_id % 2 = 0 -- 2
ORDER BY actor_id DESC  -- 4
LIMIT 10; -- 5

-- 1. GROUP BY(계산셋)
SELECT * 
FROM person -- 1 결과셋
WHERE id > 2 -- 2 결과셋
GROUP BY gender; -- 3 F,M 2개의 계산셋
-- GROUP BY에서 생성된 클론은 SELECT에서 사용가능(함수)

SELECT gender, count(*) - 공통된 gender값, 갯수
FROM person  
GROUP BY gender; 

SELECT id, name -- 조회X 
FROM person -- 1 결과셋
WHERE gender = 'M'; -- 2 

select rating, count(*), sum(length), avg(length), max(length), min(length)
from film -- 결과셋 1개
group by rating; -- 계산셋 5개

select *
from
	(select rating, 
		count(*) c, 
		sum(length) s,
		avg(length) a,
		max(length) max, 
		min(length) min
	from film 
	group by rating) t
where t.s > 25000;

select *
from
	(select rating, 
		count(*) c, 
		sum(length) s,
		avg(length) a,
		max(length) max, 
		min(length) min
	from film 
	group by rating) t
where t.s > 25000;


/*
select 집계함수 5
from -- 1
where -- 2
group by -- 3
having -- 4
*/

SELECT rating,
       COUNT(*) AS 영화수
FROM film
GROUP BY rating;

SELECT rating,
       AVG(rental_rate) AS 평균대여료
FROM film
GROUP BY rating;

SELECT rating,
       SUM(length) AS 총상영시간
FROM film
GROUP BY rating;

SELECT rating,
       MAX(length) AS 최대길이
FROM film
GROUP BY rating;

SELECT rating,
       MIN(length) AS 최소길이
FROM film
GROUP BY rating;

SELECT rating,
       COUNT(*) AS 영화수,
       AVG(length) AS 평균길이,
       MAX(length) AS 최대길이,
       MIN(length) AS 최소길이
FROM film
GROUP BY rating;

SELECT COUNT(*), avg(length) "전체 러닝타임 평균"
FROM film; -- 전체를 하나의 계산셋으로 생성 후 집계하겠다. GROUP BY NULL 생략된 형태

-- Children 최대 러닝타임의 영화보다 러닝타임이 긴 영화들 조회 (연습 문제)
-- CTE (common Table Expression)
WITH f3join as
(SELECT c.name name, f.title title, f.length length
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON fc.film_id = f.film_id)

SELECT title, length,
	(select max(length) from f3join WHERE name= 'Children') "Children Max"
FROM film
WHERE length > (select max(length)
			   from f3join
               WHERE name= 'Children')
ORDER BY length DESC;

-- 3. GROUP BY 여러 컬럼
SELECT c.name,
       f.rating,
       COUNT(*)
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON fc.film_id = f.film_id
GROUP BY c.name, f.rating; -- 17*5행

-- R, G 영화만 그룹화
SELECT
    rating,
    COUNT(*)
FROM film -- 결과셋1
WHERE rating IN ('R', 'G') -- 결과셋1
GROUP BY rating -- 계산셋 R/G 2개 생성
ORDER BY c DESC -- 계산셋 집계된 결과셋에 대한 정렬
LIMIT 1; -- ORDER BY 결과셋

-- 4. HAVING
SELECT rating,
       COUNT(*) AS cnt
FROM film
GROUP BY rating
HAVING COUNT(*) >= 200;

