/* =========================================================
1. 문자 단일행 함수
   ========================================================= */
   
SELECT
    first_name,
    UPPER(first_name) AS upper_name
FROM customer;

SELECT
    first_name,
    LOWER(first_name) AS lower_name
FROM customer
where first_name like 'A%';

SELECT
    first_name,
    SUBSTRING(first_name, 2, 3) AS sub_name -- 2부터 3개
FROM customer;

SELECT
    customer_id,
    MOD(customer_id, 2) AS remainder,
    customer_id % 2 AS remainder
FROM customer;

SELECT
    customer_id,
    FLOOR(RAND() * 100) + 1 AS coupon_number -- 1~100
FROM customer
LIMIT 10;

SELECT
    payment_id,
    amount,
    ROUND(amount, 1) AS round_amount
FROM payment;

-- 10% 할인된 금액 구하기. 반올림 소수점 2까지
SELECT
    payment_id,
    amount,
    amount * 0.1, 2 AS discount,
    ROUND(amount * 0.9, 2) AS discount_price,
    ROUND(amount-discount, 2) discount_price
FROM payment
LIMIT 10;

/* =========================================================
3. 날짜 단일행 함수
   ========================================================= */
SELECT
    NOW(),
    CURDATE(),
    CURTIME(),
    YEAR(NOW()),
    MONTH(NOW()),
    DAY(NOW());
    
SELECT
    first_name,
    YEAR(create_date) AS join_year,
    YEAR(curdate()) - YEAR(create_date) "가입 후 몇년",
    datediff(curdate(), create_date) "가입 후 몇일"
FROM customer;

-- 현재 기준 몇년 후가 언제인지 
select date_add(curdate(), interval -10 year);
select date_add(curdate(), interval 2 week);
select date_add(now(), interval 2 hour);
select date_add(curdate(), interval 1 quarter);

select curdate() + 10; -- 권장하지 않는 표현

-- 날짜 형식 변경
SELECT
    first_name,
    DATE_FORMAT(create_date, '%Y년 %m월 %d일') AS join_date
FROM customer;

-- 날짜 형식 변경
SELECT
    first_name,
    DATE_FORMAT(create_date, '%Y/%m/%d') AS join_date -- 영어 대소문자에 따라 출력값이 다름
FROM customer;

/* =========================================================
4. where절에서 단일행 함수 - 함수의 반환값을 조건값으로 비교
   ========================================================= */
   
   -- 이름이 'A'로 시작하는 고객
SELECT *
FROM customer
WHERE LEFT(first_name, 1) = 'A';

-- .org로 끝나는
SELECT *
FROM customer
WHERE RIGHT(email, 4) = '.org';

-- 올해 가입한
SELECT * 
FROM customer
WHERE YEAR(create_date) = YEAR(NOW());

-- 가입년도가 20년 이상
SELECT first_name, (YEAR(NOW()) - YEAR(create_date)) as 가입년수
FROM customer
WHERE (YEAR(NOW()) - YEAR(create_date)) >= 20;

-- first_name 길이가 6이상
SELECT
    first_name,
    LENGTH(first_name) AS name_length
FROM customer
WHERE LENGTH(first_name) >= 6;

-- 
SELECT *
FROM customer
WHERE YEAR(create_date) = 2005;

-- 다음처럼 create_date 컬럼의 인덱스를 사용하는 범위 조건으로 작성하는 것이 성능상 더 유리하다.
SELECT *
FROM customer
WHERE create_date >= '2005-01-01'
  AND create_date < '2006-01-01';
  

-- first_name이 긴 순서대로 내림차순 + last_name이 긴 순서대로 내림차순
select * from customer
order by length(first_name) desc, length(last_name) desc;

-- first_name + last_name 출력, email은 왼쪽에서 4자리 + **** 출력
select 
	concat(first_name, ' ', last_name) full_name,
    concat(left(email, 4), '****') email
from customer
order by full_name; -- 오름차순의 경우 as 생략