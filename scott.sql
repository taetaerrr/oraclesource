-- SQL 쿼리문은 대소문자를 구별하지 않음
-- 단, 비밀번호는 구별함
-- DML : 데이터 조작어(CRUD - CREATE / READ / UPDATE / D)

-- 1) 조회
-- SELCET 컬럼명
-- FROM 테이블명 -------------	 1
-- WHERE 조건절 -------------	 2
-- GROUP BY 컬럼명-----------	 3 
-- HAVING 집계함수 조건절 -----	 4
-- ORDER BY 컬럼명.. --------	 5


-- EMP(employee - 사원테이블)
-- DEPT(department - 부서테이블)
-- SALGRADE(급여테이블)

-- 전체 조회
SELECT * FROM  EMP;

-- 선택조회
-- 1) 칼럼 지정
SELECT
	EMPNO,
	ENAME,
	MGR
FROM
	EMP e; 

-- 중복 제거 후 조뢰 : distinct
SELECT DISTINCT DEPTNO 
FROM EMP e;

-- 별칭
SELECT
	EMPNO AS "사원번호"
FROM
	EMP e;

SELECT  EMPNO "사원번호"
FROM EMP e;

-- 글자 사이 공백이 있으면 ""필수
SELECT  EMPNO "사원 번호"
FROM EMP e;

-- 1년 급여
SELECT
	EMPNO,
	ENAME,
	SAL,
	COMM,
	SAL * 12 + COMM AS "연봉"
FROM
	EMP e ;

-- 조회 후 정렬(오름차순 - asc, 내림차순 - desc)
-- sal 내림차순
SELECT ENAME ,SAL 
FROM EMP e 
ORDER BY SAL DESC ;

-- sal 오름차순(asc 생략 가능)
SELECT ENAME ,SAL 
FROM EMP e 
ORDER BY SAL;

-- empno 내림차순
SELECT *
FROM EMP e 
ORDER BY EMPNO DESC ;

-- deptno 오름차순, sal 내림차순
SELECT
	*
FROM
	EMP e
ORDER BY
	DEPTNO ASC,
	SAL DESC ;

SELECT
	MGR AS MANAGER,
	SAL AS SALARY,
	COMM AS COMMISION,
	EMPNO AS EMPLOYEE_NO,
	DEPTNO AS DEPARTMENT_NO,
	ENAME AS EMPLOYEE_NAME
FROM
	EMP e
ORDER BY
	DEPTNO DESC,
	ENAME ASC;

-- 선택조회
-- 2) 조건 지정
-- SELECT 컬럼나열,... FROM 테이블명 WHERE 조건 나열

-- 부서번호가 30번인 사원 전체 조회
SELECT *
FROM EMP e 
WHERE DEPTNO = 30;

-- 사원번호가 7839 인 사원 조회
-- 사원번호 중복되지 않음
-- WHERE 조건으로 중복되지 않는 값이 사용된다면 결과는 하나만 조회됨
SELECT * FROM EMP e 
WHERE EMPNO = 7839;

-- 부서번호가 30이고(and) 직책이 SALESMAN 인 원 조회
-- 문자열은 홑따음표만 사용
SELECT * FROM  EMP e  WHERE  DEPTNO = 30 AND JOB ='SALESMAN';

-- 사원번호가 7698 이고 부서번호가 30인 사원조회
SELECT *FROM  EMP e WHERE EMPNO =7698 AND DEPTNO = 30;

-- 부서번호가 30이거나 사원직책이 CLERK 인 사원 조회
SELECT * FROM  EMP e  WHERE DEPTNO =30 OR JOB = 'CLERK';

-- 연봉이 36000 인 사원조회
-- SAL(월)*12 =36000
SELECT *FROM EMP e WHERE E.SAL * 12 =36000;

-- 급여가 3000보다 큰 사원 조회
SELECT *FROM EMP e WHERE E.SAL >3000;

-- 급여가 3000이상인 사원 조회
SELECT *FROM EMP e WHERE E.SAL >=3000;

-- ENAME이 F 이후의 문자열로 시작하는 사원 조회 F포함
SELECT *FROM EMP e WHERE E.ENAME >='F';

-- 급여가 2500 이상이고 직업이 ANALYST 인 사원 조회
SELECT *FROM EMP e WHERE E.SAL >= 2500 AND JOB = 'ANALYST';

-- JOB이 MANAGER,SALESMAN,CLERK인 사원조회
SELECT *FROM EMP e WHERE E.JOB = 'MANAGER'OR E.JOB= 'SALESMAN'OR E.JOB= 'CLERK';

-- SAL 이 3000이 아닌 사원 조회
-- 아니다 !=, <>, ^=
SELECT *FROM EMP e WHERE E.SAL != 3000;

SELECT *FROM EMP e WHERE E.SAL <> 3000;

SELECT *FROM EMP e WHERE E.SAL ^= 3000;

-- IN 
SELECT *FROM EMP e WHERE E.JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

-- JOB 이 'MANAGER', 'SALESMAN', 'CLERK'가 아닌 사원

SELECT *FROM EMP e WHERE E.JOB <> 'MANAGER' AND E.JOB != 'SALESMAN' AND E.JOB ^= 'CLERK';
SELECT *FROM EMP e WHERE E.JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');

-- 부서번호가 10번 이거나 20번인 사원 조회
SELECT *FROM EMP e WHERE E.DEPTNO IN ('10','20');

-- BETWEEN A AND B : 일정 범위 내의 데이터 조회 시 사용
-- 급여가 2000이상이고 3000이하인 직원 조회
SELECT 
*FROM EMP e 
WHERE e.SAL BETWEEN 2000 AND 3000;

-- NOT BETWEEN A AND B : 일정 범위 가 아닌 데이터 조회 시 사용
-- 급여가 2000이상 3000이하가 아닌 직원 조회
SELECT 
*FROM EMP e 
WHERE e.SAL NOT BETWEEN 2000 AND 3000;

-- LIKE 연산자와 와일드 카드(%, _)
-- ENAME = 'JONES' : 전체 일치
-- ENAME 이 J 로 시작하는 OR A 가 들어간 : 부분일치 LIKE

-- J로 시작하면 그 뒤에 어떤 문자가 몇개가 오던지 상관 없음
SELECT *FROM EMP e WHERE ENAME LIKE 'J%';

-- _J% : J 앞에 어떤 문자로 시작해도 상관없으나 개수는 하나 / 두번째 문자는 무조건 J / 그 뒤에 어떤 문자가 몇개가 오던지 상관 없음
SELECT *FROM EMP e WHERE ENAME LIKE '_J%';

SELECT *FROM EMP e WHERE ENAME LIKE '_L%';

-- 사원명에 AM 문자가 포함된 사원 조회

SELECT *FROM EMP e WHERE ENAME LIKE '%AM%';

SELECT *FROM EMP e WHERE ENAME NOT LIKE '%AM%';

-- IS NULL
-- SELECT *FROM EMP e WHERE COMM =NULL ; -- X

SELECT *FROM EMP e WHERE COMM IS NULL;
SELECT *FROM EMP e WHERE COMM IS NOT NULL;

-- 집합 연산자
-- UNION : 합집합(결과 값의 중복 제거)
-- UNION ALL : 합집합(중복해서 나옴)
-- MINUS : 차집합
-- INTERSECT : 교집합

-- 부서번호가 10번인 사원 조회(사번 이름 급여 부서번호)
-- 부서번호가 20번인 사원 조회(사번 이름 급여 부서번호) => 컬럼이 동일 해야 함

SELECT E.EMPNO,E.ENAME ,E.SAL, E.DEPTNO 
FROM EMP e 
WHERE E.DEPTNO =10
UNION 
SELECT E.EMPNO,E.ENAME ,E.SAL, E.DEPTNO 
FROM EMP e 
WHERE E.DEPTNO = 20;



SELECT E.EMPNO,E.ENAME ,E.SAL, E.DEPTNO 
FROM EMP e 
WHERE E.DEPTNO =10
UNION ALL
SELECT E.EMPNO,E.ENAME ,E.SA, E.DEPTNO 
FROM EMP e 
WHERE E.DEPTNO = 10;



SELECT E.EMPNO, E.ENAME ,E.SAL, E.DEPTNO 
FROM EMP e 
MINUS 
SELECT E.EMPNO, E.ENAME ,E.SAL, E.DEPTNO 
FROM EMP e 
WHERE E.DEPTNO = 10;

SELECT E.EMPNO,E.ENAME ,E.SAL, E.DEPTNO 
FROM EMP e 
INTERSECT
SELECT E.EMPNO, E.ENAME ,E.SAL, E.DEPTNO 
FROM EMP e 
WHERE E.DEPTNO = 10;



























