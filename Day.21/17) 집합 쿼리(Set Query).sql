SELECT COUNT(*) FROM actor;
SELECT COUNT(*) FROM customer;

SELECT first_name
FROM actor -- 200
UNION ALL  
SELECT first_name
FROM customer; -- 599

SELECT t.name
FROM
(SELECT first_name AS name FROM actor 
UNION  
SELECT first_name as name FROM customer) t 
WHERE t.name LIKE '%ac%';