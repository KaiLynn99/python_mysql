## 문제 1. 고객별 최근 3번 결제금액 합계
SELECT customer_id, payment_date, amount,
	SUM(amount) OVER(PARTITION BY customer_id
				ORDER BY payment_date ASC
                ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) "최근 3일 합계"
FROM payment
ORDER BY customer_id, payment_date;


## 문제 2. 영화 길이의 누적 평균
# CTE(WITH문)
SELECT c.name, f.title, f.length,
	AVG(f.length) OVER(PARTITION BY c.name 
				  ORDER BY f.length 
                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) "처음~현재행 누적평균"
FROM category c INNER JOIN film_category fc
	ON c.category_id = fc.category_id
    INNER JOIN film f
		ON fc.film_id = f.film_id;
        
## 문제 3.직원별 최근 5일 평균 매출
WITH t1 AS (
	SELECT staff_id, date(payment_date) "날짜", sum(amount) "하루총매출액"
	FROM payment
	GROUP BY staff_id, date(payment_date)
)

SELECT staff_id, 날짜, 하루총매출액,
		AVG(하루총매출액) OVER(PARTITION BY staff_id 
        ORDER BY 날짜 ASC
        ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) 최근5일평균
FROM t1;

--
with t1 as (
	select staff_id, date(payment_date) "날짜", sum(amount) "하루총매출액"
	from payment
	group by staff_id, date(payment_date)
),
t2 as (
	select staff_id, 날짜, 하루총매출액,
		-- 하루총매출액 평균, 스텝아이디, 날짜오름차순, 최근5일
        avg(하루총매출액) over(partition by staff_id 
							order by 날짜 asc
                            rows between 4 preceding and current row) "최근5일평균"
	from t1
),
t3 as (
	select *,
		row_number() over(partition by staff_id
								order by 최근5일평균 desc) rn
	from t2
)

SELECT *
FROM t3
where t3.rn = 1;

