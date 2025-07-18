/*
    ������
     : �ڵ����� ��ȣ �߻������ִ� ������ �ϴ� ��ü
     - �������� ���������� �������� ������Ű�鼭 �������� (�⺻������ 1�� ����)
*/

/*
        1. ������ ��ü ����
        [ǥ����]
        CREATE SEQUENCE ��������
        
        [�� ǥ����]
        CREATE SEQUENCE �������� 
        [START WITH ���ۼ���] -- ó�� �߻���ų ���۰� ����, �⺻�� 1
        [INCREMENT BY ����]  -- �� �� ������ų ������, �⺻�� 1
        [MAXVALUE ����]      -- �ִ밪 ����, �⺻�� �̳� ŭ
        [MINVALUE ����]      -- �ּҰ� ����, �⺻�� 1 = �ִ밪 ��� ÷���� �ٽ� �����ϰ� �� �� ����.
        [CYCLE | NOCYCLE]   -- �� ��ȯ ���� ����, �⺻�� NOCYCLE
        [NOCACHE | CACHE ����Ʈ ũ��] -- ĳ�ø޸� �Ҵ� (�⺻�� CACHE 20)
        
        * ĳ�� �޸� : �ӽð��� (�̸� �߻��� ������ �����ؼ� �����صδ� ����)
            - �Ź� ȣ��� ������ ���� ��ȣ�� ����X, ĳ�ø޸� ������ ������ ������ ������ �� �� ����. 
              �� ���� ������, ĳ�ø޸𸮿� ����� �� ��ȣ���� ���� 
*/

CREATE SEQUENCE SEQ_TEST;
-- ���� : ���� ������ �����ϰ� �ִ� ������ ������ �� ��
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 330
NOCYCLE
NOCACHE;

/*
        2. ������ ���
        ��������.CURRVAL : ���� �������� �� (������ ������ ����� NEXTVAL�� ��)
        ��������.NEXTVAL : ������ ���� �������� �������� �߻��� �� (�⺻������ 1���� ����� ��)
                         
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
    -- ORA-08002: sequence SEQ_EMPNO.CURRVAL is not yet defined in this session
    -- *Action:   select NEXTVAL from the sequence before selecting CURRVAL

-- SELECT ������ ġ�� ����
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- ������ ���������� ����� NEXTVAL��
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 305 > 310 ...330 ���� ���� : ���� MAX�� �ʰ�, ����
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 330 

/*
        3. ������ ���� ����
        ALTER SEQUENCE ��������  --> START WITH�� ���� �Ұ�
        [INCREMENT BY ����]  -- �� �� ������ų ������, �⺻�� 1
        [MAXVALUE ����]      -- �ִ밪 ����, �⺻�� �̳� ŭ
        [MINVALUE ����]      -- �ּҰ� ����, �⺻�� 1 = �ִ밪 ��� ÷���� �ٽ� �����ϰ� �� �� ����.
        [CYCLE | NOCYCLE]   -- �� ��ȯ ���� ����, �⺻�� NOCYCLE
        [NOCACHE | CACHE ����Ʈ ũ��] -- ĳ�ø޸� �Ҵ� (�⺻�� CACHE 20)
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; 
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;

--      4. ������ ����
DROP SEQUENCE SEQ_EMPNO;
------------------------------------------------
-- ��� ��ȣ�� Ȱ���� ������ ����
CREATE SEQUENCE SEQ_EID
START WITH 400
NOCACHE;

INSERT 
 INTO EMPLOYEE
    (
      EMP_ID
    , EMP_NAME
    , EMP_NO
    , JOB_CODE
    , SAL_LEVEL
    , HIRE_DATE
    )
    VALUES 
    (
      SEQ_EID.NEXTVAL
    , 'ȫ���'
    , '990101-1111111'
    , 'J7'
    , 'S1'
    , SYSDATE
    );
    
SELECT * FROM EMPLOYEE;


INSERT 
 INTO EMPLOYEE
    (
      EMP_ID
    , EMP_NAME
    , EMP_NO
    , JOB_CODE
    , SAL_LEVEL
    , HIRE_DATE
    )
    VALUES 
    (
      SEQ_EID.NEXTVAL
    , 'ȫ�繫'
    , '990101-2222222'
    , 'J6'
    , 'S1'
    , SYSDATE
    );

-------------------------
-- �������� 
INSERT 
 INTO EMPLOYEE
    (
      EMP_ID
    , EMP_NAME
    , EMP_NO
    , JOB_CODE
    , SAL_LEVEL
    , HIRE_DATE
    )
    VALUES 
    (
      SEQ_EID.NEXTVAL
    , ?
    , ?
    , ?
    , ?
    , SYSDATE
    );




