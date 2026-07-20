SELECT * FROM country; -- 부모
SELECT * FROM city; -- 자식

-- New Land 나라 추가
INSERT into country(country)
VALUES('New Land');

SELECT * FROM country;

SELECT *
FROM city ci INNER JOIN country co
ON ci.country_id = co.country_id
WHERE co.country = 'New Land';
-- 결과 안나옴

SELECT *
FROM country co LEFT JOIN city ci
ON ci.country_id = co.country_id;
-- 결과 나옴

SELECT co.country, ci.country_id
FROM country co LEFT JOIN city ci
ON ci.country_id = co.country_id
WHERE ci.country_id is null;
-- 결과 확인