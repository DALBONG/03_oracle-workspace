/*
    <JOIN>
    2개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
    조회결과는 하나의 결과물(Result Set)로 나옴
    
    관계형 데이터베이스는 최소한의 데이터로 각각의 테이블에 데이터를 담고 있음
    (중복 최소화 하기 위해 최대한 쪼개서 관리)
    
  -- 어떤 사원이 어떤 부서에 속해있는지 궁금하네
    => 관계형 데이터베이스에서 SQL문을 이용한 테이블간의 관계를 맺는 방법
     (다 조회를 해오는게 아니라, 각 테이블간 연결고리 데이터를 매칭시켜 조회)
     
            JOIN은, "오라클 전용 구문"  과   "ANSI(미국국립표준협회) 구문" (ASCII코드 만든 곳)
            
                                [JOIN 용어 정리]
         [오라클 전용 구문]             ||                 [ANSI 구문]
         =============================================================================
         등가 조인 (EQUAL JOIN)        ||  내부 조인 INNER(JOIN) // 자연 조인(NATURAL JOIN)
         ------------------------------------------------------------------------------
            포괄 조인                  ||  왼쪽 외부 조인 (LEFT OUTER JOIN)
          (LEFT OUTER)                ||  오른쪽 외부 조인 (RIGHT OUTER JOIN)
          (RIGHT OUTER)               ||  전체 외부 조인 (FULL OUTER JOIN)
         ------------------------------------------------------------------------------
         자체 조인 (SELF JOIN)         || JOIN ON
         비등가 조인(NON EQUAL JOIN)   ||
*/


-- 전체 사원들의 사번, 사원명, 부서코드, 부서명 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 전체 사원들의 사번, 사원명, 직급코드, 직급명 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;

/*
    1. 등가 조인 (EQUAL JOIN)  / 내부 조인(INNER JOIN)
        : 연결시키는 컬럼 값이 일치하는 행들만 조인되어 조회 
         (일치하는 값이 없는 행은 조회에서 제외)
*/
-- @@ 오라클 전용 구문활용
    -- FROM절에 조회하고자 하는 테이블 나열 ( ',' 구분자로 )
    -- WHERE절에 매칭시킬 컬럼(연결고리)에 대한 조건을 제시.
    
-- 1) 연결할 두 컬럼 명이 다른 경우 (EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID)
    -- 사번, 사원명, 부서코드, 부서명 같이 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID; -- 일치하는 값이 없는 2명은 NULL로 조회에서 제외, 

-- 2) 연결 할 두 컬럼 명이 같은 경우 (EMPLOYEE, JOB 테이블 둘다 : JOB_CODE)
    -- 사번, 사원명, 직급코드, 직급명
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE = JOB_CODE; --> ambiguously (애매한, 모호한) 

--> 해결방법 A : 테이블명 이용
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE; 

--> 해결방법 B : 테이블에 별칭부여하여 이용
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE; 

--@@@
--@@@@
--@@@@@
--@@@@@@
--@@@@@@  
    -- @ANSI 구문
    -- FROM절에 기준이 되는 테이블을 하나 기술 후, 
    -- JOIN 절에 같이 조회하고자 하는 테이블 기술 + 매칭시킬 컬럼에 대한 조건
        -- JOIN USING, JOIN ON

-- 1) 연결할 두 컬럼명이 다른 경우 (EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID)
    -- JOIN ON 구문으로만 가능.
-- 사원, 사원명, 부서코드, 부서명 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 2) 연결할 두 컬럼명이 같은경우 ((EMPLOYEE, JOB 테이블 둘다 : JOB_CODE)
    -- JOIN ON, JOIN USING 구문 사용 가능
-- 사번, 사원명, 직급코드, 직급 명
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB ON (JOB_CODE = JOB_CODE);

-- 해결방법 A) 테이블 명 또는 별칭 이용 방법
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

-- 해결방법 B) JOIN USING 구문 활용
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

--- 3. 자연 조인 [참고사항, 많이 쓰이진 않음]
    -- NATURAL JOIN : 각 테이블마다 동일한 컬럼이 한개만 존재할 경우.
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- 추가적 조건 제시
-- 직급명이 대리인 사원의 이름, 직급명, 급여 조회
--@오라클 구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND J.JOB_NAME = '대리';

--@안씨 구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리';


--============================[실습 문제]==================================
--1. 부서가 인사관리부인 사원들의 사번, 이름, 보너스 조회
--@ 오라클
    -- DEPT_ID
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE = '인사관리부';

--@ 안씨
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID AND DEPT_TITLE = '인사관리부';


--2. DEPARTMENT와 LOCATION을 참고하여 전체 부서의 부서코드, 부서명, 지역코드, 지역명 조회
--@ 오라클
SELECT DEPT_CODE, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME 
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE;

--@ 안씨
SELECT DEPT_CODE, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME 
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회 
--@ 오라클
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND BONUS IS NOT NULL;

--@ 안씨
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID AND BONUS IS NOT NULL;

--4. 부서가 총무부가 아닌 사원들의 사원명, 급여, 부서명 조회
--@ 오라클
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE <> '총무부';

--@ 안씨
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID AND DEPT_TITLE <> '총무부';
    --> 현재 DEPT_CODE가 NULL인 것들은 나오지 않고 있음.


/*
    2. 포괄조인 / 외부 조인 (OUTER JOIN)
        : 두 테이블의 JOIN시 일치하지 않는 행도 포함시켜 조회 가능
         단, LEFT / RIGHT 지정해야 함 (기준이 되는 테이블 지정)
*/

-- 사원명, 부서명, 급여, 연봉
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; 
    -- 부서배치가 안된 사원(NULL) + 부서에 배정된 사원이 없는 부서 조회 X

--@ 안씨 구문
-- 1) LEFT [OUTER] JOIN
    -- : 두 테이블중 왼쪽에 기술된 테이블 기준으로 JOIN
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE --> EMPLOYEE 테이블은 다 나옴.
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
    --> 부서배치 받지 못한 2명의 사원 정보도 조회
    
--@ 오라클 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- 기준으로 삼고자 하는 테이블의 반대편 컬럼 뒤에 '+' 붙이기

-- 2) RIGHT [OUTER] JOIN

    --@ 안씨 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; 

    --@ 오라클 전용 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID; 

-- 3) FULL [OUTER] JOIN
    -- : 두 테이블의 모든 행 조회 (단, 안씨구문으로만 가능)
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; 


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


--  3.자체 조인 (SELF 조인)
    -- : 같은 테이블을 다시 한번 조인하는 경우

SELECT * FROM EMPLOYEE;

--전체 사원의 사번, 사원명, 사원부서코드를 구하고,        --> EMPLOYEE E 
    -- 사수가 있다면, 사수의 사번, 사수명, 사수부서 코드. --> EMPLOYEE M 
    
--@ 오라클 전용 구문

SELECT E.EMP_ID "사원사번", E.EMP_NAME "사원이름", E.DEPT_CODE, M.EMP_ID "사수사번", M.EMP_NAME "사수이름", M.DEPT_CODE
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID
ORDER BY 1;

--@ 안씨 구문
SELECT E.EMP_ID "사원사번", E.EMP_NAME "사원이름", E.DEPT_CODE "사원부서", M.EMP_ID "사수사번", M.EMP_NAME "사수이름", M.DEPT_CODE "사수부서"
FROM EMPLOYEE E
JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID
ORDER BY 1;


/*
    < 다중 조인 >
    2개 이상의 테이블을 가지고 JOIN
*/

SELECT * FROM EMPLOYEE; -- DEPT_CODE, JOB_CODE 
SELECT * FROM DEPARTMENT; -- DEPT_ID
SELECT * FROM JOB;

--@ 오라클 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

--@ 안씨 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID 
JOIN JOB J USING (JOB_CODE);


-- 사번, 사원명, 부서명, 지역명
SELECT * FROM EMPLOYEE; -- DEPT_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID, LOCATION_ID
SELECT * FROM LOCATION; -- LOCAL_CODE

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE;

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

--=================[실습 문제]========================
-- 1. 사번, 사원명, 부서명, 지역명, 국가명 조회
--@ 오라클 전용 구문
SELECT * FROM EMPLOYEE; -- DEPT_CODE 
SELECT * FROM DEPARTMENT; -- DEPT_ID, LOCATION_ID
SELECT * FROM LOCATION;             -- LOCAL_CODE, NATIONAL_CODE
SELECT * FROM NATIONAL;                         -- NATIONAL_CODE, 

SELECT EMP_ID "사번", EMP_NAME "사원 명", DEPT_TITLE "부서명", LOCAL_NAME "지역명", NATIONAL_NAME "국가명"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND L.NATIONAL_CODE = N.NATIONAL_CODE;

--@ 안씨 구문
SELECT EMP_ID "사번", EMP_NAME "사원 명", DEPT_TITLE "부서명", LOCAL_NAME "지역명", NATIONAL_NAME "국가명"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
JOIN NATIONAL N USING (NATIONAL_CODE);

-- 2. 사번, 사원명, 부서명, 직급명, 지역명, 국가명, 해당 급여 등급에서 받을 수 있느 최대 금액 조회 
SELECT * FROM JOB;         -- JOB_CODE 
SELECT * FROM EMPLOYEE;   -- JOB_CODE, DEPT_CODE, SAL_LEVEL
SELECT * FROM DEPARTMENT;              -- DEPT_ID, LOCATION_ID
SELECT * FROM LOCATION;                         -- LOCAL_CODE, NATIONAL_CODE
SELECT * FROM NATIONAL;                                      --NATIONAL_CODE
SELECT * FROM SAL_GRADE;                        -- SAL_LEVEL

--@ 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE "부서명", JOB_NAME "직급명", LOCAL_NAME "지역명", NATIONAL_NAME "국가명", MAX_SAL "최대 금액"
FROM JOB J, EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE E.JOB_CODE = J.JOB_CODE 
AND E.SAL_LEVEL = S.SAL_LEVEL
AND E.DEPT_CODE = D.DEPT_ID
AND D.LOCATION_ID = L.LOCAL_CODE
AND L. NATIONAL_CODE = N.NATIONAL_CODE;

--@ 안씨 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE "부서명", JOB_NAME "직급명", LOCAL_NAME "지역명", NATIONAL_NAME "국가명", MAX_SAL "최대 금액"
FROM JOB J
JOIN EMPLOYEE E USING (JOB_CODE)
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
JOIN NATIONAL N ON L. NATIONAL_CODE = N.NATIONAL_CODE
JOIN SAL_GRADE S USING (SAL_LEVEL);























