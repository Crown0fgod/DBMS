
-- 주석 (CTRL + /)(자바와 같은 주석 단축키)
-- 대소문자를 구분하지 않는다.
-- 일반적으로 오라클은 대문자로 작업하는 경우가 많다.
-- SELECT -> 조회라는 뜻(CRUD에서 R(READ)를 의미한다.)
-- CRUD (CREATE, READ, UPDATE, DELETE)

SELECT * FROM EMPLOYEES;

-- SELECT 를 사용하여 EMPLOYEES 테이블의 
--FIRST_NAME 컬럼과 LAST_NAME 컬럼을 선택하여 조회해보자.

SELECT FIRST_NAME, LAST_NAME  
FROM EMPLOYEES; --EMPLOYEES에서 HR.이 생략되있는 상태

--[실습]

-- 직원의 성 이름 휴대전화번호 이메일주소 사원번호를 한번에 조회하기
-- 순서대로 조회되어야 함.
 
SELECT LAST_NAME , FIRST_NAME , 
	PHONE_NUMBER , EMAIL , 
	EMPLOYEE_ID 
FROM EMPLOYEES;  

SELECT * FROM EMPLOYEES;

-- 정렬해서 조회하기 
-- ORDER BY 절 
-- 사원의 이름,성, 봉급을 낮은 순서부터 조회(오름차순)
SELECT FIRST_NAME ,LAST_NAME ,SALARY 
FROM EMPLOYEES
ORDER BY SALARY ASC;  -- 무조건 EMPLOYEES 밑으로 와야된다.
-- ORDER BY 정렬하겠다. SALARY 기준 ASC 오름차순

SELECT FIRST_NAME ,LAST_NAME ,SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC; -- 내림차순

-- SQL의 자료형 타입 -> NUMBER (숫자), VARCHAR2 (문자), DATE(날짜)

-- 직원의 이름 성 고용일 고용일 순서로 정렬
SELECT FIRST_NAME , LAST_NAME , HIRE_DATE 
FROM EMPLOYEES
ORDER BY HIRE_DATE DESC ;

-- 이름순으로 정렬
SELECT FIRST_NAME , LAST_NAME , HIRE_DATE 
FROM EMPLOYEES
ORDER BY FIRST_NAME;

SELECT FIRST_NAME , SALARY , HIRE_DATE 
FROM EMPLOYEES e 
ORDER BY SALARY, FIRST_NAME DESC;

-- 조회하는 컬럼이 아닐지라도, 
-- 정렬기준으로 삼을 수 있다.
SELECT FIRST_NAME , LAST_NAME 
FROM EMPLOYEES
ORDER BY SALARY;

-- 중복 제거하는 법 (DISTINCT)
SELECT DISTINCT JOB_ID -- JOB_ID (직급)
FROM EMPLOYEES;

SELECT DISTINCT JOB_ID , HIRE_DATE  
FROM EMPLOYEES;

-- 별칭 부여하기, 별명 부여하기
SELECT FIRST_NAME AS "이름" , -- ALIAS 알리아스
	LAST_NAME AS "성",
	SALARY AS "봉급" ,
	EMPLOYEE_ID AS "사원 번호" 
FROM EMPLOYEES;

-- AS 생략 가능
-- " " <- 생략 가능
-- 단, 별명에 공백이 포함되어 있다면 
-- 별명의 시작과 끝을 쌍따옴표를 씌워서 알려줘야 한다.
SELECT FIRST_NAME 이름 , -- ALIAS 알리아스
	LAST_NAME 성,
	SALARY "봉급" ,
	EMPLOYEE_ID "사원 번호" -- 공백이 필요할땐 "" 를 써야 "~~~" 가 알리아스라는 것을 컴퓨터에서 인식 시켜줌
FROM EMPLOYEES;




-- SELECT절에서 조회하는 컬럼의 순서에 맞게 번호가 매겨진다.
-- 1부터 순차적으로 부여된다. (0은 안됨. 헷갈림 주의!)
-- 컬럼에 부여된 별명으로 정렬도 가능하다.
SELECT FIRST_NAME 이름 , 
	SALARY 봉급, 
	HIRE_DATE 고용일 
FROM EMPLOYEES e 
ORDER BY 봉급, FIRST_NAME DESC, 3;
















