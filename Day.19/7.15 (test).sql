CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    price INT,
    discount INT
);

INSERT INTO product(name, price, discount)
VALUES
('노트북', 1500000, 10),
('마우스', 30000, NULL),
('키보드', NULL, 15),
('모니터', 250000, NULL),
('스피커', NULL, NULL);

-- ------------------------------------------
select * from product;

SELECT
	id,
    name,
    IFNULL(price, 0) AS price,
    nullif(discount, 15) as discount
FROM product;

-- 처음으로 null이 아닌 값
SELECT
    name,
    COALESCE(price, discount, 0) AS value
FROM product;

SELECT *
FROM product
WHERE price IS NULL;

SELECT *
FROM product
WHERE discount IS NOT NULL;


-- 2. CASE 표현식
-- 노트북 1, 마우스 2, 나머지3
select 
	if(name = '노트북',1,if(name = '마우스',2,3))
from product;

-- if()함수 == case표현식 but, 조건의 경우가 많아지면 case(가독성 위해)

select * from product
order by ifnull(discount,100) asc;