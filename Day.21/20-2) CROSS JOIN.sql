CREATE TABLE student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(30)
);

CREATE TABLE subject (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(30)
);

INSERT INTO student VALUES
(1, '홍길동'),
(2, '김철수'),
(3, '이영희');

INSERT INTO subject VALUES
(101, 'SQL'),
(102, 'Python'),
(103, 'Power BI');


-- 과목당 성적표를 우편 배송 몇 장?
-- 과목당 출석부를 몇 개
-- 경우의 수 n개행, m개행 -> n*m

SELECT *
FROM student st CROSS JOIN subject sub;


/*INNER JOIN
OUTER JOIN - LEFT, RIGHT
CROSS JOIN
SELF JOIN
*/

-- SELF CROSS JOIN 예)
SELECT * 
FROM student s1 CROSS JOIN student s2 -- 중복됨
WHERE s1.student_name <> s2.student_name; -- 중복 제거

SELECT COUNT(*)  -- 갯수 확인
FROM student s1 CROSS JOIN student s2 
WHERE s1.student_name <> s2.student_name; 