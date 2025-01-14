SELECT * FROM EMPLOYEES; 

-- 조합키 
CREATE TABLE TBL_FLOWER( 
	FLOWER_NAME VARCHAR2(1000),
	FLOWER_COLOR VARCHAR2(1000),
	FLOWER_PRICE NUMBER,
	CONSTRAINT PK_FLOWER PRIMARY KEY(FLOWER_NAME, FLOWER_COLOR)
);

INSERT INTO TBL_FLOWER
VALUES('장미', '검정',5000);

INSERT INTO TBL_FLOWER
VALUES('장미', '빨강',5000);

INSERT INTO TBL_FLOWER
VALUES('튤립', '빨강',1500);

INSERT INTO TBL_FLOWER
VALUES('튤립', '빨강',4500); -- 오류! 조합키 2개의 컬럼이 모두 일치함.


SELECT * FROM TBL_FLOWER;

--=================================================================

-- 강사님과 함께 하는 모델링 예제
-- 5. 구현
CREATE TABLE TBL_PHONE(
   PHONE_SERIAL_NUMBER VARCHAR2(500),
   PHONE_COLOR VARCHAR2(500),
   PHONE_SIZE NUMBER,
   PHONE_PRICE NUMBER,
   PHONE_PRODUCTION_DATE DATE,
   PHONE_SALE NUMBER,
   CONSTRAINT PK_PHONE PRIMARY KEY(PHONE_SERIAL_NUMBER)
);

CREATE TABLE TBL_CASE(
   CASE_SERIAL_NUMBER VARCHAR2(500),
   CASE_COLOR VARCHAR2(500),
   CASE_PRICE NUMBER,
   PHONE_SERIAL_NUMBER VARCHAR2(500),
   CONSTRAINT PK_CASE PRIMARY KEY(CASE_SERIAL_NUMBER),
   CONSTRAINT FK_CASE FOREIGN KEY(PHONE_SERIAL_NUMBER)
   REFERENCES TBL_PHONE(PHONE_SERIAL_NUMBER)
);

--=================================================================

-- 내가 직접하는 모델링 실습
/*
CREATE TABLE TBL_MEMBER(
	MEMBER_NUMBER VARCHAR2(500),
	MEMBER_NAME VARCHAR2(500),
	MEMBER_AGE NUMBER,
	MEMBER_PHONE_NUMBER VARCHAR2(500),
	MEMBER_ADDRESS VARCHAR2(500)
	CONSTRAINT PK_MEMBER PRIMARY KEY(MEMBER_NUMBER)
);

CREATE TABLE TBL_BOOK(
	BOOK_NUMBER VARCHAR2(500),
	BOOK_NAME VARCHAR2(500),
	BOOK_KIND VARCHAR2(500),
	CONSTRAINT PK_BOOK PRIMARY KEY(BOOK_NUMBER),
	CONSTRAINT FK_BOOK FOREIGN KEY(BOOK_NAME)
	REFERENCES TBL_MEMBER(MEMBER_NUMBER)
	-- check문을 적어 장르에 들어가는 목록까지 작성해줘야됨.
);
*/

--=================================================================

-- 강사님께서 풀어본 모델링 실습 

DROP TABLE TBL_MEMBER;
DROP TABLE TBL_BOOK;

CREATE TABLE TBL_MEMBER(
   MEMBER_ID NUMBER,
   MEMBER_NAME VARCHAR2(500) NOT NULL,
   MEMBER_AGE NUMBER NOT NULL,
   MEMBER_PHONE VARCHAR2(500) NOT NULL,
   MEMBER_ADDRESS VARCHAR2(500) NOT NULL,
   CONSTRAINT PK_MEMBER PRIMARY KEY(MEMBER_ID),
   CONSTRAINT UK_MEMBER UNIQUE(MEMBER_PHONE)
);

CREATE TABLE TBL_BOOK(
   BOOK_ID NUMBER,
   BOOK_NAME VARCHAR2(500) NOT NULL,
   BOOK_GENRE VARCHAR2(500),
   MEMBER_ID NUMBER,
   CONSTRAINT PK_BOOK PRIMARY KEY(BOOK_ID),
   CONSTRAINT FK_BOOK FOREIGN KEY(MEMBER_ID)
   REFERENCES TBL_MEMBER(MEMBER_ID),
   CHECK(BOOK_GENRE IN ('인문학', '추리', 'IT', '로맨스'))
);

SELECT * FROM TBL_MEMBER;
SELECT * FROM TBL_BOOK;

-- 관계를 맺은 테이블 들의 DML 

SELECT * FROM TBL_PHONE;
SELECT * FROM TBL_CASE;

INSERT INTO HR.TBL_PHONE
(PHONE_SERIAL_NUMBER, PHONE_COLOR, PHONE_SIZE, PHONE_PRICE, PHONE_PRODUCTION_DATE, PHONE_SALE)
VALUES('S23-001', 'GREEN', 7, 200, '2023-02-11', 0);

-- DATE 타입의 컬럼에 문자타입의 값을 'YYYY-MM-DD'의 형태로 넣으면
-- 자동으로 DATE 타입으로 변환되어 들어간다.

INSERT INTO HR.TBL_PHONE
(PHONE_SERIAL_NUMBER, PHONE_COLOR, PHONE_SIZE, PHONE_PRICE, PHONE_PRODUCTION_DATE, PHONE_SALE)
VALUES('S23-002', 'WHITE', 7, 200, SYSDATE, 0);

INSERT INTO HR.TBL_PHONE
(PHONE_SERIAL_NUMBER, PHONE_COLOR, PHONE_SIZE, PHONE_PRICE, PHONE_PRODUCTION_DATE, PHONE_SALE)
VALUES('S23-003', 'BLACK', 7, 200, '2023/02/15', 0);

-- 자식 테이블에도 값 INSERT
INSERT INTO TBL_CASE
VALUES('ABC', 'WHITE', 10000, 'S23-004'); -- 오류! 부모(TBL_PHONE)에 없는 값을 참조함.

INSERT INTO TBL_CASE
VALUES('ABC', 'WHITE', 10000, 'S23-001');

INSERT INTO TBL_CASE
VALUES('DEF', 'BALCK', 12000, 'S23-002');

SELECT * FROM TBL_PHONE;
SELECT * FROM TBL_CASE;













