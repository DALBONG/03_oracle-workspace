/*
    <VIEW>
     SELECT���� �����ص� �� �ִ� ��ü 
     (���� ���� �� SELECT���� �����صθ�, �� SELECT���� �Ź� �ٽ� ����� �ʿ� ����)
     (�ӽ� ���̺� ����) (���� �����Ͱ� ����ִ� �� �ƴ�, �����ֱ� ��.)
     
     ������ ���̺� : ���� �����Ͱ� ����ִ� ��. 
     ���� ���̺� : ���� (��� ���� ���̺�)
*/

-- �並 ����� ���� ������ ������ �ۼ�
--������ ������

-- '�ѱ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�';


-- '���þ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '���þ�';

-- '�Ϻ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '�Ϻ�';

-----
/*
    1. �� ����
    
    [ǥ����]
    CREATE [OR REPLACE] VIEW ��� 
    AS ��������;
    
    OR REPLACE : ���� �ߺ��� ����� ������ ����, ������ ����
*/

CREATE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE);
    --> ORA-01031: insufficient privileges(���� ����)
        -- ������ �������� �� ���� ���� �޾ƾ� ��.

--��� ������ �������� ����, ���� �ο� �� �ٽ� �������� ���ƿ���
-- GRANT CREATE VIEW TO KH;

SELECT * FROM VW_EMP;
    --> ���� �ִ� ���̺��� �ƴ� (����.�� ���̺�)

SELECT *
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE)); -- ? �ζ��� ��
    
-- �ѱ����� �ٹ��ϴ� ���
SELECT *
FROM VW_EMP
WHERE NATIONAL_NAME = '���þ�';

-- VIEW�� �÷� �߰� �ϰ� �;�
CREATE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE);
-- ORA-00955: name is already used by an existing object (�̹� ������� �̸�)
--> �ذ� ��� : ������ �ٽ� ����� ���� ������ OR REPLACE ���� �߰� 

CREATE OR REPLACE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE);
    
------------------------------
-- �� ����� ���, �̸�, ���޸�, ����(��/��), �ٹ������ ��ȸ�� �� �ִ� SELECT���� ��(VW_EMP_JOB)���� ����

CREATE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��'), 
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
     FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE);
  --> ORA-00998: must name this expression with a column alias 
    -- �� ������ ���������� SELECT���� �Լ����̳� ���������� ����Ǿ� ���� ��� ��Ī�� �ο��ؾ���.

SELECT * FROM VW_EMP_JOB;

-- ��� �Ϳ� ��Ī�ο� 
CREATE OR REPLACE VIEW VW_EMP_JOB(���, �̸�, ���޸�, ����, �ٹ����)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') AS "����", 
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "�ٹ����"
     FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE);

SELECT * FROM VW_EMP_JOB;
SELECT ����, �̸�
FROM VW_EMP_JOB;

SELECT * 
FROM VW_EMP_JOB
WHERE �ٹ���� >= 20;

-- �� �����ϰ� �;�?
DROP VIEW VW_EMP_JOB;

----------------------------
-- ������ �並 �̿��� DML��� ����
-- �並 ���� �����ϴ��� ���� ���̺� �ݿ� �ǳ�, �� �ȵǴ� ��찡 ���� ������ ���� ������ ����.

CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
FROM JOB;

SELECT * FROM VW_JOB; -- �� ���̺�
SELECT * FROM JOB;    -- ���� ���̺�

-- �並 ���� INSERT
INSERT INTO VW_JOB VALUES('J8', '����');
-- �並 ���� UPDATE
UPDATE VW_JOB
SET JOB_NAME = '�˹�'
WHERE JOB_CODE = 'J8';
-- �並 ���� DELETE 
DELETE FROM VW_JOB
WHERE JOB_CODE = 'J8';

---------------------------------------
/*  ��, DML ��ɾ�� ������ �Ұ����� ���. (�ξ� �� ����)
    1) �信 ���ǵǾ� ���� ���� �÷��� �����Ϸ� �ϴ� ���.
    2) �信 ���ǵǾ� ���� ���� �÷���, ���̽� ���̺� �� NOT NULL ���������� �����Ǿ� �ִ� ��� 
    3) ��� ����� �Ǵ� �Լ������� ���ǵǾ� �ִ� ���
    4) GROUP BY, �׷��Լ� ���Ե� ���
    5) DISTINCT ������ ���Ե� ���
    6) JOIN�� �̿��ؼ� ���� ���̺��� ������� ���� ���
      ==> ��� ��ȸ�Ϸ� �����! DML�� ���� ����.. 
*/

SELECT * FROM VW_JOB;
SELECT * FROM JOB;


--    1) �信 ���ǵǾ� ���� ���� �÷��� �����Ϸ� �ϴ� ���.
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE FROM JOB;

--    INSERT
INSERT INTO VW_JOB VALUES ('J8', '����'); -- ����

--    UPDATE
UPDATE VW_JOB
SET JOB_NAME = '����'
WHERE JOB_CODE = 'J7';
    -- SQL ����: ORA-00904: "JOB_NAME": invalid identifier
    
-- DELETE
DELETE FROM VW_JOB
WHERE JOB_NAME = '���';

--    2) �信 ���ǵǾ� ���� ���� �÷���, ���̽� ���̺� �� NOT NULL ���������� �����Ǿ� �ִ� ��� 
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT * FROM VW_JOB; -- JOB_CODE NN �ɷ�����

-- ���� �Ұ�
INSERT INTO VW_JOB VALUES ('����');

-- ���� ����
UPDATE VW_JOB
SET JOB_NAME = '�˹�'
WHERE JOB_NAME = '���';

-- ���� ����
DELETE FROM VW_JOB
WHERE JOB_NAME = '���';

--    3) ��� ����� �Ǵ� �Լ������� ���ǵǾ� �ִ� ���
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 "����"
    FROM EMPLOYEE;
    
SELECT * FROM VW_EMP_SAL;
SELECT * FROM EMPLOYEE;

INSERT INTO VW_EMP_SAL VALUES (400, '������', 3000000, 36000000);
    --> SQL ����: ORA-01733: virtual column not allowed here (�����÷� �Ұ�)
     -- ���� ���̺� ���� �÷��� ����, �Ұ�.
    
UPDATE VW_EMP_SAL 
SET SALARY = 7000000
WHERE EMP_ID = 200;

ROLLBACK;

DELETE FROM VW_EMP_SAL
WHERE ���� = 72000000;

ROLLBACK;

--    4) GROUP BY, �׷��Լ� ���Ե� ���
CREATE OR REPLACE VIEW VW_GROUP_DEPT
AS SELECT DEPT_CODE, SUM(SALARY) "�հ�", FLOOR(AVG(SALARY)) "���"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT * FROM VW_GROUP_DEPT;

INSERT INTO VW_GROUP_DEPT VALUES ('D3', 8000000, 4000000);
    -- SQL ����: ORA-01733: virtual column not allowed here

UPDATE VW_GROUP_DEPT
SET �հ� = 8000000
WHERE DEPT_CODE = 'D1';
    -- SQL ����: ORA-01732: data manipulation operation not legal on this view
    
DELETE VW_GROUP_DEPT
WHERE �հ� = 5210000;

--    5) DISTINCT ������ ���Ե� ���
CREATE OR REPLACE VIEW VDJ
AS SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT * FROM VDJ;

INSERT INTO VDJ VALUES('J8'); -- ����

UPDATE VDJ 
SET JOB_CODE = 'J8'
WHERE JOB_CODE = 'J7';

DELETE FROM VDJ 
WHERE JOB_CODE = 'J4';

--    6) JOIN�� �̿��ؼ� ���� ���̺��� ������� ���� ���
CREATE OR REPLACE VIEW VW_J
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT * FROM VW_J;

INSERT INTO VW_J VALUES (300, '�����', '�ѹ���');
    -- SQL ����: ORA-01776: cannot modify more than one base table through a join view

UPDATE VW_J
SET EMP_NAME = '������'
WHERE EMP_ID = 200;

ROLLBACK;

UPDATE VW_J
SET DEPT_TITLE = 'ȸ���'
WHERE EMP_ID = 200;
 -- SQL ����: ORA-01779: cannot modify a column which maps to a non key-preserved table

DELETE FROM VW_J
WHERE EMP_ID = 200;

ROLLBACK;

--> VIEW�� ���� �׳�, DML ���� ����.. ^^

/*
        VIEW �ɼ�
          
        [�� ǥ����]
          CREATE [OR REPLACE] [FORCE | NOFORCE ] VIEW ���
          AS ��������
          [WITH CHECK OPTION]
          [WITH READ ONLY];
          
        
        1) OR REPLACE       : ���� ������ �� ���� �� ����, ���� �� ����
        2) FORCE | NO FORCE 
            - FORCE   : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 �����ǰ� �ϴ�.
            - NOFORCE : ���������� ����� ���̺��� �����ؾ߸� �䰡 ����
        3) WITH CHECK OPTIOM : DML�� ���������� ����� ���ǿ� ������ �����θ� DML ����
        4) WITH READ ONLY : �信 ���� ��ȸ�� ���� (DML �Ұ�)

*/

-- 2) FORCE | NOFORCE
CREATE OR REPLACE /*NOFORCE*/ VIEW VEW_EMP
AS SELECT TCODE, TNAME, TCONTENT 
FROM TT;
    -- ORA-00942: table or view does not exist (�ش� ���̺� ����) 
    
CREATE OR REPLACE FORCE VIEW VEW_EMP
AS SELECT TCODE, TNAME, TCONTENT 
FROM TT;
    -- ���: ������ ������ �Բ� �䰡 �����Ǿ����ϴ�. (��������� ��)
    
SELECT * FROM VEW_EMP;
CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR2(30)
);

-- 3) WITH CHECK OPTION : ���������� ����� ���ǿ� ���յ��� �ʴ� ������ ������ ���� �߻�
-- WITH CHECK OPTION �Ⱦ���
CREATE OR REPLACE VIEW VEW_EMP
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000;
    
SELECT * FROM VEW_EMP;
    
UPDATE VEW_EMP
SET SALARY = 2000000 -- 8000000
WHERE EMP_ID = 200;

ROLLBACK;
    
-- WITH CHECK OPTION ����
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
        -- ���������� ����� ���ǿ� ���յ��� �ʾ� ���� �Ұ�.
UPDATE VEW_EMP
SET SALARY = 4000000 -- 8000000
WHERE EMP_ID = 200;
    --> ���������� ����� ���ǿ� ���յǾ� ���� ����.
    
ROLLBACK;

-- 4) WITH READ ONLY : �信 ���� ��ȸ�� ���� (DML�� ���� �Ұ�)
CREATE OR REPLACE VIEW VEW_EMP
AS SELECT EMP_ID, EMP_NAME, BONUS
    FROM EMPLOYEE
    WHERE BONUS IS NOT NULL
WITH READ ONLY;

SELECT * FROM VEW_EMP;

DELETE FROM VEW_EMP
WHERE EMP_ID = 200;
 -- SQL ����: ORA-42399: cannot perform a DML operation on a read-only view �б� ����, ���� �Ұ�.
 
 -- �������� VIEW�� �������� ����.









