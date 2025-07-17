/*

    DCL : ������ ���� ��� 
     : �������� �ý��۱��� �Ǵ� ��ü���� ������ �ο�(GRANT)�ϰų� ȸ��(REVOKE)�ϴ� ����
     
     > �ý��� ���� : DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ���� 
     > ��ü���ٱ��� : Ư�� ��ü���� ������ �� �ִ� ����
*/


/*
    *�ý��� ���� ����
     - CREATE SESSION : ���� �� �� �ִ� ����
     - CREATE TABLE : ���̺� ���� ����
     - CREATE VIEW : �並 ������ �� �ִ� ����.
     - CREATE SEQUENCE : �������� ������ �� �ִ� ����
     ... : �Ϻδ� CONNERCT(GRANT CONNECT) �ȿ� ���ԵǾ� ����.
*/

-- 1. SAMPLE / SAMPLE ���� ����.
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
    -- ������ ����

-- 2. ������ ���� CREAT SESSION ���� �ο� 
GRANT CREATE SESSION TO SAMPLE;


-- 3_1. ���̺� ���� ���� �ο�
GRANT CREATE TABLE TO SAMPLE;

-- 3_2. TABLESPACE �Ҵ�
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
-------------------

/*
    ��ü ���� ���� ����
     : Ư�� ��ü�� �����ؼ� ������ �� �ִ� ����
  
    ���� ����               Ư�� ��ü
    SELECT    |  TABLE, VIEW, SEQUENCE
    INSERT    |  TABLE, VIEW
    UPDATE    |  TABLE, VIEW
    DELETE    |  TABLE, VIEW

    [ǥ����]
    GRANT �������� ON Ư����ü TO ���� ����
    
*/

GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

/*
    <ROLE>
     - Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� ��
     CONNECT : ������ �� �ִ� ���� CREATE SESSION
     RESOURCE : Ư�� ��ü���� ������ �� �ִ� ����
          (CREATE TABLE, CREATE SEQUENCE,...)
*/

SELECT *
FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE')
ORDER BY 1;






















