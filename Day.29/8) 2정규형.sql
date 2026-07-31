--  1. 원본 데이터만으로 컬럼에 종속되는 지 안되는지 어떻게 확인

CREATE TABLE student_course (
    student_id INT,
    student_name VARCHAR(30),
    subject_id CHAR(3),
    subject_name VARCHAR(30),
    tuition INT,
    discount_rate INT,
    PRIMARY KEY(student_id, subject_id)
);

INSERT INTO student_course
(student_id, student_name, subject_id, subject_name, tuition, discount_rate)
VALUES
(1001, '홍길동', 'S01', 'Python',    300000, 10),
(1001, '홍길동', 'S02', 'SQL',       250000, 20),
(1001, '홍길동', 'S03', 'Power BI',  350000, 15),

(1002, '김철수', 'S01', 'Python',    300000,  5),
(1002, '김철수', 'S02', 'SQL',       250000, 10),
(1002, '김철수', 'S04', 'Java',      280000,  0),

(1003, '이영희', 'S01', 'Python',    300000,  0),
(1003, '이영희', 'S03', 'Power BI',  350000, 20),
(1003, '이영희', 'S04', 'Java',      280000, 10),

(1004, '박민수', 'S02', 'SQL',       250000, 15),
(1004, '박민수', 'S03', 'Power BI',  350000,  5),

(1005, '최유리', 'S01', 'Python',    300000, 20),
(1005, '최유리', 'S04', 'Java',      280000, 10);

SELECT * FROM student_course;

-- 1) 수강료 확인
SELECT
    subject_id,
    COUNT(DISTINCT tuition) AS tuition_count
FROM student_course
GROUP BY subject_id;
-- 전부 1이므로 단일값(모두 같은 중복값)

-- 할인률 확인
SELECT
    subject_id,
    COUNT(DISTINCT discount_rate) AS discount_count
FROM student_course
GROUP BY subject_id;