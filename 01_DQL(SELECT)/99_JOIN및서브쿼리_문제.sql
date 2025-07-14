--======================= JOIN 및 서브쿼리 문제 ================================= 

-- 1. 70년대 생(1970~1979) 중 여자이면서 전씨인 사원의 이름과 주민번호, 부서 명, 직급 조회 

SELECT * FROM EMPLOYEE; -- DEPT_CODE, JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID , 
SELECT * FROM JOB;        -- JOB_CODE


SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE = J.JOB_CODE
AND (DECODE(SUBSTR(EMP_NO, 8, 1), 2, '여자', 4, '여자'), EMP_NAME) 
    = ANY (SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 2, '여자', 4, '여자'), EMP_NAME
           FROM EMPLOYEE
           WHERE EMP_NAME LIKE '전%' AND DECODE(SUBSTR(EMP_NO, 8, 1), 2, '여자', 4, '여자') IS NOT NULL);
           

-- 2. 나이 상 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회 
SELECT EMP_ID, EMP_NAME, FLOOR(FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RR.MM.DD')))/12) "나이", DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

/*
SELECT EMP_NAME, MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RR.MM.DD')
FROM EMPLOYEE;

SELECT EMP_NAME, EMP_NO, FLOOR(FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RR.MM.DD')))/12)
FROM EMPLOYEE;
*/


-- 3. 이름에 ‘형’이 들어가는 사원의 사원 코드, 사원 명, 직급 조회 
SELECT EMP_ID, EMP_NAME, JOB_NAME -- JOB_CODE
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND EMP_NAME LIKE '%형%';

-- 4. 부서코드가 D5이거나 D6인 사원의 사원 명, 직급 명, 부서 코드, 부서 명 조회 
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE 
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE = J.JOB_CODE
AND DEPT_CODE IN ('D5', 'D6');

-- 5. 보너스를 받는 사원의 사원 명, 부서 명, 지역 명 조회 
    -- E : DEPT_CODE
    -- D : DEPT_ID, , LOCATION_ID 
    -- L : LOCAL_CODE 

SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND BONUS IS NOT NULL;

-- 6. 사원 명, 직급 명, 부서 명, 지역 명 조회
    -- E : DEPT_CODE, JOB_CODE
    -- J :            JOB_CODE
    -- D : DEPT_ID, , LOCATION_ID 
    -- L : LOCAL_CODE 

SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE 
    AND E.DEPT_CODE = D.DEPT_ID
    AND LOCATION_ID = LOCAL_CODE;

-- 7. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회 
    -- E : DEPT_CODE,     JOB_CODE
        -- J :            JOB_CODE
    -- D : DEPT_ID, , LOCATION_ID 
    -- L : LOCAL_CODE, NATIONAL_CODE
    -- N :             NATIONAL_CODE 
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID 
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND NATIONAL_NAME IN (SELECT NATIONAL_NAME
                         FROM NATIONAL
                         WHERE NATIONAL_NAME IN ('한국', '일본'));

-- 8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회 
SELECT * FROM EMPLOYEE;

SELECT E.EMP_NAME, E.DEPT_CODE, M.EMP_NAME
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.DEPT_CODE = M.DEPT_CODE
    AND E.EMP_NAME != M.EMP_NAME
ORDER BY 1;


-- 9. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 이름, 직급 명, 급여 조회(NVL 이용) 
    -- E : DEPT_CODE,     JOB_CODE
    -- J :                JOB_CODE
    -- D : DEPT_ID, , LOCATION_ID 
    -- L : LOCAL_CODE, NATIONAL_CODE
    -- N :             NATIONAL_CODE 
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
    AND E.BONUS IS NULL
    AND E.JOB_CODE IN ('J4', 'J7');
    
    
                                                                    -- 10. 보너스 포함한 연봉이 높은 5명의 사번, 이름, 부서 명, 직급, 입사일, 순위 조회 


-- 11. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회 
    -- 11-1. JOIN과 HAVING 사용 
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
    
SELECT DEPT_TITLE, SUM(SALARY) "부서별 급여 합계"
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
GROUP BY D.DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY)*0.2
                     FROM EMPLOYEE);
                     
                                                                   -- 11-2. 인라인 뷰 사용 

-- 12. 부서 명과 부서 별 급여 합계 조회 



