-- 함수() over() : 전체를 하나로, 정렬x, 처음 ~ 끝
-- 함수() over(partition by) : n개의 파티션, 정렬x, 처음 ~ 끝
-- 함수() over(order by by) : 1개의 파티션, 정렬O, RANGE처음 ~ 현재
-- 함수() over(partition by order by) :  n개의 파티션, 정렬O, RANGE처음 ~ 현재

SELECT
	title,
	RANK() OVER(ORDER BY length DESC RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM film;

SELECT
	title,
    length,
	sum(length) OVER(ORDER BY length DESC 
				rows BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM film;

-- 1) 상영시간의 누적합
SELECT
    title,
    length,
    SUM(length) OVER(
        ORDER BY length
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_length
FROM film;


-- 2) 최근 3개 영화의 평균 상영시간 : 이전 2행 + 현재 (최근 3건 평균)
SELECT
    title,
    length,
    AVG(length) OVER(
        ORDER BY length
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS avg_length
FROM film;

-- 3) 최근 3개 영화의 평균 상영시간 : 이전 1행 + 현재 + 다음 1행
SELECT
    title,
    length,
    AVG(length) OVER(
        ORDER BY length
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS neighbor_avg
FROM film;

-- 4) 현재부터 마지막까지 (남은 데이터 누계)
SELECT
    title,
    length,
    SUM(length) OVER(
        ORDER BY length
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
    ) AS remaining_length
FROM film;

-- 3. PARTITION BY + ORDER BY + ROWS를 모두 사용하는 예)
SELECT
    p.staff_id,
    DATE(p.payment_date) AS pay_date,
    SUM(p.amount) AS daily_amount
FROM payment p
GROUP BY
    p.staff_id,
    DATE(p.payment_date);-- 직원별 날짜별 매출 
    
    
WITH daliy_sales AS
(
	SELECT
		p.staff_id,
		DATE(p.payment_date) AS pay_date,
		SUM(p.amount) AS daily_amount
	FROM payment p
	GROUP BY
		p.staff_id,
		DATE(p.payment_date) 
)

-- 이전 6일 + 현재일 = 7일의 매출 합계
SELECT 
	staff_id, pay_date, daily_amount,
	-- 이전 6일 + 현재일 매출 합계
    sum(daily_amount) OVER(PARTITION BY staff_id 
							ORDER BY pay_date
                            ROWS BETWEEN 6 PRECEDING and CURRENT ROW) "7days"
FROM daliy_sales
ORDER BY 7days DESC;

--
WITH daliy_sales AS
(
	SELECT
		p.staff_id,
		DATE(p.payment_date) AS pay_date,
		SUM(p.amount) AS daily_amount
	FROM payment p
	GROUP BY
		p.staff_id,
		DATE(p.payment_date) 
),
roling_sales as(
	SELECT 
		staff_id, pay_date, daily_amount,
		sum(daily_amount) OVER(PARTITION BY staff_id 
								ORDER BY pay_date
								ROWS BETWEEN 6 PRECEDING and CURRENT ROW) roling_7days
	FROM daliy_sales
),
ranked as (
	SELECT *,
    ROW_NUMBER() OVER(PARTITION BY staff_id ORDER BY roling_7days DESC) rn
    FROM roling_sales
)

SELECT staff_id, date_sub(pay_date,interval 6 day) stard_day, pay_date end_day, roling_7days
FROM ranked
WHERE rn = 1; 