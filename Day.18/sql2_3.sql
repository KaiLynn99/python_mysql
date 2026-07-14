SELECT first_name, now() , 10+7, customer_id % 2, '미국'
FROM customer
ORDER BY customer_id
LIMIT 10;

-- AS는 컬럼이나 테이블에 별칭(Alias, 별명)을 지정하는 키워드이다.

SELECT first_name AS "이름", now() AS 오늘, 10+7 AS 계산결과, 
customer_id % 2 AS "짝수 홀수", '미국' AS 국적
FROM customer
ORDER BY customer_id
LIMIT 10;

SELECT
    c.first_name, c.last_name
FROM customer AS C
ORDER BY customer_id
LIMIT 10;
-- 컬럼 별칭은 조회 결과에 필요해서, 테이블 별칭은 편의성을 위해 사용

SELECT
    c.first_name 이름, 
    c.last_name 성
FROM customer AS C
ORDER BY 성; -- ORDER 절에서는 AS 사용 가능

SELECT
    c.first_name 이름, 
    c.last_name 성
FROM customer AS C
WHERE 성 like 'A%' -- WHERE 절에서는 AS 사용 불가능 (순서 차이)
ORDER BY 성; 

SELECT first_name 이름, last_name 성
FROM customer 
ORDER BY 2; -- select절보다 뒤에 실행되는 절이기 때문에 별칭 or 위치 숫자 사용 가능
-- ORDER BY first_name;
-- ORDER BY 이름;