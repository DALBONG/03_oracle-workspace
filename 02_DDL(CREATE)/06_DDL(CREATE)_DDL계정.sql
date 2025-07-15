-- CREATE USER ddl IDENTIFIED BY ddl;
-- GRANT CONNECT, RESOURCE TO ddl;

/*
    DDL(DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    오라클에서 제공하는 객체(OBJECT)를 새로 만들고(CREATE), 구조 변경(ALTER), 구조 삭제(DROP)하는 언어
    -> 실제 데이터 값이 아닌, 구조 자체를 정의하는 언어
        주로 DB관리자, 설계자가 사용.
        
    * 오라클에서 제공하는 객체 : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE 순서 지정), 인덱스(INDEX), 패키지(PACKAGE), 
                            트리거(TRIGGER), 프로시져(PROCEDURE), 함수(FUNCTION), 사용자(USER)
                            
    <CREATE >
    객체를 새로 생성하는 구문
*/

/*
    1. 테이블 생성
     - 행(ROW),열(COLUMN)로 구성되는 기본적 DB 객체
        모든 데이터들은 테이블을 통해 저장
        DBMS 용어중 하나로, 데이터를 일종의 표 형태로 표현한 것.
        
    [표현식]
    CREATE TABLE 테이블명(컬럼명1 자료형1(크기), 컬럼명2 자료형2(크기),...);
    
    *자료형
     - 문자 (CHAR(바이트크기)) | VARCHAR2(바이트크기) => 반드시 크기 지정
        ㄴ CHAR : 2000 Byte까지 지정, 지정한 범위 내에서만 사용
                / 고정길이(지정 크기보다 더 적은 값이 돌아와도 공백으로 채워짐)
                  : 고정된 글자 수의 데이터만 담을 경우 사용
        ㄴ VARCHAR2 : 4000Byte 까지 지정
                / 가변길이(담긴 값에 따라 공간의 크기 맞춰짐)
                  : 몇 그라의 데이터가 들어올지 모를 때 사용
     - 숫자 (NUMBER)
     - 날짜 (DATE)
*/


-- 회원에 대한 데이터를 담기 위한 테이블 MEMBER 생성

CREATE TABLE MEMBER(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

--> 컬럼명 오타 생겼을 경우 다시 생성 불가, 삭제하고 다시하던지 해야 함.

-----------------------------------------------
/*
    2. 컬럼에 주석 달기(컬럼에 대한 설명)
    
    [표현법]
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
*/

COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원 이름';
COMMENT ON COLUMN MEMBER.GENDER IS '성별(남/여)';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.MEM_DATE IS '가입 일';

-- 테이블에 데이터를 추가시키기 (DML : INSERT) (나중에 자세히 배울 것)
    -- INSERT INTO 테이블명 VALUES(값1, 값2,...);
    
SELECT * FROM MEMBER;

--INSERT INTO MEMBER VALUES (1, 'USER01', 'PASS01', '차은우');
            --> 컬럼 갯수만큼 쓰지 않으면 오류.
INSERT INTO MEMBER VALUES (1, 'user01', 'pass01', '차은우', '남', '010-4438-2384', 'cew.com', '24/2/10');
INSERT INTO MEMBER VALUES (2, 'user02', 'pass02', '장워녕', '여', NULL, NULL , SYSDATE);
INSERT INTO MEMBER VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL , NULL);
        --> 유효하지 않은 데이터가 들어가고 있음. 뭔가 조건을 걸어줘야 함. (제약조건)
        
        /*
            <제약 조건 CONSTRAINT>
            - 원하는 데이터 값만 유지하기 위해 특정 컬럼에 설정하는 제약조건
            - 데이터 무결성 보장을 목적으로 함.
            
            *종류 : NOT NULL, UNIQUE(중복X), CHECK(남OR녀 아니야? 빠꾸), PRIMARY KEY, FOREIGN KEY 
        */
        
            /*
                 1) NOT NULL
                  해당 컬럼에 반드시 값이 존재해야만 하는 경우 
                  삽입/ 수정시 NULL값을 허용하지 않도록 제한
                  
                  제약 조건을 부여하는 방식은 크게 2가지 방식 (컬럼 레벨 방식 / 테이블 레벨 방식)
                  - NOT NULL 제약 조건은 오로지 컬럼 레벨방식 밖에 안됨.
            */
-- 컬럼 레벨 방식 : 컬럼명 자료형 제약조건
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- 컬럼 레벨 방식
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1, 'user01', 'user02', '차응우', '남', NULL, NULL, NULL);
-- INSERT INTO MEM_NOTNULL VALUES(2, 'user02', NULL, '박복엄', '남', NULL, 'ppy.com', NULL);
    -- ORA-01400: cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_PWD")
    -- NOT NULL 제약조건에 걸려 오류 발생
INSERT INTO MEM_NOTNULL VALUES(2, 'user01', 'pass02', '박복엄', '남', NULL, 'ppy.com', NULL);
    -- ID 중복 발생
--------------------------------------------------------------------------------
            /*
                 2) UNIQUE 제약조건
                  해당 컬럼에 중복된 값이 들어가서는 안될 경우 
                  삽입/ 수정시 기존 데이터 값이 있을경우 오류발생.
            */
            
-- 컬럼 레벨 방식 : 컬럼명 자료형 제약조건
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- 컬럼 레벨 방식
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);           
            
DROP TABLE MEM_UNIQUE;

-- 테이블 레벨 방식 : 모든 컬럼을 다 나열 후, 마지막에 기술
                -- 제약 조건(컬럼명)
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID) -- 테이블 레벨 방식
);           
SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '차응우', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '박복엄', '남', NULL, 'ppy.com');
    --ORA-00001: unique constraint (DDL.SYS_C007049) violated (UNIQUE 제약 조건에 위배, INSERT 실패)
    --> 오류구문을 제약조건 명으로 알려줌 (특정 컬럼에 어떤 문제가 있는지 알려주진 않음, 쉽게 파악 어려움)
    --> 제약조건 부여시 조건명을 지정해주지 않으면 시스템에서 임의로 제약조건명 부여함
/*
    * 제약조건 부여시 제약조건명까지 지어주기
     > 컬럼 레벨방식
         CREATE TABLE 테이블명(
            컬럼명1 자료형1 [CONSTRAINT 제약조건명] 제약조건,
            컬럼명2 자료형2,...);
     > 테이블 레벨방식
         CREATE TABLE 테이블명(
            컬럼명1 자료형1,
            컬럼명2 자료형2,...),
            [CONSTRAINT 제약조건명] 제약조건(컬럼명;)
*/
DROP TABLE MEM_UNIQUE;


CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL, 
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID));

INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '박복엄', '남', NULL, 'ppy.com');
INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass03', '장워녕', 'ㄴ', NULL, NULL);

SELECT * FROM MEM_UNIQUE;
    --> 성별에 유효하지 않은 데이터
-------------------------------------------------
            /*
                 3) CHECK 제약조건
                  해당 컬럼에 들어올 수 있는 값에 대한 조건 제시 
                  조건에 만족하는 데이터 값만 담을 수 있음.
            */
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CHECK(GENDER IN ('남', '여')) > 테이블 레벨 방식
);

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', '차응우', '남', NULL, NULL);
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '박북엄', 'ㄴ', NULL, NULL);
    -- ORA-02290: check constraint (DDL.SYS_C007059) violated (체크 제약조건 위배, INSERT X)
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '박북엄', NULL, NULL, NULL); -- 이건 또 됨
    -- GENDER 컬럼에 데이터 값을 넣고자 한다면 CHECK제약조건에 만족하는 값을 넣어야 함. 
    -- NOT NULL 아니면 NULL도 가능
INSERT INTO MEM_CHECK VALUES(2, 'user03', 'pass03', '장웡영', NULL, NULL, NULL); -- 회원번호 동일해도 INSERT 성공
---------------------------------------------
            /*
                 4) PRIMARY KEY(기본키) 제약조건
                  테이블에서 각 행들을 식별하기 위해 사용될 컬럼에 부여하는 제약조건(식별자의 역할)
                  EX) 회원번호, 학번, 사원번호(EMP_ID), 부서코드(DEPT_ID), 직급코드(JOB_CODE), 주문번호, 예약,운송장번호 등....
                  
                  PRIMARY KEY 제약조건을 부여하면 자동으로 NOT NULL, UNIQE 제약조건 가짐.
                  
                  * 유의사항 : '한 테이블당 한개만 설정' 가능
            */
CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- PRIBARY KEY(컬럼명)
);

SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI VALUES(1, 'user01', 'pass01', '차응우', '남', '010-7474-4875', NULL);
INSERT INTO MEM_PRI VALUES(1, 'user02', 'pass02', '박북엄', '남', NULL, NULL);
    -- ORA-00001: unique constraint (DDL.MEMNO_PK) violated (프라이머리 키 줬지만 유니크 위배되었다 뜸)
INSERT INTO MEM_PRI VALUES(NULL, 'user02', 'pass02', '박북엄', '남', NULL, NULL);
    -- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
        -- 기본키에 NULL 담으려 할때 NOT NULL 제약조건 위배
INSERT INTO MEM_PRI VALUES(2, 'user02', 'pass02', '박북엄', '남', NULL, NULL);
       
CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, 
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_PK PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
); --02260. 00000 -  "table can have only one primary key"
        -- 기본키는 하나만 됨

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID) -- 묶어서 PRIVARY KEY 제약조건 부여 (복합 키)
);
SELECT * FROM MEM_PRI2;

INSERT INTO MEM_PRI2 VALUES(1, 'user01', 'pass01', '차옹우', NULL, '010-7474-4875', NULL);
INSERT INTO MEM_PRI2 VALUES(1, 'user02', 'pass02', '박북엄', NULL, NULL, NULL);
INSERT INTO MEM_PRI2 VALUES(2, 'user02', 'pass02', '장원용', NULL, NULL, NULL);
INSERT INTO MEM_PRI2 VALUES(NULL, 'user02', 'pass02', '박종민', NULL, NULL, NULL);
    -- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
        -- 묵여있는 각 컬럼에는 절대 NULL 허용 X

-- 복합키 사용 예시 : 쇼핑몰 찜하기, 좋아요, 구독
    -- 한 상품은 한번만 찜할 수 있음.

-- 회원이 어떤 상품을 찜하는지에 대한 데이터 보관 테이블

CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(40),
    LIKE_DATE DATE,
    PRIMARY KEY (MEM_NO, PRODUCT_NAME)
);

SELECT * FROM TB_LIKE;

INSERT INTO TB_LIKE VALUES(1, '백도 말랑이', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, '백도 딱딱이', SYSDATE);
INSERT INTO TB_LIKE VALUES(2, '백도 딱딱이', SYSDATE);
-- INSERT INTO TB_LIKE VALUES(1, '백도 말랑이', SYSDATE); >> 오류, 한번만 찜해야지.
-------------------------------------------------------------

      
 --               5)  회원 등급에 대한 데이터를 따로 보관하는 테이블
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);  

SELECT * FROM MEM_GRADE;

INSERT INTO MEM_GRADE VALUES(10, '일반회원');
INSERT INTO MEM_GRADE VALUES(20, '우수회원');
INSERT INTO MEM_GRADE VALUES(30, '특별회원');

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER -- 회원등급을 같이 보관할 컬럼
);

SELECT * FROM MEM;

INSERT INTO MEM VALUES(1, 'user01', 'pass01', '차옹우', '남', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '박부검', '남', NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '장웅영', '여', NULL, NULL, 90);
        -- 유효하지 않은 회원등급 번호도 INSERT
        
----------------------------------------------------------------
            /*
                 5) FOREIGN KEY (외래키) 제약조건
                  다른 테이블에 존재하는 값만 들어와야 한느 특정 컬럼에 부여하는 제약조건
                    -> 다른 테이블 참조.
                  --> 주로 FK 제약조건에 의해 테이블간의 관계 형성
                  
                  * 컬럼 레벨 방식
                    : 컬럼명 자료형 [CONSTRAINT 제약조건명] REFERENCES 참조할 테이블명([참조할 컬럼 명])
                  * 테이블 레벨 방식
                    : [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명([참조할 컬럼 명])
                    --> 참조할 컬럼명 생략시 참조할 테이블의 PK로 자동 설정.
            */
            
DROP TABLE MEM;
            
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE (GRADE_CODE) -- 컬럼 레벨 방식
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE (GRADE_CODE) -- 테이블 레벨 방식
);

SELECT * FROM MEM;

INSERT INTO MEM VALUES(1, 'user01', 'pass01', '차옹우', '남', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '박부검', '남', NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '장웅영', '여', NULL, NULL, 90);
    -- ORA-02291: integrity constraint (DDL.SYS_C007086) violated - parent key not found
        -- PARENT 키를 찾을 수 없음.
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '장웅영', '여', NULL, NULL, 30);
    -- MEM_GRADE(부모 테이블) ---> MEM(자식 테이블)

-- 이때 부모테이블에서 데이터 값을 삭제할 경우 어떤 문제? 
    -- 데이터 삭제 : DELETE FROM 테이블 명 WHERE 조건 ;

-- MEM_GRADE 테이블에서 10번 등급 삭제

DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = 10;
    -- constraint (DDL.SYS_C007086) violated - child record found 
        -- 자식테이블(MEM)에서 이미 쓰고있는 10 데이터가 있어서 삭제 안돼
DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = 20;
    -- 자식 테이블에서(MEM) 20값을 사용하고 있지 않아 삭제 가능
    
--> 자식 테이블에 이미 사용하고 있는 값이 있을경우 부모테이블로 부터 무조건 삭제가 안되게 하는 "삭제 제한" 옵션 걸려있음

SELECT * FROM MEM_GRADE;
--삭제 되돌리기 
ROLLBACK;
    
-------------------------------------------------------------------------------
/*
    자식 테이블 생성시 외래키 제약조건 부여할 때 삭제옵션 지정 가능
    * 삭제 옵션 : 부모테이블의 데이터 삭제시 그 데이터를 사용하고 있는 자식테이블 값을 어떻게 처리할 것인지?
    
    시험시, 98% 출제
    - ON DELETE RESTRICTED(기본값) : 삭제 제한, 자식에서 쓰고있는 부모 데이터는 삭제 불가
    - ON DELETE SET NULL : 부모데이터 삭제시 해당 데이터를 쓰고 있는 자식 데이터의 값을  NULL로 변경
    - ON DELETE CASCADE : 부모데이터 삭제시 해당 데이터를 쓰고있는 자식 데이터도 삭제
*/

DROP TABLE MEM;

-- ON DELETE SET NULL
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE (GRADE_CODE) ON DELETE SET NULL
);

SELECT * FROM MEM;

INSERT INTO MEM VALUES(1, 'user01', 'pass01', '차옹우', '남', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '박부검', '남', NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '장운영', '여', NULL, NULL, 20);
INSERT INTO MEM VALUES(4, 'user04', 'pass04', '박부영', '여', NULL, NULL, 10);

-- 10 등급 삭제
DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = 10;
-- 삭제 후 10을 쓰고있던 자식 데이터 값은 NULL로 변경
SELECT * FROM MEM_GRADE;
ROLLBACK;
    
DROP TABLE MEM;

-- ON DELETE CASCADE
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE (GRADE_CODE) ON DELETE CASCADE
);

SELECT * FROM MEM;
SELECT * FROM MEM_GRADE;

INSERT INTO MEM VALUES(1, 'user01', 'pass01', '차옹우', '남', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '박부검', '남', NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '장운영', '여', NULL, NULL, 20);
INSERT INTO MEM VALUES(4, 'user04', 'pass04', '박부영', '여', NULL, NULL, 10);
    
    -- 10번 등급 삭제
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;

--==============================================================================

/*
    DEFAULT 기본값
    : 컬럼을 선정하지 않고 INSERT시 NULL이 아닌 기본값을 INSERT하고자 할 때 셋팅 해줄 수 있는 값
*/
DROP TABLE MEMBER;
-- 컬럼명 자료형 DEFAULT 기본값 [제약조건]

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '숨쉬기',
    ENROLL_DATE DATE DEFAULT SYSDATE
);

SELECT * FROM MEMBER;

-- INSERT INTO 테이블명 VALUES (값1, 값2, ...)
INSERT INTO MEMBER VALUES(1, '차인우', 20, '막춤', '25/01/07');
INSERT INTO MEMBER VALUES(2, '박보금', NULL, NULL, NULL);
INSERT INTO MEMBER VALUES(3, '박보현', NULL, DEFAULT, DEFAULT);

-- INSERT INTO 테이블명 (컬럼명, 컬럼명) VALUES (값1, 값2); 
    -- ㄴ NOT NULL인건 꼭 골라야 함.
INSERT INTO MEMBER (MEM_NO, MEM_NAME) VALUES(4, '박정밈');
    -- 선택되지 않은 컬럼은 기본적으로 NULL이나, 해당 컬럼에 DEFAULT 값이 있을 경우 DEFAULT 값 들어감

--=============================================================================
/*
    !!!!!!!!!!!!!!!!!!!!!!!!!! KH계정으로 전환!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    <서브쿼리를 이용한 테이블 생성>
     테이블 복사 개념
     
     [표현식]
     CREATE TABLE 테이블명 
     AS 서브쿼리;
*/

-- EMPLOYEE 테이블을 복제한 새 테이블 생성
CREATE TABLE EMPLOYEE_COPY 
AS SELECT *
    FROM EMPLOYEE;
    --> 컬럼, 데이터값, 제약조건 같은 경우 NOT NULL만 복사됨 

SELECT * FROM EMPLOYEE_COPY2;

CREATE TABLE EMPLOYEE_COPY2
AS SELECT *
    FROM EMPLOYEE  -- 테이블 구조만 복제 
    WHERE 1 = 0; -- 무조건 FALSE인 조건
    
    
CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 "연봉"
    FROM EMPLOYEE;
    -- 00998. 00000 -  "must name this expression with a column alias"
        --> 컬럼 별칭과 함께 지정
        -- 서크쿼리 SELECT 절에 산술식, 함수식이 기술된 경우 반드시 별칭 지정
SELECT * FROM EMPLOYEE_COPY3;

--====================================================================
/*
    테이블 생성 후 제약조건 추가.
    ALTER TABLE 테이블명 변경내용;
    
    - PRIMARY KEY (기본 키)         : ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명);
    - FOREIGN KYE (다른 테이블 참조) : ALTER TABLE 테이블명 ADD FOREIGN KEY (컬럼명) REFERENCES (참조 테이블 명);
    - UNIQUE (데이터 값 중복X)       : ALTER TABLE 테이블명 ADD UNIQUE(컬럼명);
    - CHECK                        : ALTER TABLE 테이블명 ADD CHECK (컬럼에 대한 조건식);
    - NOT NULL                     : ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL; **약간 특이
*/

-- 서브 쿼리를 이용해서 복제한 테이블은 NN 제약조건 빼고 복제 안됨
-- EMPLOYEE_COPY 테이블 PK 제약조건 추가 (EMP_ID)

ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);
-- EMPLOYEE 테이블에 DEPT_CODE에 외래키 제약조건 추가 (참조테이블(부모)) : DEPARTMENT(DEPT_ID)

ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT;
    -- 생략하면 부모테이블의 FK로 감
    
    
-- EMPLOYEE 테이블에 JOB_CODE에 외래키 제약조건 추가 (JOB 테이블 참조)
SELECT JOB_CODE FROM JOB;

ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB;
SELECT * FROM EMPLOYEE;

-- EMPLOYEE 테이블 SAL_LEVEL에 외래키 제약조건 (SAL_GRADE 테이블 참조)

ALTER TABLE EMPLOYEE ADD FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE;

-- DEPARTMENT 테이블에 LOCATION_ID에 외래키 제약조건 (LOCATION 테이블 참조)
ALTER TABLE DEPARTMENT ADD FOREIGN KEY (LOCATION_ID) REFERENCES LOCATION;

--=============================================================================
    
    
        
            
            
            
            


