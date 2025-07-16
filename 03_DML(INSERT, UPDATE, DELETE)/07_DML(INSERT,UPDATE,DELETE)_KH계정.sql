/* 
    DQL (QUERYU ������ ���� ���)           : SELECT
    
    DML (MANIPULATION ������ ���� ���)     : INSERT, UPDATE, DELETE, [SELECT]

    DDL (DEFINITION ������ ���� ���)       : CREATE, ALTER, DROP
    
    DCL (CONTROL ������ ���� ���)          : GRANT, REVOKE, [COMMIT, ROLLBACK]
    
    TCL (TRANSACTION Ʈ������ ���� ���)    : COMMIT, ROLLBACK
    

         <DML : ������ ���� ���>
         ���̺� ���� ���� / ���� / �����ϴ� ����
*/

/*
    1. INSERT (����)
      ���̺� ���ο� ���� �߰��ϴ� ����
      
      [ǥ����]
      1) INSERT INTO ���̺�� VALUES (��1, ��2,...) : ���̺��� ��� �÷��� ���� ���� �����ؼ� �� �� �����ϰ��� ���
         -> �÷� ������ ���� �����ؾ���, �÷� �������� �����ϰ� �� ���ý� NOT ENOUGH VALUES / ���� ���ý� TO MANY VALUES ����
*/

/*  SELECT * FROM CLASS;
CREATE TABLE CLASS( CL_NO NUMBER,  CL_NAME VARCHAR2(5),  �г� NUMBER  --> �ѱ� �÷��� ����! BUT ���� ���� */ 


INSERT INTO EMPLOYEE VALUES (900, '������', '900143-4374233', 'car_94@kh.or.kr', '01027372734', 'D1', 'J7', 'S3', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT);
SELECT * FROM EMPLOYEE;

/*
      2) INSERT INTO ���̺�� (�÷���, �÷���, �÷���) VALUES (��, ��, ��) : 
         -> ���̺� ���� ������ �÷��� ���� ���� INSERT�� �� ���, ���� ������ �߰��Ǳ⿡ ���õ��� ���� �÷��� NULL�� ��. 
            (NOT NULL ���������� �ɷ��ִ� �÷��� �ݵ�� �����ؼ� ���� �� ����)
            ��, DEFAULT ���� �ִ� ��� NULL�� �ƴ� DEFAULT�� ��
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
        , '�ںΰ�'
        , '840223-1234233'
        , 'J1'
        , 'S2'
        , SYSDATE
        );
        
SELECT * FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
      3) INSERT INTO ���̺�� (��������) 
         : VALUES�� ���� ���� ����ϴ� ���, ���������� ��ȸ�� ������� ��°�� INSERT ����
*/

CREATE TABLE EMP_O1(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_O1;

-- ��ü ������� ���, �̸�, �μ��� ��ȸ
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
      ���̺� ���ο� ���� �߰��ϴ� ����
*/

-- ������ �賢��
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
��, �μ��ڵ�, �Ի���, ������ ��ȸ
-- �μ��ڵ尡 D1�� ������� ���, ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

/*
    [INSERT ALL ǥ����]
    INSERT ALL
    INTO ���̺��1 VALUES(�÷���, �÷���, ...)
    INTO ���̺��2 VALUES(�÷���, �÷���, ...)
    ��������;
*/

INSERT ALL 
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
    
-- ������ ����ؼ� �� ���̺� INSERT ����.
-- �Ի��� 2000�� �� �Ի��ڵ鿡 ���� ������ ���� ���̺�
CREATE TABLE EMP_OLD
  AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
       FROM EMPLOYEE
      WHERE 1=0;


-- �Ի��� 2000�� �� �Ի��ڵ鿡 ���� ������ ���� ���̺�
CREATE TABLE EMP_NEW
  AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
       FROM EMPLOYEE
      WHERE 1=0;
      
/*
    [ǥ����]
     INSERT ALL 
     WHEN ����1 THEN
        INTO ���̺�1 VALUES (�÷���, �÷���, ...)
     WHEN ����2 THEN
        INTO ���̺�2 VALUES (�÷���, �÷���, ...)
     ��������
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

-- �������� 1-2 ��� ���� ���� ���!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

--==============================================================================
--==============================================================================
--==============================================================================
--==============================================================================
--==============================================================================
--==============================================================================
--==============================================================================
/*
    3. UPDATE 
     : ���̺� ��ϵǾ� �ִ� ������ �����͸� ����
     
     [ǥ����]
     UPDATE ���̺��
        SET �÷��� = �ٲ� ��,
            �÷��� = �ٲ� ��,...     --> (�������� �÷��� ���ÿ� ���� ����)
    [WHERE] ����  --> ���� �����ϳ�, ��ü ���̺� �ִ� ������� �����Ͱ� �����, �� ���� ����!
*/

-- ���纻 ���̺� ���� �۾�
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPARTMENT;

-- D9 �μ��� �μ����� ������ȹ������ ����
UPDATE DEPARTMENT
   SET DEPT_TITLE = '������ȹ��'  -- �ѹ��� (������ �ٲٱ� ��, ���� ������ ���)
 WHERE DEPT_ID = 'D9';
 
-- ������Ʈ �ǵ����� : ROLLBACK; 

-- ���纻 ���� ����
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;
    
SELECT * FROM EMP_SALARY;
-- ���ö ����� �޿��� 100���� ����,  --������ ���
UPDATE EMP_SALARY
   SET SALARY = 1000000  --> 3700000
 WHERE EMP_NAME = '���ö';  -->  �� ����� �Ǳ� �ǳ�, ���������� ���� �� �����Ƿ� �ߺ��� ���� EMP_ID 202�� ���� 
 

-- ������ ����� �޿��� 700����, ���ʽ��� 0.2�� ����
SELECT * FROM EMP_SALARY;

UPDATE EMP_SALARY, BONUS 
   SET SALARY = 7000000  --> 8000000
 WHERE EMP_NAME = '������';
 
 UPDATE EMP_SALARY
   SET BONUS = 0.2  --> 0.3
 WHERE EMP_NAME = '������';

-- ��ü ����� �޿��� ���� �޿��� 10% �λ��� �ݾ�
 UPDATE EMP_SALARY
   SET SALARY = SALARY*1.2;  --> 0.3

-----------------------------------------------------------------
 -- UPDATE�� �������� ���
 /*
    UPDATE ���̺��
       SET �÷��� = (��������)
     WHERE ����;
 */
 
-- ���� ����� �޿�, ���ʽ� ���� ����� ����� �޿��� ���ʽ� ������ ����.
SELECT * FROM EMP_SALARY
    WHERE EMP_NAME = '����';
    
UPDATE EMP_SALARY
   SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME = '�����') -- ������� SALARY 4080000
     , BONUS  = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME = '�����')-- ������� BONUS
 WHERE EMP_ID = 214;
 
-- ���߿� ��������
UPDATE EMP_SALARY
    SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY WHERE EMP_NAME = '�����')
 WHERE EMP_ID = 214;
 
 --ASIA �������� �״��ϴ� ������� ���ʽ� ���� 0.3 ��,�ѷ� ����
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
-- UPDATE�ÿ��� �ش� �÷��� ���� �������ǿ� ����Ǹ� �ȵ�.
  -- ����� 200���� ����� �̸��� NULL�� ����

UPDATE EMPLOYEE
 SET EMP_NAME = NULL
 WHERE EMP_ID = 200;
 -- NOT NULL �������� ����  ORA-01407: cannot update ("KH"."EMPLOYEE"."EMP_NAME") to NULL

-- ���ö ����� �����ڵ带 J9�� ����.
SELECT * FROM JOB; -- (J1 ~ J7)
UPDATE EMPLOYEE
SET JOB_CODE = 'J9'
WHERE EMP_ID = 203;
 -- ORA-02291: integrity constraint (KH.SYS_C007117) violated - parent key not found
 -- �ܷ�Ű(FL) �������� ����

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
     : ���̺� ��ϵ� �����͸� �����ϴ� ���� (�� �� ������ ����)
     
     [ǥ����]
     DELECT FROM ���̺��
     [WHERE ����];  --> WHERE �� ���� ���ϸ� ��ü �� ���� 
*/

-- ������ ����� ������ ����� 
-- ROLLBACK; : Ŀ�� �������� ���ư�

SELECT * FROM EMPLOYEE;

DELETE FROM EMPLOYEE
WHERE EMP_ID = 900;

DELETE FROM EMPLOYEE
WHERE EMP_ID = 901;

COMMIT; -- ���� Ȯ��

-- DEPT_ID�� D1�μ��� ���� 
DELETE FROM DEPARTMENT 
WHERE DEPT_ID = 'D1';
 -- ORA-02292: integrity constraint (KH.SYS_C007116) violated - child record found
 -- �ܷ�Ű �������� ����
 -- D1�� ���� ������ ���� �ڽĵ����Ͱ� �ֱ� ������ ���� �Ұ�.
 
 -- DEPT_ID�� D3�� �μ� ����
 DELETE FROM DEPARTMENT
  WHERE DEPT_ID = 'D3';
  
SELECT * FROM DEPARTMENT;
ROLLBACK;

---------------------------------------------------
 -- TRUNCATE : ���̺� ��ü ���� ������ �� ���Ǵ� ����.
    -- DELETE ���� ����ӵ��� ����.
    -- ������ �������� �Ұ�, ROLLBACK�� �Ұ�. 
     
-- [ǥ����]  TRUNCATE TABLE ���̺��;

SELECT * FROM EMP_SALARY;
TRUNCATE TABLE EMP_SALARY;

ROLLBACK;















