CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(10)
);
-- 01031. 00000 -  "insufficient privileges"
    -- �� ���̺� �������� X 
-- 3_1. CREATE TABLE ���� �ޱ�
-- 3_2. TABLESPACE �Ҵ� �ޱ�

SELECT * FROM TEST;

INSERT INTO TEST VALUES(10, '�ȳ�');
    --> CREATE TABLE���� ������, ���̺� ���� ���� 
    
-- �� ���� ���̺� ����
SELECT * FROM KH.EMPLOYEE;
--4. SELECT ON KH.EMPLOYEE ���� �ޱ�

INSERT INTO KH.DEPARTMENT VALUES ('D0', 'ȸ���', 'L1');
-- INSERT ON KH.DEPARTMENT ���� �ޱ�

ROLLBACK;


