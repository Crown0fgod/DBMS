SELECT * FROM PLAYER;

/*
 	롤백 테스트!
 	
 	PLAYER 테이블에서 TEAM_ID가 'K01'인 선수 이름을 내 이름으로 바꾸기
 	단, 메뉴얼 커밋이어야한다!
   
 */

UPDATE PLAYER  
SET PLAYER_NAME = '김진수'
WHERE TEAM_ID = 'K01';

SELECT * FROM PLAYER
WHERE TEAM_ID = 'K01';

--========================================================

-- 함수 

-- 숫자와 관련된 집계함수 
-- 집계함수 : 결과 행이 1개, WHERE절에는 사용불가
-
/*
  평균 : AVG()
  총합 : SUM()
  최대값 : MAX()
  최솟값 : MIN ()
  갯수 : COUNT ()
 */

SELECT AVG(HEIGHT), 
	SUM(WEIGHT), 
	COUNT(PLAYER_ID) 
FROM PLAYER; 

-- NULL을 포함하지 않는다.
-- 일반적으로 COUNT()를 할 때는 PK를 전달해준다.
SELECT COUNT(HEIGHT) FROM PLAYER; 

-- PLAYER 테이블에서 키가 입력되지 않은 친구는 몇 명일까요?
-- HEIGHT 컬럼이 NULL인 사람은 몇 명일까요?

-- 가상의 테이블 개념!
SELECT COUNT(PLAYER_ID) 
FROM PLAYER  
WHERE HEIGHT IS NULL; 

--========================================================

-- GROUP BY 
/*
 * GROUP BY : ~ 별(예 : 포지션 별 평균 키)
 * GROUP BY 컬럼명
 * HAVING 조건식 
 */

-- PLAYER 테이블에 어떤 포지션이 있는지 확인 
SELECT DISTINCT "POSITION"
FROM PLAYER;

/*
 * 오류 발생! 포지션의 종류는 NULL까지 5가지
 * 5개의 행으로 모든 정보를 본다는 것은 말이 되지 않기에, 에러가 난다.
 */
SELECT *
FROM PLAYER
GROUP BY "POSITION";

/*
 * 포지션을 GROUP BY로 묶어준다면, 묶어주는 포지션 컬럼을 조회한다.
 * 반드시 조회를 해야하는 것은 아니지만 무엇을 기준으로 그룹을 지었는지 알기 쉽다.
 */
-- 포지션 별 평균 키 
SELECT "POSITION" , AVG(HEIGHT)
FROM PLAYER
GROUP BY "POSITION";

-- HAVING 에서는 집계함수 사용가능!
SELECT "POSITION" , AVG(HEIGHT) 
FROM PLAYER
GROUP BY "POSITION"
HAVING AVG(HEIGHT) > 180;

-- 정렬까지 추가
SELECT "POSITION" , AVG(HEIGHT) 평균키 
FROM PLAYER
GROUP BY "POSITION"
HAVING AVG(HEIGHT) > 180
ORDER BY 평균키;

-- WHERE 추가 
-- 키가 180 이상인 축구 선수들의 포지션 별 평균 키가 180을 초과하는 
-- 포지션을 구하고 , 평균 키 오름차순으로 조회하라
SELECT "POSITION" , AVG(HEIGHT) 평균키 
FROM PLAYER
WHERE HEIGHT >= 180
GROUP BY "POSITION"
HAVING AVG(HEIGHT) > 180
ORDER BY 평균키;


-- 실습 

-- PLAYER 테이블에서 몸무게가 80 이상인 선수들의
-- 평균 키가 180 초과인 포지션 검색 

SELECT "POSITION"  , AVG(HEIGHT)
FROM PLAYER
WHERE WEIGHT >= 80
GROUP BY "POSITION"  
HAVING AVG(HEIGHT) > 180;


-- EMPLOYEES 테이블에서 JOB_ID별 평균 SALARY가
-- 10000 미만인 JPB_ID 검색 
-- JOB_ID는 알파벳 순으로 정렬

SELECT "JOB_ID" , AVG(SALARY) 알파벳순
FROM EMPLOYEES
WHERE SALARY < 10000
GROUP BY "JOB_ID" 
HAVING AVG(SALARY)
ORDER BY 알파벳순;

-- 강사님께서 적은 코드
SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID 
HAVING AVG(SALARY) < 10000
ORDER BY JOB_ID;



-- 실습 

/*
 * PLAYER 테이블 실습
 * 1. PLAYER_ID가 2007로 시작하는 선수들 중
 * POSITION 별 평균 키를 조회 
 */

SELECT "POSITION" , AVG(HEIGHT) -- 포지션과 키의 평균을 선택
FROM PLAYER -- player 테이블에서 
WHERE PLAYER_ID LIKE '2007%'-- PLAYER_ID 의 2007인 사람들을 %로 선택하여 따로 빼옴.
GROUP BY "POSITION"; -- 포지션을 그룹으로 묶음
--==========================================================
 /*
 * 2. 선수들 중 포지션이 DF인 선수들의 평균 키를 TEAM_ID 별로 조회하고 
 * 평균 키 오름차순으로 정렬하기 
 */
--==========================================================
SELECT TEAM_ID ,
	AVG(HEIGHT)
FROM PLAYER 
WHERE "POSITION" = 'DF'
GROUP BY TEAM_ID 
ORDER BY AVG(HEIGHT);
--==========================================================
-- 강사님께서 적은 1번 문제 실습
SELECT "POSITION" , AVG(HEIGHT)
FROM PLAYER  
WHERE PLAYER_ID LIKE '2007%'
GROUP BY "POSITION"; 

-- 강사님께서 적은 2번 문제 실습
SELECT TEAM_ID , AVG(HEIGHT) 평균키
FROM PLAYER
WHERE "POSITION" = 'DF'
GROUP BY TEAM_ID 
ORDER BY  평균키;
--==========================================================

/*
 * 3번 문제
 * 포지션이 MF인 선수들의
 * 입단연도 별 평균 몸무게, 평균키를 구하는데,
 * 컬럼명은 입단연도, 평균 몸무게,평균 키로 표시한다.
 * 입단연도를 오름차순으로 정렬한다.
 * 단, 평균 몸무게는 70이상 그리고 평균 키는 160 이상인 입단연도만 조회
 */

SELECT "JOIN_YYYY" 입단연도,
AVG(WEIGHT) 몸무게, 
AVG(HEIGHT) 키 -- 입단연도, 평균 몸무게, 평균 키 를 선택 (알리아스를 통해 명칭도 변경)
FROM PLAYER -- PLAYER 테이블에서 
WHERE "POSITION" = 'MF' -- 포지션에서 MF인 사람들
GROUP BY JOIN_YYYY -- 입단연도를 그룹으로 묶음
HAVING AVG(WEIGHT) >= 70 AND AVG(HEIGHT) >= 160 -- 그룹에 조건식이 있으므로 HAVING절 사용
ORDER BY 입단연도; -- 입단연도 오른차순

SELECT * FROM PLAYER;
--==========================================================
-- 강사님께서 적은 3번 문제 실습
SELECT JOIN_YYYY 입단연도,
	AVG(WEIGHT) "평균 몸무게",
	AVG(HEIGHT) "평균 키" 
FROM PLAYER
WHERE "POSITION" = 'MF'
GROUP BY JOIN_YYYY 
HAVING AVG(WEIGHT) >= 70 AND AVG(HEIGHT) >= 160
ORDER BY 입단연도;


/*
 * 4번 문제 
 * EMPLOYEE 테이블에서 COMMISSION_PCT 별 평균 급여를 조회한다.
 * COMMISSION_PCT 를 오름차순으로 정렬하며
 * HAVING절을 사용하여 NULL은 제외한다.
 */

SELECT COMMISSION_PCT , --COMMISSION_PCT 의 평균급여 선택
	AVG(SALARY)
FROM EMPLOYEES -- EMPLOYEES 테이블에서
GROUP BY COMMISSION_PCT -- COMMISSION_PCT로 그룹으로 묶음
HAVING COMMISSION_PCT IS NOT NULL -- 그룹에 NULL 제외 조건이 있으므로 HAVING절과 IS NOT NULL을 사용
ORDER BY COMMISSION_PCT; -- COMMISSION_PCT를 오름차순으로 정렬

-- 강사님께서 적은 4번 문제 

SELECT COMMISSION_PCT , AVG(SALARY) 
FROM EMPLOYEES
GROUP BY COMMISSION_PCT 
HAVING COMMISSION_PCT IS NOT NULL
ORDER BY COMMISSION_PCT;


