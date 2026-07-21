-- 영화가 존재하지 않는 카테고리
SELECT *
FROM category
WHERE category_id = 
	(SELECT category_id FROM category -- 전체 카테고리
	EXCEPT
	SELECT DISTINCT category_id FROM film_category); -- 영화 존재 카테고리
    
-- 카테고리에 영화가 존재하는 카테고리 -> 몇 개?
-- 영화가 존재하지 않는 카테고리 -> 몇 개?

-- LEFT JOIN : category X film_category
SELECT
	sum(CASE WHEN t.cnt = 0 THEN 1 ELSE 0 end) "영화가 존재하지 않는 카테고리",
	sum(CASE WHEN t.cnt > 0 THEN 1 ELSE 0 end) "영화가 존재하는 카테고리"
FROM
	(SELECT c.category_id id, count(fc.film_id) cnt
	FROM category C LEFT JOIN film_category fc
	ON c.category_id = fc.category_id
	GROUP BY c.category_id) t
GROUP BY NULL;