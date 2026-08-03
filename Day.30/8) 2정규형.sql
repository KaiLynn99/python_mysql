CREATE TABLE student_course_score (
    student_id INT,
    course_id INT,
    student_name VARCHAR(30),
    course_name VARCHAR(50),
    score INT,
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO student_course_score
VALUES
(1001, 101, '홍길동', '데이터베이스', 95),
(1001, 102, '홍길동', 'Python', 88),
(1002, 101, '김철수', '데이터베이스', 91),
(1002, 103, '김철수', 'Power BI', 85),
(1003, 102, '이영희', 'Python', 93);

SELECT * FROM student_course_score;
-- 기본키 전체가 아닌 기본키의 일부 컬럼에만 종속되는 속성이 존재

-- -------------------------------------

-- 1) 2정규형으로 분리

CREATE TABLE student_master (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(30)
);
INSERT INTO student_master
VALUES
(1001,'홍길동'),
(1002,'김철수'),
(1003,'이영희');

CREATE TABLE course_master (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
);

INSERT INTO course_master
VALUES
(101,'데이터베이스'),
(102,'Python'),
(103,'Power BI');

CREATE TABLE enrollment_score (
    student_id INT,
    course_id INT,
    score INT,
    PRIMARY KEY(student_id, course_id),
    FOREIGN KEY(student_id)
        REFERENCES student_master(student_id),
    FOREIGN KEY(course_id)
        REFERENCES course_master(course_id)
);

INSERT INTO enrollment_score
VALUES
(1001,101,95),
(1001,102,88),
(1002,101,91),
(1002,103,85),
(1003,102,93);

SELECT * FROM enrollment_score;

SELECT
    s.student_id,
    s.student_name,
    c.course_name,
    e.score
FROM student_master s
JOIN enrollment_score e
    ON s.student_id = e.student_id
JOIN course_master c
    ON e.course_id = c.course_id
ORDER BY s.student_id, c.course_name;