CREATE TABLE student (
    id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    gender CHAR(1) NOT NULL,
    age INT NOT NULL
);

INSERT INTO student (id, name, gender, age) VALUES
(1, '김민수', 'M', 20),
(2, '이영희', 'F', 22),
(3, '박지훈', 'M', 21),
(4, '최수진', 'F', 23),
(5, '정우성', 'M', 19),
(6, '한지민', 'F', 20),
(7, '오세훈', 'M', 24),
(8, '윤아름', 'F', 21),
(9, '강동원', 'M', 22),
(10, '송지은', 'F', 19);

SELECT gender, count(name), 
	min(name), 
	group_concat(name ORDER BY name SEPARATOR ' ') 
FROM student
GROUP BY gender;

-- 숫자에만 사용가능한 집계함수 avg, sum
-- 숫자+문자 count(distinct), max, min
-- 문자만 group_concat(order by, sep) 문자열값들을 연결
-- variance(), stddev()

INSERT INTO student(id, name, gender, age)
VALUES(11, '송지은', 'F', 20);

SELECT gender, count(DISTINCT name) -- 중복 제거
FROM student
GROUP BY gender;

-- --------
SELECT gender, avg(age), variance(age), stddev(age)
FROM student
GROUP BY gender;