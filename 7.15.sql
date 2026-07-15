-- 1. 기타 단일행 함수

1) IF()

-- 영화 러닝타임으로 구분
SELECT
    title, -- 컬럼
    length, -- 컬럼
    IF(length >= 120, '장편', '일반') AS movie_type -- 계산된 조회
FROM film
order by movie_type asc, length asc;

-- 대여기간으로 구분
SELECT
    title,
    rental_duration,
    IF(rental_duration >= 5, '길다', '짧다') AS duration_type
FROM film;

-- 2) NULL관련 함수

-- film 테이블은 대부분 NULL이 없지만, 만약 original_language_id가 NULL이면 0을 출력한다.
SELECT
    title,
    language_id,
    original_language_id,
    IFNULL(original_language_id, 0) AS original_language_id
FROM film;

-- 특정 값을 null로 바꾸고 싶을 때
SELECT
    title,
    rental_rate,
    NULLIF(rental_rate, 4.99) AS result
FROM film;

-- 2. CASE 표현식
SELECT
    title,
    length,
    CASE
        WHEN length >= 150 THEN '매우 김'
        WHEN length >= 120 THEN '장편'
        WHEN length >= 90 THEN '보통'
        ELSE '단편'
    END AS length_type
FROM film;

SELECT
    title,
    rental_rate,
    CASE
        WHEN rental_rate = 0.99 THEN '저가'
        WHEN rental_rate = 2.99 THEN '중가'
        WHEN rental_rate = 4.99 THEN '고가'
        ELSE '기타'
    END AS price_type
FROM film;

SELECT
    title,
    rating,
    CASE rating
        WHEN 'G' THEN '전체관람가'
        WHEN 'PG' THEN '부모지도'
        WHEN 'PG-13' THEN '13세 이상'
        WHEN 'R' THEN '청소년 제한'
        WHEN 'NC-17' THEN '17세 이상'
        ELSE '기타'
    END AS rating_name
FROM film;

-- 3. where절에서 사용 예

-- 상영시간이 120분 이상이면 rental_rate >= 2.99 인 영화 조회
-- 120분 미만이면 rental_rate >= 0.99인 영화 조회
SELECT
    title,
    length,
    rental_rate
FROM film
WHERE IF(length >= 120,
         rental_rate >= 2.99,
         rental_rate >= 0.99);
-- WHERE rental_rate >= 2.99
-- WHERE rental_rate >= 0.99

-- rating이 G이면 90분 이상 조회, 아니면 120분 이상 조회
SELECT
    title,
    rating,
    length
FROM film
WHERE IF(rating = 'G',
         length >= 90,
         length >= 120);
         
-- original_language_id가 NULL이면 >=연산자를 사용할 수 없기때문에 NULL이면 0으로 바꿔 비교
SELECT
    title,
    original_language_id
FROM film

-- WHERE IFNULL(original_language_id, 0) = 0;
where original_language_id is null 
or original_language_id = 0;

SELECT
    title,
    rental_rate
FROM film
WHERE NULLIF(rental_rate, 4.99) IS NULL;
-- where rental_rate is null or rental_rate = 4.99

-- G 등급은 90분 이상, 그 외는 120분 이상 조회
SELECT
    title,
    rating,
    length
FROM film
WHERE
CASE
    WHEN rating = 'G'
        THEN length >= 90
    ELSE
        length >= 120
END;

-- 4. order by절에서 사용 예

SELECT
    title,
    length
FROM film
ORDER BY length ASC;

-- 120분보다 작은 영화와 120분 이상인 영화로 구분하여 제목의 오름차순으로 조회 
SELECT
    title,
    length
FROM film
ORDER BY IF(length < 120, 0, 1) ASC, title ASC;

-- - 오름차순 정렬하면 NULL값은 제일 먼저 온다. NULL이면 999로 바꿔 마지막에 정렬이 되게
select * from product
order by discount asc;

select * from product
order by ifnull(discount, 100) asc;
-- 오름차순 + NULL값 맨 뒤로

-- PG-13 -> NC-17 순으로 하고 나머지 순서없이 조회 
SELECT
    title,
    rating
FROM film
ORDER BY
CASE
    WHEN rating = 'PG-13' THEN 1
    WHEN rating = 'NC-17' THEN 2
    ELSE 3
END asc, title asc;

-- 장편 먼저, 같은 장편이면 제목순으로 정렬
SELECT
    title,
    length
FROM film
ORDER BY
CASE
    WHEN length >= 150 THEN 1
    WHEN length >= 100 THEN 2
    ELSE 3
END,
title;