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