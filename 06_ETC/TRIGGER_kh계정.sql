/*
     < 트리거 TRIGGER >
      : 지정한 테이블에 INSERT, UPDATE, DELECT 등.. DML문에 의해 변경사항이 생길 때(이벤트 발생)
        자동으로 매번 실행할 내용을 미리 정의해둘 수 있는 객체 

     EX) 
      - 회원탈퇴시 기존 회원 테이블에 DELETE후 바로 탈퇴된 회원들만 따로 보관하는 테이블에 자동으로 INSERT 처리.
      - 신고횟수가 일정 수 넘겼을 때, 해당 회원을 블랙리스트로 처리되게끔.
      - 입.출고 데이터 기록(INSERT)될 때 마다 해당 상품에 대한 재고 수량을 매번 수정(UPDATE)해야 할 때.
      
          * 트리거 종류
          - SQL문의 실행식에 따른 분류
            > BEFORE TRIGGER : 지정한 테이블에 이벤트 발생 전 TRIGGER 실행 
            > AFTER TRIGGER  : 지정한 테이블에 이벤트 발생 후 TRIGGER 실행
          - SQL문에 의해 영향을 받는 각 행에 따른 분류
            > STATEMENT TRIGGER (문장) : 이벤트 발생한 SQL문에 대해 딱 한번만 TRIGGER 실행
            > ROW TRIGGER        (행) : 해당 SQL문을 실행할 때마다 매번 TRIGGER 실행 
              --> (FOR EACH ROW 옵션 기술)
                 ㄴ  :OLD - BEFORE UPDATE (수정전 자료) ,  BEFORE DELETE (삭제전 자료)
                 ㄴ  :NEW - AFTER INSERT (추가된 자료) ,  AFTER UPDATE (수정후 자료)
                 
        < 표현식 >
        CREATE [OR REPLACE] TRIGGER 트리거명
        BEFROE | AFTER  INSERT|UPDATE|DELETE  ON  테이블명 
        [FOR EACH ROW]
        자동으로 실행할 내용; 
            [DECLARE 
              변수 선언]
             BEGIN 
              실행 내용(해당 위에 지정된 이벤트 발생시 자동으로 실행할 구문) 
             [EXCEPTION
              예외 처리 구문]
             END;
             /
*/
SET SERVEROUTPUT ON;

-- EMPLOYEE 테이블에 새 행이 INSERT 될 때마다 자동으로 메시지 출력하는 트리거 만ㄴ드릭

CREATE OR REPLACE TRIGGER TRG_01 
AFTER INSERT ON EMPLOYEE
BEGIN 
 DBMS_OUTPUT.PUT_LINE('신입인가 환영 하네');
END;
/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES (500, '이순신', '274461-1873443', 'D7', 'J7', 'S2', SYSDATE);
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES (501, '신짱구', '991022-1345322', 'D7', 'J7', 'S3', SYSDATE);

----------------------------------------------
-- 상품 입고 및 출고 관련 예시 
   --> 테스트를 위한 테이블 및 시퀀스 생성
   
-- 1. 상품 데이터 보관 테이블 (TB_PRODUCT)
CREATE TABLE TB_PRODUCT
    (PCODE NUMBER PRIMARY KEY,     -- 상품번호
     PNAME VARCHAR2(30) NOT NULL,  -- 상품명
     BRAND VARCHAR2(30) NOT NULL,  -- 브랜드
     PIRCE NUMBER,                 -- 가격
     STOCK NUMBER DEFAULT 0        -- 재고 수량
    );

-- 품번 중복 안되게끔 매번 새로운 번호 발생시키는 시퀀스 (SEQ_PCODE)
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

-- 샘플 데이터 추가
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '갤럭시25', '삼성', 1400000, DEFAULT); 
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '아이폰16', '애플', 1600000, 10);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '대륙폰', '샤오밍', 700000, 20);

SELECT * FROM TB_PRODUCT;
COMMIT;

-- 
-- 
-- 
-- 
-- 2. 상품 입출고 상세 이력 테이블 (TB_PRODETAIL)
-- 어떤 상품이 어떤 날짜에 몇개 입고, 출고 되었느지 데이터 기록 테이블
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,                       -- 이력 번호
    PCODE NUMBER REFERENCES TB_PRODUCT,             -- 상품번호
    PDATE DATE NOT NULL,                            -- 상품입출고일
    AMOUNT NUMBER NOT NULL,                         -- 입출고 수량
    STATUS CHAR(6) CHECK(STATUS IN ('입고', '출고')) -- 상태
); 

-- 이력 번호로 매번 새로운 번호 발생시켜 들어갈 수 있게 도와주는 시퀀스 (SEQ_DCODE)
CREATE SEQUENCE SEQ_DCODE
    NOCACHE;
    
-- 200번 상품이 오늘 날짤로 10개 입고
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 10, '입고');
-- 200번 상품의 재고수량을 10개 증가
UPDATE TB_PRODUCT 
SET STOCK = STOCK + 10
WHERE PCODE = 200;

COMMIT;

-- 210번 상품 5개 출고
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 5, '출고');
-- 210번 상품 재고수량 감소
UPDATE TB_PRODUCT 
SET STOCK = STOCK - 5
WHERE PCODE = 210;

COMMIT;

-- 205상품 오늘날짜로 20개 입고
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '입고');
-- 205번 상품의 재고수량 20개 증가
UPDATE TB_PRODUCT 
SET STOCK = STOCK + 20
WHERE PCODE = 200; -- 잘못 기입함
ROLLBACK;
---------------------- 다시 실행
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '입고');
UPDATE TB_PRODUCT 
SET STOCK = STOCK + 20
WHERE PCODE = 205;

COMMIT;

-- 아.. 자동으로 되었으면.. 해서 쓰는게 TRIGGER

-- TB_PRODETAIL 테이블에 INSERT 이벤트 발생시
-- TB_PRODUCT 테이블에 자동으로 재고수량 UPDATE 되게끔 트리거 정의
/*
     - 상품이 입고된 경우 : 해당 상품 찾아 재고수량 증가 UPDATE 
     UPDATE TB_PRODUCT 
     SET STOCK = STOCK + 현재 입고 수량(INSERT된 자료의 AMOUNT 값)
     WHERE PCODE = 입고된 상품번호 (INSERT된 자료의 PCODE값);
     
     - 상품 출고된 경우 : 해당 상품 찾아 재고수량 감소 UPDATE 
     UPDATE TB_PRODUCT
     SET STOCK = STOCK - 현재 출고 수량 (INSERT된 자료의 AMOUNT 값)
     WHERE PCODE = 출고된 상품 번호(INSER된 자료의 PCODE값);
*/

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    -- 상품 입고된 경우 (재고수량 증가)
    IF (:NEW.STATUS = '입고')
        THEN UPDATE TB_PRODUCT
        SET STOCK = STOCK + :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE; 
    END IF;
    
    -- 상품 출고된 경우 
    IF (:NEW.STATUS = '출고')
         THEN UPDATE TB_PRODUCT
         SET STOCK = STOCK - :NEW.AMOUNT 
         WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

-- 210번 상품이 오늘 날짜로 7개 출고
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 7, '출고'); -- 15개
-- 200번 상품이 오늘 날짜로 100개 입고
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 100, '입고');
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 30, '출고');
COMMIT;
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 10, '출고');
-- DCODE 9
ROLLBACK;
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 20, '출고');
  --> ROLLBACK시 그 데이터는 날라가고, 그 다음 시퀀스 순번 부터 계수함
COMMIT;





