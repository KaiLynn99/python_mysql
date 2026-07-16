-- 2. 2개의 테이블을 INNER JOIN
-- country_id = 86에 어떤 city가 있는지
SELECT * from city WHERE country_id = 86;

-- country_id = 86에 어떤 country가 있는지
SELECT * from country WHERE country_id = 86;
 
-- 

-- city + country (country_id = 86)
SELECT
	ci.city, ci.country_id, co.country
from city ci inner join country co -- as 생략 가능
on ci.country_id = co.country_id -- 테이블 합치기
WHERE ci.country_id = 86;

-- ----------------------------------------------
-- 3. 3개의 테이블을 INNER JOIN
SELECT * FROM address;

-- city_id = 463가 어느 나라?(몇 번?) 
SELECT * FROM city WHERE city_id = 463;

-- country_id = 50 어느 나라?(몇 번?) 
SELECT * FROM country WHERE country_id = 50;

--
SELECT
    co.country,
    c.city,
    a.address,
    a.city_id
FROM country AS co
INNER JOIN city AS c
    ON co.country_id = c.country_id
INNER JOIN address AS a
    ON c.city_id = a.city_id
WHERE co.country = 'japan'
ORDER BY c.city;
 
-- ----------------------------------------------
-- 4. 중간(연결)테이블로 연결된 3개의 테이블을 INNER JOIN
-- 1) 영화 제목과 카테고리 조회
SELECT
    f.title,
    c.name AS category
FROM film AS f  -- ① film 테이블부터 시작한다.
INNER JOIN film_category AS fc
    ON f.film_id = fc.film_id  -- ② 영화의 film_id와 film_category의 film_id를 연결한다.
INNER JOIN category AS c
    ON fc.category_id = c.category_id  -- ③ film_category의 category_id와 category의 category_id를 연결한다.
ORDER BY title;  