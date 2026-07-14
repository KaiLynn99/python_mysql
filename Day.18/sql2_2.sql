-- 1. ORDER BY절

SELECT *
FROM customer
ORDER BY customer_id DESC; -- ASC:오름차순, DESC:내림차순

SELECT *
FROM customer
ORDER BY create_date;

SELECT *
FROM customer
ORDER BY last_name ASC, first_name ASC;

SELECT store_id, customer_id, first_name
FROM customer
ORDER BY store_id ASC, customer_id DESC;

-- 최근 등록된 고객 순으로
SELECT *
FROM customer
ORDER BY create_date DESC;

-- 2. LIMIT : 상위 N개의 데이터만 조회, OFFSET 특정 구간의 상위 N개 조회
SELECT *
FROM customer
LIMIT 5; -- 0부터 5개 (0,1,2,3,4)

SELECT *
FROM customer
LIMIT 3,10; 

SELECT *
FROM customer
order by customer_id
limit 10 offset 3; -- limit 3, 10

SELECT *
FROM customer
WHERE first_name LIKE 'A%'
ORDER BY first_name
LIMIT 3;