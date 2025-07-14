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