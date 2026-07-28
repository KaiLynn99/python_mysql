SELECT *
FROM stock_price
LIMIT 10;

-- 기초 통계량 : 수치 데이터에 대한 통계값


-- 1) 전체 종목별 종가 기초통계량
SELECT
    ticker,
    COUNT(*) AS data_count,
    ROUND(AVG(close_price), 2) AS mean_price,
    ROUND(STDDEV(close_price), 2) AS stddev_price,
    ROUND(VARIANCE(close_price), 2) AS variance_price,

    MIN(close_price) AS min_price,
    MAX(close_price) AS max_price,

    ROUND(MAX(close_price) - MIN(close_price), 2) AS range_price
FROM stock_price
GROUP BY ticker
ORDER BY ticker;

-- 2) 전체 종목별 종가 기초통계량(회사정보도 함께 출력)
SELECT
    c.company_name,
    sp.ticker,
    COUNT(*) AS trading_days,
    ROUND(AVG(sp.close_price), 2) AS mean_price,
    MIN(sp.close_price) AS min_price,
    MAX(sp.close_price) AS max_price,
    ROUND(STDDEV(sp.close_price), 2) AS stddev_price,
    ROUND(VARIANCE(sp.close_price), 2) AS variance_price
FROM stock_price sp
INNER JOIN company c
    ON sp.ticker = c.ticker
GROUP BY
    c.company_name,
    sp.ticker
ORDER BY c.company_name;

-- 3) 시가(Open) 기초통계량
SELECT
    ticker,
    ROUND(AVG(open_price), 2) AS mean_open,
    MIN(open_price) AS min_open,
    MAX(open_price) AS max_open,
    ROUND(STDDEV(open_price), 2) AS stddev_open
FROM stock_price
GROUP BY ticker;

-- 4) 거래량(Volume) 기초통계량
SELECT
    ticker,
    ROUND(AVG(volume), 0) AS mean_volume,
    MIN(volume) AS min_volume,
    MAX(volume) AS max_volume,
    FORMAT(ROUND(STDDEV(volume), 0), 0) AS stddev_volume
FROM stock_price
GROUP BY ticker;

-- 6) 40주간 최저가와 최고가 조회
SELECT
    ticker,
    COUNT(*),
    MAX(high_price) AS highest_40week,
    MIN(low_price) AS lowest_40week
FROM stock_price
WHERE trade_date >= (SELECT MAX(trade_date) FROM stock_price) - INTERVAL 280 DAY
GROUP BY ticker;

-- 날짜빼기 연산자대신 "DATE_SUB() 함수"를 사용해도 동일한 결과
-- DATE_SUB((SELECT MAX(trade_date) FROM stock_price), INTERVAL 280 DAY)


-- 7) 40주간 최저가와 최고가 조회 + 최저/최고 날짜 같이 조회
-- 최근 40주(약 280일) 데이터에서
-- 종목별 최고가와 최저가를 기록한 날짜를 조회

WITH stock40 AS (
    -- 전체 데이터 중 최근 40주(약 280일) 데이터만 추출
    SELECT *
    FROM stock_price
    WHERE trade_date >= (SELECT MAX(trade_date) FROM stock_price) - INTERVAL 280 DAY
),

high_rank AS (
    -- 종목별 최고가를 높은 순으로 정렬하여 순위 부여
    SELECT
        ticker,
        trade_date,
        high_price,
        ROW_NUMBER() OVER (
            PARTITION BY ticker
            ORDER BY high_price DESC
        ) AS rn
    FROM stock40
),

low_rank AS (
    -- 종목별 최저가를 낮은 순으로 정렬하여 순위 부여
    SELECT
        ticker,
        trade_date,
        low_price,
        ROW_NUMBER() OVER (
            PARTITION BY ticker
            ORDER BY low_price ASC
        ) AS rn
    FROM stock40
)

-- 종목별 최고가와 최저가(1위)만 조회
SELECT
    h.ticker,
    h.trade_date AS highest_date,
    h.high_price AS highest_40week,
    l.trade_date AS lowest_date,
    l.low_price AS lowest_40week
FROM high_rank h
JOIN low_rank l
    ON h.ticker = l.ticker
WHERE h.rn = 1
  AND l.rn = 1
ORDER BY h.ticker;

-- 5) BigQuery 야후 주가 데이터 분석
-- 4) 최근 3개월 수익률 TOP 5

WITH tmp as (
	SELECT
		max(trade_date) - INTERVAL 3 month startday,
		max(trade_date) endday
	FROM stock_price
),
start_tmp as(
	SELECT  sp.ticker, tmp.startday, sp.close_price scp
	FROM stock_price sp
	INNER JOIN tmp
		ON sp.trade_date = tmp.startday
),
end_tmp as (
	SELECT  sp.ticker, tmp.endday, sp.close_price ecp
	FROM stock_price sp
	INNER JOIN tmp
		ON sp.trade_date = tmp.endday
)
SELECT *, round((ecp-scp)/scp * 100, 1) "수익률"
FROM start_tmp s INNER JOIN end_tmp e
ON s.ticker = e.ticker
ORDER BY 수익률 DESC
LIMIT 5;