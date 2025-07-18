/*
    <VIEW>
     SELECT문을 저장해둘 수 있는 객체 
     (자주 쓰는 긴 SELECT문을 저장해두면, 긴 SELECT문을 매번 다시 기술할 필요 없음)
     (임시 테이블 같은) (실제 데이터가 담겨있는 건 아님, 보여주기 용.)
     
     물리적 테이블 : 실제 데이터가 담겨있는 것. 
     논리적 테이블 : 가상 (뷰는 논리적 테이블)
*/

-- 뷰를 만들기 위한 복잡한 쿼리문 작성
--관리자 페이지

-- '한국'에서 근무하는 사원들의 삽번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국';


-- '러시아'에서 근무하는 사원들의 삽번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '러시아';

-- '일본'에서 근무하는 사원들의 삽번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '일본';

-----
/*
    1. 뷰 생성
    
    [표현식]
    CREATE [OR REPLACE] VIEW 뷰명 
    AS 서브쿼리;
    
    OR REPLACE : 기존 중복된 뷰명이 없으면 생성, 있으면 변경
*/

CREATE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE);
    --> ORA-01031: insufficient privileges(권한 없음)
        -- 관리자 계정에서 뷰 생성 권한 받아야 함.

--잠시 관리자 권한으로 변경, 권한 부여 후 다시 계정으로 돌아오기
-- GRANT CREATE VIEW TO KH;

SELECT * FROM VW_EMP;
    --> 실제 있는 테이블이 아님 (가상.논리 테이블)

SELECT *
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE)); -- ? 인라인 뷰
    
-- 한국에서 근무하는 사원
SELECT *
FROM VW_EMP
WHERE NATIONAL_NAME = '러시아';

-- VIEW에 컬럼 추가 하고 싶어
CREATE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE);
-- ORA-00955: name is already used by an existing object (이미 사용중인 이름)
--> 해결 방법 : 삭제후 다시 만드는 법도 있지만 OR REPLACE 구문 추가 

CREATE OR REPLACE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE);
    
------------------------------
-- 전 사원의 사번, 이름, 직급명, 성별(남/여), 근무년수를 조회할 수 있는 SELECT문을 뷰(VW_EMP_JOB)으로 정의

CREATE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여'), 
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
     FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE);
  --> ORA-00998: must name this expression with a column alias 
    -- 뷰 생성시 서브쿼리의 SELECT절에 함수식이나 산술연산식이 기술되어 있을 경우 별칭을 부여해야함.

SELECT * FROM VW_EMP_JOB;

-- 모든 것에 별칭부여 
CREATE OR REPLACE VIEW VW_EMP_JOB(사번, 이름, 직급명, 성별, 근무년수)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') AS "성별", 
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "근무년수"
     FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE);

SELECT * FROM VW_EMP_JOB;
SELECT 성별, 이름
FROM VW_EMP_JOB;

SELECT * 
FROM VW_EMP_JOB
WHERE 근무년수 >= 20;

-- 뷰 삭제하고 싶어?
DROP VIEW VW_EMP_JOB;

----------------------------
-- 생성된 뷰를 이용해 DML사용 가능
-- 뷰를 통해 조작하더라도 실제 테이블에 반영 되나, 잘 안되는 경우가 많아 실제로 많이 쓰이진 않음.

CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
FROM JOB;

SELECT * FROM VW_JOB; -- 논리 테이블
SELECT * FROM JOB;    -- 물리 테이블

-- 뷰를 통해 INSERT
INSERT INTO VW_JOB VALUES('J8', '인턴');
-- 뷰를 통해 UPDATE
UPDATE VW_JOB
SET JOB_NAME = '알바'
WHERE JOB_CODE = 'J8';
-- 뷰를 통해 DELETE 
DELETE FROM VW_JOB
WHERE JOB_CODE = 'J8';

---------------------------------------
/*  단, DML 명령어로 조작이 불가능한 경우. (훨씬 더 많음)
    1) 뷰에 정의되어 있지 않은 컬럼을 조작하려 하는 경우.
    2) 뷰에 정의되어 있지 않은 컬럼중, 베이스 테이블 상에 NOT NULL 제약조건이 지정되어 있는 경우 
    3) 산술 연산식 또는 함수식으로 정의되어 있는 경우
    4) GROUP BY, 그룹함수 포함된 경우
    5) DISTINCT 구문이 포함된 경우
    6) JOIN을 이용해서 여러 테이블을 연결시켜 놓은 경우
      ==> 뷰는 조회하려 만든것! DML은 하지 말자.. 
*/

SELECT * FROM VW_JOB;
SELECT * FROM JOB;


--    1) 뷰에 정의되어 있지 않은 컬럼을 조작하려 하는 경우.
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE FROM JOB;

--    INSERT
INSERT INTO VW_JOB VALUES ('J8', '인턴'); -- 에러

--    UPDATE
UPDATE VW_JOB
SET JOB_NAME = '인턴'
WHERE JOB_CODE = 'J7';
    -- SQL 오류: ORA-00904: "JOB_NAME": invalid identifier
    
-- DELETE
DELETE FROM VW_JOB
WHERE JOB_NAME = '사원';

--    2) 뷰에 정의되어 있지 않은 컬럼중, 베이스 테이블 상에 NOT NULL 제약조건이 지정되어 있는 경우 
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT * FROM VW_JOB; -- JOB_CODE NN 걸려있음

-- 삽입 불가
INSERT INTO VW_JOB VALUES ('인턴');

-- 업뎃 가능
UPDATE VW_JOB
SET JOB_NAME = '알바'
WHERE JOB_NAME = '사원';

-- 제거 가능
DELETE FROM VW_JOB
WHERE JOB_NAME = '사원';

--    3) 산술 연산식 또는 함수식으로 정의되어 있는 경우
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 "연봉"
    FROM EMPLOYEE;
    
SELECT * FROM VW_EMP_SAL;
SELECT * FROM EMPLOYEE;

INSERT INTO VW_EMP_SAL VALUES (400, '차흔후', 3000000, 36000000);
    --> SQL 오류: ORA-01733: virtual column not allowed here (가상컬럼 불가)
     -- 원본 테이블에 연봉 컬럼이 없음, 불가.
    
UPDATE VW_EMP_SAL 
SET SALARY = 7000000
WHERE EMP_ID = 200;

ROLLBACK;

DELETE FROM VW_EMP_SAL
WHERE 연봉 = 72000000;

ROLLBACK;

--    4) GROUP BY, 그룹함수 포함된 경우
CREATE OR REPLACE VIEW VW_GROUP_DEPT
AS SELECT DEPT_CODE, SUM(SALARY) "합계", FLOOR(AVG(SALARY)) "평균"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT * FROM VW_GROUP_DEPT;

INSERT INTO VW_GROUP_DEPT VALUES ('D3', 8000000, 4000000);
    -- SQL 오류: ORA-01733: virtual column not allowed here

UPDATE VW_GROUP_DEPT
SET 합계 = 8000000
WHERE DEPT_CODE = 'D1';
    -- SQL 오류: ORA-01732: data manipulation operation not legal on this view
    
DELETE VW_GROUP_DEPT
WHERE 합계 = 5210000;

--    5) DISTINCT 구문이 포함된 경우
CREATE OR REPLACE VIEW VDJ
AS SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT * FROM VDJ;

INSERT INTO VDJ VALUES('J8'); -- 에러

UPDATE VDJ 
SET JOB_CODE = 'J8'
WHERE JOB_CODE = 'J7';

DELETE FROM VDJ 
WHERE JOB_CODE = 'J4';

--    6) JOIN을 이용해서 여러 테이블을 연결시켜 놓은 경우
CREATE OR REPLACE VIEW VW_J
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT * FROM VW_J;

INSERT INTO VW_J VALUES (300, '장원영', '총무부');
    -- SQL 오류: ORA-01776: cannot modify more than one base table through a join view

UPDATE VW_J
SET EMP_NAME = '선동이'
WHERE EMP_ID = 200;

ROLLBACK;

UPDATE VW_J
SET DEPT_TITLE = '회계부'
WHERE EMP_ID = 200;
 -- SQL 오류: ORA-01779: cannot modify a column which maps to a non key-preserved table

DELETE FROM VW_J
WHERE EMP_ID = 200;

ROLLBACK;

--> VIEW를 통해 그냥, DML 하지 말자.. ^^

/*
        VIEW 옵션
          
        [상세 표현식]
          CREATE [OR REPLACE] [FORCE | NOFORCE ] VIEW 뷰명
          AS 서브쿼리
          [WITH CHECK OPTION]
          [WITH READ ONLY];
          
        
        1) OR REPLACE       : 기존 동일한 뷰 있을 시 갱신, 없을 시 생성
        2) FORCE | NO FORCE 
            - FORCE   : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰가 생성되게 하는.
            - NOFORCE : 서브쿼리에 기술된 테이블이 존재해야만 뷰가 생성
        3) WITH CHECK OPTIOM : DML시 서브쿼리에 기술된 조건에 부합한 값으로만 DML 가능
        4) WITH READ ONLY : 뷰에 대해 조회만 가능 (DML 불가)

*/

-- 2) FORCE | NOFORCE
CREATE OR REPLACE /*NOFORCE*/ VIEW VEW_EMP
AS SELECT TCODE, TNAME, TCONTENT 
FROM TT;
    -- ORA-00942: table or view does not exist (해당 테이블 없음) 
    
CREATE OR REPLACE FORCE VIEW VEW_EMP
AS SELECT TCODE, TNAME, TCONTENT 
FROM TT;
    -- 경고: 컴파일 오류와 함께 뷰가 생성되었습니다. (만들어지긴 함)
    
SELECT * FROM VEW_EMP;
CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR2(30)
);

-- 3) WITH CHECK OPTION : 서브쿼리의 기술된 조건에 부합되지 않는 값으로 수정시 오류 발생
-- WITH CHECK OPTION 안쓰고
CREATE OR REPLACE VIEW VEW_EMP
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000;
    
SELECT * FROM VEW_EMP;
    
UPDATE VEW_EMP
SET SALARY = 2000000 -- 8000000
WHERE EMP_ID = 200;

ROLLBACK;
    
-- WITH CHECK OPTION 쓰고
CREATE OR REPLACE VIEW VEW_EMP
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000
WITH CHECK OPTION;

SELECT * FROM VEW_EMP;

UPDATE VEW_EMP
SET SALARY = 2000000 -- 8000000
WHERE EMP_ID = 200;
    --> ORA-01402: view WITH CHECK OPTION where-clause violation 
        -- 서브쿼리에 기술한 조건에 부합되지 않아 변경 불가.
UPDATE VEW_EMP
SET SALARY = 4000000 -- 8000000
WHERE EMP_ID = 200;
    --> 서브쿼리에 기술한 조건에 부합되어 변경 가능.
    
ROLLBACK;

-- 4) WITH READ ONLY : 뷰에 대해 조회만 가능 (DML문 수행 불가)
CREATE OR REPLACE VIEW VEW_EMP
AS SELECT EMP_ID, EMP_NAME, BONUS
    FROM EMPLOYEE
    WHERE BONUS IS NOT NULL
WITH READ ONLY;

SELECT * FROM VEW_EMP;

DELETE FROM VEW_EMP
WHERE EMP_ID = 200;
 -- SQL 오류: ORA-42399: cannot perform a DML operation on a read-only view 읽기 전용, 수정 불가.
 
 -- 현업에서 VIEW를 만들일은 없음.









