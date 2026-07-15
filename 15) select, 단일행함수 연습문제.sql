-- 1. film 테이블 - WHERE + LIKE + ORDER BY
-- 문제
-- 영화 제목(title)이 'A'로 시작하는 영화를 조회하시오
-- 영화 제목과 상영시간(length)을 출력하고, 상영시간이 긴 순으로 정렬하시오.

-- 1)
select *
from film
where title like 'A%'
limit 10;

-- 2)
select title, length
from film
order by length desc
limit 10;



-- 2. film 테이블 - 영화 러닝타임(숫자 함수)
-- 문제
-- 영화 제목(title)과 상영시간(length)을 조회하고, 상영시간을 시간(hour) 단위로 반올림하여(ROUND(length / 60, 1)) 함께 출력하시오.
select 
	title, length,
	round(length/60,1)
from film
limit 10;



-- 3. actor 테이블 - 문자열 함수
-- 문제
-- 배우의 이름과 성을 하나의 문자열로 합쳐(CONCAT) 배우 이름(full_name) 으로 출력하시오.
select
	concat(first_name, ' ', last_name) as full_name
from actor
limit 10;

-- 4. actor 테이블 - WHERE + LIKE + ORDER BY
-- 문제
-- 이름(first_name)이 'A'로 시작하는 배우를 조회하시오.
-- 이름과 성을 출력하고 성(last_name) 오름차순으로 정렬하시오.

-- 1)
select *
from actor
where first_name like 'A%'
limit 10;

-- 2)
select first_name, last_name
from actor
order by last_name
limit 10;



-- 5. country 테이블 - WHERE + LIKE + ORDER BY
-- 문제
-- 국가명(country)에 'an' 이 포함된 국가를 조회하시오.
-- 국가명을 출력하고 국가명 오름차순으로 정렬하시오.

-- 1)
select country
from country
where country like '%an%'
limit 10;

-- 2) 
select country
from country
order by country
limit 10;



-- 6. country 테이블 - 단일행 함수
-- 문제
-- 국가명(country)과 국가명의 글자 수(LENGTH) 를 함께 출력하시오.
select 
	country,
    length(country) as length
from country
limit 10;

-- 7. customer 테이블 - WHERE + LIKE + ORDER BY
-- 문제
-- 이름(first_name)이 'M'으로 시작하는 고객을 조회하시오.
-- 이름, 성, 이메일을 출력하고 이름 오름차순으로 정렬하시오.

-- 1)
select first_name
from customer
where first_name like 'M%'
limit 10;

-- 2)
select first_name, last_name, email
from customer
order by first_name
limit 10;



-- 8. customer 테이블 - 단일행 함수
-- 문제
-- 고객의 이름과 성을 연결하여(CONCAT) 전체 이름(full_name) 을 출력하고, 가입일(create_date)은 YYYY-MM-DD 형식(DATE_FORMAT) 으로 출력하시오.
select 
	concat(first_name, ' ', last_name) as full_name, 
    date_format(create_date, '%Y-%m-%d')
from customer
limit 10;



-- 9. category 테이블 - WHERE + LIKE + ORDER BY
-- 문제
-- 카테고리명(name)이 'C'로 시작하는 카테고리를 조회하시오.
-- 카테고리명을 출력하고 이름 오름차순으로 정렬하시오.

-- 1)
select name
from category
where name like 'C%';

-- 2)
select name
from category
where name like 'C%'
order by name; 



-- 10. city 테이블 - 단일행 함수
-- 문제
-- 도시명(city)과 도시명의 글자 수(LENGTH) 를 함께 출력하시오.
select
	city,
    length(city) as length
from city
limit 10;



-- sakila film 테이블
-- 11. 영화 제목과 상영시간을 조회하고, 상영시간이 120분 이상이면 "장편", 아니면 "일반"을 출력하시오.
select 
	title,
    length,
    if(length >= 120, '장편', '단편') as movee_type
from film
limit 10;


/*
12.영화 제목과 대여요금을 조회하고,

0.99 → "저가"

2.99 → "중가"

4.99 → "고가"
"""

-- 로 출력하시오.
*/
SELECT 
	title,
    rental_rate,
    CASE
		WHEN rental_rate = 0.99 THEN '저가'
		WHEN rental_rate = 2.99 THEN '중가'
        WHEN rental_rate = 4.99 THEN '고가'
	END AS price_type
FROM film
LIMIT 10;