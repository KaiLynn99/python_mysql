-- 집계 함수(GROUP BY): 여러 행을 하나의 결과로 묶는다. 
-- 윈도우 함수: 여러 행을 참고해서 계산하지만, 원래의 행은 그대로 유지한다.

-- 1)
SELECT rating,
       AVG(length) AS avg_length
FROM film
GROUP BY rating;

-- 2)
SELECT title, length, rating
FROM film;

-- 1+2) rating 값으로 JOIN --> 코드가 복잡함
SELECT f.title, f.rating, f.length, t.avg_length
FROM film f INNER JOIN (SELECT rating,
					AVG(length) AS avg_length
					FROM film
					GROUP BY rating) t
ON f.rating = t.rating
ORDER BY f.rating;

-- 윈도우 함수 -> 코드가 단순해짐
SELECT title,
       rating,
       length,
       AVG(length) OVER(PARTITION BY rating) AS avg_length
FROM film;

-- 3. 윈도우 함수 종류

-- 1) ROW_NUMBER(), RANK(), DENSE_RANK()
SELECT
    title, length,
    ROW_NUMBER() OVER(ORDER BY length DESC) "row_number",
    RANK() OVER(ORDER BY length DESC) "rank",
    DENSE_RANK() OVER(ORDER BY length DESC) "dense_rank"
FROM film;

-- 4) NTILE() 그룹 나누기
SELECT
    title,
    length,
    NTILE(4) OVER(ORDER BY length)
FROM film;

-- 5) LAG() 이전 행
SELECT
    title,
    length,
    LAG(title) OVER(ORDER BY length)
FROM film;

-- 6) LEAD() 다음 행
SELECT
	film_id,
    title,
    length,
    LEAD(length) OVER(ORDER BY film_id)
FROM film;

-- 7) CUME_DIST() 누적 분포
SELECT
    title,
    length,
    CUME_DIST() OVER(ORDER BY length)
FROM film;

-- 8) PERCENT_RANK() 백분위 순위
SELECT
    title,
    length,
    PERCENT_RANK() OVER(ORDER BY length)
FROM film;

-- 9) 집계 윈도우 함수
SELECT
	title, 
    rating,
	COUNT(length) OVER(PARTITION BY rating), 
	SUM(length) OVER(PARTITION BY rating), 
	AVG(length) OVER(PARTITION BY rating), 
	MIN(length) OVER(PARTITION BY rating), 
	MAX(length) OVER(PARTITION BY rating)
FROM film;