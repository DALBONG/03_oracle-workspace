/* 
    DQL (QUERYU 데이터 질문 언어)           : SELECT
    
    DML (MANIPULATION 데이터 조작 언어)     : INSERT, UPDATE, DELETE, [SELECT]

    DDL (DEFINITION 데이터 정의 언어)       : CREATE, ALTER, DROP
    
    DCL (CONTROL 데이터 제어 언어)          : GRANT, REVOKE, [COMMIT, ROLLBACK]
    
    TCL (TRANSACTION 트랜젝션 제어 언어)    : COMMIT, ROLLBACK
    

         <DML : 데이터 조작 언어>
         테이블에 값을 삽입 / 수정 / 삭제하는 구문
*/

/*
    1. INSERT (삽입)
      테이블에 새로운 행을 추가하는 구문
      
      [표현식]
      1) INSERT INTO 테이블명 VALUES (값1, 값2,...) : 테이블의 모든 컬럼에 대한 값을 제시해서 한 행 삽입하고자 사용
         -> 컬럼 순번을 지켜 나열해야함, 컬럼 갯수보다 부족하게 값 제시시 NOT ENOUGH VALUES / 많이 제시시 TO MANY VALUES 오류
*/

/*  SELECT * FROM CLASS;
CREATE TABLE CLASS( CL_NO NUMBER,  CL_NAME VARCHAR2(5),  학년 NUMBER  --> 한글 컬럼명도 가능! BUT 좋진 않음 */ 


INSERT INTO EMPLOYEE VALUES (900, '차응우', '900143-4374233', 'car_94@kh.or.kr', '01027372734', 'D1', 'J7', 'S3', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT);
SELECT * FROM EMPLOYEE;

/*
      2) INSERT INTO 테이블명 (컬럼명, 컬럼명, 컬럼명) VALUES (값, 값, 값) : 
         -> 테이블에 내가 선택한 컬럼에 대한 값만 INSERT할 때 사용, 한행 단위로 추가되기에 선택되지 않은 컬럼은 NULL이 들어감. 
            (NOT NULL 제약조건이 걸려있는 컬럼은 반드시 선택해서 직접 값 제시)
            단, DEFAULT 값이 있는 경우 NULL이 아닌 DEFAULT값 들어감
*/

INSERT 
  INTO EMPLOYEE (
        EMP_ID
        , EMP_NAME
        , EMP_NO
        , JOB_CODE
        , SAL_LEVEL
        , HIRE_DATE)
VALUES (
        901
        , '박부검'
        , '840223-1234233'
        , 'J1'
        , 'S2'
        , SYSDATE
        );
        
SELECT * FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
      3) INSERT INTO 테이블명 (서브쿼리) 
         : VALUES로 값을 직접 명시하는 대신, 서브쿼리로 조회된 결과값을 통째로 INSERT 가능
*/

CREATE TABLE EMP_O1(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_O1;

-- 전체 사원들의 사번, 이름, 부서명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

INSERT INTO EMP_O1(SELECT EMP_ID, EMP_NAME, DEPT_TITLE
                     FROM EMPLOYEE
                LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID));
                
SELECT * FROM EMP_O1;
--------------------------------------------------------------------------------
/*
    2. INSERT ALL
      테이블에 새로운 행을 추가하는 구문
*/

-- 구조만 배끼기
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0;
    
CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0;
    
SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;
름, 부서코드, 입사일, 사수사번 조회
-- 부서코드가 D1인 사원들의 사번, 이
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

/*
    [INSERT ALL 표현식]
    INSERT ALL
    INTO 테이블명1 VALUES(컬럼명, 컬럼명, ...)
    INTO 테이블명2 VALUES(컬럼명, 컬럼명, ...)
    서브쿼리;
*/

INSERT ALL 
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
    
-- 조건을 사용해서 각 테이블에 INSERT 가능.
-- 입사일 2000년 전 입사자들에 대한 정보를 담을 테이블
CREATE TABLE EMP_OLD
  AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
       FROM EMPLOYEE
      WHERE 1=0;


-- 입사일 2000년 후 입사자들에 대한 정보를 담을 테이블
CREATE TABLE EMP_NEW
  AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
       FROM EMPLOYEE
      WHERE 1=0;
      
/*
    [표현식]
     INSERT ALL 
     WHEN 조건1 THEN
        INTO 테이블1 VALUES (컬럼명, 컬럼명, ...)
     WHEN 조건2 THEN
        INTO 테이블2 VALUES (컬럼명, 컬럼명, ...)
     서브쿼리
*/

INSERT ALL
  WHEN HIRE_DATE < '2000/01/01' THEN
  INTO EMP_OLD VALUES (EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
  WHEN HIRE_DATE > '2000/01/01' THEN
  INTO EMP_NEW VALUES (EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
  FROM EMPLOYEE;
  
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

-- 실전에선 1-2 방법 제일 많이 사용!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

--==============================================================================
--==============================================================================
--==============================================================================
--==============================================================================
--==============================================================================
--==============================================================================
--==============================================================================
/*
    3. UPDATE 
     : 테이블에 기록되어 있는 기존의 데이터를 수정
     
     [표현식]
     UPDATE 테이블명
        SET 컬럼명 = 바꿀 값,
            컬럼명 = 바꿀 값,...     --> (여러개의 컬럼값 동시에 변경 가능)
    [WHERE] 조건  --> 생략 가능하나, 전체 테이블에 있는 모든행의 데이터가 변경됨, 꼭 조건 쓰기!
*/

-- 복사본 테이블 만들어서 작업
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPARTMENT;

-- D9 부서의 부서명을 전략기획팀으로 수정
UPDATE DEPARTMENT
   SET DEPT_TITLE = '전략기획팀'  -- 총무부 (데이터 바꾸기 전, 이전 데이터 백업)
 WHERE DEPT_ID = 'D9';
 
-- 업데이트 되돌리기 : ROLLBACK; 

-- 복사본 떠서 진행
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;
    
SELECT * FROM EMP_SALARY;
-- 노옹철 사원의 급여를 100으로 변경,  --데이터 백업
UPDATE EMP_SALARY
   SET SALARY = 1000000  --> 3700000
 WHERE EMP_NAME = '노옹철';  -->  이 방법도 되긴 되나, 동명이인이 있을 수 있으므로 중복값 없는 EMP_ID 202로 수정 
 

-- 선동일 사원의 급여를 700으로, 보너스도 0.2로 변경
SELECT * FROM EMP_SALARY;

UPDATE EMP_SALARY, BONUS 
   SET SALARY = 7000000  --> 8000000
 WHERE EMP_NAME = '선동일';
 
 UPDATE EMP_SALARY
   SET BONUS = 0.2  --> 0.3
 WHERE EMP_NAME = '선동일';

-- 전체 사원의 급여를 기존 급여의 10% 인상한 금액
 UPDATE EMP_SALARY
   SET SALARY = SALARY*1.2;  --> 0.3

-----------------------------------------------------------------
 -- UPDATE시 서브쿼리 사용
 /*
    UPDATE 테이블명
       SET 컬럼명 = (서브쿼리)
     WHERE 조건;
 */
 
-- 방명수 사원의 급여, 보너스 값을 유재식 사원의 급여와 보너스 값으로 변경.
SELECT * FROM EMP_SALARY
    WHERE EMP_NAME = '방명수';
    
UPDATE EMP_SALARY
   SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME = '유재식') -- 유재식의 SALARY 4080000
     , BONUS  = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME = '유재식')-- 유재식의 BONUS
 WHERE EMP_ID = 214;
 
-- 다중열 서브쿼리
UPDATE EMP_SALARY
    SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY WHERE EMP_NAME = '유재식')
 WHERE EMP_ID = 214;
 
 --ASIA 지역에서 그눔하는 사원들의 보너스 값을 0.3 ㅇ,ㅡ로 변경
 SELECT EMP_ID
 FROM EMP_SALARY
 JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

UPDATE EMP_SALARY
 SET BONUS = 0.3
WHERE EMP_ID IN( SELECT EMP_ID
                 FROM EMP_SALARY
                JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                WHERE LOCAL_NAME LIKE 'ASIA%');
                
SELECT * FROM EMP_SALARY;

------------------------------------------------------------------------
-- UPDATE시에도 해당 컬럼에 대한 제약조건에 위배되면 안됨.
  -- 사번이 200번인 사원의 이름을 NULL로 변경

UPDATE EMPLOYEE
 SET EMP_NAME = NULL
 WHERE EMP_ID = 200;
 -- NOT NULL 제약조건 위배  ORA-01407: cannot update ("KH"."EMPLOYEE"."EMP_NAME") to NULL

-- 노옹철 사원의 직급코드를 J9로 변경.
SELECT * FROM JOB; -- (J1 ~ J7)
UPDATE EMPLOYEE
SET JOB_CODE = 'J9'
WHERE EMP_ID = 203;
 -- ORA-02291: integrity constraint (KH.SYS_C007117) violated - parent key not found
 -- 외래키(FL) 제약조건 위배

---############################################################################
---############################################################################
---############################################################################
---############################################################################
---############################################################################
---############################################################################
---############################################################################
---############################################################################
COMMIT;

/*
    4. DELETE
     : 테이블에 기록된 데이터를 삭제하는 구문 (한 행 단위로 삭제)
     
     [표현식]
     DELECT FROM 테이블명
     [WHERE 조건];  --> WHERE 절 제시 안하면 전체 행 삭제 
*/

-- 차응우 사원의 데이터 지우기 
-- ROLLBACK; : 커밋 시점으로 돌아감

SELECT * FROM EMPLOYEE;

DELETE FROM EMPLOYEE
WHERE EMP_ID = 900;

DELETE FROM EMPLOYEE
WHERE EMP_ID = 901;

COMMIT; -- 완전 확정

-- DEPT_ID가 D1부서를 삭제 
DELETE FROM DEPARTMENT 
WHERE DEPT_ID = 'D1';
 -- ORA-02292: integrity constraint (KH.SYS_C007116) violated - child record found
 -- 외래키 제약조건 위반
 -- D1의 값을 가져다 쓰는 자식데이터가 있기 때문에 삭제 불가.
 
 -- DEPT_ID가 D3인 부서 삭제
 DELETE FROM DEPARTMENT
  WHERE DEPT_ID = 'D3';
  
SELECT * FROM DEPARTMENT;
ROLLBACK;

---------------------------------------------------
 -- TRUNCATE : 테이블 전체 행을 삭제할 때 사용되는 구문.
    -- DELETE 보다 수행속도가 빠름.
    -- 별도의 조건제시 불가, ROLLBACK이 불가. 
     
-- [표현식]  TRUNCATE TABLE 테이블명;

SELECT * FROM EMP_SALARY;
TRUNCATE TABLE EMP_SALARY;

ROLLBACK;















