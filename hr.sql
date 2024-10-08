-- EMPLOYEES (scott 계정의 emp 테이블 원본)
-- EMPLOYEES 전체 조회
SELECT * FROM EMPLOYEES e ;
-- EMPLOYEES 의 first_name, last_name, job_id
SELECT FIRST_NAME, LAST_NAME, JOB_ID
FROM EMPLOYEES e; 

-- 사원번호가 176 인 사원의 LAST_NAME, 부서 번호 조회
SELECT EMPLOYEE_ID, LAST_NAME,DEPARTMENT_ID
FROM EMPLOYEES e 
WHERE EMPLOYEE_ID  = 176;

-- 연봉이 12000이상 되는 직원들의 LAST_NAME 과 연봉 조회
SELECT  LAST_NAME , SALARY 
FROM EMPLOYEES e 
WHERE SALARY >= 12000;
-- 연봉이 5000~12000 범위가 아닌 사람들의 LAST_NAME과 연봉조회
SELECT LAST_NAME , SALARY 
FROM EMPLOYEES e 
WHERE SALARY <5000 OR SALARY >12000;

-- 20번 혹은 50번 부서에서 근무하는 사원들의 LAST_NAME,부서번호를 조회
-- 단, 이름의 오름차순, 부서의 오름차순으로 정렬
SELECT LAST_NAME , DEPARTMENT_ID 
FROM EMPLOYEES e WHERE DEPARTMENT_ID  IN(20,50)
ORDER BY LAST_NAME ASC,DEPARTMENT_ID ASC ; 

-- 커미션을 버는 사원들의 LAST_NAME SALARY COMMISION_PCT를 조회
-- 단, 연봉의 내림차순 커미션 내림차순으로 정렬
SELECT LAST_NAME , SALARY ,COMMISSION_PCT 
FROM EMPLOYEES e 
WHERE E.COMMISSION_PCT > 0
ORDER BY SALARY DESC,COMMISSION_PCT DESC;

-- 연봉이 2500,3500,7000 이 아니며 JOB_ID가 SA_REP OR ST_CLERK인 사원 조회
SELECT *FROM EMPLOYEES e 
WHERE 
	E.SALARY NOT IN (2500, 3500, 7000) AND E.JOB_ID IN( 'SA_REP' , 'SH_CLERK');

-- 2018/02/20 ~ 2018/05/01 사이에 고용된 직원들의 LAST_NAME,EMPLOYEES_ID, 고용일자(HIRE_DATE) 조회
SELECT E.LAST_NAME ,E.EMPLOYEE_ID ,E.HIRE_DATE 
FROM EMPLOYEES e 
WHERE E.HIRE_DATE >= '2018-02-20' AND E.HIRE_DATE <= '2018-05-01';

SELECT LAST_NAME ,E.EMPLOYEE_ID ,E.HIRE_DATE 
FROM EMPLOYEES e 
WHERE E.HIRE_DATE BETWEEN  '2018-02-20' AND '2018-05-01';

-- 2015년에 고용된 사원조회
SELECT *
FROM EMPLOYEES e 
WHERE E.HIRE_DATE >= '2015-01-01'  AND E.HIRE_DATE <= '2015-12-31';

SELECT *
FROM EMPLOYEES e 
WHERE E.HIRE_DATE BETWEEN  '2015-01-01' AND '2015-12-31';

--20번 혹은 50번 부서에서 근무하며, 연봉이 5000~12000사이인 직원들의
--FIRST_NAME,LAST-NAME, 연봉 오름차순 조회
SELECT FIRST_NAME , LAST_NAME , DEPARTMENT_ID 
FROM EMPLOYEES e WHERE DEPARTMENT_ID  IN(20,50) AND e.SALARY BETWEEN 5000 AND 12000
ORDER BY DEPARTMENT_ID ASC ; 

-- 연봉이 5000~12000 사이가 아닌 직원들의 정보조회
SELECT *
FROM EMPLOYEES e 
WHERE SALARY NOT BETWEEN 5000 AND 12000;

-- LIKE
-- LAST NAME에 U 가포함되는 사원들의 사번, LASTNAME 조회
SELECT EMPLOYEE_ID ,LAST_NAME 
FROM EMPLOYEES e 
WHERE LAST_NAME LIKE '%u%';

-- LAST NAME의 네번째 글자가 A인 사원들의 사번, LASTNAME 조회
SELECT EMPLOYEE_ID ,LAST_NAME 
FROM EMPLOYEES e 
WHERE LAST_NAME LIKE '___a%';

-- LAST NAME에  a or e사원들의 사번, LASTNAME 조회 단 lastname 오름차순
SELECT EMPLOYEE_ID ,LAST_NAME 
FROM EMPLOYEES e 
WHERE LAST_NAME LIKE '%a%' OR LAST_NAME LIKE'%e%'
ORDER BY LAST_NAME ;

-- LAST NAME에  a and e사원들의 사번, LASTNAME 조회 단 lastname 오름차순
SELECT EMPLOYEE_ID ,LAST_NAME 
FROM EMPLOYEES e 
WHERE LAST_NAME LIKE '%a%' and  LAST_NAME LIKE '%e%'
ORDER BY LAST_NAME ;

-- IS NULL
-- MANAGER_ID 가 없는 사원들의 LASTNAME및 JOBID 조회
SELECT E.LAST_NAME ,E.JOB_ID 
FROM EMPLOYEES e 
WHERE MANAGER_ID IS NULL ;

-- JOBID가 STCLERK가 아닌 사원이 없는 부서 조회
-- 단, 부서번호가 NULL인 경우는 제외
SELECT DISTINCT DEPARTMENT_ID 
FROM EMPLOYEES e 
WHERE JOB_ID NOT IN('ST_CLERK') AND JOB_ID IS NOT NULL ;

--COMISSION PCT NULL이 아닌 사원들중 COMISION = SALARY * COMMISION PCT를 구함
-- 사원번호 FIRSTNAME ,JOBID 와 함께조회
SELECT SALARY * COMMISSION_PCT AS COMMISSION ,EMPLOYEE_ID , FIRST_NAME , JOB_ID 
FROM EMPLOYEES e 
WHERE COMMISSION_PCT IS NOT NULL ;

-- 부서 80의 사원에 적용 가능한 세율 표시하기
-- LAST_NAME, SALARY, TAX_RATE
-- TAX_RATE = SALARY / 2000 후 버림
--		    	해당 값이 0이면 0.0 /1, 0.09 / 2, 0.20 / 3, 0.30 / 4, 0.40 / 5, 0.42 / 6, 0.44 / 그외 0.45
SELECT
	E.LAST_NAME ,
	E.SALARY ,
	WHEN TRUNC(E.SALARY / 2000) = 0 THEN '0.0'
	WHEN TRUNC(E.SALARY / 2000) = 1 THEN '0.09'
	WHEN TRUNC(E.SALARY / 2000) = 2 THEN '0.20'
	WHEN TRUNC(E.SALARY / 2000) = 3 THEN '0.30'
	WHEN TRUNC(E.SALARY / 2000) = 4 THEN '0.40'
	WHEN TRUNC(E.SALARY / 2000) = 5 THEN '0.42'
	WHEN TRUNC(E.SALARY / 2000) = 6 THEN '0.44'
	ELSE '0.45'
	END AS TAX_RATE
FROM
	EMPLOYEES e ;

SELECT TRUNC(E.SALARY / 2000)
FROM EMPLOYEES e 



SELECT
	E.LAST_NAME ,
	E.SALARY ,
	DECODE(TRUNC(SALARY / 2000),
		0, 0.00,
		1, 0.09,
		2, 0.20,
		3, 0.30,
		4, 0.40,
		5, 0.42,
		6, 0.44,
		0.45
		) AS TAX_RATE
FROM
	EMPLOYEES E;


-- 회사 내의 최대 연봉 및 최소 연봉의 차이를 출력
SELECT MAX(SALARY)-MIN(SALARY) AS SALARY 
FROM EMPLOYEES e ;

-- 매니저로 근무하는 사원드르이 총 숫자를 출력
SELECT COUNT(DISTINCT E.MANAGER_ID)AS 매니저수 
FROM EMPLOYEES e ;

--매니저가 없는 사원들은 제외하고 매니저가 관리하는
-- 사원들 중에서 최소 급여를 받는 사원 조회
-- 매니저가 관리하는 사원중에서 연봉이 6천 미만 제외
SELECT MANAGER_ID , MIN(SALARY) 
FROM EMPLOYEES e 
GROUP BY MANAGER_ID 
HAVING MANAGER_ID IS NOT NULL AND MIN(SALARY) >= 6000
ORDER BY MANAGER_ID ;


-- JOIN
-- 자신의 담당 매니저의 고용일보다 빠른 입사자 찾기
-- 사원번호, 입사일 이름 매니저 아이디 출력
SELECT E1.EMPLOYEE_ID, E1.HIRE_DATE  ,E1.LAST_NAME ,E2.MANAGER_ID 
FROM EMPLOYEES e1 JOIN EMPLOYEES e2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID 
AND E2.HIRE_DATE >E1.HIRE_DATE 

--도시 이름이 T로 시작하는 지역에 사는 사원드릐 정보 조회
--사원번호 이름 부서번호 지역명
SELECT E.EMPLOYEE_ID ,E.LAST_NAME ,D.DEPARTMENT_ID ,L.CITY 
FROM EMPLOYEES e JOIN DEPARTMENTS d ON E.DEPARTMENT_ID = D.DEPARTMENT_ID JOIN LOCATIONS l 
ON D.LOCATION_ID = L.LOCATION_ID 
WHERE L.CITY LIKE 'T%';

--각 부서별 사원 수 평균연봉(소수점2자리)
-- 부서명 부서위치아이디 부서별 사원수 평균연봉
-- EMPLOYESS DEPARTMENT
SELECT D.DEPARTMENT_NAME  ,D.LOCATION_ID ,COUNT(E.EMPLOYEE_ID) AS COUNT, ROUND(AVG(E.SALARY),2) AS AVG
FROM EMPLOYEES e JOIN DEPARTMENTS d ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
GROUP BY D.DEPARTMENT_NAME , D.LOCATION_ID 
ORDER BY D.LOCATION_ID ;


--  EXECUTIVE 부서에 근무하는 모든 사원들의 부서번호 이름 JOBID 조회
-- EMPLYES DARTMENT
SELECT e.DEPARTMENT_ID , E.LAST_NAME , E.JOB_ID 
FROM EMPLOYEES e JOIN DEPARTMENTS d ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
WHERE D.DEPARTMENT_NAME ='Executive';


-- 기존의 직무를 계속하고잇는 사원조회
 -- 사원번호 JOB ID
-- EMP JOBHIS
SELECT E.LAST_NAME , E.EMPLOYEE_ID , E.JOB_ID 
FROM EMPLOYEES e JOIN JOB_HISTORY jh ON E.EMPLOYEE_ID = JH.EMPLOYEE_ID 
AND E.JOB_ID = JH.JOB_ID ;


--각 사원별 소속부서에서 자신보다 늦게고용되엇으나 많은 급여를 받는 사원의 정보
-- 부서번호 FIRS LAST연결 출력 급여 입사일
-- EMPL SELF 조인
SELECT
	DISTINCT E1.DEPARTMENT_ID ,
	E1.FIRST_NAME || ' ' || E1.LAST_NAME AS NAME ,
	E1.SALARY ,
	E1.HIRE_DATE
FROM
	EMPLOYEES e1
JOIN EMPLOYEES e2 ON
	E1.DEPARTMENT_ID = E2.DEPARTMENT_ID
	AND e2.HIRE_DATE > e1.HIRE_DATE
	AND E2.SALARY > E1.SALARY
ORDER BY
	E1.DEPARTMENT_ID;



--서브 쿼리로 작성
--  EXECUTIVE 부서에 근무하는 모든 사원들의 부서번호 이름 JOBID 조회
SELECT
	e.DEPARTMENT_ID ,
	E.LAST_NAME ,
	E.JOB_ID
FROM
	EMPLOYEES e
WHERE
	(E.DEPARTMENT_ID,
	'Executive') IN (
	SELECT
		d.department_id ,
		d.department_name
	FROM
		DEPARTMENTS d);












































































