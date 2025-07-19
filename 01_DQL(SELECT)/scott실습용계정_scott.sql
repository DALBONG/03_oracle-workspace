--SCOTT_연습문제
--1. EMP테이블에서 COMM 의 값이 NULL이 아닌 정보 조회
SELECT *
FROM EMP
WHERE COMM IS NOT NULL;

--2. EMP테이블에서 커미션을 받지 못하는 직원 조회
SELECT *
FROM EMP
WHERE COMM IS NULL;

--3. EMP테이블에서 관리자가 없는 직원 정보 조회
SELECT *
FROM EMP
WHERE MGR IS NULL;

--4. EMP테이블에서 급여를 많이 받는 직원 순으로 조회
SELECT *
FROM EMP 
ORDER BY SAL DESC;

--5. EMP테이블에서 급여가 같을 경우 커미션을 내림차순 정렬 조회
SELECT *
FROM EMP
ORDER BY SAL ASC, COMM DESC;

--6. EMP테이블에서 사원번호, 사원명,직급, 입사일 조회 (단, 입사일을 오름차순 정렬 처리)
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
ORDER BY HIREDATE ASC;

--7. EMP테이블에서 사원번호, 사원명 조회 (사원번호 기준 내림차순 정렬)
SELECT EMPNO, ENAME
FROM EMP
ORDER BY EMPNO DESC;

--8. EMP테이블에서 사번, 입사일, 사원명, 급여 조회
-- (부서번호가 빠른 순으로, 같은 부서번호일 때는 최근 입사일 순으로 처리)
SELECT EMPNO, HIREDATE, ENAME, SAL, DEPTNO
FROM EMP
ORDER BY DEPTNO ASC, HIREDATE DESC;

--9. 오늘 날짜에 대한 정보 조회
SELECT SYSDATE
FROM EMP;

--10. EMP테이블에서 사번, 사원명, 급여 조회
-- (단, 급여는 100단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬)
SELECT EMPNO, ENAME, SAL, /*SUBSTR(TO_CHAR(SAL), -4, 3),*/ 
        -- LENGTH 길이가 3일경우 SUBSTR 앞에서 두자리 반환, 4일 경우 앞에서 세자리 반환 
        TO_NUMBER(CASE WHEN LENGTH(SAL) = 3 THEN SUBSTR(TO_CHAR(SAL), 1, 2)
            ELSE SUBSTR(TO_CHAR(SAL), 1, 3)
        END) "급여" 
FROM EMP
ORDER BY "급여" DESC;

--11. EMP테이블에서 사원번호가 홀수인 사원들을 조회
SELECT *
FROM EMP
WHERE SUBSTR(EMPNO, -1, 1) IN ('1', '3', '5', '7', '9');

--12. EMP테이블에서 사원명, 입사일 조회 (단, 입사일은 년도와 월을 분리 추출해서 출력)
SELECT ENAME, HIREDATE "입사 날", EXTRACT(YEAR FROM HIREDATE) "입사 년", EXTRACT(MONTH FROM HIREDATE) "일사 월"
FROM EMP;

--13. EMP테이블에서 9월에 입사한 직원의 정보 조회
SELECT *
FROM EMP
WHERE  EXTRACT(MONTH FROM HIREDATE) = '9';

--14. EMP테이블에서 81년도에 입사한 직원 조회
SELECT *
FROM EMP
WHERE EXTRACT(YEAR FROM HIREDATE) = 1981;

--15. EMP테이블에서 이름이 'E'로 끝나는 직원 조회
SELECT *
FROM EMP 
WHERE SUBSTR(ENAME, -1, 1) = 'E';

--16. EMP테이블에서 이름의 세 번째 글자가 'R'인 직원의 정보 조회
--16-1. LIKE 사용
SELECT *
FROM EMP
WHERE ENAME LIKE '__R%';

--16-2. SUBSTR() 함수 사용
SELECT *
FROM EMP
WHERE SUBSTR(ENAME, 3, 1) = 'R';

--17. EMP테이블에서 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 480) "입사 40년차"--, EXTRACT(YEAR FROM ADD_MONTHS(HIREDATE, 480))
FROM EMP;

--18. EMP테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회
SELECT ENAME, HIREDATE--, MONTHS_BETWEEN(SYSDATE, HIREDATE)
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) >= 456;

--19. 오늘 날짜에서 년도만 추출
SELECT SYSDATE "오늘 날짜", EXTRACT(YEAR FROM SYSDATE) "올해 년도"
FROM EMP;

--===================================================================
--===================================================================
--===================================================================
--추가 문제

--EMP 테이블에서 모든 직원의 급여(SAL) 평균을 구하세요.
SELECT TO_CHAR(FLOOR(AVG(SAL)), '$9,999') "전 직원 급여 평균"
FROM EMP;

--EMP 테이블에서 직무(JOB)가 'SALESMAN'인 직원들의 이름과 급여를 조회하세요.
SELECT ENAME, SAL
FROM EMP
WHERE JOB = 'SALESMAN';

--EMP 테이블에서 모든 직원을 이름(ENAME) 기준으로 오름차순 정렬해 조회하세요.
SELECT *
FROM EMP
ORDER BY ENAME ASC;

--EMP 테이블에서 커미션(COMM)이 NULL인 직원 수를 구하세요.
SELECT COUNT(*)
FROM EMP
WHERE COMM IS NULL;

--EMP 테이블에서 급여가 가장 높은 직원의 급여와 이름(ENAME)을 출력하세요.
SELECT ENAME, 최고급여
FROM (SELECT RANK() OVER (ORDER BY SAL DESC)"순위", SAL "최고급여", ENAME
        FROM EMP)
 WHERE 순위 = 1;

--EMP 테이블에서 부서번호가 10 또는 30이면서 급여가 1500 이상인 직원들의 이름, 직무, 급여를 조회하세요.
SELECT ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE /*DEPTNO = 10 OR DEPTNO = 30;*/ (DEPTNO IN(10, 30)) AND SAL >= 1500; 

--EMP 테이블에서 각 부서별 최대 급여, 최소 급여, 평균 급여를 출력하세요.
SELECT DISTINCT DEPTNO (MAX(SAL), MIN(SAL), FLOOR(AVG(SAL)))
FROM EMP;

--EMP 테이블에서 급여(SAL)가 2000 이상인 직원들의 이름과 부서번호(DEPTNO)를 조회하세요.
SELECT ENAME, DEPTNO, SAL
FROM EMP
WHERE SAL >= 2000;

--EMP 테이블에서 커미션(COMM)이 NULL이 아닌 직원들의 이름과 커미션을 조회하세요.
SELECT ENAME, COMM
FROM EMP
WHERE COMM IS NOT NULL;

--EMP 테이블에서 급여(SAL)를 기준으로 내림차순 정렬해 직원 이름과 급여를 조회하세요.
SELECT ENAME, SAL
FROM EMP
ORDER BY SAL DESC;

--EMP 테이블에서 부서번호(DEPTNO) 오름차순, 급여 내림차순으로 직원 정보를 조회하세요.
SELECT DEPTNO, SAL
FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;

--EMP 테이블에서 커미션(COMM)을 내림차순으로 정렬하고, 커미션이 같은 경우 급여를 오름차순으로 정렬해 조회하세요.
SELECT *
FROM EMP
ORDER BY COMM DESC NULLS LAST, SAL ASC;







