select title 제목, length 시간 
from film
limit 10;  

select f2.제목, f2.시간
from
	(select title 제목, length 시간
	from film
	limit 10) as f2
where f2.시간 between 50 and 100;
-- 여러번 사용하면 복잡해진다

-- -------------------
with f2 as(select title 제목, length 시간
	from film
	limit 10
)

select f2.제목, f2.시간
from f2
where f2.시간 between 50 and 100;

-- film테이블에서 title, rental_rate 컬럼만을 가진 가상의 테이블
WITH movie AS (
    SELECT title, rental_rate
    FROM film
)
SELECT *
FROM movie;

-- rental_rate가 4 이상인 영화의 title, rental_rate 컬럼만을 가진 가상의 테이블
WITH expensive_movie AS (
    SELECT title, rental_rate
    FROM film
    WHERE rental_rate >= 4
)
SELECT *
FROM expensive_movie;

-- 영화 길이가 120분 이상
WITH long_movie AS (
    SELECT title, length
    FROM film
    WHERE length >= 120
)
SELECT *
FROM long_movie
ORDER BY length DESC;

-- z 이름을 가진 가상의 테이블

-- 1)
select *
from actor
where upper(first_name) like '%Z%'
or upper(last_name) like '%Z%';

-- 2)
select * from actor
where upper(concat(first_name, last_name)) like '%Z%';

-- 3)
with actor_name as(
	select actor_id, (concat(first_name, last_name)) fullname
    from actor
)
select * from actor_name
where fullname like '%Z%'