-- SQL 쿼리문은 대소문자를 구별하지 않음
-- 단, 비밀번호는 구별함
-- DML : 데이터 조작어(CRUD - CREATE / READ / UPDATE / DELETE)

-- 1) 조회
-- SELCET 컬럼명 ------------	 5
-- FROM 테이블명 -------------	 1
-- WHERE 조건절 -------------	 2
-- GROUP BY 컬럼명-----------	 3 
-- HAVING 집계함수 조건절 -----	 4
-- ORDER BY 컬럼명.. --------	 6


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

-- ##############################

-- 데이터베이스 서버 : 오라클
-- 질의문(sol)을 작성 => 결과



-- 함수
-- 1. 오라클 내장 함수
-- 2. 사용자 정의 함수(PL/SQL)

-- 오라클 내장 함수
-- 1. 단일행 함수 : 데이터가 한 행 씩 입력되고 입력된 한 행당 결과가 하나씩 나오는 함수
-- 2. 다중행 함수 : 여러 행이 입력되고 결과가 하나의 행으로 반환되는 함수

-- 1. 문자함수
-- UPPER(문자열) : 괄호 안 문자열을 모두 대문자로
-- LOWER(문자열) : 괄호 안 문자열을 모두 소문자로
-- INITCAP(문자열) : 괄호 안 문자 데이터중 첫문자만 대문자, 나머지는 소문자로
-- LENGTH(문자열) : 문자열 길이
-- LENGTH(문자열) : 문자열 바이트 수
-- SUBSTR(문자열,시작위치)/ SUBSTR(문자열,시작위치,추출길이)
-- INSTR(문자열,찾으려는 문자) ㅣ 특정 문자나 문자열이 어디에 포함되어 있는지
-- INSTR(문자열,찾으려는 문자 위치 찾기를 시작할 대상 문자열 데이터 위치, 시작위치에서 찾으려는 문자가 몇 번째 인지)
-- REPLACE(문자열,찾는문자,대체문자)
-- CONCAT(문자열1, 문자열2)
-- TRIM / LTRIM / RTRIM : 특정 문자를 제거


-- 데이터는 대소문자 구분함
-- oracle = ORACLE
SELECT E.ENAME , UPPER(E.ENAME), LOWER(E.ENAME), INITCAP(E.ENAME) 
FROM EMP e ;

SELECT *FROM EMP e ;

--smith
SELECT *
FROM EMP e
WHERE UPPER(ENAME)= UPPER('smith') ;

SELECT *
FROM EMP e
WHERE UPPER(ENAME) LIKE UPPER('%smith%') ;


-- DUAL : 오라클에서 제공하는 기본 테이블(함수 적용 결과 보기)
-- LENGTH / LENGTHB(바이트 물어보는거)
SELECT LENGTH('한글'), LENGTHB('한글'), LENGTH('AB'), LENGTHB('AB')
FROM  DUAL;

SELECT JOB, SUBSTR(JOB,1,2), SUBSTR(JOB,3,2), SUBSTR(JOB,5) 
FROM EMP e ;

--   - : 오른쪽 끝을 의미
SELECT JOB, SUBSTR(JOB,-LENGTH(JOB)), SUBSTR(JOB,-LENGTH(JOB),2), SUBSTR(JOB,-3) 
FROM EMP e ;

SELECT 
INSTR('HELLO, ORACLE!', 'L') AS INSTR_1, 
INSTR('HELLO, ORACLE!', 'L',5) AS INSTR_2, 
INSTR('HELLO, ORACLE!', 'L',2,2) AS INSTR_3
FROM DUAL;

--사원이름에 S가 있는 행 구하기
--LIKE

--INSTR
SELECT 
INSTR(ENAME,'S') 
FROM EMP e ;

-- 010-1234-1535
SELECT ('010-1234-1535') AS '변경전',
REPLACE ('010-1234-1535', '-', ' ')AS '공백',
REPLACE ('010-1234-1535', '-')AS '-제거'
FROM DUAL;

-- EMPNO, ENAME 연결 조회
-- CONCAT(EMPNO,CONCAT(':', ENAME))
SELECT CONCAT(EMPNO,ENAME),CONCAT(EMPNO,CONCAT(':',ENAME)) 
FROM EMP e ;

-- || == CONCAT
SELECT EMPNO  || ENAME , EMPNO || ':' || ENAME 
FROM  EMP e ;

SELECT
	'[' || TRIM(' _Oracle_ ') || ']' AS TRIM, 
	'[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
	'[' || LTRIM(' <_Oracle_>', '_<') || ']' AS LTRIM2,
	'[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
	'[' || RTRIM(' <_Oracle_ >', '>_') || ']' AS RTRIM2
FROM
	DUAL;

-- 숫자함수
-- ROUND(숫자,[반올림위치]) 
-- TRUNC(숫자,[버림위치])
-- CEIL(숫자) : 지정한 숫자와 가장 가까운 큰 점수 찾기
-- FLOOR(숫자) : 지정한 숫자와 가장 가까운 작은 정수 찾기
-- MOD(숫자,나눌숫자) == %

SELECT
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678, 0) AS ROUND_0,
	ROUND(1234.5678, 1) AS ROUND_1,
	ROUND(1234.5678, 2) AS ROUND_2,
	ROUND(1234.5678,-1) AS ROUND_MINUS1,
	ROUND(1234.5678,-2) AS ROUND_MINUS2
FROM
	DUAL;

-- 지정한 숫자

SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM DUAL;

SELECT MOD (15,6)
FROM DUAL;

-- 날짜함수
-- SYSDATE : 오라클 서버가 설치된 OS 시간
-- 날짜 데이터 + 숫자 : 날짜 데이터보다 숫자만큼 일 수 이후의 날짜
-- 날짜 데이터 - 날짜 데이터 : 일수 차이
-- 날짜 데이터 + 날짜 데이터 : 안됨 
-- ADD_MONTHS(날짜데이터, 더할 개월수)
-- MONTHS_BETWEEN(날짜데이터, 날짜데이터) : 두 날짜 데이터 간의 차이를 개월 수로 계산
-- NEXT_DAY(날짜데이터, 요일문자) : 날짜 데이터에서 돌아오는 요일의 날짜 반환
-- LAST_DAY(날짜데이터) : 이달의 마지막날 

SELECT  SYSDATE FROM DUAL;

SELECT SYSDATE , SYSDATE -1, SYSDATE +1 FROM DUAL;

SELECT SYSDATE , ADD_MONTHS(SYSDATE, 3) FROM DUAL; 

-- 입사 20 주년 조회

SELECT EMPNO ,ENAME ,HIREDATE ,ADD_MONTHS( HIREDATE, 240) 
FROM EMP e ;

SELECT
	EMPNO ,
	ENAME ,
	HIREDATE ,
	SYSDATE,
	MONTHS_BETWEEN(HIREDATE,SYSDATE) AS MONTH1,
	MONTHS_BETWEEN(SYSDATE,HIREDATE) AS MONTH2 ,
	TRUNC( MONTHS_BETWEEN(SYSDATE,HIREDATE))AS MONTH3 
FROM
	EMP e ;

SELECT SYSDATE ,NEXT_DAY(SYSDATE,'월요일'), LAST_DAY(SYSDATE)FROM DUAL; 

-- 형변환 함수 
-- TO_CHAR(날짜데이터, '출력되길 원하는 문자형태')
-- TO_NUMBER(문자데이터, '인식되길 원하는 숫자형태')
-- TO_DATE(문자데이터, '인식되길 원하는 날짜형태')

--NUMBER +'문자숫자' : 연산해줌
SELECT EMPNO ,ENAME ,EMPNO +'500'
FROM EMP e ;

-- 수치가 부적합합니다.
-- SELECT EMPNO ,ENAME ,EMPNO +'abcd'
-- FROM EMP e ;

-- 날짜데이터 => 문자데이터 
SELECT SYSDATE , TO_CHAR(SYSDATE, 'YYYY/MM/DD')AS 현재날짜
FROM DUAL;

SELECT
	TO_CHAR(SYSDATE, 'MM') AS 현재월,
	TO_CHAR(SYSDATE, 'MON') AS 현재월2,
	TO_CHAR(SYSDATE, 'MOMTH') AS 현재월3
FROM
	DUAL;

SELECT
	TO_CHAR(SYSDATE, 'DD') AS 일자,
	TO_CHAR(SYSDATE, 'DAY') AS 일자2,
FROM DUAL;

SELECT
	SYSDATE ,
	TO_CHAR(SYSDATE, 'HH:MI:SS') AS 현재시간,
	TO_CHAR(SYSDATE, 'HH12:MI:SS') AS 현재시간2,
	TO_CHAR(SYSDATE, 'HH24:MI:SS') AS 현재시간3, 
	TO_CHAR(SYSDATE, 'HH24:MI:SS AM') AS 현재시간4
	FROM DUAL;

-- 문자데이터 => 숫자데이터
SELECT 1300 - '1500', '1300' +1500
FROM DUAL;

SELECT '1300' + '1500'
FROM DUAL;

-- 수치가 부적합합니다(, 가 포함되면 문자로 처리)
-- SELECT '1,300' + '1,500'
-- FROM DUAL;

-- 9(숫자 한자리를 의미 : 빈자리는 채우지 않음) OR 0(숫자 한자리 : 빈자리를 채움)
SELECT TO_NUMBER('1,300','999,999') + TO_NUMBER('1,500','999,999')
FROM DUAL;

-- 문자데이터 => 날짜데이터
SELECT TO_DATE('2024-09-05', 'YYYY-MM-DD')AS TODATE1, TO_DATE('20240905', 'YYYY-MM-DD')AS TODATE2
FROM DUAL;

-- EMP 테이블에서 1981-06-01 이후에 입사한 사원 조회
SELECT *
FROM EMP e 
WHERE E.HIREDATE >= '1981-06-01';

SELECT *
FROM EMP e 
WHERE E.HIREDATE >= TO_DATE('1981-06-01');

-- 날짜데이터 + 날짜 데이터
-- 수치가 부적합합니다
-- SELECT '2024-09-05' - '2024-01-02'
-- FROM DUAL;

-- 날짜와 날짜의 가산은 할 수 없습니다
-- SELECT TO_DATE('2024-09-05') + TO_DATE('2024-01-02')
-- FROM DUAL;

SELECT TO_DATE('2024-09-05') - TO_DATE('2024-01-02')
FROM DUAL;

-- NULL 처리 함수
-- NULL 과 산술 연산이 안됨 => NULL 을 다른 값으로 변경
-- NVL(널값,대체할값)
-- NVL2(널값,널이 아닌경우 반환값,널인경우반환값)
-- SAL = NULL (X) IS (O)

SELECT EMPNO ,ENAME ,SAL ,COMM ,SAL +COMM , SAL +NVL(COMM,0) 
FROM EMP e ;

-- 널이 아니면 SAL*12+COMM
-- 널이면 SAL*12
SELECT EMPNO ,ENAME ,SAL ,COMM ,NVL2(COMM,'0','X') , NVL2(COMM, SAL*12+COMM , SAL*12) 
FROM EMP e ;

-- DECODE 함수 / CASE 문
-- DECODE (데이터,
--		조건1, 조건1을 만족할때 해야할것,
--		조건2, 조건2를 만족할때 해야할것,
--		) AS 별칭

-- JOB 이 MANAGER 라면 SAL * 1.1
-- JOB 이 SALESMAN 라면 SAL * 1.5
-- JOB 이 ALALYST 라면 SAL
--		그 외 라면 SAL * 1.03

SELECT
	E.EMPNO ,
	E.ENAME ,
	E.JOB ,
	E.SAL ,
	DECODE(JOB, 'MANAGER', E.SAL * 1.1,
	'SALESMAN', E.SAL * 1.5,
	'ALALYST', E.SAL,
	E.SAL * 1.03) AS UPSAL
FROM
	EMP e ;

SELECT
	E.EMPNO ,
	E.ENAME ,
	E.JOB ,
	E.SAL ,
	CASE
		JOB
	WHEN 'MANAGER' THEN E.SAL * 1.1
		WHEN 'SALESMAN' THEN E.SAL * 1.5
		WHEN 'ALALYST' THEN E.SAL
		ELSE E.SAL * 1.03
	END AS UPSAL
FROM
	EMP e ;

-- COMM 널일때 '해당사항없음'
-- COMM = 0 일때 '수당없음'
-- COMM > 0 일때 '수당 : COMM'

SELECT
	E.EMPNO ,
	E.ENAME ,
	E.COMM,
	CASE
		WHEN E.COMM IS NULL THEN '해당 사항없음'
		WHEN E.COMM = 0 THEN '수당없음' 
		WHEN E.COMM > 0 THEN '수당 : ' || E.COMM 
	END AS COMM_TEXT
FROM
	EMP e ;

-- EMP 테이블에서 사원들의 월 평균 근무일수는 21.5일이다. 하루 근무시간을 8시간으로 봤을 때
-- 사원들의 하루급여(DAY_PAY) 와 시급(TIME_PAY)를 계산하ㅏ여 결과를 출력한다
-- 사번 이름 SAL DAYPAY TIME PAY 출력
-- 단, 하루급여는 소수점 셋째자리에서 버리고, 시급은 두번째 소수점에서 반올림
SELECT
	E.EMPNO ,
	E.ENAME,
	E.SAL ,
	TRUNC( E.SAL / '21.5', 2) AS DAY_PAY,
	ROUND( E.SAL / '21.5' / '8', 1) AS TIME_PAY
FROM
	EMP e ;

-- EMP 테이블에서 사원들은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다. 사원들의
-- 정직원이 되는 날짜 R_JOB 을 YYYY-MM-DD 형식으로 출력
-- 사번 이름 고용일 RJOB을 출력
SELECT E.EMPNO ,E.ENAME ,E.HIREDATE ,ADD_MONTHS( HIREDATE ,3) AS R_JOB
FROM EMP e ;

-- + 추가수당
-- COMM이 없으면 'N/A', 있으면 COMM 출력
SELECT
	E.EMPNO ,
	E.ENAME,
	E.HIREDATE,
	NEXT_DAY(ADD_MONTHS(E.HIREDATE, 3),'월요일') AS R_JOB,
	CASE
		WHEN E.COMM IS NULL THEN 'N/A'
		WHEN E.COMM IS NOT NULL THEN E.COMM || ' '
	END AS COMM
FROM
	EMP e ;

-- ORA-01722: 수치가 부적합합니다
--SELECT COMM , NVL(COMM,'N/A') 
--FROM	EMP e ;


SELECT
	E.EMPNO ,
	E.ENAME,
	E.HIREDATE,
	NEXT_DAY(ADD_MONTHS(E.HIREDATE, 3),'월요일') AS R_JOB,
	NVL(TO_CHAR(E.COMM),'N/A') AS COMM 
FROM
	EMP e ;



-- EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원번호(MGR)를 변환해서 CHG_MGR에 출력
-- 사번 이름 MGR CHG_MGR 출력
-- CHG_MGR에 조건
-- MGR이 널이면 '0000'/ MGR의 앞두자리가 75이면'5555/76 6666/ 77 7777/ 78 8888로 출력
SELECT
	E.EMPNO ,
	E.ENAME ,
	E.MGR,
	CASE
		WHEN E.MGR IS NULL THEN '0000'
		WHEN E.MGR >= 7500 AND E.MGR < 7600 THEN '5555'
		WHEN E.MGR >= 7600 AND E.MGR < 7700  THEN '6666'
		WHEN E.MGR >= 7700 AND E.MGR < 7800  THEN '7777'
		WHEN E.MGR >= 7800 AND E.MGR < 7900  THEN '8888'
		WHEN E.MGR >= 7900 AND E.MGR < 8000  THEN '8888'
		END AS CHG_MGR
	FROM
		EMP e ;

SELECT E.EMPNO ,
	E.ENAME ,
	E.MGR,
	DECODE(SUBSTR(TO_CHAR(E.MGR),1,2),
		NULL, '0000',
		'75', '5555',
		'76', '6666',
		'77', '7777',
		'78', '8888',
		SUBSTR(TO_CHAR(E.MGR), 1) 
		) AS CHG_MGR
	FROM EMP e ;
	
	
-- WHEN E.MGR LIKE '75%' THEN '5555	
	
-- 다중행 함수
-- SUM(합계를 낼 열), COUNT(), MAX(), MIN(), AVG()
-- DISTINCT : 중복 제거

SELECT SUM(SAL)
FROM EMP e ;

SELECT SUM(DISTINCT SAL), SUM(ALL SAL), SUM(SAL)
FROM EMP e ;

SELECT COUNT(DISTINCT SAL), COUNT(ALL SAL), COUNT(SAL)
FROM EMP e ;

SELECT MAX(SAL), MIN(SAL) 
FROM EMP e ;

SELECT MAX(SAL), MIN(SAL) 
FROM EMP e 
WHERE DEPTNO  = 10;

-- 부서번호가 20인 사원의 최근 입사일
SELECT MAX(HIREDATE) 
FROM EMP e ;

SELECT AVG(DISTINCT SAL), AVG(ALL SAL), AVG(SAL)
FROM EMP e ;

-- 부서번호  30의 평균 추가 수당
SELECT AVG(COMM)
FROM EMP e 
WHERE DEPTNO  = 30;

-- GROUP BY : 결과값을 원하는 열로 묶어 출력
-- GROUP BY 그룹화할 열

-- 각 부서별 평균 급여 출력
SELECT DEPTNO ,AVG(SAL) 
FROM EMP e 
GROUP BY DEPTNO 
ORDER BY DEPTNO ;

-- 각 부서별 직책별 평균 급여 출력

SELECT DEPTNO, JOB ,AVG(SAL) 
FROM EMP e 
GROUP BY DEPTNO , JOB 
ORDER BY DEPTNO , JOB;

-- GROUP BY 표현식이 아닙니다.(GROUP BY 절을 사용할 때에는 SELECT 절에서 사용할 수 있는 열이 제한됨)
-- SELECT 가능 : GRUOP BY 쓰여진 열, 다중행함수
--SELECT ENAME , AVG(SAL) 
--FROM EMP e 
--GROUP BY DEPTNO ;

-- GROUP BY ~ HAVING : 그룹 바이 절에 조건을 줄때 사용
-- 각 부서의 직책별 평균 급여 (평균 급여가 2000이상인 그룹만 조회)
SELECT
	DEPTNO ,
	JOB,
	AVG(SAL)
FROM
	EMP e
GROUP BY
	DEPTNO ,
	JOB
HAVING
	AVG(SAL) >= 2000
ORDER BY
	DEPTNO ,
	JOB;


--그룹 함수는 허가되지 않습니다
--SELECT DEPTNO ,JOB,AVG(SAL) 
--FROM EMP e 
--WHERE AVG(SAL) >=2000 
--GROUP BY DEPTNO , JOB 
--ORDER BY DEPTNO ,JOB;

--부서별 평균급여 최고급여 최저급여 사원수
-- 평균급여 출력시 소수점 제외
SELECT
	DEPTNO ,
	TRUNC(AVG(SAL)),
	MAX(SAL),
	MIN(SAL),
	COUNT('SALESMAN')
FROM
	EMP e
GROUP BY
	DEPTNO
ORDER BY
	DEPTNO ;

-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수를 출력
SELECT
	JOB ,
	COUNT(JOB)
FROM
	EMP e
GROUP BY
	JOB
HAVING
	COUNT(JOB) >= 3
ORDER BY
	JOB;
-- 사원들의 입사년도를 기준으로 부서별로 몇명의 입사인원이 있는지 출력
-- 1987 20 2 (1987년도 20번 부서에 2명입사)
SELECT
	TO_CHAR(HIREDATE, 'YYYY')AS HIRE_YEAR ,
	DEPTNO ,
	COUNT(*) AS CNT
FROM
	EMP e
GROUP BY
	TO_CHAR(HIREDATE, 'YYYY'),
	DEPTNO
ORDER BY
	HIRE_YEAR,
	DEPTNO ;

-- JOIN(조인) : 두 개이상의 테이블을 연결하여 하나의 테이블 처럼 출력
-- 내부조인 
--  등가조인(*) : 테이블 연결 후 출력행을 각 테이블의 특정 열에 일치한 데이터를 기준으로 선정
--  비등가조인 
-- 외부조인 
-- 왼쪽 외부 조인 LEFT OUTER JOIN : 오른쪽 ㅌ이블에 + 기호
-- 오른쪽 외부 조인 RIGHT OUTER JOIN : 왼쪽 테이블에  + 기호
-- 전체 외부조인 FULL OUTER JOIN : X

-- SELECT *FROM EMP, DEPT ;

-- 1) 내부조인
-- 등가조인 : EMP 테이블의 DEPTNO와 DEPT 테이블의 DEPTNO가 일치시 연결


--열의 정의가 애매합니다 (조인시 동일한 필드명을 가지고 있을때)
SELECT E.EMPNO ,E.ENAME ,D.DEPTNO ,D.DNAME ,D.LOC 
FROM EMP e ,DEPT d 
WHERE E.DEPTNO = D.DEPTNO ;



-- +sal 3천 이상인 사원 조회
SELECT e.EMPNO ,e.ENAME ,d.DEPTNO ,d.DNAME 
FROM EMP e ,DEPT d 
WHERE e.DEPTNO =d.DEPTNO  AND e.SAL >=3000;

-- 비등가조인 : 등가조인 이외의 방식
-- EMP /SALGRADE

SELECT *
FROM EMP e ,SALGRADE s 
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL ;

-- 자체조인
-- MGR 의 이름조회
SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.EMPNO  AS MGR_EMPNO, E2.ENAME  AS MGR_ENAME
FROM EMP e1,EMP e2 
WHERE E1.MGR = E2.EMPNO ;

-- 외부조인
-- LEFT OUTER JOIN
SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.EMPNO  AS MGR_EMPNO, E2.ENAME  AS MGR_ENAME
FROM EMP e1,EMP e2 
WHERE E1.MGR = E2.EMPNO(+) ;

-- RIGHT OUTER JOIN
SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.EMPNO  AS MGR_EMPNO, E2.ENAME  AS MGR_ENAME
FROM EMP e1,EMP e2 
WHERE E1.MGR(+) = E2.EMPNO ;


-- 쿼리문 변화
-- 내부조인 : JOIN ~ ON
-- 외부조인 : LEFT OUTER JOIN ~ ON

SELECT
	E.EMPNO ,
	E.ENAME ,
	E.DEPTNO ,
	D.DNAME ,
	D.LOC
FROM
	EMP e
JOIN DEPT d 
ON
	E.DEPTNO = D.DEPTNO ;

SELECT
	E.EMPNO ,
	E.ENAME ,
	E.DEPTNO ,
	D.DNAME ,
	D.LOC
FROM
	EMP e
JOIN DEPT d 
ON
	E.DEPTNO = D.DEPTNO
WHERE
	E.SAL >= 3000;

SELECT
	E1.EMPNO,
	E1.ENAME,
	E1.MGR,
	E2.EMPNO AS MGR_EMPNO,
	E2.ENAME AS MGR_ENAME
FROM
	EMP e1
LEFT OUTER JOIN EMP e2 
ON
	E1.MGR = E2.EMPNO;


SELECT
	E1.EMPNO,
	E1.ENAME,
	E1.MGR,
	E2.EMPNO AS MGR_EMPNO,
	E2.ENAME AS MGR_ENAME
FROM
	EMP e1
RIGHT OUTER JOIN EMP e2 
ON
	E1.MGR = E2.EMPNO ;

-- TABLE 3개 조인
-- SELECT * 
-- FROM EMP e1 JOIN EMP e2 ON E1.MGR = E2.EMPNO JOIN EMP e3 ON 

-- 각 부서별 평균 급여, 최대급여 최소급여 사원수를 조회
-- 부서번호 부서명 평균급여AVG 최대급여MAX 최소급여MIN 사원수CNT
SELECT E.DEPTNO, D.DNAME ,AVG(SAL) , MAX(SAL) AS MAX_SAL, MIN(SAL)AS MIN_SAL, COUNT(*) AS CNT 
FROM EMP e JOIN DEPT d ON E.DEPTNO  = D.DEPTNO 
GROUP BY E.DEPTNO , D.DNAME 
ORDER BY E.DEPTNO ;



-- 모든 부서정보와 사원 정보를 조회
-- 부서번호, 부서명 사원번호 사원명 직무(JOB) 급여
SELECT D.DEPTNO ,D.DNAME , E.EMPNO , E.ENAME ,E.JOB ,E.SAL 
FROM DEPT D LEFT OUTER JOIN EMP E ON E.DEPTNO  = D.DEPTNO 
ORDER BY D.DEPTNO, E.DEPTNO ;


-- 서브쿼리 : 쿼리문 안에 또 다른 쿼리문(SELECT,UPDATE,DELETE,INSERT)이 포함
--SELECT 
--FROM
--WHERE (SELECT FROM WHERE)

--SELECT 
--FROM (SELECT FROM WHERE)
--WHERE

--SELECT (SELECT FROM WHERE)
--FROM
--WHERE

-- JONES 의 월급보다 많은 월급을 받는 사원 조회
SELECT *
FROM EMP e 
WHERE E.SAL > 2975;

SELECT
	*
FROM
	EMP e
WHERE
	E.SAL > (
	SELECT
		E2.SAL
	FROM
		EMP e2
	WHERE
		E2.ENAME = 'JONES');

-- 실행 결과가 하나인 단일행 서브쿼리
-- > , >= , = , < , <= , <> , != , ^=
	
-- KING 보다 빠른 입사자 조회
SELECT *
FROM EMP e 
WHERE E.HIREDATE < (SELECT E2.HIREDATE FROM EMP e2 WHERE E2.ENAME = 'KING');
	
  -- ALLEN 보다 추가수당 많이 받는 사원 조회

SELECT
	*
FROM
	EMP e
WHERE
	E.COMM > (
	SELECT
		E2.COMM
	FROM
		EMP e2
	WHERE
		E2.ENAME = 'ALLEN');

--20번 부서에 근무하는 사원중 전체 사원의 평균 급여보다 높은 급여를 받은 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	E.DEPTNO = 20
	AND E.SAL > (
	SELECT
		AVG(E2.SAL)
	FROM
		EMP e2 ); 

--20번 부서에 근무하는 사원중 전체 사원의 평균 급여보다 높은 급여를 받은 사원 조회 + 부서명, 부서 위치
SELECT
	E.*,
	D.DNAME ,
	D.LOC
FROM
	EMP e
JOIN DEPT d ON
	E.DEPTNO = D.DEPTNO
WHERE
	E.DEPTNO = 20
	AND E.SAL > (
	SELECT
		AVG(E2.SAL)
	FROM
		EMP e2 ); 


-- 실행 결과가 여러 개인 다중행 서브쿼리
-- IN : 메인 쿼리의 데이터가 서브쿼리의 결과중 하난라도 일치한 데이터가 잇다면 TRUE
-- ANY(SOME) : 메인 쿼리의 조건식을 만족하는 서브쿼리의 결과가 하나 이상이면 TRUE
-- ALL : 메인 쿼리의 조건식을 서브 쿼리의 결과 모두가 만족하면 TRUE
-- EXISTS : 서브 쿼리의 결과가 존재하면(즉, 행이 1개 이상일 경우) TRUE

-- 각 부서별 최고 급여와 동일하거나 큰 급여를 받는 사원 조회
	--단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
SELECT  * 
FROM EMP e 
WHERE e.SAL IN (SELECT MAX(e2.sal) FROM emp E2 GROUP BY E2.DEPTNO);

-- IN == = ANY
SELECT  * 
FROM EMP e 
WHERE e.SAL = ANY (SELECT MAX(e2.sal) FROM emp E2 GROUP BY E2.DEPTNO);

SELECT  * 
FROM EMP e 
WHERE e.SAL = SOME (SELECT MAX(e2.sal) FROM emp E2 GROUP BY E2.DEPTNO);

-- 30 번 부서의 급여보다 적은 급여를 받는 사원 조회
-- 30번 부서의 최대 급여보다 적은 사원 조회하는 겨로가와 같아짐
-- 다중행 서브쿼리로 할때
SELECT  * 
FROM EMP e 
WHERE e.SAL < ANY (SELECT e2.sal FROM emp E2 WHERE E2.DEPTNO =30)
ORDER BY E.SAL ,E.EMPNO ;

-- 단일행 서브쿼리로 할때
SELECT  * 
FROM EMP e 
WHERE e.SAL < (SELECT MAX( e2.sal) FROM emp E2 WHERE E2.DEPTNO =30)
ORDER BY E.SAL ,E.EMPNO ;

-- 30 번 부서의 급여보다 많은 급여를 받는 사원 조회
-- 30번 부서의 최대 급여보다 적은 사원 조회하는 겨로가와 같아짐
-- 다중행 서브쿼리로 할때
SELECT  * 
FROM EMP e 
WHERE e.SAL > ANY (SELECT e2.sal FROM emp E2 WHERE E2.DEPTNO =30)
ORDER BY E.SAL ,E.EMPNO ;

SELECT  * 
FROM EMP e 
WHERE e.SAL > (SELECT MIN( e2.sal) FROM emp E2 WHERE E2.DEPTNO =30)
ORDER BY E.SAL ,E.EMPNO ;

-- 부서번호가 30번인 사원들의 최소 급여보다 더 적은 사원 조회
-- ALL
SELECT  * 
FROM EMP e 
WHERE e.SAL < ALL (SELECT e2.sal FROM emp E2 WHERE E2.DEPTNO =30)
ORDER BY E.SAL ,E.EMPNO ;


--EXISTS

SELECT *
FROM EMP e 
WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO = 10);

SELECT *
FROM EMP e 
WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO = 50);

-- 비교할 열이 여러개인 다중열 서브쿼리
SELECT *
FROM EMP e 
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)FROM EMP e2 GROUP BY DEPTNO);

-- FROM 절에 작성하는 서브쿼리(== 인라인뷰) 작성

SELECT E10.EMPNO,E10.ENAME, D.DNAME, D.LOC
FROM (SELECT *FROM EMP WHERE DEPTNO = 10) E10, (SELECT * FROM DEPT )D
WHERE E10.DEPTNO = D.DEPTNO;

-- SELECT 절에 작성하는 서브쿼리(== 스칼라 서브쿼리)
SELECT
	E.EMPNO ,
	E.JOB ,
	E.SAL ,
	(
	SELECT
		GRADE
	FROM
		SALGRADE s
	WHERE
		E.SAL BETWEEN S.LOSAL AND S.HISAL) AS SALGRADE,
		E.DEPTNO ,(SELECT DNAME FROM DEPT D WHERE E.DEPTNO = D.DEPTNO) AS DNAME
FROM
	EMP e ;




-- INSERT

-- 테이블 복사
CREATE TABLE DEPT_TEMP AS SELECT * FROM DEPT;

SELECT *FROM DEPT_TEMP;

-- 열 이름 나열 하는 부분은 생략 가능
-- INSERT INTO 테이블명(열이름1, 열이름2...)
-- VALUES (열 이름에 맞춰 값 나열)

INSERT INTO DEPT_TEMP(DEPTNO, DNAME,LOC)
VALUES (50, 'DATABASE', 'SEOUL');

INSERT INTO DEPT_TEMP
VALUES (60, 'DATABASE', 'SEOUL');

INSERT INTO DEPT_TEMP(DEPTNO, DNAME,LOC)
VALUES (70, 'DATABASE', NULL);

INSERT INTO DEPT_TEMP(DEPTNO, DNAME)
VALUES (80, 'DATABASE');


CREATE TABLE EMP_TEMP AS SELECT * FROM  EMP;
SELECT  * FROM  EMP_TEMP;

-- 값을 전부 넣을 거라 필드명 안써도됨
-- 날짜데이터 - OR /
INSERT INTO EMP_TEMP VALUES(9999, '홍길동', 'PRESIDENT', NULL, '2001-01-01', 5000 , 1000, 10);

-- 몇개만 넣을거면 필드명 써야함
INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO)
VALUES (8888,'성춘향','SALESMAN',SYSDATE,3000,20);

-- 날짜 년/월/일 ==> 일/월/년 순으로 입력
INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO)
VALUES (7777,'이순신','SALESMAN',TO_DATE('07/08/2023','DD/MM/YYYY'),3000,20);

-- 테이블 제거
DROP TABLE EMP_TEMP;

-- 테이블 복사 시 테이블의 구조만 복사하고 데이터는 복사하지 않을 때
CREATE TABLE EMP_TEMP AS SELECT * FROM EMP WHERE 1<>1;

-- EMP 테이블과 SALGRADE 조인 후 급여 등급이 1인 사원들만 EMP_TEMP에 삽입(서브쿼리)
-- 데이터가 추가되는 테이블 열 개수와 서브쿼리 열 개수 일치 / 자료형 일치
INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
SELECT E.EMPNO ,E.ENAME ,E.JOB ,E.MGR ,E.HIREDATE ,E.SAL ,E.COMM ,E.DEPTNO 
FROM EMP E JOIN SALGRADE s ON E.SAL BETWEEN S.LOSAL AND S.HISAL 
WHERE S.GRADE =1;


-- UPDATE(수정)

--UPDATE 변경 테이블명
--SET 변경할 열 = 값, 변경할열=값...
--WHERE 변경할 대상 행 조건

SELECT * FROM DEPT_TEMP;

-- 모든 행의 LOC 를 SEOUL로 변경
UPDATE DEPT_TMEP
SET LOC='SEOUL';

CREATE TABLE DEPT_TEMP2 AS SELECT * FROM DEPT;

--40번 부서의 부서명은 DATABASE, LOC 는 SEOUL로 변경
UPDATE DEPT_TEMP2
SET DNAME='DATABASE',LOC='SEOUL'
WHERE DEPTNO = 40;

SELECT * FROM DEPT_TEMP2;

-- EMP_TEMP 의 사원들 중에서 급여가 2500 이하인 사원들의 추가수당을
-- 50으로 수정
UPDATE EMP_TEMP 
SET COMM = 50
WHERE SAL <= 2500;

SELECT * FROM EMP_TEMP;

-- DEPT 테이블의 DEPTNO=40 부서의 DNAME,LOC 를 추출해서 DEPT_TEMP2의 DNAME,LOC 수정

UPDATE
	DEPT_TEMP2
SET
	(DNAME,
	LOC) =
(
	SELECT
		DNAME,
		LOC
	FROM
		DEPT
	WHERE
		DEPTNO = 40)
	WHERE DEPTNO = 40;

-- DELETE : 데이터 삭제
-- DELETE 테이블명 WHERE 삭제할 조건
-- DELETE FROM 테이블명 WHERE 삭제할 조건
-- DELETE 테이블명; > 전체 데이터 삭제

CREATE TABLE EMP_TEMP2 AS SELECT * FROM  EMP;
SELECT * FROM  EMP_TEMP2;


-- JOB = 'MANAGER'인 사원 삭제
DELETE EMP_TEMP2 
WHERE JOB='MANAGER';

DELETE FROM EMP_TEMP2;

-- EMP 테이블 행 전부 추출 후 EMP_TEMP2에 삽입
INSERT INTO EMP_TEMP2(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
SELECT E.EMPNO ,E.ENAME ,E.JOB ,E.MGR ,E.HIREDATE ,E.SAL ,E.COMM ,E.DEPTNO 
FROM EMP E ;

-- 서브쿼리
-- 급여등금이 3등급이고,, 부서 번호가 30번인 사원 삭제
DELETE
FROM
	EMP_TEMP2
WHERE
	EMPNO IN(
	SELECT
		E.EMPNO
	FROM
		EMP_TEMP2 E
	JOIN SALGRADE s ON
		E.SAL BETWEEN S.LOSAL AND S.HISAL
		AND S.GRADE = 3
		AND E.DEPTNO = 30);

-- 테이블 복사
-- emp,dept,salgrade 테이블복사
-- exam_emp,exam_dept,exam_sal grade생성
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;
CREATE TABLE exam_dept AS SELECT * FROM DEPT;
CREATE TABLE exam_SALGRADE AS SELECT * FROM SALGRADE;
	
	
-- insert
-- exam_dept 테이블에 50,60,70 부서 등록
-- 50:ORACLE,BUSAN / 60:SQL,ILSAN / 70:SELECT,INCHEON / 80:DML ,BUNDANG
INSERT INTO EXAM_DEPT(DEPTNO, DNAME,LOC)
VALUES (50,'ORACLE', 'BUSAN') ;
INSERT INTO EXAM_DEPT(DEPTNO, DNAME,LOC)
VALUES (60,'SQL','ILSAN');
INSERT INTO EXAM_DEPT(DEPTNO, DNAME,LOC)
VALUES (70,'SELECT','INCHEON');
INSERT INTO EXAM_DEPT(DEPTNO, DNAME,LOC)
VALUES (80,'DML' ,'BUNDANG');

--EXAM_EMP 사원등록
--7201, TEST_USER1, MANAGER, 7788, 2016-01-02,4500,NULL,50
--7202, TEST_USER2, CLERK, 7201, 2016-02-21,1800,NULL,50
--7203, TEST_USER3, ANALYST, 7201, 2016-04-11,3400,NULL,60
--7204, TEST_USER4, SALESMAN, 7201, 2016-05-31,2700,NULL,60
--7205, TEST_USER5, CLERK, 7201, 2016-07-20,2600,NULL,70
--7206, TEST_USER6, CLERK, 7201, 2016-09-08,23,NULL,70
--7207, TEST_USER7, LECTURER, 7201, 2016-10-28,4500,NULL,80
INSERT INTO EXAM_EMP
VALUES (7201, 'TEST_USER1', 'MANAGER', 7788, '2016-01-02',4500,NULL,50);

INSERT INTO EXAM_EMP
VALUES (7202, 'TEST_USER2', 'CLERK', 7201, '2016-02-21',1800,NULL,50);

INSERT INTO EXAM_EMP
VALUES (7203, 'TEST_USER3','ANALYST', 7201, '2016-04-11',3400,NULL,60);

INSERT INTO EXAM_EMP
VALUES (7204, 'TEST_USER4', 'SALESMAN', 7201, '2016-05-31',2700,NULL,60);

INSERT INTO EXAM_EMP
VALUES (7205, 'TEST_USER5', 'CLERK', 7201, '2016-07-20',2600,NULL,70);

INSERT INTO EXAM_EMP
VALUES (7206, 'TEST_USER6', 'CLERK', 7201, '2016-09-08',2300,NULL,70);

INSERT INTO EXAM_EMP
VALUES (7207, 'TEST_USER7', 'LECTURER', 7201, '2016-10-28',4500,NULL,80);

SELECT *FROM EXAM_EMP;
	
	
--UPDATE 
--EXAM_EMP 에 속한 사원중 50번 부서에서 근무하는 사우너들의 평균급여보다 많은 급여를 받고있는 사원들을 70번 부서로 변경
UPDATE EXAM_EMP
SET DEPTNO = 70
WHERE SAL >= (SELECT avg(SAL) FROM EXAM_EMP WHERE DEPTNO =50);

--EXAM_EMP  에 속한 사원중 60번 부서의 사원중에서 입사일이 가장빠른 사원보다늦게 입사한 사원의 급여를 10퍼 인상하고 80번부서로변경
UPDATE EXAM_EMP E
SET DEPTNO  = 80, sal = SAL*1.1
WHERE HIREDATE > (SELECT MIN(E.HIREDATE) FROM EXAM_EMP EE WHERE DEPTNO =60);

--EXAM_EMP 에 속한 사원중 급여 등급이 5인 사원삭제
DELETE
FROM
	EXAM_EMP
WHERE
	EMPNO IN(
	SELECT
		e.EMPNO
	FROM
		EXAM_EMP E
	JOIN SALGRADE S
	on
		E.SAL BETWEEN S.LOSAL AND S.HISAL
		AND S.GRADE = 5);
	
-- 트랜잭션 : 한번에 일어나야 하는 작업들 
--		  : 최소 수행단위
--	 	  : 은행 계좌이체
--		    COMMIT(반영), ROLLBACK(취소)
-- INSERT DELETE UPDATE => 데이터 변화
	
-- AUTO-COMMIT : 자동 반영
	
-- 취소 불가한 트랜직션 시작
CREATE TABLE DEPT_TCL AS SELECT * FROM DEPT;
-- 트랜잭션 종료

-- 트랜잭션 시작
INSERT  INTO DEPT_TCL VALUES(50,'DATABASE','SEOUL');
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO =40;
DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';
SELECT *FROM DEPT_TCL dt ;
-- 트랜잭션 종료

-- 트랜잭션 취소
ROLLBACK;

SELECT *FROM DEPT_TCL dt ;

-- 트랜잭션 시작
INSERT  INTO DEPT_TCL VALUES(50,'DATABASE','SEOUL');
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO =40;
DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';

SELECT *FROM DEPT_TCL;

-- 트랜잭션 최종 반영
COMMIT;
-- 트랜잭션 종료

SELECT  * FROM DEPT_TCL;

DELETE FROM DEPT_TCL WHERE DEPTNO = 50;
COMMIT;
 
UPDATE DEPT_TCL SET LOC = 'SEOUL' WHERE DEPTNO  = 30;
COMMIT;


-- DDL(데이터 정의어)
-- 데이터베이스 데이터를 보관하고 관리하기 위해 제공되는 여러 객체의 생성/변경/삭제 관련기능
-- CREATE(생성) / ALTER(생성된 객체 변경) / DROP(생성된 객체 삭제)

--1. 테이블 정의어
--CREATE TABLE 테이블이름()
--	열이름1 자료형,
--	열이름2 자료형,
--	열이름3 자료형,
--	열이름4 자료형
--	)

-- 테이블 이름 작성 규칙
-- 1) 문자로 시작(한글 가능하나 사용하지 않음)
-- 2) 테이블 이름은 길이의 제한이 있음
-- 3) 같은 소유자 소유의 테이블 이름은 중복불가
-- 4) SQL 키워드는 사용 불가(SELECT, INSERT 등)

-- 열이름 생성 규칙
-- 1) 문자로 시작
-- 2) 길이의 제한이 있음(30byte)
-- 3) 한 테이블에 열 이름 중복 불가
-- 4) 열 이름은 영문자, 숫자, 특수문자(_, #, $)사용 가능
-- 5) SQL 키워드는 사용 불가(SELECT, INSERT 등)

-- 자료형
-- 문자 : varchar2(길이), nvarchar2(길이), char(길이), nchar(길이)
--		 var : 가변(저장된 값의 길이만큼만 사용)
-- 		 name varchar2(10) : 홍길동(9byte)
--		 name char(10) : 홍길동(10byte) -고정길이
--  	 db 버전에 따라 한글 문자 하나당 2byte를 할당 or 3byte 할당
--		 name varchar2(10) : 홍길동전 => 들어갈 값의 크기가 크다고 오류 남 
--			  nvarchar2(10), nchar() : 10 이 바이트 개념이 아니라 문자 길이 자체를 의미
-- 숫자 : number(전체자릿수, 소수점자릿수) 
-- 날짜 : DATE
-- BLOB : 대용량 이진 데이터 저장
-- CLOB : 대용량 텍스트 데이터 저장

CREATE TABLE EMP_DDL(
	EMPNO NUMBER(4,0),
	ENAME VARCHAR2(10),		--영어 10자, 한글 3자 까지 가능 
	JOB VARCHAR2(9),
	MRG NUMBER(4,0),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2,0)
);

-- DEPT 테이블의 열구조와 데이터 복사
CREATE TABLE DEPT_DDL AS SELECT * FROM DEPT;

-- DEPT 테이블의 열구조만 복사하여 새 테이블 생성
CREATE TABLE DEPT_DDL AS SELECT * FROM DEPT WHERE 1<>1;


-- ALTER : 변경
-- 새로운 열 추가 / 열 이름 변경 / 열 삭제 / 열 자료형 변경
-- EMP_DDL에 새로운 열(HP : 010-1234-5637) 추가
ALTER TABLE EMP_DDL ADD HP VARCHAR2(20);
SELECT * FROM EMP_DDL ed;

-- HP => TEL
ALTER TABLE EMP_DDL RENAME COLUMN HP TO TEL;

-- EMPNO NUMBER(5) 로 변경
ALTER TABLE EMP_DDL MODIFY EMPNO NUMBER(5);

-- TEL 삭제
ALTER TABLE EMP_DDL DROP COLUMN TEL;

-- 테이블 이름 변경
RENAME EMP_DDL TO EMP_RENAME;

-- DROP : 삭제
DROP TABLE EMP_RENAME ;

CREATE TABLE MEMBERTBL(
	ID CHAR(8),
	NAME VARCHAR2(10), -- NVARCHAR2(10)
	ADDR VARCHAR2(50), -- NVARCHAR2(50)
	NATION CHAR(4), -- NCHAR(4)
	EMAIL VARCHAR2(50), -- NVARCHAR2
	AGE NUMBER(7,2)	
);

SELECT * FROM MEMBERTBL ed;

ALTER TABLE MEMBERTBL ADD BIGO VARCHAR2(20);

ALTER TABLE MEMBERTBL MODIFY BIGO VARCHAR2(30);

ALTER TABLE MEMBERTBL MODIFY NATION NCHAR(4);

ALTER TABLE MEMBERTBL RENAME COLUMN BIGO TO REMARK;

ALTER TABLE MEMBERTBL ADD 

INSERT INTO MEMBERTBL(ID, NAME, ADDR, NATION, EMAIL, AGE)
VALUES('hong1234', '홍길동', '서울시 구로구 개봉동', '대한민국', 'hong123@naver.com', 25);
INSERT INTO MEMBERTBL(ID, NAME, ADDR, NATION, EMAIL, AGE)
VALUES('hong1235', '이승기', '서울시 강서구 화곡동', '대한민국', 'lee89@naver.com', 26);
INSERT INTO MEMBERTBL(ID, NAME, ADDR, NATION, EMAIL, AGE)
VALUES('hong1236', '강호동', '서울시 마포구 상수동', '대한민국', 'kang56@naver.com', 42);
INSERT INTO MEMBERTBL(ID, NAME, ADDR, NATION, EMAIL, AGE)
VALUES('hong1237', '이수근', '경기도 부천시 ', '대한민국', 'leesu@naver.com', 42);
INSERT INTO MEMBERTBL(ID, NAME, ADDR, NATION, EMAIL, AGE)
VALUES('hong1238', '서장훈', '서울시 강남구 대치동', '대한민국', 'seo568@google.com', 36);
INSERT INTO MEMBERTBL(ID, NAME, ADDR, NATION, EMAIL, AGE)
VALUES('hong1239', '김영철', '서울시 도봉구 도봉동', '대한민국', 'young@naver.com', 41);
INSERT INTO MEMBERTBL(ID, NAME, ADDR, NATION, EMAIL, AGE)
VALUES('hong1210', '김장훈', '서울시 노원구 노원1동', '대한민국', 'kim@naver.com', 48);
INSERT INTO MEMBERTBL(ID, NAME, ADDR, NATION, EMAIL, AGE)
VALUES('hong1211', '임창정', '서울시 양천구 신월동', '대한민국', 'limchang@naver.com', 45);
INSERT INTO MEMBERTBL(ID, NAME, ADDR, NATION, EMAIL, AGE)
VALUES('hong1212', '김종국', '서울시 강남구 도곡동', '대한민국', 'kimjong@naver.com', 44);
INSERT INTO MEMBERTBL(ID, NAME, ADDR, NATION, EMAIL, AGE)
VALUES('hong1213', '김범수', '경기도 일산동구 일산동', '대한민국', 'kim77@naver.com', 36);
INSERT INTO MEMBERTBL(ID, NAME, ADDR, NATION, EMAIL, AGE)
VALUES('hong1214', '김경호', '인천시 서구 가좌동', '대한민국', 'ho789@naver.com', 26);
INSERT INTO MEMBERTBL(ID, NAME, ADDR, NATION, EMAIL, AGE)
VALUES('hong1215', '민경훈', '경기도 수원시 수원1동', '대한민국', 'min@naver.com', 35);
INSERT INTO MEMBERTBL(ID, NAME, ADDR, NATION, EMAIL, AGE)
VALUES('hong1216', '바이브', '경기도 용인시 기흥구', '대한민국', 'vibe@naver.com', 33);

SELECT * FROM MEMBERTBL;

-- 오라클 객체
-- 인덱스 / 뷰 / 시퀀스(*) / 동의어

-- 인덱스 : 빠른검색 
-- 1) 자동 생성 : 기본키를 설정 시 인덱스가 자동으로 설정
-- 2) 직접 인덱스 생성 : 
-- CREATE INDEX 인덱스명 ON 테이블명(열이름1 ASC OR DESC, 열이름2 ASC OR DESC...)
-- EMP 테이블의 SAL 컬럼을 INDEX로 지정
CREATE INDEX IDX_EMP_SAL ON EMP(SAL);

DROP INDEX IDX_EMP_SAL ;

-- 뷰 : 가상 테이블
-- 1. 편리성 : 복잡한 SELECT 문의 복잡도를 완화하기 위해
--			  자주 활용하는 SELECT 문을 뷰로 저장해 놓은 후 다른 SQL 구문에서 활용
-- 2. 보안성 : 노출되면 안되는 컬럼을 제외하여 접근 허용

-- 뷰 생성 할 수 있는 권한 부여 받기
-- CREATE [OR REPLACE] VIEW 뷰이름(열이름1,열이름2...) AS (SELECT 구문)

-- EMP 테이블의 20번 부서에 해당하는 사원들의 뷰 생성
CREATE VIEW VW_EMP_20 AS(SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE DEPTNO = 20);
DROP VIEW VW_EMP_20;


































	
	
	
	
	
	
	
	
	
	
	
	