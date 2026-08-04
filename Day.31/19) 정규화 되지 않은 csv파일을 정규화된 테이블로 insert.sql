-- 1. 정규화된 테이블 생성

CREATE TABLE customer(customer
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(50),
    grade VARCHAR(20),
    region VARCHAR(30)
);

CREATE TABLE product(
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    unit_price INT
);

CREATE TABLE sales(
    order_id VARCHAR(10) PRIMARY KEY,
    order_date DATE,
    customer_id VARCHAR(10),
    product_id VARCHAR(10),
    qty INT,
    sales INT,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY(product_id) REFERENCES product(product_id)
);

SELECT * 
FROM customer c JOIN sales s
ON c.customer_id = s.customer_id
	JOIN product p
    ON s.product_id = p.product_id;
    
-- * GROUP BY 확장 기능(소계+총계)
-- 상품별 판매량
SELECT product_id, count(*)
FROM sales
GROUP BY product_id

UNION ALL

-- 총 합계
SELECT 'total' as "total", count(*)
FROM sales;

-- 같은 결과
SELECT product_id, count(*)
FROM sales
GROUP BY ROLLUP(product_id);

SELECT product_id, customer_id, count(*)
FROM sales
GROUP BY ROLLUP(product_id, customer_id); -- AND로 연결