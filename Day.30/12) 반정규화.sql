-- 1. 반정규화(Denormalization)
-- JOIN을 줄여 조회 속도를 높이는 것이 목적

-- 6) 이력 데이터 중복(History Duplication)
CREATE TABLE member (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(30),
    password VARCHAR(100),
    password_changed_at DATETIME
);

CREATE TABLE password_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    password VARCHAR(100),
    changed_at DATETIME,

    FOREIGN KEY(member_id)
        REFERENCES member(member_id)
);

INSERT INTO member VALUES
(1001,'홍길동','pw1234',NOW()),
(1002,'김철수','abcd1234',NOW());

SELECT * FROM member;

UPDATE member
SET password = '1234'
WHERE member_id = 1001;

INSERT INTO password_history(member_id, password, changed_at) VALUES(1001, '1234', NOW());

SELECT * FROM member;
SELECT * FROM password_history; -- password 변경 이력

-- 
SELECT * FROM password_history
WHERE member_id = 1001 and password = '1234';

UPDATE member
SET password = '0000'
WHERE member_id = 1001;

INSERT INTO password_history(member_id, password, changed_at) VALUES(1001, '0000', NOW());

SELECT * FROM member;
SELECT * FROM password_history; -- password 변경 이력