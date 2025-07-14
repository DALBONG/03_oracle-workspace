/*
    ** 서브쿼리 
    - 하나의 SQL문 안에 포함된 또다른 SELECT문
    - 메인 SQL문을 위해 보조 역할을 하는 쿼리문
*/

-- 간단한 서브쿼리 예시1
    -- 노옹철 사원과 같은 부서에 속한 사원들 조회
        -- 1) 노옹철 사원의 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'; 
        -- 2) 부서코드가 D9인 사원들 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--> 위의 2단계를 하나의 쿼리문으로
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '노옹철');
                    
                    
-- 간단 서브쿼리 예시2
    -- 전 직원의 평균 급여보다 더 많은 급여를 받는 사원들의 사번, 이름, 직급코드, 급여 조회
    -- 1) 전 직원의 평균 급여 조회
SELECT FLOOR(AVG(SALARY))
FROM EMPLOYEE;
    --2) 급여가 3047663원 이상인 사원 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047662;

--> 위의 2단계를 하나의 쿼리문으로
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT FLOOR(AVG(SALARY))
                    FROM EMPLOYEE);
    
--============================================================================                
/*
    ** 서브쿼리의 구분
        서브쿼리 결과값이 몇행, 몇열이냐에 따라 분류
        
        - 단일행 서브쿼리 : 서브쿼리의 결과값의 갯수가 오로지 1개일 때
        - 다중행 서브쿼리 : 서브쿼리의 결과값이 여러 행일 때(여러 행, 한 열)
            ==> 동명이인 노옹철 2명일 때
        - 다중열 서브쿼리 : 서브쿼리의 결과값이 여러 열일 때(한 행, 여러 열)
        - 다중행 다중 열 서브쿼리 : 서브쿼리 결과값이 여러행 여러 컬럼일 때 (여러 행, 여러 열)
        
        --> 서브쿼리 종류에 따라 서브쿼리 앞에 붙는 연산자가 달라짐 
*/  

/*
    1. 단일행 서브쿼리 (SINGLE ROW SUBQUERY)
        서브쿼리의 조회 결과값이 오로지 1개 (한 행, 한 열)
        일반 비교 연산자 사용 가능 (=, !=, ^= 등..)
*/
-- 1) 전 직원의 평균급여보다 급여를 더 적게 받는 사원ㄷ르의 사원명, 직급코드, 급여 조회 
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY) 
                FROM EMPLOYEE );
                
-- 2) 급여를 가장 적게 받는 사원의 사번, 이름, 급여, 입사일D
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);
                
-- 3) 노옹철 사원의 급여보다 더 많이 받는 사원들의 사번, 이름, 부서코드, 급여조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY 
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');
                
-- 4) 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND SALARY > (SELECT SALARY 
              FROM EMPLOYEE
              WHERE EMP_NAME = '노옹철');
              
              
--@ 안씨 구문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
WHERE SALARY > (SELECT SALARY 
              FROM EMPLOYEE
              WHERE EMP_NAME = '노옹철');
              
-- 4) 부서별 급여합이 가장 큰 부서의 부서코드, 급여 합
    -- 1) 부서별 급여합 중에서도 가장 큰 값 하나 조회
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;  -- 17700000
    -- 2) 부서별 급여합이 17700000이하의 부서 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;


SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                       FROM EMPLOYEE
                       GROUP BY DEPT_CODE); 
    
-- 전지연 사원과 같은 부서원들의 사번, 사원명, 전번, 입사일, 부서명
    --(단, 전지연은 제외)
--@ 오라클
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID 
    AND DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME LIKE '_지연%')
MINUS
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID 
    AND EMP_NAME = (SELECT EMP_NAME
                    FROM EMPLOYEE
                    WHERE EMP_NAME LIKE '_지연%');

--@ 안씨
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    AND DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME LIKE '_지연%')
MINUS
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID 
    AND EMP_NAME = (SELECT EMP_NAME
                    FROM EMPLOYEE
                    WHERE EMP_NAME LIKE '_지연%');

--======================================================================                    
/*
    2. 다중행 서브쿼리 (MULTI ROW SUBQUERY)
        : 서브쿼리를 수행한 결과 값이 여러 행일 때 (컬럼은 한개)
        
    - IN 서브쿼리 : 여러개의 결과값 중 하나라도 일치하는 값이 있다면 
    
    - > ANY 서브쿼리 : 여러 결과값 중, '한개라도' 클 경우
      < ANY 서브쿼리 : 여러 결과값 중, '한개라도' 작을 경우
      => 비교대상 > ANY (서브쿼리 값1, 값2, ...)
      
    - > ALL 서브쿼리 : 여러개의 모든 결과 값들보다 '모두' 클 경우
      < ALL 서브쿼리 : 여러개의 모든 결과 값들 보다 '모두' 작을 경우
        
*/

-- 1) 유재식 또는 윤은해 사원과 같은 직급인 사원들의 사번, 사원명, 직급코드, 급여
    --1_1) 직급 조회
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('유재식', '윤은해'); 
    --1_2) 같은 직급 사원들 조회 
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME IN ('유재식', '윤은해'));
    -- 여러행이 조회되었기 때문에 = 을 쓰면 오류 ( =을 쓰면 J3를 읽어야할지 J7을 읽어야할지 모름) 

-- 사원 => 대리 => 과장 => 차장 => 부장
-- 2) 대리 직급임에도 불구하고 과장직급 급여들 중 최소 급여보다 더 많이 받는 직원 조회 (사번, 이름, 직급, 급여)
    --2_1) 과장 직급 사원들의 급여 조회
SELECT SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '과장'; -- 2200000~3760000
    --2_1) 대리 면서, 급여 값이 위 목록들 값중 하나라도 큰 사원
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > ANY (2200000, 2500000, 3760000);


SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > ANY (SELECT SALARY
                FROM EMPLOYEE E, JOB J
                WHERE E.JOB_CODE = J.JOB_CODE
                AND JOB_NAME = '과장');
                
                
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > (SELECT MIN(SALARY)
                FROM EMPLOYEE E, JOB J
                WHERE E.JOB_CODE = J.JOB_CODE
                AND JOB_NAME = '과장');
                
-- 3) 과장 직급임에도, 차장 직급인 사원들의 모든 급여보다도 더 많이 받는 사원들의 사번, 사원명, 직급명, 급여
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
AND SALARY > ALL (SELECT SALARY 
            FROM EMPLOYEE
            JOIN JOB USING(JOB_CODE)
            WHERE JOB_NAME = '차장');
            
----------------------------------------------------------------------
/*
    3. 다중열 서브쿼리 
        : 결과값은 한 행이지만, 나열된 컬럼 수가 여러개일 경우.
    
*/

-- 1) 하이유 사원과 같은 부서코드, 같은 직급코드에 해당하는 사원들 조회 (사원명, 부서코드, 직급코드, 입사일)
    --> 단일행 서브쿼리로도 가능
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '하이유')
AND JOB_CODE = (SELECT JOB_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '하이유');
                
-- 다중열 서브쿼리로!
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '하이유');
                                
-- 박나라 사원과 같은 직급코드, 같은 사수를 가지고 있는 사원들의 사번, 사원명, 직급코드, 사수사번 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '박나라');
                                
----------------------------------------------------------------------------
/*
    4. 다중 행, 다중 열 서브쿼리
        : 서브쿼리 조회 결과 값이 여러 행, 열일 경우
*/

-- 1) 각 직급별, 최소급여를 받는 사원 조회 (사번, 사원명,직급코드, 급여)
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 1_2)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 3700000 
    OR JOB_CODE = 'J7' AND SALARY = 1380000;
    
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) = ANY (SELECT JOB_CODE, MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);

-- 각 부서별 최고급여를 받는 사원들의 사번, 사원명, 부서코드, 급여
SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) = ANY (SELECT DEPT_CODE, MAX(SALARY)
                                FROM EMPLOYEE
                                GROUP BY DEPT_CODE);
                                

                
                





                    
                    
                    
                    
    