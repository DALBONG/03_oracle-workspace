/*
<GROUP BY절>
그룹 기준을 제시할 수 있는 구문(해당 그룹기준별로 여러 그룹을 묶을 수 있음)
여러개의 값들을 하나의 그룹으로 묶어 처리할 목적으로 사용
*/

SELECT SUM(SALARY)
FROM EMPLOYEE; -- 전체 사원을 하나의 그룹으로 묵어 총합을 구한 결과

    -- 각 부서별 총 급여 합
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

-- 각 부서별 사원 수
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 직급별 총 사원수, 급여 합
SELECT JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 각 직급별 총 사원수, 보너스 받는 사원수, 급여 합계, 평균 급여, 최대 급여, 최저 급여
SELECT JOB_CODE, COUNT(*) "총 사원수", COUNT(BONUS) "보너스 받는 사원", SUM(SALARY) "급여 합계", FLOOR(AVG(SALARY)) "급여 평균", MAX(SALARY) "최대 급여", MIN(SALARY) "최저 급여"  
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

-- 성별 별 
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 1 , '남', 2, '여') , COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);
-- GROUP BY 절에 함수식 기술 가능

-- GROUP BY 절에 여러 컬럼 기술 가능
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE -- DEPT 이면서, JOB 인 사원 수
ORDER BY 1;

--============================================================================
/*
    < HAVING 절 > 
    그룹 조건을 제시할 때 사용되는 구문 (그룹함수식을 가지고 조건을 제시할 때 사용)
*/

-- 각 부서별 평균 급여 조회
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;

-- 각 부서별 평균 급여가 300이상인 부서만 조회
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) --4
FROM EMPLOYEE --1
-- WHERE AVG(SAL) >= 3000000 --> WHERE에선 그룹함수 조건 작성X,  HAVING 사용!
GROUP BY DEPT_CODE  --2 
HAVING AVG(SALARY) >= 3000000 --3
ORDER BY 1;  --5

-- 직븝별 총 급여합(단 직급별 급여합이 1000만원 이상인 직급만을 조회)
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- 부서별 보너스를 받는 사원이 없는 부서만을 조회 (부서코드, 보너스 받는 사원)
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

--=======================================================================
--=======================================================================
/*
    <SELECT문 실행 순서>
    5. SELECT *  | 조회 컬럼 [별칭]  |  산술식  | 함수식 |
    1. FROM 조회 테이블 명
    2. WHERE 조건식(연산자 가지고 기술)
    3. GROUP BY 그룹 기준으로 삼을 컬럼  |  함수식 포함 컬럼
    4. HAVING 그룹함수를 가지고 기술한 조건식 
    6. ORDER BY 컬럼명  |  별칭  |  순번 기준 정렬
*/

--========================================================================
--========================================================================
--========================================================================

/*
    <집계 함수>
    그룹별 산출된 결과값이 중간 집계를 계산해주는 함수
    
    ROLLUP(컬럼1, 컬럼2) : 컬럼 1을 가지고 다시 중간집계를 내는 함수 + 컬럼 2 중간집계 
      => GROUP BY 절에 기술하는 함수
*/

-- 각 직급별 급여 합
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE);

--========================================================================
/* 
    <집합 연산자 == SET OPERATION >
    여러개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
    
    - UNION(합집합) : A OR B (두 쿼리문 수행 결과 더한 후, 중복되는 값은 한번만 더해지도록)
    - INTERSECT(교집합) : AND (두 쿼리문 수행 결과에 중복된 결과값) 
    - UNION ALL(합+교) : 중복 되는 부분이 두번 표현될 수 있음. 
    - MINUS(차집합) : 선행 결과값에서 후행 결과값을 뺀 나머지
*/

-- 1.UNION
    --부서코드가 D5인 사원 또는 급여가 300만 초과인 사원들 조회(사번, 이름, 부서코드, 급여)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'; -- 6개행 (나라, 이유, 해술, 봉선, 은해, 북혼)

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8개행 (동일,종기,옹철,재식,중하,봉선,북혼,지연)

    -- 두 쿼리 UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
/*
 --> OR써도 해결 가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;
*/

-- 2. INTERSECT (교집합)
    -- 부서코드가 D5이면서 급여도 300만 초과인 사원 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

/* 
    --> AND를 써도 해결 가능!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;
*/

 -- UNION 사용시 주의사항
-- 1) 각 쿼리문의 컬럼 개수가 동일해야 함.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 2) 컬럼 타입도 가능해야 함
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 타입은 같으니 출력은 되나, 이상한 값 도출
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, BONUS
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- ORDER BY절을 붙이고자 한다면 마지막에 기술
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_NAME; 

--========================================================================
--========================================================================

 -- 3. UNION ALL  : 여러개 쿼리 결과를 모두 다 더하는 연산자
 SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 4. MINUS : 선행 SELECT 결과에서 후행 SELECT 결과를 뺀 나머지(차집합)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'-- 6개행 (나라, 이유, 해술, 봉선, 은해, 북혼)
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8개행 (동일,종기,옹철,재식,중하,봉선,북혼,지연)
/*
    --> 이렇게도 가능!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY < 3000000;
*/

