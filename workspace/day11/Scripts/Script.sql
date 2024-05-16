-- JOIN 

SELECT * FROM EMP e ;
SELECT * FROM DEPT d; 

-- 관계를 맺고 있는 EMP 테이블과 DEPT 테이블을 한 번에 조회
-- 관계를 맺고 있는 테이블들이기 때문에, 등가 조인을 이용하면 효율적이겠다. 

-- ※ 행의 갯수가 더 작은 테이블을 선행 테이블로 선정한다. (성능면에서 행의 갯수가 더 작은게 좋다) 
-- 속도와 성능의 차이 때문


-- 별칭을 줘서 ON절에서 어느 테이블의 컬럼인지를 구분할 수 있다.
SELECT *
FROM DEPT D JOIN EMP E 
ON D.DEPTNO = E.DEPTNO (가상의 테이블이됨.)
WHERE DNAME = 'SALES'; (SALES라는 부서이름만 골라낼때) 
(WHERE절과 AND절을 써도 상관없다.)


-- ON절에 논리연산을 추가하여 여러 개의 조건을 추가할 수 있다.
SELECT * 
FROM DEPT D JOIN EMP E
ON D.DEPTNO = E.DEPTNO 
AND DNAME = 'SALES';


-- 열 골라내기 
-- 우리가 원하는 정보만 뽑을 수 있다.
SELECT ENAME 이름, 
	SAL 봉급, 
	DNAME 부서, 
	LOC 근무지
FROM DEPT D JOIN EMP E
ON D.DEPTNO = E.DEPTNO 
AND DNAME = 'SALES';

-- 실습 
-- 1. 테이블의 관계를 파악하기 
-- 2. 관계를 맺은 테이블이라면, 컬럼 이름들을 확인
-- 3. 선행 테이블로 삼을 테이블 선택 

-- 1번 문제 
-- PLAYER 테이블에서 송종국 선수가 속한 팀의 전화번호 검색하기
-- 송종국, 팀 이름, 팀의 전화번호

SELECT PLAYER_NAME 선수이름,
	TEAM_ID '팀 이름',	
FROM PLAYER p 
WHERE 

--====================================================
-- 강사님께서 적은 1번 문제 
SELECT COUNT(*) FROM PLAYER; -- 480
SELECT COUNT(*) FROM TEAM; -- 15 > 선행!

SELECT PLAYER_NAME 이름,
   T.TEAM_NAME "팀 이름",
   T.TEL "팀 전화번호"
FROM TEAM t JOIN PLAYER p 
ON T.TEAM_ID = P.TEAM_ID 
AND PLAYER_NAME = '송종국';

--====================================================

-- 2번 문제
-- JOBS 테이블에서 JOB_ID로 직원들의 JOB_TITLEL, EMAIL, 성, 이름 조회

SELECT JOB_TITLE ,
	EMAIL,

FROM JOBS j JOIN JOB_ID
ON
AND 


-- 강사님께서 적은 2번 문제 
SELECT COUNT(*) FROM JOBS; -- 19 > 선행
SELECT COUNT(*) FROM EMPLOYEES; -- 107

SELECT JOB_TITLE, EMAIL, FIRST_NAME, LAST_NAME 
FROM JOBS j JOIN EMPLOYEES e  
ON J.JOB_ID = E.JOB_ID;

--====================================================
-- 3번 문제 
-- 축구 선수들 중에서 각 팀 별로 키가 가장 큰 선수들의 전체 정보 조회 

SELECT COUNT(*) PLAYER_NAME -- 480개
FROM PLAYER p ;

SELECT COUNT(*) TEAM -- 15팀
FROM TEAM t ;

SELECT HEIGHT 
FROM PLAYER p ;

SELECT PLAYER_NAME ,
	TEAM_ID ,
	MAX(HEIGHT)
	--(SELECT MAX(HEIGHT) FROM PLAYER p)
FROM TEAM t JOIN PLAYER p 
ON T.TEAM_ID = P.PLAYER_NAME 
AND PLAYER_NAME = (
	SELECT MAX(HEIGHT)
	FROM PLAYER p2 
)
GROUP BY "PLAYER_NAME" ;

-- 강사님께서 적은 3번 문제 

SELECT P.TEAM_ID , M.큰키, P.HEIGHT , P.PLAYER_NAME 
FROM 
(
	SELECT TEAM_ID, MAX(HEIGHT) 큰키
	FROM PLAYER 
	GROUP BY TEAM_ID
) M JOIN PLAYER p 
ON M.TEAM_ID = P.TEAM_ID 
AND M.큰키 = P.HEIGHT 
ORDER BY M.TEAM_ID;

-- 위 문제를 JOIN없이 풀기 
-- (A,B) IN (C,D) : A = C AND B = D

SELECT * FROM PLAYER
WHERE (TEAM_ID,HEIGHT) IN (
	SELECT TEAM_ID ,MAX(HEIGHT)
	FROM PLAYER
	GROUP BY TEAM_ID 

);

--====================================================
-- EMPLOYEES 테이블에서 각 사원의 매니저 이름을 출력해보자
-- 사원 이름, 매니저 이름 

SELECT * FROM EMPLOYEES;

-- SELF JOIN에 대한 예제 
SELECT E1.FIRST_NAME , E2.FIRST_NAME  
FROM EMPLOYEES e1 JOIN EMPLOYEES e2
ON E1.MANAGER_ID = E2.EMPLOYEE_ID;

--====================================================

-- 외부 조인(OUTER JOIN)
CREATE TABLE TBL_GRADE(
   GRADE_NUM NUMBER,
   GRADE_NAME VARCHAR2(1000),
   CONSTRAINT PK_GRADE PRIMARY KEY(GRADE_NUM)
);

CREATE TABLE TBL_USER_LIST(
   USER_NUM NUMBER,
   USER_ID VARCHAR2(1000),
   GRADE_NUM NUMBER,
   CONSTRAINT PK_USER_LIST PRIMARY KEY(USER_NUM),
   CONSTRAINT FK_USER_LIST FOREIGN KEY(GRADE_NUM)
   REFERENCES TBL_GRADE(GRADE_NUM)
);

INSERT INTO TBL_GRADE
VALUES(3, 'NORMAL');

INSERT INTO TBL_USER_LIST
VALUES(2, '홍길동', 3);

-- INNER JOIN
SELECT *
FROM TBL_GRADE tg JOIN TBL_USER_LIST tul
ON TG.GRADE_NUM = TUL.GRADE_NUM;

-- OUTER JOIN
SELECT *
FROM TBL_GRADE tg LEFT OUTER JOIN TBL_USER_LIST tul
ON TG.GRADE_NUM = TUL.GRADE_NUM;

SELECT *
FROM TBL_GRADE tg RIGHT OUTER JOIN TBL_USER_LIST tul
ON TG.GRADE_NUM = TUL.GRADE_NUM;

-- 두 테이블의 모든 행 조회
SELECT *
FROM TBL_GRADE tg FULL OUTER JOIN TBL_USER_LIST tul
ON TG.GRADE_NUM = TUL.GRADE_NUM;

-- CROSS
-- JOIN 할 때 조건이 없을 때 유용하게 사용할 수 있다.
SELECT *
FROM TBL_GRADE tg CROSS JOIN TBL_USER_LIST tul;
















