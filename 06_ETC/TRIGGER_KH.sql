
-- 1. �������̺�(�й�, �̸�, ��, ��, ��), �������̺�(�й�, ������, ���, ���) �����
  -- �������̺� : TB_SCORE       /             �������̺� : TB_GRADE
CREATE TABLE TB_SCORE 
    (STUDENT_NO NUMBER NOT NULL,
     STUDENT_NAME VARCHAR2(15) NOT NULL,
     KO_SCORE NUMBER,
     EN_SCORE NUMBER,
     MAT_SCORE NUMBER
    );
    
CREATE TABLE TB_GRAD
    (STUDENT_NO NUMBER,
     SUM_SCORE NUMBER,
     AVG_SCORE NUMBER, 
     RANK NUMBER
    );

-- 2. �������̺� INSERT �߻��ϸ� �ڵ����� �������̺� INSERT���ִ� Ʈ���� ����

/*
CREATE OR REPLACE TRIGGER TRG_SCORE
AFTER INSERT ON TB_SCORE
FOR EACH ROW
DECLARE 
    STU_NO TB_SCORE.STUDENT_NO%TYPE;
    SUM_SCO NUMBER := TB_SCORE(KO_SCORE + EN_SCORE + MAT_SCORE);
    AVG_SCO NUMBER := TB_SCORE(KO_SCORE + EN_SCORE + MAT_SCORE / 3);
            -- ����, ������ �÷��� �߰��Ǹ� �� ���� ��������, �ϴ�... �Ӹ����V��..
    TOTAL_RANK NUMBER;
BEGIN
    INSERT INTO TB_GRADE VALUES (STU_NO, SUM_SCO, AVG_SCO, TOTAL_RANK);
END;
/
*/

CREATE OR REPLACE TRIGGER TRG_SCORE
AFTER INSERT ON TB_SCORE
FOR EACH ROW
BEGIN
    INSERT INTO TB_GRAD(STUDENT_NO, SUM_SCORE, AVG_SCORE)
    VALUES(:NEW.STUDENT_NO,
           :NEW.KO_SCORE + :NEW.EN_SCORE + :NEW.MAT_SCORE,
           (:NEW.KO_SCORE + :NEW.EN_SCORE + :NEW.MAT_SCORE)/3);
END;
/

INSERT INTO TB_SCORE VALUES(200, '�赹��', 70, 60, 60);
INSERT INTO TB_SCORE VALUES(201, '�ڱÿ�', 80, 90, 70);
INSERT INTO TB_SCORE VALUES(202, '�̴ܱ�', 80, 80, 70);

-- 3. �������̺��� UPDATE�Ǹ� �ش� ����, ����, ���� ������ ���� 
   -- ����Ŭ �ֿܼ� ��µǴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_GRADE
AFTER UPDATE ON TB_SCORE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('���� : ' || :NEW.KO_SCORE);
    DBMS_OUTPUT.PUT_LINE('���� : ' || :NEW.EN_SCORE);
    DBMS_OUTPUT.PUT_LINE('���� : ' || :NEW.MAT_SCORE);
END;
/

-- 4. �������̺� INSERT/ UPDATE �Ǹ� ����� �Űܼ� �������ִ� ���ν��� ����
CREATE OR REPLACE PROCEDURE PROC_UPDATE_RANK IS
BEGIN
    UPDATE TB_GRAD G     --> ���� ����������
    SET RANK = (SELECT RN  
                  FROM (SELECT STUDENT_NO, RANK()OVER(ORDER BY SUM_SCORE DESC) AS "RN"
                          FROM TB_GRAD) SUB
                 WHERE G.STUDENT_NO = SUB.STUDENT_NO
                );
END;
/
  
CREATE OR REPLACE TRIGGER TRG_TEST3
AFTER INSERT OR UPDATE ON TB_SCORE
BEGIN
    PROC_UPDATE_RANK;
END;
/
 
 -- 5. ���� ���̺� �л� �����Ͱ� �����Ǹ� ���� ���̺��� 
  -- �л� ������ ���� + ������ ��� ��� �ű�� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRT_TEST4
AFTER DELETE ON TB_SCORE
FOR EACH ROW
BEGIN
    DELETE FROM TB_GRAD
     WHERE STUDENT_NO = :OLD.STUDENT_NO; 
     
    PROC_UPDATE_RANK;
END;
/
  
  

  
  