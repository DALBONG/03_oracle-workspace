/*
    DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
         : 객체들을 생성, 변경, 삭제하는 구문
         
    < ALTER >
    객체를 변경하는 구문.

    [표현식]
    ALTER TABLE 테이블명 변경할 내용;
    
    * 변경할 내용
    1) 컬럼 추가/수정/삭제
    2) 제약조건  추가/삭제 (수정 불가, 삭제후 새로 추가해야 함)
    3) 컬럼명 / 테이블명 수정
*/

-- 1) 컬럼 추가/수정/삭제
-- 1-1) 컬럼 추가 (ADD) : ADD 컬럼명 자료형 [DEFAULT 기본값] [제약조건]
-- DEPT_COPY C_NAME 컬럼 추가
SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);

-- LNAME 컬럼 추가, (기본값 지정)
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';

-- 1-2) 컬럼 수정 (MODIFY)
    -- 자료형 수정           --> MODIFY 컬럼명 바꿀자료형
    -- DEFAULT 값 수정      --> MODIFY 컬럼명 DEFAULT 바꿀 기본값
    
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
    -- 존재하는 데이터가 없어야만 자료형 자체를 변경 가능.
        -- ORA-01439: column to be modified must be empty to change datatype
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
    -- 존재하는 데이터가 변경하려는 길이보다 커 수정 불가 
        -- ORA-01441: cannot decrease column length because some value is too big

SELECT * FROM DEPT_COPY;
-- DEPT_TITEL 컬럼을 VARCHAR2(50)로
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR(50);

-- LOCATION_ID 컬럼을 VARCHAR2(4)로
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR(4);

-- LNAME 컬럼의 기본값을 '미국'으로 변경
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '미국';
    --> DEFAULT 값을 바꾼다 해서 이전에 데이터 값이 바뀌지는 않음.

-- 다중변경 가능
ALTER TABLE DEPT_COPY 
    MODIFY DEPT_TITLE VARCHAR(50)
    MODIFY LOCATION_ID VARCHAR(4)
    MODIFY LNAME DEFAULT '미국';
    

-- 1-3) 컬럼 삭제 (DROP COLUMN) : DROP COLUMN 삭제할 컬럼명

CREATE TABLE DEPT_COPY2
 AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2에서 DEPT_ID 컬럼 삭제
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
    --> 컬럼 삭제는 다중 ALTER 불가.
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
    -- 최소 1개의 컬럼은 존재해야 하므로 삭제 불가.
        -- ORA-12983: cannot drop all columns in a table
        
------------------------------------------------------------------------

-- 2) 제약조건 추가 / 삭제.

/*
    2-1) 제약조건 추가
        PRIMARY KEY 기본키 : ADD PRIMARY KEY (컬럼명)
        FOREIGN KEY 외래키 : ADD FOREIGN KEY (컬럼명) REFERENCES 참조 테이블 [(컬럼명)]
        UNIQUE 중복 방지   : ADD UNIQUE (컬럼명) 
        CHECK 남녀        : ADD CHECK (컬럼에 대한 조건)   
        NOT NULL          : MODIFY 컬럼명 NOT NULL | NULL(널 허용)
        
        제약조건 명을 지정하고자 한다면 [CONSTRAINT 제약조건명] 제약조건
*/

-- DEPT_ID에 [PK제약조건 추가]
-- DEPT_TITLE에 UNIQUE 추가
-- LNAME에 NOT NULL 추가

ALTER TABLE DEPT_COPY
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
    ADD CONSTRAINT DCOPY_UQ UNIQUE (DEPT_TITLE)
    MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;

-- 2-2) 제약조건 삭제 : DROP CONSTRAINT 제약조건명 
--                   NN은 삭제 X MODIFY 

ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;
ALTER TABLE DEPT_COPY 
    DROP CONSTRAINT DCOPY_UQ
    MODIFY LNAME NULL;
    
--------------------------------------------------------------------------------]
-- 3) 컬럼명 / 제약조건 명/ 테이블명 변경 RENAME

-- 3-1) 컬럼명 수정 : RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명

-- DEPT_TITLE -> DEPT_NAME

SELECT * FROM DEPT_COPY;
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3-2) 제약조건 명 변경 : RENAME CONSTRAINT 제약조건 명 TO 바꿀 제약조건명
    -- SYS_C007158 --> DCOPY_LID_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007158 TO DCOPY_LID_NN;

-- 3-3) 테이블 명 변경 : RENAME [기존테이블명] TO 바꿀 테이블명
-- DEPT_TEST로

ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;
SELECT * FROM DEPT_TEST;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- 테이블  삭제 
DROP TABLE DEPT_TEST;
    -- 단, 어딘가에서 참조되고 있는 부모 테이블은 삭제 불가! 삭제하고자 한다면
        -- 1) 자식 테이블 삭제 후 부모테이블 삭제
        -- 2) 부모테이블 삭제하는데, 제약조건 까지 같이 삭제
            -- (DROP TABLE 테이블명 CASCADE CONSTRAINT;)









































