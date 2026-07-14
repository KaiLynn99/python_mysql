-- 1. 테이블의 열정보 확인
show columns from customer;

-- 2. SELECT절
select store_id
from customer
limit 10;

select distinct store_id, active -- distinct 뒤의 중복 제거
from customer;
-- from -> where -> select -> distinct -> order by -> limit

-- 3. WHERE 절 : 특정행에 연산 비교/논리 연산 후 '참'인 행만 필터링

-- 1) 비교 연산

show columns from film;

select film_id, title, length
from film
where length != 50
limit 10;

select film_id, title, length
from film
where title < 'AD' -- 비교 연산은 문자도 가능, AA or AB or AC
limit 10;


show columns from customer;

select first_name, create_date
from customer
where create_date <= '2006-02-14 22:04:37'; -- 해당 날짜보다 작은 것

-- 2) 논리 연산

SELECT *
FROM customer
WHERE active = 1
AND store_id = 1;

SELECT *
FROM customer
WHERE store_id = 1
OR store_id = 2;

SELECT *
FROM customer
WHERE NOT active = 1;

SELECT *
FROM customer
WHERE active <> 1;

SELECT *
FROM customer
WHERE first_name IN ('MARY', 'PATRICIA', 'LINDA');
-- 컬럼값의 대소문자를 구분X, 다른 RDBMS는 구분

SELECT *
FROM customer
WHERE first_name = 'MARY'
OR first_name = 'PATRICIA'
OR first_name = 'LINDA'

SELECT *
FROM customer
WHERE first_name NOT IN ('MARY', 'PATRICIA');

SELECT *
FROM customer
WHERE customer_id BETWEEN 10 AND 20; -- 10(포함)~20(포함)

SELECT *
FROM customer
WHERE customer_id >= 10 AND customer_id <= 20;

SELECT *
FROM customer
WHERE customer_id NOT BETWEEN 10 AND 20;

SELECT *
FROM customer
WHERE first_name LIKE 'A%'; -- 대문자 A로 시작하는...mysql에서는 a도 가능

SELECT *
FROM customer
WHERE first_name LIKE '%A'; -- 대문자 A로 끝나는

SELECT *
FROM customer
WHERE first_name LIKE '%AR%'; -- %는 여러 글자, 대문자 AR을 포함

SELECT *
FROM customer
WHERE first_name LIKE '_AR_';  -- _는 한글자

SELECT *
FROM customer
WHERE email is NULL; -- =는 값 비교 연산자 이므로 사용 못함

-- ※ 연산자 우선순위 : () -> NOT -> AND -> OR
SELECT *
FROM customer
WHERE (first_name = 'MARY' OR store_id = 1) AND active = 1 ;
-- ()가 없으면 AND가 먼저 실행, OR는 마지막에 실행