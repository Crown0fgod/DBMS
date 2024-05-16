-- PLAYER 테이블에서 키가 NULL인 선수들의 키를 170으로 변경하고 평균 조회

SELECT COUNT(*) HEIGHT FROM PLAYER;

--============================================
--강사님께서 적은 1번 문제 코드 

SELECT AVG(NVL(HEIGHT , 170)) 
FROM PLAYER;


-- AVG함수를 쓰지 않고 PLAYER 테이블에서 선수들의 평균키 구하기
-- 단, NULL은 미포함






--============================================
--강사님께서 적은 2번 문제 코드 

SELECT SUM(HEIGHT)/COUNT(HEIGHT) 
FROM PLAYER;

/*
 * DEPT 테이블의 LOC별 평균 급여를 셋 째 자리에서 반올림한 값과 각 LOC별 SAL합을 조회
 */






--============================================
--강사님께서 적은 3번 문제 코드 

SELECT LOC , ROUND(AVG(SAL),2) , SUM(SAL)
FROM DEPT d JOIN EMP e
ON D.DEPTNO  = E.DEPTNO 
GROUP BY LOC;

/*
 * PLAYER 테이블에서 팀별 최대 몸무게인 선수 전체 정보 검색
 */







--============================================
--강사님께서 적은 4번 문제 코드 

SELECT P2.*
FROM
(
   SELECT TEAM_ID, MAX(WEIGHT) WEIGHT
   FROM PLAYER
   GROUP BY TEAM_ID
) P1 JOIN PLAYER P2
ON P1.TEAM_ID = P2.TEAM_ID 
AND P1.WEIGHT = P2.WEIGHT
ORDER BY P1.TEAM_ID;

/*
 * EMP테이블에서 HIREDATE가 FORD의 입사년도와 같은 사원 전체 정보 조회
 */






--============================================
--강사님께서 적은 5번 문제 코드 

SELECT * FROM EMP e 
WHERE ENAME = 'FORD';

SELECT * FROM EMP e 
WHERE HIREDATE BETWEEN '1981-01-01' AND '1981-12-31';

-- 서브쿼리 

SELECT * FROM EMP 
WHERE TO_CHAR(HIREDATE, 'YYYY') = (
	SELECT TO_CHAR(HIREDATE, 'YYYY') 
	FROM EMP	
	WHERE ENAME = 'FORD'
);

--조인 

SELECT * 
FROM EMP e1 JOIN 
(
	SELECT HIREDATE 
	FROM EMP 
	WHERE ENAME = 'FORD'
) E2
ON TO_CHAR(E1.HIREDATE,'YYYY')= TO_CHAR(E2.HIREDATE,'YYYY');  

--======================================================================

-- 형변환 함수 
-- TO_CHAR()

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') -- 특수문자만 가능 
FROM DUAL;


-- 한글과의 콜라보 
SELECT TO_CHAR(SYSDATE, 'YYYY"년 "MM"월 "DD"일 "') 
FROM DUAL;


SELECT TO_CHAR(SYSDATE, 'YYYY"년 "MM"월 "DD"일 "HH24"시 "MI"분 "SS"초"') 
FROM DUAL;

-- 숫자에 콤마찍기 

SELECT 1000000000000
FROM DUAL;

SELECT TO_CHAR(1000000000000000000, 'FM9,999,999,999,999,999,999') 숫자
FROM DUAL;

--======================================================================

-- 집합 
-- EMP 테이블에서 DEPTNO 가 30 또는 10인 데이터를 조회하기
-- 두 테이블을 UNION으로 연결한다.

SELECT * FROM EMP e 
WHERE DEPTNO = 30
UNION
SELECT * FROM EMP e 
WHERE DEPTNO = 10;

-- UNION으로 다른 테이블의 값들도 같이 조회할 수 있을까?
-- 안된다.

--컬럼의 수가 달라서 에러!
SELECT * FROM EMP e 
UNION 
SELECT * FROM DEPT d ;

-- 컬럼의 수가 같을때 
-- 자료형이 달라서 오류!
SELECT ENAME , HIREDATE , SAL 
FROM EMP e 
UNION
SELECT * FROM EMP e ;


-- 자료형이 같을 때 실행됨.
SELECT EMPNO , ENAME , JOB 
FROM EMP e 
UNION
SELECT * FROM DEPT d;


-- 가상의 테이블이라는 것을 인지!
SELECT  COUNT(*)
FROM 
( 
SELECT EMPNO , ENAME , JOB 
FROM EMP e 
UNION
SELECT * FROM DEPT d
);



SELECT EMPNO , ENAME , JOB 
FROM EMP e 
UNION
SELECT * FROM 
(SELECT * FROM DEPT d
ORDER BY DEPTNO 
);

--======================================================================

-- VIEW 

-- PLAYER 테이블에서 나이 컬럼을 추가한 뷰 만들기 

SELECT * FROM PLAYER ;

CREATE VIEW VIEW_PLAYER AS 
SELECT P.*,ROUND((SYSDATE -  BIRTH_DATE)/ 365) AGE FROM PLAYER p ; 

SELECT * FROM VIEW_PLAYER;

-- 매뉴얼 커밋 하고! 실습!
SELECT * FROM VIEW_PLAYER
WHERE PLAYER_NAME = '류호근';

INSERT INTO HR.VIEW_PLAYER
(PLAYER_ID, PLAYER_NAME, TEAM_ID, E_PLAYER_NAME, NICKNAME, JOIN_YYYY, "POSITION", BACK_NO, NATION, BIRTH_DATE, SOLAR, HEIGHT, WEIGHT)
VALUES('AB', '류호근', 'K01', 'DD', 'DD', 'DD', 'DD', 3, 'DD', SYSDATE, 'D', 0, 0);

SELECT * FROM PLAYER
WHERE PLAYER_NAME = '류호근';
-- 오토커밋으로 다시 컴백!

--======================================================================

-- 실습 1,2문제 

-- EMP 테이블에서 사원의 이름과 그 사원의 매니저 이름이 있는 VIEW 만들기 
-- 사원 번호와 매니저 정보도 같이 조회 

SELECT D.ENAME , E.MGR
FROM DEPT d JOIN EMP e 
ON D.DNAME = E.ENAME;

--======================================================================

-- 강사님께서 적은 1번 문제 
SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.ENAME 
FROM EMP e1 JOIN EMP e2
ON E1.MGR = E2.EMPNO;



-- PLAYER 테이블에서 TEAM_NAME 컬럼을 추가한 VIEW 만들기 

SELECT * FROM PLAYER;

/*
CREATE VIEW TEAM_NAME AS
SELECT P.PLAYER
FROM PLAYER p;
*/

CREATE VIEW TEAM_NAME AS 
SELECT P. * FROM PLAYER p ;


SELECT * FROM TEAM_NAME tn ;














