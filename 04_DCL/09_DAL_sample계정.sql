CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(10)
);
-- 01031. 00000 -  "insufficient privileges"
    -- ㄴ 테이블 생성권한 X 
-- 3_1. CREATE TABLE 권한 받기
-- 3_2. TABLESPACE 할당 받기

SELECT * FROM TEST;

INSERT INTO TEST VALUES(10, '안녕');
    --> CREATE TABLE권한 받으면, 테이블 조작 가능 
    
-- 옆 동네 테이블에 접근
SELECT * FROM KH.EMPLOYEE;
--4. SELECT ON KH.EMPLOYEE 권한 받기

INSERT INTO KH.DEPARTMENT VALUES ('D0', '회계부', 'L1');
-- INSERT ON KH.DEPARTMENT 권한 받기

ROLLBACK;


