CREATE TABLE department_raw
(
    dept_no     INT,
    dept_name   VARCHAR(20),
    dept_loc    VARCHAR(20),

    emp_no      INT,
    emp_name    VARCHAR(20),
    emp_job     VARCHAR(20),
    hire_date   DATE
);

INSERT INTO department_raw
VALUES
(1, '관리과', '서울', NULL, NULL, NULL, NULL),
(2, 'IT과', '부산', NULL, NULL, NULL, NULL),
(3, '홍보과', '대전', NULL, NULL, NULL, NULL),
(4, '회계과', '전주', 1001, 'jjdev', '관리자', '2015-10-21'),
(5, '인사과', '인천', 1002, 'zeroDay', '사원', '2015-10-21');

SELECT *
FROM department_raw;

-- -------------------------------
-- 셀 수 : 35 -> 25
-- 25% 셀 공간 절약 

CREATE TABLE department
(
    dept_no     INT PRIMARY KEY,
    dept_name   VARCHAR(20) NOT NULL,
    dept_loc    VARCHAR(20) NOT NULL
);

INSERT INTO department
VALUES
(1, '관리과', '서울'),
(2, 'IT과', '부산'),
(3, '홍보과', '대전'),
(4, '회계과', '전주'),
(5, '인사과', '인천');

CREATE TABLE employee
(
    emp_no      INT PRIMARY KEY,
    emp_name    VARCHAR(20) NOT NULL,
    emp_job     VARCHAR(20),
    hire_date   DATE,

    dept_no     INT,

    CONSTRAINT fk_employee_department
        FOREIGN KEY (dept_no)
        REFERENCES department(dept_no)
);

INSERT INTO employee
VALUES
(1001, 'jjdev', '관리자', '2015-10-21', 4),
(1002, 'zeroDay', '사원', '2015-10-21', 5);

SELECT *
FROM employee;

SELECT
    d.dept_no,
    d.dept_name,
    d.dept_loc,
    e.emp_no,
    e.emp_name,
    e.emp_job,
    e.hire_date
FROM department d
LEFT JOIN employee e
ON d.dept_no = e.dept_no
ORDER BY d.dept_no;

-- ----------------------
-- 직접 TABLE을 만든 뒤, AUTO_INCREMENT 확인
INSERT INTO sample(x,y,z)
values(0,2,100);

DELETE FROM sample WHERE NO = 2;

SELECT *
FROM sample;