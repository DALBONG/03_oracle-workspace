/*
 <SELECT>
 데이터 조회할 때 사용되는 구문
  >> 결과 RESULT SET : SELECT 문을 통해 조회된 결과물 (조회된 행동들의 집합)
  
  [표현법]
  SELECT 조회하고자 하는 컬럼1, 컬럼2,... 
  FROM 테이블명;
       * 반드시 존재하는 컬럼으로 써야 함. 없는 컬럼을 쓰면 오류.
    
*/

-- EMPLOYEE 테이블의 모든 컬럼(== *) 조회
-- SELECT EMP_ID, EMP_NAME
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사 번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- JOB 테이블의 모든 컬럼 조회
SELECT *
FROM JOB;
------------------------------------------------------------------------------
-- ===============================실습문제=====================================

-- 1. JOB테이블의 직급 명만 조회
SELECT JOB_NAME
FROM JOB;

-- 2. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT;

-- 3. DEPARTMENT 테이블의 부서 코드, 부서명만 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 4. EMPLOYEE  테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
 < 컬럼 값을 통한 산출 연산>
 SELECT절 컬럼명 작성 부분에 산술연산 기술 가능 (산출 연산된 결과 조회)
*/

-- EMPLOYEE 테이블의 사원명, 사원의 연봉 조회 (급여*12)
SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명 급여 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

-- EMPLOYEE 사원명, 급여, 보너스, 연봉, 보너스 포함된 연봉조회 
SELECT EMP_NAME, SALARY, BONUS, SALARY*12, (SALARY+SALARY*BONUS)*12
FROM EMPLOYEE;
  --> 산술 연산 과정중 null값이 있을 경우 산술연산한 결과값도 null로 출력
  
-- EMPLOYEE 사원명 입사일
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE 사원명, 입사일, 근무일수(오늘날짜 - 입사일)
-- ORACLE은 date 형식끼리 연산 가능
   --> 오늘날짜 : SYSDATE
SELECT EMP_NAME, SYSDATE-HIRE_DATE  
FROM EMPLOYEE;  
--> 결과값은 일 단위로 맞으나 DATE형식이 년,월,일,시,분,초 단위도 관리를 하여 소수점까지 나올 수 있음.

--==============================================================================
/*
    <컬럼 명에 별칭 지정하기>
    산술 연산을 할 경우 컬럼명 지저분해짐. 이때 컬럼명에 별칭 부여하여 깔끔히 보여줌
    
    (표현법)
    컬럼명 별칭  /  컬럼명 AS   / 컬럼명 "별칭"  / 컬럼명 AS "별칭"
     -  AS 붙이든 안붙이든, 부여하고자 하는 별칭에 띄어쓰기 혹은 특문이 포함될 경우
        반드시 " " 로 기술해야 함.
*/

SELECT EMP_NAME 사원명, SALARY AS 급여, SALARY*12 "연봉(원)", (SALARY + SALARY*BONUS)*12 AS "총소득"
FROM EMPLOYEE;


/*
   <리터럴>
   임의로 지정한 문자열 (' ')
   SELECT 절 리터럴 제시하면 마치 테이블에 존재하는 데이터처럼 조회가능

*/
-- EMPLOYEE 테이블의 사번, 사원명, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원' AS "단위"
FROM EMPLOYEE;

/*
 <연결 연산자 : || >
 여러 컬럼값들을 하나의 컬럼인 것 처럼 연결
  컬럼값과 리터럴 값을 연결할 수 있음.
  System.out.println("num의 값 : " + num) -> +의 역할과 비슷
*/

-- 사번, 이름, 급여를 하나의 컬럼으로 조회
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

--컬럼 값과 리터럴을 연결
-- ㅇㅇㅇ의 월급은 ㅇㅇㅇ원 입니다. -> 컬럼명 별칭 : 급여정보

SELECT (EMP_NAME || ' 훈련병의 월급은 ' || SALARY || '원 입니다.' ) AS "급여정보"
FROM EMPLOYEE;

--==================================================================
/*
 <DISTINCT>
 컬럼의 중복된 값들을 한번씩만 표시하고자 할 때 사용
*/

-- 현재 우리 회사에 어떤 직급의 사람들이 존재하는가? 
SELECT JOB_CODE 
FROM EMPLOYEE; --> 23명의 직급 모두 조회

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; --> 직급코드 중복 제거 조회 

SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

/* 구문 오류 : DISTINCT는 셀렉절에 한번만 기술 가능.
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
FROM EMPLOYEE;
*/

SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE; 
--===========================================================================

/*
 <WHERE 절>
 조회하고자 하는 테이블로부터 특정 조건에 만족하는 데이터만을 조회하고자 할 떄 사용
 WHERE 조건식을 제시하게 됨.
 조건식에서는 다양한 연산자들 사용 가능.
 
 [표현법]
 SELECT  컬럼1, 컬럼2
 FROM 테이블 명 
 WHERE 조건식;
 
 [비교연산자]
  >, <, >=, <=  : 대소비교
  = : 동등비교
  ^= , != , <> : 동등비교
*/

-- EMPLOYEE 에서 부서코드가 D9인 사원들만 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 부서코드가 D1인 사원들의 사원명, 급여, 부서코드만 조회

SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

--부서코드가 D1이 아닌 사원들의 사번, 사원명, 부서코드 조회
SELECT  EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D1';
--WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

-- 급여가 400만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- 재직중인 사원들의 사번, 이름. 입사일, 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

--=================================실습문제 ================================
-- 1. 급여가 300이상 받는 사람들의 사원명, 급여, 입사일, 연봉
SELECT EMP_NAME, SALARY, HIRE_DATE, SALARY*12 "연봉"
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. 연봉이 5000이상 사원들의 사원명, 급여, 연봉, 부서코드 조회
SELECT EMP_NAME, SALARY, SALARY*12 AS "연봉", DEPT_CODE
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;
--WHERE 연봉 >= 50000000;  --> 옵티마이저 : 오라클의 실행 시스템.
     --> 옵티마이저의 실행계획 순서에 따라 1)FROM > 2)WHERE > 3)SELECT 이기 때문 

-- 3. 직급코드가 'J3'이 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- 부서코드가  D9이면서 급여는 500이상인 사원들의 사번, 사원명, 급여, 부서코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- 부서코드가 D6이거나 급여가 300 이상인 사원들의 사원명,부서코드,급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- 급여가 350이상 부터 600이하까지 받는 사원들의 사원명, 사번, 급여 조회
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;
--======================================================
/*
 <BETWEEN A AND B>
 조건식에서 사용되는, '몇 이상 몇 이하' 인 범위에 대한 조건을 제시할떄 사용되는 연산자 
 
 [표현법]
 비교대상 컬럼 BETWEEN A(값1) AND B(값2)
   -> 해당 컬럼 값이 A이상이고 B 이하인 경우의 데이터만 찾음 
*/
-- 급여가 350이상 부터 600이하까지 받는 사원들의 사원명, 사번, 급여 조회
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;
    --> 이 범위 밖의 사람들을 조회하고 싶다면? 
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
    --WHERE SALARY <= 3500000 OR SALARY >= 6000000;
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
   --> NOT : 논리 부정 연산자로, 컬럼앞 또는 BETWEEN 앞에 기입 가능
   
--입사일이 90/1/1 ~ 01/01/01 사이
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'
--====================================

/*
  <LIKE>
  비교하고자 하는 컬럼값이 내가 제시한 특정 패턴에 만족할 경우 조회
  
  [표현법]
  비교대상 컬럼 LIKE '특정 패턴'
  
    -> 특정패턴 제시시 '%', '_' 를 같은 와일드 카드를 쓸 수 있음.
  - '%' : 0글자 이상
    ex) 비교대상 칼럼 LIKE '문자%' -> 비교대상 컬럼값이 문자로 '시작'되는 것 조회
        비교대상 컬럼 LIKE '%문자' -> 비교 대상 컬럼값이 문자로 '끝'나는 것 조회
        비교대상 컬럼 LIKE '%문자%' -> 비교 대상 컬럼값에 문자가 포함되는 것 조회
        
  - '_' : 1글자 이상
    ex) 비교대상 컬럼 LIKE '_문자' -> 비교대상 컬럼값의 문자 앞에 무조건 한글자가 올 경우 조회
        비교대상 컬럼 LIKE '_ _문자' -> 비교대상 컬럼값의 문자 앞에 무조건 2글자가 올 경우 조회
        비교대상 컬럼 LIKE '_문자_' -> 비교대상 컬럼값의 문자 앞 뒤에 무조건 한글자씩 올 경우 조회
*/
-- 사원들중 성이 전씨인 사원들의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 이름중 하가 포함된 사원들의 사우너명, 주민번호, 전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 이름의 가운데 글자가 하인 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

-- 전화번호의 3번째 자리가 1인 사람들의 사번, 사원명, 전화번호, 이메일 조회 
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- 특이케이스 
  -- 이메일 중 _ 기준으로 앞글자가 3글자인 사원들의 사번, 이름, 이메일 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%'; 
  --> 와일드 카드로 사용하고 있는 문자와 컬럼값에 담긴 문자가 동일하여 조회X 
  --> 무엇이 와일드 카드고 어떤게 데이터 값인지 구분지어줘야함.
  --> 데이터 값으로 취급하고자 하는 값 앞에 나만의 와일드카드를 제시하고 ESCAPE OPTION 으로
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$'; 

--=============================실습문제==============================================

-- 1. EMPLOYEE에서 이름이 '연'으로 끝나는 사람들의 사원명, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. EMPLOYEE에서 전화번호 처음 3자리가 010이 아닌 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 3. EMPLOYEE에서 이름에 '하'가 포함되어 있고, 급여가 240만원 이상인 사원들의 사원명, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%' AND SALARY >= '2400000';

-- 4. DEPARTMENT에서 해외영업무인 부서들의 부서코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '%해외영업%';

---===================================================================
---===================================================================
---===================================================================
---===================================================================
---===================================================================
---===================================================================
---===================================================================
---===================================================================
---===================================================================
---===================================================================
---===================================================================
---===================================================================
---===================================================================
---===================================================================
---===================================================================
---===================================================================
/*
    <IS NULL / IS NOT NULL>
    컬럼 값에 null 이 있을 경우 null 값 비교에 사용되는 연산자
*/

-- 보너스를 받지 않는 사람들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
-- WHERE BONUS = NULL; 
WHERE BONUS IS NULL;   -- NULL값은 IS NULL 로 조회


-- 보너스를 받는 사원들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;  
        -- NOT은 컬럼명 앞 또는 IS뒤에 사용 가능

-- 사수가 없는 사원들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE 
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- 부서배치는 아직 받지 않았지만 보너스는 받는 사원들의 이름, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-------------------------------------------------------------------
/*
    <IN>
    비교대상 컬럼값이 내가 제시한 목록중에 일치 하는 값이 있는지.
    
    [표현법]
    비교대상 컬럼 IN('값1', '값2', '값3',...)
*/

-- DEPT_CODE가 D6이거나 D5인 부서원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN ('D6', 'D5');

--그 외의 사원들 
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D6', 'D5');

--================================================================
/*
    <연산자의 우선순위>
    0. ( ) 안의 연산자
    1. 산술 연산자
    2. 연결 연산자 ||
    3. 비교 연산자 
    4. IS NULL / LIKE / IN 
    5. BETWEEN A AND B
    6. NOT(논리 부정 연산자)
    7. AND(논리 연산자)
    8. OR
*/

--직급 코드가 J7 이거나 J2인 사원들 중 급여가 200이상인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000; 
    --> OR보다 AND 연산이 먼저 되기 때문에 ( ) 연산부터 할 수 있도록
    
    
--==========================실습 문제 =======================================

-- 1. 사수가 없고 부서배치도 받지 않은 사원들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--2. 연봉(보너스 미포함)이 3000이상이고 보너스를 받지 않는 사원들의 사번, 사원명, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS, SALARY*12 AS "연봉"
FROM EMPLOYEE
WHERE SALARY*12 >= 30000000 AND BONUS IS NULL; 

--3. 입사일이 95/01/01 이상이고 부서배치를 받은 사원들의 사번, 사원명, 입사일, 부서코드 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95.01.01' AND DEPT_CODE IS NOT NULL;

--4. 급여가 200이상 500이하이고 입사일이 01.01.01 이상이고, 보너스를 받지 않는 사원들의 
      --사번, 사원명, 급여, 입사일, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM EMPLOYEE
WHERE (SALARY BETWEEN 2000000 AND 5000000) AND HIRE_DATE >= '01.01.01' AND BONUS IS NULL; 


--5. 보너스 포함 연봉이 NULL이 아니고 이름에 '하'가 포함되어 있는 사원들의 
        -- 사번, 사원명, 급여, 보너스 포함연봉 조회 (별칭부여)
SELECT EMP_ID "사번", EMP_NAME "사원이름", SALARY "월급", BONUS "보너스", (SALARY+SALARY*BONUS)*12 AS "연봉"
FROM EMPLOYEE
WHERE (BONUS IS NOT NULL) AND EMP_NAME LIKE '%하%';


--=====================================================================
/*
 <ORDER BY 절>
 가장 마지막 줄에 작성, 실행순서 또한 마지막에 실행;
 
 [표현법]
 SELECT 조회 칼럼, (산술연산, 별칭)
 FROM 조회하고자 하는 테이블 명
 WHERE 조건식
 ORDER BY 정렬하고 싶은 컬럼 | 별칭적는 것 가능 | 컬럼순번 [오름(ASC)/내림차순(DESC)] [NULLS FIRST | NULLS LAST]
    
    - ASC : 오름차순 정렬 (생략시 기본 값)
    - DESC : 내림차순 정렬 
    - NULLS FIRST : 정렬하고자 하는 값에 NULL이 있을 경우 해당 데이터를 맨 앞 배치 (생략시 DESC일 때의 기본 값)
    - NULLS LAST : 정렬하고자 하는 값에 NULL이 있을 경우 해당 데이터를 맨 뒤 배치 (생략시 ASC일 때의 기본 값)

*/


SELECT *
FROM EMPLOYEE
--ORDER BY BONUS;
-- ORDER BY BONUS ASC; --오름차순 정렬일 때 기본적으로 NULLS LAST
--ORDER BY BONUS ASC NULLS FIRST;
-- ORDER BY BONUS DESC; -- 내림차순 정렬일 때 기본적으로 NULLS FIRST
ORDER BY BONUS DESC, SALARY ASC;
   -- 정렬기준 여러개 제시 가능 (첫 기준의 컬럼값이 동일할 경우, 두번째 기준 컬럼으로 정렬)


-- 전체 사원의 사원명, 연봉 조회 (이때 연봉별 내림차순 정렬 조회)
SELECT EMP_NAME, SALARY*12 AS "연봉"
FROM EMPLOYEE
-- ORDER BY 연봉 DESC; -- 별칭 사용 가능
ORDER BY 2 DESC; -- 컬럼 순번 사용 가능, (컬럼 개수보다 큰 숫자 안됨)

 













