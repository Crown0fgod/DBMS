/* CASE */


/*
 EMPLOYEES 테이블에서
 부서 ID가 50인 부서는 기존 급여에서 10% 삭감
 부서 ID가 80인 부서는 기존 급여에서 10% 인상
 나머지는 그대로인 컬럼을 하나 만들어서 조회해보자.

결과 컬럼 : 이름, 부서 ID 기존급여, 조정급여
*/

SELECT FIRST_NAME 이름,
	DEPARTMENT_ID 부서,
	SALARY 기존급여,
	CASE 
		WHEN DEPARTMENT_ID = 50 THEN SALARY * 0.9
		WHEN DEPARTMENT_ID = 80 THEN SALARY * 1.1
		ELSE SALARY
	END 조정급여
FROM EMPLOYEES;
-- CASE 조건은 위부터 검사하고, TRUE가 뜨면 끝
-- 자바의 ELSE IF 를 떠올리자!

-- CASE 실습 

/*
 * EMP테이블에서 사원들의 번호, 이름, 급여와 
 * 최종 급여 컬럼을 같이 조회한다.
 * 최종 급여는 커미션(COMM)이 존재하면 봉급과 더하고 
 * 커미션이 존재하지 않는다면 100을 더해준다.
 * 조회 결과는 최종급여 오름차순으로 정렬한다.
 * */


SELECT * FROM EMP;

SELECT EMPNO 사원번호,
	ENAME 이름,
	SAL 급여,
	CASE 
		WHEN COMM THEN SAL + COMM
		WHEN COMM THEN SAL + 100
	END 최종급여
	
FROM EMP;

--======================================================================
-- 강사님께서 적은 실습 문제
SELECT EMPNO 번호,
   ENAME 이름,
   SAL 급여,
   COMM,
   CASE 
      WHEN COMM IS NOT NULL THEN SAL+COMM
      ELSE SAL+100
   END 최종급여
FROM EMP
ORDER BY 최종급여;

/* 실습 
 * EMP 테이블의 사원 정보를 가져온다.
 * 이 때 SAL가 높은 순으로 정렬하고 비고 컬럼을 만든다.
 * 비고 컬럼에는 급여 순위가 
 * 1~5등 이면 상 
 * 6~10등 이면 중
 * 나머지는 하를 넣는다.
 */

SELECT SAL 급여
FROM EMP e 
ORDER BY SAL
ALTER TABLE EMP ADD NULL VARCHAR(4);

--======================================================================
-- 강사님께서 적은 실습 문제

SELECT ROWNUM, E.* ,
   CASE
      WHEN ROWNUM BETWEEN 1 AND 5 THEN '상'
      WHEN ROWNUM BETWEEN 6 AND 10 THEN '중'
      ELSE '하'
   END 등급
FROM (
   SELECT *
   FROM EMP
   ORDER BY SAL DESC
) E;

--======================================================================

/*
 * EMP 테이블의 사원들의 사원번호, 이름, 부서번호,급여,지역을 조회한다.
 * 이 때 영업부서는(SALSES) 급여를 30% 인상
 * RESEARCH 부서는 급여를 20% 인상하여 조회한다.
 */

-- 서브쿼리 내부에서 JOIN을 사용하면 같은 컬럼명을 벼링으로 각각 뽑을 수 없다.
-- 서브쿼리의 SELET에 원하는 컬럼만 직접 명시해서 조회하거나
-- 따로 조회하여 별칭을 주고 가져와야함.
SELECT EMPNO, ENAME, 부서번호,
	CASE DNAME
		WHEN 'SALES' THEN SAL * 1.3
		WHEN 'RESEARCH' THEN SAL * 1.2
		ELSE SAL
	END 급여,
	LOC
FROM 
(
	SELECT D.DEPTNO 부서번호, D.*, E.*
	FROM DEPT D JOIN EMP E 
	ON D.DEPTNO = E.DEPTNO
);





















































