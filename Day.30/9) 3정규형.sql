-- 1. 3정규형
CREATE TABLE employee_info (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(30),
    dept_code CHAR(2),
    dept_name VARCHAR(30)
);

INSERT INTO employee_info
VALUES
(1001, '홍길동', 'D1', '영업부'),
(1002, '김철수', 'D2', '개발부'),
(1003, '이영희', 'D2', '개발부'),
(1004, '박민수', 'D3', '인사부');

SELECT * FROM employee_info;
-- dept_name은 기본키(emp_id)에 직접 종속되지 않고, 일반 컬럼(dept_code)을 통해 결정된다.

-- 2. 3정규형으로 분리
CREATE TABLE department_master (
    dept_code CHAR(2) PRIMARY KEY,
    dept_name VARCHAR(30)
);

INSERT INTO department_master
VALUES
('D1','영업부'),
('D2','개발부'),
('D3','인사부');

CREATE TABLE employee_master (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(30),
    dept_code CHAR(2),
    FOREIGN KEY (dept_code)
        REFERENCES department_master(dept_code)
);

INSERT INTO employee_master
VALUES
(1001,'홍길동','D1'),
(1002,'김철수','D2'),
(1003,'이영희','D2'),
(1004,'박민수','D3');

SELECT * FROM employee_master;
-- dept_code 알 수 없음

-- 정규화 후에는 직원 + 부서명을 보기 위해 직원 테이블과 부서 테이블을 JOIN한다.
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name
FROM employee_master e
JOIN department_master d
    ON e.dept_code = d.dept_code
ORDER BY e.emp_id;