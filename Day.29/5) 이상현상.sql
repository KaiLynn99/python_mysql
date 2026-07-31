-- 1. 이상현상
-- 테이블에 중복된 데이터가 입력되게 설계하면 다음과 같이 이상현상이 발생한다.

CREATE TABLE employee (
    emp_no      CHAR(4) PRIMARY KEY,
    emp_name    VARCHAR(20),
    address     VARCHAR(100),
    phone       VARCHAR(20),
    dept_no     CHAR(3),
    dept_name   VARCHAR(30),
    dept_loc    VARCHAR(30)
);

INSERT INTO employee VALUES
('E001', '홍길동', '서울', '010-1111-1111', 'D01', '영업부', '서울');

INSERT INTO employee VALUES
('E002', '김철수', '인천', '010-2222-2222', 'D01', '영업부', '서울');

INSERT INTO employee VALUES
('E003', '이영희', '부산', '010-3333-3333', 'D02', '개발부', '판교');

INSERT INTO employee VALUES
('E004', '박민수', '대전', '010-4444-4444', 'D02', '개발부', '판교');

INSERT INTO employee VALUES
('E005', '최지훈', '광주', '010-5555-5555', 'D03', '인사부', '서울');

SELECT * FROM employee;

-- 1) 수정 이상
UPDATE employee
SET dept_loc = '성남'
WHERE emp_no = 'E003';

SELECT * FROM employee;
-- 같은 부서인데 부서 위치가 서로 다르다.

-- 2) 삽입 이상
INSERT INTO employee
VALUES
(NULL, NULL, NULL, NULL, 'D04', '마케팅부', '부산');
-- 사원이 없으면 부서 정보만 저장할 수 없는 문제가 발생한다.

INSERT INTO employee
VALUES
('E006', '마이클', '서울', '000', 'D01', '엉업', '서울');
-- 영업부 = 영업 -> 정상 처리되는 오류 발생

-- 3) 삭제 이상
DELETE
FROM employee
WHERE emp_no = 'E005';
-- D03(인사부) 관련 데이터가 모두 사라진다.
-- - 부서 자체가 없어지는 것은 아닌데, 부서 정보까지 함께 삭제된다.

-- 이상현상이 발생하는 쿼리는 개발자/분석가가 피해야 한다.
-- 이런 쿼리가 실행될 수 없도록 테이블 설계를 하면 좋다 -> 정규화

-- -> 상황에 따라서는 수집의 용이성, 경비, 프로세스의 간편화... 등으로 일부러 정규화하지 않는 경우도 있다. 