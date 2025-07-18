/*
    <PL / SQL >
    PROCEDURE LANGUAGE EXTENSION TO SQL (������)
    ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ��� (������ �Ʒ��� ����)
    
    SQL���� ��, ������ ���� �� ����ó�� (IF), �ݺ�ó��(LOOP, FOR, WHILE)���� �����Ͽ� SQL ���� ����
    -> �ټ��� SQL���� �ѹ��� ���� ���� + ���� ó�� ����.
    
    *PL/SQL ���� 
    - [�����]     : DEQLARE�� ����, ������ ����� ���� �� �ʱ�ȭ
    - �����       : BEGIN���� ����, ������ �־�� ��,  SQL�� �Ǵ� ���(����,�ݺ���)���� ������ ��� 
    - [����ó����]  : EXCEPTION���� ����, ���� �߻��� �ذ��ϱ� ���� ������ �̸� ���
*/


-- ȭ�鿡 HELLO ORACLE ���

SET SERVEROUTPUT ON;  --> �ܼ� �ѱ�

BEGIN 
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/
-----------------------------------------
/*
        1. DECLARE �����
         : ���� �� ��� �����ϴ� ���� (����� �ʱ�ȭ)
           �Ϲ� Ÿ�� ����, ���۷��� Ÿ�� ����, LOW Ÿ�� ����
           
        1_1) �Ϲ�Ÿ�� ���� ���� �� �ʱ�ȭ
            [ǥ����] : ������ [CONSTANT ����� ��] �ڷ��� [:= ��];
*/

DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    --EID := 800;
    --ENAME := '������';
    
    EID := &����;
    ENAME := '&�̸�';
    
    DBMS_OUTPUT.PUT_LINE('EID :' || EID );
    DBMS_OUTPUT.PUT_LINE('ENAME :' || ENAME );
    DBMS_OUTPUT.PUT_LINE('PI :' || PI );
END;
/

-- Q. �Ʊ� ����ο��� �� �� ������ := &�ڷ���;

-------------------------------------------
-- 1_2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ (� ���̺��� � �÷��� ������Ÿ�� �����ؼ� �� Ÿ������ ����)
--      [ǥ����] ������ ���̺��.�÷���%TYPE;


--> �ڷ����� �����ϴ� �� 
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    --EID := 300;
    --ENAME := '��޺�';
    --SAL := 3000000;
    
    --����� 200���� ����� ���, �����, �޿���ȸ�ؼ� �� ������ ����
    SELECT EMP_ID, EMP_NAME, SALARY
        INTO EID, ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/
------------------------- �ǽ� ����

/*
    ���۷��� Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLE�� ����
    �� �ڷ��� EMPLOYEE, DEPARTMENT ���̺���� �÷����� ����
    
    ����ڰ� �Է��� ����� ���, ���, �����, �����ڵ�, �޿�, �μ��� ��ȸ �� �� �� ������ ��� ���
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
        INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE E, DEPARTMENT D
    WHERE E.DEPT_CODE = D.DEPT_ID
      AND EMP_ID  = &���;
    
    DBMS_OUTPUT.PUT_LINE(EID);
    DBMS_OUTPUT.PUT_LINE(ENAME);
    DBMS_OUTPUT.PUT_LINE(JCODE);
    DBMS_OUTPUT.PUT_LINE(SAL);
    DBMS_OUTPUT.PUT_LINE(DTITLE);

END;
/

---------------------------------------
--  1_3) ROWTYPE ����
--      : ���̺��� �� �࿡ ���� ��� �÷��� ������ Ÿ���� �Ѳ����� ���� �� �ִ� ����
--      [ǥ����] ������ ���̺��%ROWTYPE;

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
        INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('����� : '|| E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '|| E.SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : '|| NVL(E.BONUS, 0));
END;
/


-------------------------------------------
--  2. BEGIN �����
--  <���ǹ�>


-- 1) IF ���ǽ� THEN ���೻�� END IF; (�ܵ� IF��)

-- ��� �Է� ���� �� �ش� ����� ���, �̸�, �޿�, ���ʽ� ��(%) ���.
-- �� ���ʽ�, ���� �ʴ� ����� �γʽ� �� ��� �� '���ʽ� ���޹��� �ʴ� ����Դϴ�' ���
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SLA EMPLOYEE.SALARY%TYPE;
    BN EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
      INTO EID, ENAME, SLA, BN
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE(EID);
    DBMS_OUTPUT.PUT_LINE(ENAME);
    DBMS_OUTPUT.PUT_LINE(SLA);
    
    IF BN = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE ('���ʽ��� :' || BN * 100 || '%');
END;
/

-- 2) IF ���ǽ� THEN ���೻�� ELSE ���೻�� ���� END IF;
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SLA EMPLOYEE.SALARY%TYPE;
    BN EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
      INTO EID, ENAME, SLA, BN
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE(EID);
    DBMS_OUTPUT.PUT_LINE(ENAME);
    DBMS_OUTPUT.PUT_LINE(SLA);
    
    IF BN = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ� ����');
    ELSE 
            DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BN * 100 || '%');
    END IF;
END;
/

-- �ǹ� --------------
DECLARE
    -- ���۷��� Ÿ�� ���� EID, ENAME, DTITLE, NCODE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    -- ���� ���̺� EMPLOYEE, DEPARTMENT, LOCATION
    -- �Ϲ� Ÿ�� ���� TEAM ���ڿ� -> ������ OR �ؿ��� ��� ����
    TEAM VARCHAR(20);
BEGIN
    -- ����ڰ� �Է��� ����� ������ �ִ� ����� ���, �̸�, �μ���, �ٹ������ڵ� ��ȸ �� �� ������ ����.
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
      INTO EID, ENAME, DTITLE, NCODE
      FROM EMPLOYEE E, DEPARTMENT D, LOCATION L 
     WHERE E.DEPT_CODE = D.DEPT_ID
       AND D.LOCATION_ID = L.LOCAL_CODE
       AND EMP_ID = &���;
       
    
    IF NCODE = 'KO'
        THEN TEAM := '������';
    ELSE 
        TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(EID);
    DBMS_OUTPUT.PUT_LINE(ENAME);
    DBMS_OUTPUT.PUT_LINE(DTITLE);
    DBMS_OUTPUT.PUT_LINE(TEAM);

    -- NCODE�� ���� KO�� ��� TEAM�� ������
    -- �ƴҰ�� TEAM �ؿ��� 
    -- ���, �̸�, �μ���, �Ҽӿ� ���� ���
    
END;
/
-----------------------------------------------------
-- 3) IF ���ǽ�1 THEN ���೻��1 ELS IF ���ǽ�2 THEN ���೻��2 ELSE ���೻��3 END IF; 

-- ���� �Է� �޾� SCORE ������ ����
-- 90�� �̻� : A / 80~89 : B / 70~79 : C / 60~69 : D / 60�� �̸��� F�� ó��
-- GRADE ������ ����
-- ����� ������ XX ���̰�, ������ X ���� �Դϴ�. 

DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(1);

BEGIN
    SCORE := &����;
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D'; 
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE ('����� ������' || SCORE ||'���̰�, ' || '������ '|| GRADE ||'���� �Դϴ�.');

END;
/


-- ���� �Է��� ����� ����� �޿��� 500 �̻��̸� GRADE ���, 300�̻��̸� GRADE �߱�, 300 �̸��̸� �ʱ�
 -- �ش� ����� �޿� ����� ���� �Դϴ�.
 
 DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;

    GRADE VARCHAR2(10);
 BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
      INTO EID, ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
 
    IF SAL >= 5000000 THEN GRADE := '���'; 
     ELSIF SAL >= 3000000 THEN GRADE := '�߱�';
     ELSE GRADE := '�ʱ�';
     END IF;
     
     DBMS_OUTPUT.PUT_LINE(ENAME || ' ����� �޿� ����� ' || GRADE || '�Դϴ�.');
    
 END;
 /
--------------------------------------------------------------
-- 4) CASE �񱳴���� WHEN ������Ұ� 1 THEN �����1 WHEN ������Ұ�2 THEN �����2,... ELSE �����M END;

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30); --�μ��� ����
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DNAME := CASE EMP.DEPT_CODE
        WHEN 'D1' THEN '�λ���'
        WHEN 'D2' THEN 'ȸ����'
        WHEN 'D3' THEN '��������'
        WHEN 'D4' THEN '����������'
        WHEN 'D9' THEN '�ѹ���'
        ELSE '�ؿܿ�����'
    END;
    
    DBMS_OUTPUT.PUT_LINE (EMP.EMP_NAME || '��(��) ' || DNAME || '�Դϴ�');
                            
END;
/

-------------------
-- 1. ����� ������ ���ϴ� ���Ͻ��� �ۼ�
    -- ���ʽ��� �ִ� ����� ���ʽ��� �����ؼ� ���, 
    -- ���ʽ��� ������ ������ ����.
    -- ��� ���� : �޿� �̸� W999,999,999 (--> 8000000 ������ ��ȭ��ȣ124,333,444)
    
    
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    SALARY NUMBER;
BEGIN
    SELECT *
      INTO EMP
      FROM EMPLOYEE
      WHERE EMP_ID = &���;
      
    /*
     SALARY := CASE EMP_BONUS
        WHEN EMP_(NVL(BONUS, 0) = 0 THEN (SALARY+SALARY*0)*12
        WHEN 
    */
    IF EMP.BONUS IS NULL
        THEN SALARY := EMP.SALARY *12;
        ELSE SALARY :=(EMP.SALARY + EMP.SALARY * EMP.BONUS)*12;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(EMP.SALARY || '' || EMP.EMP_NAME || TO_CHAR(SALARY, 'L999,999,999'));

END;
/

---------------------------------------------------------
--  �ݺ���

/*
    1) BASIC LOOP��
    [ǥ����]
    LOOP 
        �ݺ������� ������ ����
        * �ݺ��� �������� �� �ִ� ����
    END LOOP;
    
    *�ݺ��� ���������� ����
    1) IF ���ǽ� THEN EXIT;
    2) EXIT WHEN ���ǽ�;
*/

-- 1~5���� ���������� 1�� ����

DECLARE
    I NUMBER := 1;
BEGIN
    LOOP 
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1; 
        --IF I = 6 THEN EXIT; 
        --END IF;
        EXIT WHEN I = 6;
    END LOOP;
END;
/

---------------
/*
        2) FOR LOOP��
        
        [ǥ����]
        FOR ���� IN �ʱⰪ.. ������ --(1..5)
        LOOP
            �ݺ������� ������ ����
        END LOOP;
*/

BEGIN 
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

--> ���� �� �۾����� �ϰ���� ��
/*
        FOR ���� IN REVERSE �ʱⰪ.. ������ --(1..5)
        LOOP
            �ݺ������� ������ ����
        END LOOP;
*/
BEGIN  
    FOR I IN REVERSE 1..5  --> �ʱⰪ�� �� Ŭ �� ����
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

DROP TABLE TEST;

CREATE TABLE TEST (
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
);

SELECT * FROM TEST;

DROP SEQUENCE SEQ_TNO;

CREATE SEQUENCE SEQ_TNO
START WITH 1
INCREMENT BY 2
MAXVALUE 100
NOCYCLE
NOCACHE;

BEGIN 
    FOR I IN 1..100
    LOOP 
        INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL, SYSDATE);
    END LOOP;
END;
/

SELECT * FROM SEQ_TNO;


-----------------------------------------------
/*
        3) WHILE LOOP��
        [ǥ����]
        WHILE �ݺ����� ����� ����
        LOOP
            �ݺ������� ������ ����
        END LOOP;
*/

DECLARE
    I NUMBER := 1;
BEGIN
    WHILE I <=6
    LOOP
        DBMS_OUTPUT.PUT_LINE (I);
        I := I + 1;
    END LOOP;
END;
/

----------------------------
/*
        3. ���� ó�� ��
        
        [ǥ����]
        EXCEPTION ������ �߻��ϴ� ���� 
            WHEN ���ܸ�1 THEN ����ó������1;
            WHEN ���ܸ�2 THEN ����ó������2;
            ...
            WHEN OTHERS THEN ����ó������N;
            
        * ���ܸ�, �ý��ۿ��� (����Ŭ���� �̸� �����ص� ����)
         - NO_DATA_FOUND : SELECT�� ����� �� �൵ ���� ��
         - TOO_MANY_RESULT : SELECT�� ����� ���� ���� ���
         - ZERO_DIVIDE : 0���� ������ �� ��
         - DUP_VAL_ON_INDEX : UNIQUE �������ǿ� ����Ǿ��� ���
*/

-- ����ڰ� �Է��� ���� ������ ������ ��� ���
DECLARE
    RESULT NUMBER;
BEGIN
    RESULT := 10 / &����;
    DBMS_OUTPUT.PUT_LINE ('��� : ' || RESULT);
EXCEPTION
    -- WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0���� ���� �� ����');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('0���� ���� �� ����');
END;
/


-- UNIQUE �������� ����
BEGIN 
    UPDATE EMPLOYEE
    SET EMP_ID = &�����һ��
    WHERE EMP_NAME = '���ö';
    
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ���!');
END;
/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID = &������; --211 ������, 200 ����, 202 ����
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    
    EXCEPTION
    --WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('�ʹ� ����!');
    --WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�ش� ��� ���� ��� ����!');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('��� ����!');
END;
/





