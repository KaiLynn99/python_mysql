/* =========================================================
1. 형 변환
   ========================================================= */
-- 문자 -> 숫자
-- CAST(인수 as 타입) 형변환 함수
SELECT CAST('100' AS float) AS result;

-- 문자열끼리 더하기 자동 형변환(MySQL에선 +연산이 숫자 연산에만 사용된다)
SELECT '100' + '200' AS result;
SELECT '100' + 50;
SELECT '100원' + 50; -- 글자가 있어도 자동 형 변환
SELECT 'xyz' + 50; -- 문자는 0으로 변환

-- 숫자 -> 문자
SELECT length(cast(123 AS CHAR));
SELECT CONCAT(CAST(100 AS CHAR), '원');

-- concat(문자, 문자, 문자, ...)
SELECT CONCAT(100,'원'); -- 100을 자동으로 문자로 형변환 후 연산

select concat(customer_id, '번') 번호, first_name
from customer;

-- 문자 -> 날짜
SELECT CAST('2026-07-13' AS DATE);
SELECT CAST('2026-07-13 09:30:00' AS DATETIME);

-- 날짜 -> 문자
SELECT CAST(NOW() AS CHAR);

-- 문자 -> 날짜
SELECT STR_TO_DATE('20260713', '%Y%m%d');
SELECT STR_TO_DATE('2026-07-13', '%Y-%m-%d');

-- 실수 <-> 정수
SELECT CAST(123.987 AS SIGNED);
SELECT CAST(100 AS DECIMAL(10,2));


SELECT CAST(10/3 AS unsigned),
	CAST(10/3 AS DECIMAL(10,2)),
	CAST(10/3 AS float),
	CAST(10/3 AS double);