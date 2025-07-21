/*
     < Ʈ���� TRIGGER >
      : ������ ���̺� INSERT, UPDATE, DELECT ��.. DML���� ���� ��������� ���� ��(�̺�Ʈ �߻�)
        �ڵ����� �Ź� ������ ������ �̸� �����ص� �� �ִ� ��ü 

     EX) 
      - ȸ��Ż��� ���� ȸ�� ���̺� DELETE�� �ٷ� Ż��� ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERT ó��.
      - �Ű�Ƚ���� ���� �� �Ѱ��� ��, �ش� ȸ���� ������Ʈ�� ó���ǰԲ�.
      - ��.��� ������ ���(INSERT)�� �� ���� �ش� ��ǰ�� ���� ��� ������ �Ź� ����(UPDATE)�ؾ� �� ��.
      
          * Ʈ���� ����
          - SQL���� ����Ŀ� ���� �з�
            > BEFORE TRIGGER : ������ ���̺� �̺�Ʈ �߻� �� TRIGGER ���� 
            > AFTER TRIGGER  : ������ ���̺� �̺�Ʈ �߻� �� TRIGGER ����
          - SQL���� ���� ������ �޴� �� �࿡ ���� �з�
            > STATEMENT TRIGGER (����) : �̺�Ʈ �߻��� SQL���� ���� �� �ѹ��� TRIGGER ����
            > ROW TRIGGER        (��) : �ش� SQL���� ������ ������ �Ź� TRIGGER ���� 
              --> (FOR EACH ROW �ɼ� ���)
                 ��  :OLD - BEFORE UPDATE (������ �ڷ�) ,  BEFORE DELETE (������ �ڷ�)
                 ��  :NEW - AFTER INSERT (�߰��� �ڷ�) ,  AFTER UPDATE (������ �ڷ�)
                 
        < ǥ���� >
        CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
        BEFROE | AFTER  INSERT|UPDATE|DELETE  ON  ���̺�� 
        [FOR EACH ROW]
        �ڵ����� ������ ����; 
            [DECLARE 
              ���� ����]
             BEGIN 
              ���� ����(�ش� ���� ������ �̺�Ʈ �߻��� �ڵ����� ������ ����) 
             [EXCEPTION
              ���� ó�� ����]
             END;
             /
*/
SET SERVEROUTPUT ON;

-- EMPLOYEE ���̺� �� ���� INSERT �� ������ �ڵ����� �޽��� ����ϴ� Ʈ���� �����帯

CREATE OR REPLACE TRIGGER TRG_01 
AFTER INSERT ON EMPLOYEE
BEGIN 
 DBMS_OUTPUT.PUT_LINE('�����ΰ� ȯ�� �ϳ�');
END;
/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES (500, '�̼���', '274461-1873443', 'D7', 'J7', 'S2', SYSDATE);
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES (501, '��¯��', '991022-1345322', 'D7', 'J7', 'S3', SYSDATE);

----------------------------------------------
-- ��ǰ �԰� �� ��� ���� ���� 
   --> �׽�Ʈ�� ���� ���̺� �� ������ ����
   
-- 1. ��ǰ ������ ���� ���̺� (TB_PRODUCT)
CREATE TABLE TB_PRODUCT
    (PCODE NUMBER PRIMARY KEY,     -- ��ǰ��ȣ
     PNAME VARCHAR2(30) NOT NULL,  -- ��ǰ��
     BRAND VARCHAR2(30) NOT NULL,  -- �귣��
     PIRCE NUMBER,                 -- ����
     STOCK NUMBER DEFAULT 0        -- ��� ����
    );

-- ǰ�� �ߺ� �ȵǰԲ� �Ź� ���ο� ��ȣ �߻���Ű�� ������ (SEQ_PCODE)
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

-- ���� ������ �߰�
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������25', '�Ｚ', 1400000, DEFAULT); 
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������16', '����', 1600000, 10);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '�����', '������', 700000, 20);

SELECT * FROM TB_PRODUCT;
COMMIT;

-- 
-- 
-- 
-- 
-- 2. ��ǰ ����� �� �̷� ���̺� (TB_PRODETAIL)
-- � ��ǰ�� � ��¥�� � �԰�, ��� �Ǿ����� ������ ��� ���̺�
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,                       -- �̷� ��ȣ
    PCODE NUMBER REFERENCES TB_PRODUCT,             -- ��ǰ��ȣ
    PDATE DATE NOT NULL,                            -- ��ǰ�������
    AMOUNT NUMBER NOT NULL,                         -- ����� ����
    STATUS CHAR(6) CHECK(STATUS IN ('�԰�', '���')) -- ����
); 

-- �̷� ��ȣ�� �Ź� ���ο� ��ȣ �߻����� �� �� �ְ� �����ִ� ������ (SEQ_DCODE)
CREATE SEQUENCE SEQ_DCODE
    NOCACHE;
    
-- 200�� ��ǰ�� ���� ��©�� 10�� �԰�
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 10, '�԰�');
-- 200�� ��ǰ�� �������� 10�� ����
UPDATE TB_PRODUCT 
SET STOCK = STOCK + 10
WHERE PCODE = 200;

COMMIT;

-- 210�� ��ǰ 5�� ���
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 5, '���');
-- 210�� ��ǰ ������ ����
UPDATE TB_PRODUCT 
SET STOCK = STOCK - 5
WHERE PCODE = 210;

COMMIT;

-- 205��ǰ ���ó�¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');
-- 205�� ��ǰ�� ������ 20�� ����
UPDATE TB_PRODUCT 
SET STOCK = STOCK + 20
WHERE PCODE = 200; -- �߸� ������
ROLLBACK;
---------------------- �ٽ� ����
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');
UPDATE TB_PRODUCT 
SET STOCK = STOCK + 20
WHERE PCODE = 205;

COMMIT;

-- ��.. �ڵ����� �Ǿ�����.. �ؼ� ���°� TRIGGER

-- TB_PRODETAIL ���̺� INSERT �̺�Ʈ �߻���
-- TB_PRODUCT ���̺� �ڵ����� ������ UPDATE �ǰԲ� Ʈ���� ����
/*
     - ��ǰ�� �԰�� ��� : �ش� ��ǰ ã�� ������ ���� UPDATE 
     UPDATE TB_PRODUCT 
     SET STOCK = STOCK + ���� �԰� ����(INSERT�� �ڷ��� AMOUNT ��)
     WHERE PCODE = �԰�� ��ǰ��ȣ (INSERT�� �ڷ��� PCODE��);
     
     - ��ǰ ���� ��� : �ش� ��ǰ ã�� ������ ���� UPDATE 
     UPDATE TB_PRODUCT
     SET STOCK = STOCK - ���� ��� ���� (INSERT�� �ڷ��� AMOUNT ��)
     WHERE PCODE = ���� ��ǰ ��ȣ(INSER�� �ڷ��� PCODE��);
*/

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    -- ��ǰ �԰�� ��� (������ ����)
    IF (:NEW.STATUS = '�԰�')
        THEN UPDATE TB_PRODUCT
        SET STOCK = STOCK + :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE; 
    END IF;
    
    -- ��ǰ ���� ��� 
    IF (:NEW.STATUS = '���')
         THEN UPDATE TB_PRODUCT
         SET STOCK = STOCK - :NEW.AMOUNT 
         WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

-- 210�� ��ǰ�� ���� ��¥�� 7�� ���
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 7, '���'); -- 15��
-- 200�� ��ǰ�� ���� ��¥�� 100�� �԰�
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 100, '�԰�');
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 30, '���');
COMMIT;
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 10, '���');
-- DCODE 9
ROLLBACK;
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 20, '���');
  --> ROLLBACK�� �� �����ʹ� ���󰡰�, �� ���� ������ ���� ���� �����
COMMIT;





