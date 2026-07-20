CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(30),
    manager_id INT
);

INSERT INTO employee VALUES
(1, '김부장', NULL),
(2, '이과장', 1),
(3, '박대리', 2),
(4, '최사원', 2),
(5, '정사원', 3),
(6, '한인턴', 4);

SELECT  
	e1.emp_id, e1.emp_name, 
    ifnull(e2.emp_name, '대표') "관리자"
FROM employee e1 LEFT JOIN employee e2 -- 김부장의 null값 나오게
ON e1.manager_id = e2.emp_id;