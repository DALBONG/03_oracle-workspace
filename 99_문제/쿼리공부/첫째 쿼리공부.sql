/*이거슨 쿼리 공부*/

--############################### QUIZ 1 #####################################--
-- 보너스를 안받지만 부서배치는 된 사원 조회 
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE = NULL;
    --> NULL값에 대해 정상적으로 비교처리X
    --> NULL값 비교할 때 단순한 일반 비교 연산자 통해 비교 X IS NULL or IS NOT NULL 사용
-- 답_
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;
--############################### QUIZ 2 #####################################--
-- 검색하고자 하는 내용
    -- JOB_CODE가 J7 이거나 J6 이면서 SALARY값이 200 이상, BONUS가 있고, 여자이며, 이메일 _앞에 3글자만 있는 사원의 
    -- EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS를 조회
    -- 정상 조회가 된다면 실행결과는 2행이여야 함

-- 위의 내용을 실행시키고자 작성한 SQL문은 아래와 같다.
SELECT EMP_NAME, EMAIL, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
    AND EMAIL LIKE '____%' AND BONUS IS NULL;
    -- 문제점 
    -- 1. AND 연산자, OR 연산자가 있을 경우 AND 연산자가 먼저 (OR부터 먼저 수행되어야 함)
    -- 2. 급여 비교가 잘못되어 있음 이상인데, 초과로 기재.
    -- 3. BONUS가 있는 조건인데 IS NULL로 작성, IS NOT NULL로 비교해야 함.
    -- 4. 여자에 대한 조건 누락
    -- 5. 메일 비교시 네번째 자리의 _로 취급하기 위해서 와일드카드 부여하여 ESCAPE옵션 부여해야 함
--> 답)

SELECT EMP_NAME, EMAIL, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
    AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL
    AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4');
    
--############################### QUIZ 3 #####################################--
-- [계정 생성 구문] CREATE USER 계정명 IDENTIFIED BY 비밀번호;
-- 계정명 SCOTT, 비밀번호 TIGER 계정을 생성하고 싶음.
-- 이때 일반 사용자 계정에 접속하여 명령함,
-- CREATE USER SCOTT; 실행하니 문제발생
    -- 문제점1. 사용자 계정 만들 때, 관리자 계정에서만 가능.  -> 조치 1: 관리자 계정으로 접속
         -- 2. SQL문이 잘못되었음. 비밀번호까지 입력해야 함. -> 조치 2: CREAT USER SCOTT IDENTIFIED BY TIGER; 실행

-- 위의 SQL문 실행 후 접속을 만들어 접속을 하려 했더니 실패.
-- 뿐만 아니라, 해당 계정에 테이블 생성도 되지 않음.
    -- 문제점1. 사용자 계정 생성후 최소한의 권한 부여가 안됨. -> 조치 1: GRANT CONNECT, RESOURCE TO SCOTT;
    