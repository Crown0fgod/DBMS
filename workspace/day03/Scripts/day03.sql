SELECT * FROM EMPLOYEES e ;


-- DUAL 테이블 : 다른 테이블을 참조할 필요 없이 
-- 값을 확인하고 싶을 때 사용할 수 있는 테이블
-- (오라클에서 지원해준다.)
SELECT 10 || 20 RES
FROM DUAL; --  정수 연결 정수 -> 문자

-- 문자열타입 
-- 항상 작은 따옴표를 써줘야한다.
-- 중간에 공백을 들어가지 않는다.
SELECT '츄파츕스' || '요거트 스트로베리'
FROM DUAL; --  문자 연결 문자 -> 문자

-- 테이블을 이용해서 연결 연산자 실습.
SELECT FIRST_NAME || LAST_NAME AS 풀네임
FROM EMPLOYEES e ;

-- 날짜 타입 연결 문자든 숫자든 결과는 -> 문자
SELECT HIRE_DATE || '에 취업'
FROM EMPLOYEES e 

--[실습]
-- 사원의 이름과 메일 주소를 출력해라
-- 이때 이름은 FIRST_NAME 과 LAST_NAME이 띄어쓰기로 이어져있고,
-- 메울 주소는 EMAIL@GMAIL.COM 이다.

SELECT FIRST_NAME ||' '|| LAST_NAME 이름 , 
	EMAIL || '@GAMIL.COM' 메일주소
FROM EMPLOYEES e ;

--===================================================

--산술 연산자
-- (+,-,*,/)

-- 산술 연산자는 피연산자로 문자가 올 수 없다.
SELECT 10 + '번'
FROM DUAL; 

-- 날짜타입의 연산
-- 날짜와 정수의 연산에서 정수는 DAY이다.
SELECT HIRE_DATE , 
	HIRE_DATE  + 10, -- 에서 정수 1은 하루를 의미한다.
	HIRE_DATE + 10,
	HIRE_DATE - 10
	--10 - HIRE_DATE 날짜 타입이 먼저 와야한다.
FROM EMPLOYEES e ;

-- 날짜와 날짜의 연산

-- SYDATE
-- 현재 날짜와 시간 정보를 가지고 있으며
-- 오라클에서 제공해준다.
SELECT SYSDATE 
FROM DUAL;

-- 날짜와 날짜의 연산은 뺄셈만 지원한다.

SELECT HIRE_DATE ,
	SYSDATE ,
	SYSDATE - HIRE_DATE 
	-- SYSDATE + HIRE_DATE -- 에러가 난다.
FROM EMPLOYEES e ;

SELECT SYSDATE ,
	SYSDATE + 0.5 ,-- 12시간
	SYSDATE - 12/24, -- 12시간
	SYSDATE - 10 / 60 / 24, -- 10분
	SYSDATE - 1 / 60 / 60 / 24 --1초
FROM DUAL;

--===================================================

-- 관계 연산자, WEHER 절 

-- 직원의 이름, 성, 봉급을 조회한다.
-- 단, 봉급이 10000 이상인 직원 정보만 조회

SELECT FIRST_NAME , LAST_NAME , SALARY 
FROM EMPLOYEES
WHERE SALARY >= 10000;
-- 해당 조건이 TRUE인 행만 가지고 온다.

--정렬 추가
SELECT FIRST_NAME , LAST_NAME , SALARY 
FROM EMPLOYEES
WHERE SALARY >= 10000
ORDER BY SALARY;

--[실습]
-- 직원의 이름, 성을 조회한다.
-- 단, 이름이 DAVID인 직원만 골라서 조회한다.

SELECT FIRST_NAME , LAST_NAME 
FROM EMPLOYEES
WHERE FIRST_NAME = 'David';

--===================================================

-- SQL 실행 순서 

SELECT FIRST_NAME 이름,
	LAST_NAME 성,
	SALARY 봉급 
FROM EMPLOYEES
WHERE SALARY >= 10000  --SQL실행 순서때문에 오류가 난다.
ORDER BY SALARY 


SELECT FIRST_NAME 이름,		-- 3번 원하는 컬럼을 조회
	LAST_NAME 성,			-- 각 컬럼에 별칭을 부여
	SALARY 봉급 
FROM EMPLOYEES				-- 1번 EMPLOYEES 테이블에서
WHERE 봉급 >= 10000  			-- 2번 봉급이 10000 이상인 데이터만 가져와라 (EMPLOYEES에 봉급이라는 별칭이 없어 불러올수 없음(봉급이 뭐야? 오류)
ORDER BY SALARY 			-- 4번 봉급 기준으로 오름차순 정렬
							-- SELECT 절에서 별칭이 부여가 되어있는 상황
		
--===================================================

-- SQL 연산자

-- BETWEEN a AND b 

-- 직원 테이블에서 
-- 봉급이 10,000 이상 12,000 이하인 직원의
-- 이름, 성, 봉급을 봉급 오름차순으로 조회

SELECT FIRST_NAME ,
	LAST_NAME ,
	SALARY 
FROM EMPLOYEES
WHERE SALARY BETWEEN 10000 AND 12000
ORDER BY SALARY ;


-- 직원 테이블에서 
-- 봉급이 10,000 혹은 11,000 혹은 12,000 인 직원의
-- 이름, 성, 봉급을 봉급 오름차순으로 조회

SELECT FIRST_NAME ,
	LAST_NAME ,
	SALARY 
FROM EMPLOYEES
WHERE SALARY IN(10000,11000, 12000)
ORDER BY SALARY ;

--===================================================

-- LIKE 
-- % : ~ 아무거나 

SELECT FIRST_NAME 
FROM EMPLOYEES 
WHERE FIRST_NAME LIKE '%e';

-- _ : 자릿수 

SELECT FIRST_NAME 
FROM EMPLOYEES 
WHERE FIRST_NAME LIKE '____e'; -- e로 끝나는 5글자 이름만 출력

-- '%e%' -> 그냥 e가 있으면 true

SELECT FIRST_NAME 
FROM EMPLOYEES 
WHERE FIRST_NAME LIKE '%e%';

-- '%en%'	-> en이 있으면 true

-- '%e%n%'	-> e와 n 을 포함하면 true (순서대로 e -> n)

-- '%e_n%'	-> e와 n사이에 무조건 한글자가 더 있으면 true 

--===================================================

-- COMMISSION_PCT 에 NULL이 있는걸 확인
SELECT * FROM EMPLOYEES;

-- NULL을 이용한 연산의 결과는 항상 NULL
SELECT NULL + 10 
FROM DUAL;

-- 직원 테이블에서
-- 할인률이 NULL인 직원의
-- 이름과 성과 할인률을 조회

SELECT FIRST_NAME ,
	LAST_NAME ,
	COMMISSION_PCT 
FROM EMPLOYEES
WHERE COMMISSION_PCT = NULL;
-- NULL의 연산의 결과는 NULL이기 때문에 우리가 원하는대로 실행되지 않는다.

SELECT FIRST_NAME ,
	LAST_NAME ,
	COMMISSION_PCT 
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL; --(NULL인걸 출력)

SELECT FIRST_NAME ,
	LAST_NAME ,
	COMMISSION_PCT 
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL; --(NULL이 아닌걸 출력)

--===================================================

-- 논리 연산자 

-- 직원 테이블에서 
-- 부서가 영업부서이면서, 봉급이 10000 이상인 직원들의 
-- 이름, 성, 봉급, 부서ID를
-- 봉급 오름차순으로 조회하기

SELECT * FROM EMPLOYEES;

SELECT FIRST_NAME ,
	LAST_NAME ,
	SALARY, 
	DEPARTMENT_ID 
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80 AND SALARY >= 10000 --(영업부서인 직원들 출력)
ORDER BY SALARY ;


-- 직원 테이블에서 
-- 부서가 영업부서 아니면서, 봉급이 10000 이상인 직원들의 
-- 이름, 성, 봉급, 부서ID를
-- 봉급 오름차순으로 조회하기

SELECT * FROM EMPLOYEES;

SELECT FIRST_NAME ,
	LAST_NAME ,
	SALARY, 
	DEPARTMENT_ID 
FROM EMPLOYEES
WHERE NOT DEPARTMENT_ID = 80 AND SALARY >= 10000 --(영업부서가 아닌 직원들 출력)
ORDER BY SALARY ;






