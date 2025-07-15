-- CREATE USER ddl IDENTIFIED BY ddl;
-- GRANT CONNECT, RESOURCE TO ddl;

/*
    DDL(DATA DEFINITION LANGUAGE) : ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü(OBJECT)�� ���� �����(CREATE), ���� ����(ALTER), ���� ����(DROP)�ϴ� ���
    -> ���� ������ ���� �ƴ�, ���� ��ü�� �����ϴ� ���
        �ַ� DB������, �����ڰ� ���.
        
    * ����Ŭ���� �����ϴ� ��ü : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE ���� ����), �ε���(INDEX), ��Ű��(PACKAGE), 
                            Ʈ����(TRIGGER), ���ν���(PROCEDURE), �Լ�(FUNCTION), �����(USER)
                            
    <CREATE >
    ��ü�� ���� �����ϴ� ����
*/

/*
    1. ���̺� ����
     - ��(ROW),��(COLUMN)�� �����Ǵ� �⺻�� DB ��ü
        ��� �����͵��� ���̺��� ���� ����
        DBMS ����� �ϳ���, �����͸� ������ ǥ ���·� ǥ���� ��.
        
    [ǥ����]
    CREATE TABLE ���̺��(�÷���1 �ڷ���1(ũ��), �÷���2 �ڷ���2(ũ��),...);
    
    *�ڷ���
     - ���� (CHAR(����Ʈũ��)) | VARCHAR2(����Ʈũ��) => �ݵ�� ũ�� ����
        �� CHAR : 2000 Byte���� ����, ������ ���� �������� ���
                / ��������(���� ũ�⺸�� �� ���� ���� ���ƿ͵� �������� ä����)
                  : ������ ���� ���� �����͸� ���� ��� ���
        �� VARCHAR2 : 4000Byte ���� ����
                / ��������(��� ���� ���� ������ ũ�� ������)
                  : �� �׶��� �����Ͱ� ������ �� �� ���
     - ���� (NUMBER)
     - ��¥ (DATE)
*/


-- ȸ���� ���� �����͸� ��� ���� ���̺� MEMBER ����

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

--> �÷��� ��Ÿ ������ ��� �ٽ� ���� �Ұ�, �����ϰ� �ٽ��ϴ��� �ؾ� ��.

-----------------------------------------------
/*
    2. �÷��� �ּ� �ޱ�(�÷��� ���� ����)
    
    [ǥ����]
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
*/

COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '��й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ�� �̸�';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS '���� ��';

-- ���̺� �����͸� �߰���Ű�� (DML : INSERT) (���߿� �ڼ��� ��� ��)
    -- INSERT INTO ���̺�� VALUES(��1, ��2,...);
    
SELECT * FROM MEMBER;

--INSERT INTO MEMBER VALUES (1, 'USER01', 'PASS01', '������');
            --> �÷� ������ŭ ���� ������ ����.
INSERT INTO MEMBER VALUES (1, 'user01', 'pass01', '������', '��', '010-4438-2384', 'cew.com', '24/2/10');
INSERT INTO MEMBER VALUES (2, 'user02', 'pass02', '�����', '��', NULL, NULL , SYSDATE);
INSERT INTO MEMBER VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL , NULL);
        --> ��ȿ���� ���� �����Ͱ� ���� ����. ���� ������ �ɾ���� ��. (��������)
        
        /*
            <���� ���� CONSTRAINT>
            - ���ϴ� ������ ���� �����ϱ� ���� Ư�� �÷��� �����ϴ� ��������
            - ������ ���Ἲ ������ �������� ��.
            
            *���� : NOT NULL, UNIQUE(�ߺ�X), CHECK(��OR�� �ƴϾ�? ����), PRIMARY KEY, FOREIGN KEY 
        */
        
            /*
                 1) NOT NULL
                  �ش� �÷��� �ݵ�� ���� �����ؾ߸� �ϴ� ��� 
                  ����/ ������ NULL���� ������� �ʵ��� ����
                  
                  ���� ������ �ο��ϴ� ����� ũ�� 2���� ��� (�÷� ���� ��� / ���̺� ���� ���)
                  - NOT NULL ���� ������ ������ �÷� ������� �ۿ� �ȵ�.
            */
-- �÷� ���� ��� : �÷��� �ڷ��� ��������
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷� ���� ���
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1, 'user01', 'user02', '������', '��', NULL, NULL, NULL);
-- INSERT INTO MEM_NOTNULL VALUES(2, 'user02', NULL, '�ں���', '��', NULL, 'ppy.com', NULL);
    -- ORA-01400: cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_PWD")
    -- NOT NULL �������ǿ� �ɷ� ���� �߻�
INSERT INTO MEM_NOTNULL VALUES(2, 'user01', 'pass02', '�ں���', '��', NULL, 'ppy.com', NULL);
    -- ID �ߺ� �߻�
--------------------------------------------------------------------------------
            /*
                 2) UNIQUE ��������
                  �ش� �÷��� �ߺ��� ���� ������ �ȵ� ��� 
                  ����/ ������ ���� ������ ���� ������� �����߻�.
            */
            
-- �÷� ���� ��� : �÷��� �ڷ��� ��������
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷� ���� ���
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);           
            
DROP TABLE MEM_UNIQUE;

-- ���̺� ���� ��� : ��� �÷��� �� ���� ��, �������� ���
                -- ���� ����(�÷���)
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID) -- ���̺� ���� ���
);           
SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '������', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '�ں���', '��', NULL, 'ppy.com');
    --ORA-00001: unique constraint (DDL.SYS_C007049) violated (UNIQUE ���� ���ǿ� ����, INSERT ����)
    --> ���������� �������� ������ �˷��� (Ư�� �÷��� � ������ �ִ��� �˷����� ����, ���� �ľ� �����)
    --> �������� �ο��� ���Ǹ��� ���������� ������ �ý��ۿ��� ���Ƿ� �������Ǹ� �ο���
/*
    * �������� �ο��� �������Ǹ���� �����ֱ�
     > �÷� �������
         CREATE TABLE ���̺��(
            �÷���1 �ڷ���1 [CONSTRAINT �������Ǹ�] ��������,
            �÷���2 �ڷ���2,...);
     > ���̺� �������
         CREATE TABLE ���̺��(
            �÷���1 �ڷ���1,
            �÷���2 �ڷ���2,...),
            [CONSTRAINT �������Ǹ�] ��������(�÷���;)
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

INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '�ں���', '��', NULL, 'ppy.com');
INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass03', '�����', '��', NULL, NULL);

SELECT * FROM MEM_UNIQUE;
    --> ������ ��ȿ���� ���� ������
-------------------------------------------------
            /*
                 3) CHECK ��������
                  �ش� �÷��� ���� �� �ִ� ���� ���� ���� ���� 
                  ���ǿ� �����ϴ� ������ ���� ���� �� ����.
            */
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CHECK(GENDER IN ('��', '��')) > ���̺� ���� ���
);

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', '������', '��', NULL, NULL);
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '�ںϾ�', '��', NULL, NULL);
    -- ORA-02290: check constraint (DDL.SYS_C007059) violated (üũ �������� ����, INSERT X)
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '�ںϾ�', NULL, NULL, NULL); -- �̰� �� ��
    -- GENDER �÷��� ������ ���� �ְ��� �Ѵٸ� CHECK�������ǿ� �����ϴ� ���� �־�� ��. 
    -- NOT NULL �ƴϸ� NULL�� ����
INSERT INTO MEM_CHECK VALUES(2, 'user03', 'pass03', '�����', NULL, NULL, NULL); -- ȸ����ȣ �����ص� INSERT ����
---------------------------------------------
            /*
                 4) PRIMARY KEY(�⺻Ű) ��������
                  ���̺��� �� ����� �ĺ��ϱ� ���� ���� �÷��� �ο��ϴ� ��������(�ĺ����� ����)
                  EX) ȸ����ȣ, �й�, �����ȣ(EMP_ID), �μ��ڵ�(DEPT_ID), �����ڵ�(JOB_CODE), �ֹ���ȣ, ����,������ȣ ��....
                  
                  PRIMARY KEY ���������� �ο��ϸ� �ڵ����� NOT NULL, UNIQE �������� ����.
                  
                  * ���ǻ��� : '�� ���̺�� �Ѱ��� ����' ����
            */
CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- PRIBARY KEY(�÷���)
);

SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI VALUES(1, 'user01', 'pass01', '������', '��', '010-7474-4875', NULL);
INSERT INTO MEM_PRI VALUES(1, 'user02', 'pass02', '�ںϾ�', '��', NULL, NULL);
    -- ORA-00001: unique constraint (DDL.MEMNO_PK) violated (�����̸Ӹ� Ű ������ ����ũ ����Ǿ��� ��)
INSERT INTO MEM_PRI VALUES(NULL, 'user02', 'pass02', '�ںϾ�', '��', NULL, NULL);
    -- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
        -- �⺻Ű�� NULL ������ �Ҷ� NOT NULL �������� ����
INSERT INTO MEM_PRI VALUES(2, 'user02', 'pass02', '�ںϾ�', '��', NULL, NULL);
       
CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, 
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_PK PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
); --02260. 00000 -  "table can have only one primary key"
        -- �⺻Ű�� �ϳ��� ��

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID) -- ��� PRIVARY KEY �������� �ο� (���� Ű)
);
SELECT * FROM MEM_PRI2;

INSERT INTO MEM_PRI2 VALUES(1, 'user01', 'pass01', '���˿�', NULL, '010-7474-4875', NULL);
INSERT INTO MEM_PRI2 VALUES(1, 'user02', 'pass02', '�ںϾ�', NULL, NULL, NULL);
INSERT INTO MEM_PRI2 VALUES(2, 'user02', 'pass02', '�����', NULL, NULL, NULL);
INSERT INTO MEM_PRI2 VALUES(NULL, 'user02', 'pass02', '������', NULL, NULL, NULL);
    -- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
        -- �����ִ� �� �÷����� ���� NULL ��� X

-- ����Ű ��� ���� : ���θ� ���ϱ�, ���ƿ�, ����
    -- �� ��ǰ�� �ѹ��� ���� �� ����.

-- ȸ���� � ��ǰ�� ���ϴ����� ���� ������ ���� ���̺�

CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(40),
    LIKE_DATE DATE,
    PRIMARY KEY (MEM_NO, PRODUCT_NAME)
);

SELECT * FROM TB_LIKE;

INSERT INTO TB_LIKE VALUES(1, '�鵵 ������', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, '�鵵 ������', SYSDATE);
INSERT INTO TB_LIKE VALUES(2, '�鵵 ������', SYSDATE);
-- INSERT INTO TB_LIKE VALUES(1, '�鵵 ������', SYSDATE); >> ����, �ѹ��� ���ؾ���.
-------------------------------------------------------------

      
 --               5)  ȸ�� ��޿� ���� �����͸� ���� �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);  

SELECT * FROM MEM_GRADE;

INSERT INTO MEM_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES(20, '���ȸ��');
INSERT INTO MEM_GRADE VALUES(30, 'Ư��ȸ��');

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER -- ȸ������� ���� ������ �÷�
);

SELECT * FROM MEM;

INSERT INTO MEM VALUES(1, 'user01', 'pass01', '���˿�', '��', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '�ںΰ�', '��', NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '�����', '��', NULL, NULL, 90);
        -- ��ȿ���� ���� ȸ����� ��ȣ�� INSERT
        
----------------------------------------------------------------
            /*
                 5) FOREIGN KEY (�ܷ�Ű) ��������
                  �ٸ� ���̺� �����ϴ� ���� ���;� �Ѵ� Ư�� �÷��� �ο��ϴ� ��������
                    -> �ٸ� ���̺� ����.
                  --> �ַ� FK �������ǿ� ���� ���̺��� ���� ����
                  
                  * �÷� ���� ���
                    : �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] REFERENCES ������ ���̺��([������ �÷� ��])
                  * ���̺� ���� ���
                    : [CONSTRAINT �������Ǹ�] FOREIGN KEY(�÷���) REFERENCES ������ ���̺��([������ �÷� ��])
                    --> ������ �÷��� ������ ������ ���̺��� PK�� �ڵ� ����.
            */
            
DROP TABLE MEM;
            
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE (GRADE_CODE) -- �÷� ���� ���
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE (GRADE_CODE) -- ���̺� ���� ���
);

SELECT * FROM MEM;

INSERT INTO MEM VALUES(1, 'user01', 'pass01', '���˿�', '��', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '�ںΰ�', '��', NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '�����', '��', NULL, NULL, 90);
    -- ORA-02291: integrity constraint (DDL.SYS_C007086) violated - parent key not found
        -- PARENT Ű�� ã�� �� ����.
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '�����', '��', NULL, NULL, 30);
    -- MEM_GRADE(�θ� ���̺�) ---> MEM(�ڽ� ���̺�)

-- �̶� �θ����̺��� ������ ���� ������ ��� � ����? 
    -- ������ ���� : DELETE FROM ���̺� �� WHERE ���� ;

-- MEM_GRADE ���̺��� 10�� ��� ����

DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = 10;
    -- constraint (DDL.SYS_C007086) violated - child record found 
        -- �ڽ����̺�(MEM)���� �̹� �����ִ� 10 �����Ͱ� �־ ���� �ȵ�
DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = 20;
    -- �ڽ� ���̺���(MEM) 20���� ����ϰ� ���� �ʾ� ���� ����
    
--> �ڽ� ���̺� �̹� ����ϰ� �ִ� ���� ������� �θ����̺�� ���� ������ ������ �ȵǰ� �ϴ� "���� ����" �ɼ� �ɷ�����

SELECT * FROM MEM_GRADE;
--���� �ǵ����� 
ROLLBACK;
    
-------------------------------------------------------------------------------
/*
    �ڽ� ���̺� ������ �ܷ�Ű �������� �ο��� �� �����ɼ� ���� ����
    * ���� �ɼ� : �θ����̺��� ������ ������ �� �����͸� ����ϰ� �ִ� �ڽ����̺� ���� ��� ó���� ������?
    
    �����, 98% ����
    - ON DELETE RESTRICTED(�⺻��) : ���� ����, �ڽĿ��� �����ִ� �θ� �����ʹ� ���� �Ұ�
    - ON DELETE SET NULL : �θ����� ������ �ش� �����͸� ���� �ִ� �ڽ� �������� ����  NULL�� ����
    - ON DELETE CASCADE : �θ����� ������ �ش� �����͸� �����ִ� �ڽ� �����͵� ����
*/

DROP TABLE MEM;

-- ON DELETE SET NULL
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE (GRADE_CODE) ON DELETE SET NULL
);

SELECT * FROM MEM;

INSERT INTO MEM VALUES(1, 'user01', 'pass01', '���˿�', '��', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '�ںΰ�', '��', NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '��', '��', NULL, NULL, 20);
INSERT INTO MEM VALUES(4, 'user04', 'pass04', '�ںο�', '��', NULL, NULL, 10);

-- 10 ��� ����
DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = 10;
-- ���� �� 10�� �����ִ� �ڽ� ������ ���� NULL�� ����
SELECT * FROM MEM_GRADE;
ROLLBACK;
    
DROP TABLE MEM;

-- ON DELETE CASCADE
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE (GRADE_CODE) ON DELETE CASCADE
);

SELECT * FROM MEM;
SELECT * FROM MEM_GRADE;

INSERT INTO MEM VALUES(1, 'user01', 'pass01', '���˿�', '��', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '�ںΰ�', '��', NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '��', '��', NULL, NULL, 20);
INSERT INTO MEM VALUES(4, 'user04', 'pass04', '�ںο�', '��', NULL, NULL, 10);
    
    -- 10�� ��� ����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;

--==============================================================================

/*
    DEFAULT �⺻��
    : �÷��� �������� �ʰ� INSERT�� NULL�� �ƴ� �⺻���� INSERT�ϰ��� �� �� ���� ���� �� �ִ� ��
*/
DROP TABLE MEMBER;
-- �÷��� �ڷ��� DEFAULT �⺻�� [��������]

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '������',
    ENROLL_DATE DATE DEFAULT SYSDATE
);

SELECT * FROM MEMBER;

-- INSERT INTO ���̺�� VALUES (��1, ��2, ...)
INSERT INTO MEMBER VALUES(1, '���ο�', 20, '����', '25/01/07');
INSERT INTO MEMBER VALUES(2, '�ں���', NULL, NULL, NULL);
INSERT INTO MEMBER VALUES(3, '�ں���', NULL, DEFAULT, DEFAULT);

-- INSERT INTO ���̺�� (�÷���, �÷���) VALUES (��1, ��2); 
    -- �� NOT NULL�ΰ� �� ���� ��.
INSERT INTO MEMBER (MEM_NO, MEM_NAME) VALUES(4, '������');
    -- ���õ��� ���� �÷��� �⺻������ NULL�̳�, �ش� �÷��� DEFAULT ���� ���� ��� DEFAULT �� ��

--=============================================================================
/*
    !!!!!!!!!!!!!!!!!!!!!!!!!! KH�������� ��ȯ!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    <���������� �̿��� ���̺� ����>
     ���̺� ���� ����
     
     [ǥ����]
     CREATE TABLE ���̺�� 
     AS ��������;
*/

-- EMPLOYEE ���̺��� ������ �� ���̺� ����
CREATE TABLE EMPLOYEE_COPY 
AS SELECT *
    FROM EMPLOYEE;
    --> �÷�, �����Ͱ�, �������� ���� ��� NOT NULL�� ����� 

SELECT * FROM EMPLOYEE_COPY2;

CREATE TABLE EMPLOYEE_COPY2
AS SELECT *
    FROM EMPLOYEE  -- ���̺� ������ ���� 
    WHERE 1 = 0; -- ������ FALSE�� ����
    
    
CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 "����"
    FROM EMPLOYEE;
    -- 00998. 00000 -  "must name this expression with a column alias"
        --> �÷� ��Ī�� �Բ� ����
        -- ��ũ���� SELECT ���� �����, �Լ����� ����� ��� �ݵ�� ��Ī ����
SELECT * FROM EMPLOYEE_COPY3;

--====================================================================
/*
    ���̺� ���� �� �������� �߰�.
    ALTER TABLE ���̺�� ���泻��;
    
    - PRIMARY KEY (�⺻ Ű)         : ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���);
    - FOREIGN KYE (�ٸ� ���̺� ����) : ALTER TABLE ���̺�� ADD FOREIGN KEY (�÷���) REFERENCES (���� ���̺� ��);
    - UNIQUE (������ �� �ߺ�X)       : ALTER TABLE ���̺�� ADD UNIQUE(�÷���);
    - CHECK                        : ALTER TABLE ���̺�� ADD CHECK (�÷��� ���� ���ǽ�);
    - NOT NULL                     : ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL; **�ణ Ư��
*/

-- ���� ������ �̿��ؼ� ������ ���̺��� NN �������� ���� ���� �ȵ�
-- EMPLOYEE_COPY ���̺� PK �������� �߰� (EMP_ID)

ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);
-- EMPLOYEE ���̺� DEPT_CODE�� �ܷ�Ű �������� �߰� (�������̺�(�θ�)) : DEPARTMENT(DEPT_ID)

ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT;
    -- �����ϸ� �θ����̺��� FK�� ��
    
    
-- EMPLOYEE ���̺� JOB_CODE�� �ܷ�Ű �������� �߰� (JOB ���̺� ����)
SELECT JOB_CODE FROM JOB;

ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB;
SELECT * FROM EMPLOYEE;

-- EMPLOYEE ���̺� SAL_LEVEL�� �ܷ�Ű �������� (SAL_GRADE ���̺� ����)

ALTER TABLE EMPLOYEE ADD FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE;

-- DEPARTMENT ���̺� LOCATION_ID�� �ܷ�Ű �������� (LOCATION ���̺� ����)
ALTER TABLE DEPARTMENT ADD FOREIGN KEY (LOCATION_ID) REFERENCES LOCATION;

--=============================================================================
    
    
        
            
            
            
            


