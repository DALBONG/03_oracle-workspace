/*
    DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
         : ��ü���� ����, ����, �����ϴ� ����
         
    < ALTER >
    ��ü�� �����ϴ� ����.

    [ǥ����]
    ALTER TABLE ���̺�� ������ ����;
    
    * ������ ����
    1) �÷� �߰�/����/����
    2) ��������  �߰�/���� (���� �Ұ�, ������ ���� �߰��ؾ� ��)
    3) �÷��� / ���̺�� ����
*/

-- 1) �÷� �߰�/����/����
-- 1-1) �÷� �߰� (ADD) : ADD �÷��� �ڷ��� [DEFAULT �⺻��] [��������]
-- DEPT_COPY C_NAME �÷� �߰�
SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);

-- LNAME �÷� �߰�, (�⺻�� ����)
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';

-- 1-2) �÷� ���� (MODIFY)
    -- �ڷ��� ����           --> MODIFY �÷��� �ٲ��ڷ���
    -- DEFAULT �� ����      --> MODIFY �÷��� DEFAULT �ٲ� �⺻��
    
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
    -- �����ϴ� �����Ͱ� ����߸� �ڷ��� ��ü�� ���� ����.
        -- ORA-01439: column to be modified must be empty to change datatype
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
    -- �����ϴ� �����Ͱ� �����Ϸ��� ���̺��� Ŀ ���� �Ұ� 
        -- ORA-01441: cannot decrease column length because some value is too big

SELECT * FROM DEPT_COPY;
-- DEPT_TITEL �÷��� VARCHAR2(50)��
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR(50);

-- LOCATION_ID �÷��� VARCHAR2(4)��
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR(4);

-- LNAME �÷��� �⺻���� '�̱�'���� ����
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '�̱�';
    --> DEFAULT ���� �ٲ۴� �ؼ� ������ ������ ���� �ٲ����� ����.

-- ���ߺ��� ����
ALTER TABLE DEPT_COPY 
    MODIFY DEPT_TITLE VARCHAR(50)
    MODIFY LOCATION_ID VARCHAR(4)
    MODIFY LNAME DEFAULT '�̱�';
    

-- 1-3) �÷� ���� (DROP COLUMN) : DROP COLUMN ������ �÷���

CREATE TABLE DEPT_COPY2
 AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2���� DEPT_ID �÷� ����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
    --> �÷� ������ ���� ALTER �Ұ�.
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
    -- �ּ� 1���� �÷��� �����ؾ� �ϹǷ� ���� �Ұ�.
        -- ORA-12983: cannot drop all columns in a table
        
------------------------------------------------------------------------

-- 2) �������� �߰� / ����.

/*
    2-1) �������� �߰�
        PRIMARY KEY �⺻Ű : ADD PRIMARY KEY (�÷���)
        FOREIGN KEY �ܷ�Ű : ADD FOREIGN KEY (�÷���) REFERENCES ���� ���̺� [(�÷���)]
        UNIQUE �ߺ� ����   : ADD UNIQUE (�÷���) 
        CHECK ����        : ADD CHECK (�÷��� ���� ����)   
        NOT NULL          : MODIFY �÷��� NOT NULL | NULL(�� ���)
        
        �������� ���� �����ϰ��� �Ѵٸ� [CONSTRAINT �������Ǹ�] ��������
*/

-- DEPT_ID�� [PK�������� �߰�]
-- DEPT_TITLE�� UNIQUE �߰�
-- LNAME�� NOT NULL �߰�

ALTER TABLE DEPT_COPY
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
    ADD CONSTRAINT DCOPY_UQ UNIQUE (DEPT_TITLE)
    MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;

-- 2-2) �������� ���� : DROP CONSTRAINT �������Ǹ� 
--                   NN�� ���� X MODIFY 

ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;
ALTER TABLE DEPT_COPY 
    DROP CONSTRAINT DCOPY_UQ
    MODIFY LNAME NULL;
    
--------------------------------------------------------------------------------]
-- 3) �÷��� / �������� ��/ ���̺�� ���� RENAME

-- 3-1) �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ��÷���

-- DEPT_TITLE -> DEPT_NAME

SELECT * FROM DEPT_COPY;
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3-2) �������� �� ���� : RENAME CONSTRAINT �������� �� TO �ٲ� �������Ǹ�
    -- SYS_C007158 --> DCOPY_LID_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007158 TO DCOPY_LID_NN;

-- 3-3) ���̺� �� ���� : RENAME [�������̺��] TO �ٲ� ���̺��
-- DEPT_TEST��

ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;
SELECT * FROM DEPT_TEST;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- ���̺�  ���� 
DROP TABLE DEPT_TEST;
    -- ��, ��򰡿��� �����ǰ� �ִ� �θ� ���̺��� ���� �Ұ�! �����ϰ��� �Ѵٸ�
        -- 1) �ڽ� ���̺� ���� �� �θ����̺� ����
        -- 2) �θ����̺� �����ϴµ�, �������� ���� ���� ����
            -- (DROP TABLE ���̺�� CASCADE CONSTRAINT;)









































