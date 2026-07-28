-- 1. DDL - 회사정보 테이블 + 주가 테이블로 분리하는 것이 관계형 데이터베이스 설계

-- 회사 정보 : 실제 분석에서는 많은 정보 컬럼이 필요하지만, 지금은 티커(Ticker Symbol)와 회사이름 컬럼만 사용 
CREATE TABLE company (
    ticker VARCHAR(10) PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL
);

-- 주가 정보
CREATE TABLE stock_price (
    ticker VARCHAR(10) NOT NULL,
    trade_date DATE NOT NULL,

    open_price DECIMAL(10,2),
    high_price DECIMAL(10,2),
    low_price DECIMAL(10,2),
    close_price DECIMAL(10,2),
    volume BIGINT,

    PRIMARY KEY (ticker, trade_date),

    CONSTRAINT fk_stock_company
        FOREIGN KEY (ticker)
        REFERENCES company(ticker)
);

-- 2. 회사 데이터 티커(Ticker Symbol)와 회사이름 입력(샘플로 10개의 회사만)
INSERT INTO company VALUES
('AAPL','Apple'),
('MSFT','Microsoft'),
('GOOGL','Alphabet'),
('AMZN','Amazon'),
('META','Meta'),
('NVDA','NVIDIA'),
('TSLA','Tesla'),
('NFLX','Netflix'),
('AMD','AMD'),
('INTC','Intel');

-- 10개 회사 * 251 데이터 --> 2510행
select count(*) from stock_price;

select * 
from company c inner join stock_price sp
on c.ticker = sp.ticker
order by trade_date desc, c.ticker
limit 10;

select max(trade_date) from stock_price;