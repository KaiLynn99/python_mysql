-- 2. 1정규화 실습
-- 1) 원자값이 아닌 컬럼값에 대해 1:N관계로 테이블 분리

CREATE TABLE person (
    person_id INT PRIMARY KEY,
    person_name VARCHAR(30),
    hobby VARCHAR(100)
);

INSERT INTO person VALUES
(1001, '홍길동', '야구,농구'),
(1002, '김철수', '독서'),
(1003, '이영희', '영화감상,여행'),
(1004, '박민수', '등산,수영,캠핑'),
(1005, '최지훈', '게임,발야구');

SELECT * FROM person
WHERE hobby = '영화감상,여행';
-- - 특정 취미 검색이 어렵다.

SELECT * FROM person
WHERE hobby LIKE '%영화감상%';

SELECT * FROM person
WHERE hobby LIKE '%야구%';
-- like 예시

-- ----------------------------
-- 1정규형으로 분리

CREATE TABLE person1 (
    person_id INT PRIMARY KEY,
    person_name VARCHAR(30)
);

INSERT INTO person1 VALUES
(1001,'홍길동'),
(1002,'김철수'),
(1003,'이영희'),
(1004,'박민수'),
(1005,'최지훈');

CREATE TABLE person1_hobby (
    person_id INT,
    hobby VARCHAR(30),
    PRIMARY KEY(person_id, hobby),
    FOREIGN KEY(person_id)
        REFERENCES person1(person_id)
);

INSERT INTO person1_hobby VALUES
(1001,'야구'),
(1001,'농구'),
(1002,'독서'),
(1003,'영화감상'),
(1003,'여행'),
(1004,'등산'),
(1004,'수영'),
(1004,'캠핑'),
(1005,'게임'),
(1005,'발야구');

SELECT * FROM person1_hobby 
WHERE hobby = '영화감상';
-- persom_id 값만 나오게 됨

SELECT * 
FROM person1_hobby ph JOIN person1 p
on ph.person_id = p.person_id
WHERE hobby = '영화감상';
-- JOIN 필요

-- 2) 반복되는 컬럼을 분리하여 1:N관계로 테이블 분리

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(30),
    subject1 VARCHAR(30),
    subject2 VARCHAR(30),
    subject3 VARCHAR(30)
);

INSERT INTO student VALUES
(1001,'홍길동','DB','Python','Power BI'),
(1002,'김철수','Java','SQL',NULL),
(1003,'이영희','Python',NULL,NULL);

SELECT * FROM student;
-- 과목이 4개가 되면 컬럼 추가 필요
-- ALTER TABLE student... 테이블 구조를 바꿔야 함

-- 1정규형으로 분리

CREATE TABLE student1 (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(30)
);

CREATE TABLE student1_subject (
    student_id INT,
    subject_name VARCHAR(30),
    PRIMARY KEY(student_id, subject_name),
    FOREIGN KEY(student_id)
        REFERENCES student1(student_id)
);

INSERT INTO student1 VALUES
(1001,'홍길동'),
(1002,'김철수'),
(1003,'이영희');

INSERT INTO student1_subject VALUES
(1001,'DB'),
(1001,'Python'),
(1001,'Power BI'),
(1002,'Java'),
(1002,'SQL'),
(1003,'Python');

SELECT * FROM student1_subject;

INSERT INTO student1_subject 
VALUES('1001', 'JAVA');

SELECT * FROM student1_subject;
-- 컬럼 추가 없이, 정상적으로 과목이 추가됨

-- 1정규화 전
SELECT * FROM student WHERE student_id = '1001';
-- 1정규화 후
SELECT * 
FROM student1_subject 
WHERE student_id = '1001';
-- student_id만 나옴

-- 1정규화 후 JOIN 필요
SELECT s.student_id, s.student_name, ss.subject_name
FROM student1_subject ss JOIN student1 s
on ss.student_id = s.student_id
WHERE s.student_id = '1001';
-- student_id, subject_name 같이 조회

-- 정규화 전에는 한 행으로 출력 가능
SELECT * FROM student WHERE student_id = '1001';
-- 1정규화 후 결과도 한 행으로  
select s.student_id, s.student_name, group_concat(ss.subject_name)
from student1_subject ss join student1 s
on ss.student_id = s.student_id
where s.student_id = '1001'
group by student_id, s.student_name;