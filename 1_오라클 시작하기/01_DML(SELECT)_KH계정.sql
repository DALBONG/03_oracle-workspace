/*
 <SELECT>
 ������ ��ȸ�� �� ���Ǵ� ����
  >> ��� RESULT SET : SELECT ���� ���� ��ȸ�� ����� (��ȸ�� �ൿ���� ����)
  
  [ǥ����]
  SELECT ��ȸ�ϰ��� �ϴ� �÷�1, �÷�2,... 
  FROM ���̺��;
       * �ݵ�� �����ϴ� �÷����� ��� ��. ���� �÷��� ���� ����.
    
*/

-- EMPLOYEE ���̺��� ��� �÷�(== *) ��ȸ
-- SELECT EMP_ID, EMP_NAME
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �� ��, �̸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- JOB ���̺��� ��� �÷� ��ȸ
SELECT *
FROM JOB;
------------------------------------------------------------------------------
-- ===============================�ǽ�����=====================================

-- 1. JOB���̺��� ���� �� ��ȸ
SELECT JOB_NAME
FROM JOB;

-- 2. DEPARTMENT ���̺��� ��� �÷� ��ȸ
SELECT *
FROM DEPARTMENT;

-- 3. DEPARTMENT ���̺��� �μ� �ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 4. EMPLOYEE  ���̺��� �����, �̸���, ��ȭ��ȣ, �Ի���, �޿� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
 < �÷� ���� ���� ���� ����>
 SELECT�� �÷��� �ۼ� �κп� ������� ��� ���� (���� ����� ��� ��ȸ)
*/

-- EMPLOYEE ���̺��� �����, ����� ���� ��ȸ (�޿�*12)
SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ����� �޿� ���ʽ� ��ȸ
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

-- EMPLOYEE �����, �޿�, ���ʽ�, ����, ���ʽ� ���Ե� ������ȸ 
SELECT EMP_NAME, SALARY, BONUS, SALARY*12, (SALARY+SALARY*BONUS)*12
FROM EMPLOYEE;
  --> ��� ���� ������ null���� ���� ��� ��������� ������� null�� ���
  
-- EMPLOYEE ����� �Ի���
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE �����, �Ի���, �ٹ��ϼ�(���ó�¥ - �Ի���)
-- ORACLE�� date ���ĳ��� ���� ����
   --> ���ó�¥ : SYSDATE
SELECT EMP_NAME, SYSDATE-HIRE_DATE  
FROM EMPLOYEE;  
--> ������� �� ������ ������ DATE������ ��,��,��,��,��,�� ������ ������ �Ͽ� �Ҽ������� ���� �� ����.

--==============================================================================
/*
    <�÷� �� ��Ī �����ϱ�>
    ��� ������ �� ��� �÷��� ����������. �̶� �÷��� ��Ī �ο��Ͽ� ����� ������
    
    (ǥ����)
    �÷��� ��Ī  /  �÷��� AS   / �÷��� "��Ī"  / �÷��� AS "��Ī"
     -  AS ���̵� �Ⱥ��̵�, �ο��ϰ��� �ϴ� ��Ī�� ���� Ȥ�� Ư���� ���Ե� ���
        �ݵ�� " " �� ����ؾ� ��.
*/

SELECT EMP_NAME �����, SALARY AS �޿�, SALARY*12 "����(��)", (SALARY + SALARY*BONUS)*12 AS "�Ѽҵ�"
FROM EMPLOYEE;


/*
   <���ͷ�>
   ���Ƿ� ������ ���ڿ� (' ')
   SELECT �� ���ͷ� �����ϸ� ��ġ ���̺� �����ϴ� ������ó�� ��ȸ����

*/
-- EMPLOYEE ���̺��� ���, �����, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, '��' AS "����"
FROM EMPLOYEE;

/*
 <���� ������ : || >
 ���� �÷������� �ϳ��� �÷��� �� ó�� ����
  �÷����� ���ͷ� ���� ������ �� ����.
  System.out.println("num�� �� : " + num) -> +�� ���Ұ� ���
*/

-- ���, �̸�, �޿��� �ϳ��� �÷����� ��ȸ
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

--�÷� ���� ���ͷ��� ����
-- �������� ������ �������� �Դϴ�. -> �÷��� ��Ī : �޿�����

SELECT (EMP_NAME || ' �Ʒú��� ������ ' || SALARY || '�� �Դϴ�.' ) AS "�޿�����"
FROM EMPLOYEE;

--==================================================================
/*
 <DISTINCT>
 �÷��� �ߺ��� ������ �ѹ����� ǥ���ϰ��� �� �� ���
*/

-- ���� �츮 ȸ�翡 � ������ ������� �����ϴ°�? 
SELECT JOB_CODE 
FROM EMPLOYEE; --> 23���� ���� ��� ��ȸ

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; --> �����ڵ� �ߺ� ���� ��ȸ 

SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

/* ���� ���� : DISTINCT�� �������� �ѹ��� ��� ����.
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
FROM EMPLOYEE;
*/

SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE; 
--===========================================================================

/*
 <WHERE ��>
 ��ȸ�ϰ��� �ϴ� ���̺�κ��� Ư�� ���ǿ� �����ϴ� �����͸��� ��ȸ�ϰ��� �� �� ���
 WHERE ���ǽ��� �����ϰ� ��.
 ���ǽĿ����� �پ��� �����ڵ� ��� ����.
 
 [ǥ����]
 SELECT  �÷�1, �÷�2
 FROM ���̺� �� 
 WHERE ���ǽ�;
 
 [�񱳿�����]
  >, <, >=, <=  : ��Һ�
  = : �����
  ^= , != , <> : �����
*/

-- EMPLOYEE ���� �μ��ڵ尡 D9�� ����鸸 ��ȸ
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- �μ��ڵ尡 D1�� ������� �����, �޿�, �μ��ڵ常 ��ȸ

SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

--�μ��ڵ尡 D1�� �ƴ� ������� ���, �����, �μ��ڵ� ��ȸ
SELECT  EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D1';
--WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

-- �޿��� 400���� �̻��� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- �������� ������� ���, �̸�. �Ի���, ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

--=================================�ǽ����� ================================
-- 1. �޿��� 300�̻� �޴� ������� �����, �޿�, �Ի���, ����
SELECT EMP_NAME, SALARY, HIRE_DATE, SALARY*12 "����"
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. ������ 5000�̻� ������� �����, �޿�, ����, �μ��ڵ� ��ȸ
SELECT EMP_NAME, SALARY, SALARY*12 AS "����", DEPT_CODE
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;
--WHERE ���� >= 50000000;  --> ��Ƽ������ : ����Ŭ�� ���� �ý���.
     --> ��Ƽ�������� �����ȹ ������ ���� 1)FROM > 2)WHERE > 3)SELECT �̱� ���� 

-- 3. �����ڵ尡 'J3'�� �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- �μ��ڵ尡  D9�̸鼭 �޿��� 500�̻��� ������� ���, �����, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- �μ��ڵ尡 D6�̰ų� �޿��� 300 �̻��� ������� �����,�μ��ڵ�,�޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- �޿��� 350�̻� ���� 600���ϱ��� �޴� ������� �����, ���, �޿� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;
--======================================================
/*
 <BETWEEN A AND B>
 ���ǽĿ��� ���Ǵ�, '�� �̻� �� ����' �� ������ ���� ������ �����ҋ� ���Ǵ� ������ 
 
 [ǥ����]
 �񱳴�� �÷� BETWEEN A(��1) AND B(��2)
   -> �ش� �÷� ���� A�̻��̰� B ������ ����� �����͸� ã�� 
*/
-- �޿��� 350�̻� ���� 600���ϱ��� �޴� ������� �����, ���, �޿� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;
    --> �� ���� ���� ������� ��ȸ�ϰ� �ʹٸ�? 
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
    --WHERE SALARY <= 3500000 OR SALARY >= 6000000;
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
   --> NOT : �� ���� �����ڷ�, �÷��� �Ǵ� BETWEEN �տ� ���� ����
   
--�Ի����� 90/1/1 ~ 01/01/01 ����
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'
--====================================

/*
  <LIKE>
  ���ϰ��� �ϴ� �÷����� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
  
  [ǥ����]
  �񱳴�� �÷� LIKE 'Ư�� ����'
  
    -> Ư������ ���ý� '%', '_' �� ���� ���ϵ� ī�带 �� �� ����.
  - '%' : 0���� �̻�
    ex) �񱳴�� Į�� LIKE '����%' -> �񱳴�� �÷����� ���ڷ� '����'�Ǵ� �� ��ȸ
        �񱳴�� �÷� LIKE '%����' -> �� ��� �÷����� ���ڷ� '��'���� �� ��ȸ
        �񱳴�� �÷� LIKE '%����%' -> �� ��� �÷����� ���ڰ� ���ԵǴ� �� ��ȸ
        
  - '_' : 1���� �̻�
    ex) �񱳴�� �÷� LIKE '_����' -> �񱳴�� �÷����� ���� �տ� ������ �ѱ��ڰ� �� ��� ��ȸ
        �񱳴�� �÷� LIKE '_ _����' -> �񱳴�� �÷����� ���� �տ� ������ 2���ڰ� �� ��� ��ȸ
        �񱳴�� �÷� LIKE '_����_' -> �񱳴�� �÷����� ���� �� �ڿ� ������ �ѱ��ھ� �� ��� ��ȸ
*/
-- ������� ���� ������ ������� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- �̸��� �ϰ� ���Ե� ������� ���ʸ�, �ֹι�ȣ, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- �̸��� ��� ���ڰ� ���� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';

-- ��ȭ��ȣ�� 3��° �ڸ��� 1�� ������� ���, �����, ��ȭ��ȣ, �̸��� ��ȸ 
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- Ư�����̽� 
  -- �̸��� �� _ �������� �ձ��ڰ� 3������ ������� ���, �̸�, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%'; 
  --> ���ϵ� ī��� ����ϰ� �ִ� ���ڿ� �÷����� ��� ���ڰ� �����Ͽ� ��ȸX 
  --> ������ ���ϵ� ī��� ��� ������ ������ �������������.
  --> ������ ������ ����ϰ��� �ϴ� �� �տ� ������ ���ϵ�ī�带 �����ϰ� ESCAPE OPTION ����
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$'; 

--=============================�ǽ�����==============================================

-- 1. EMPLOYEE���� �̸��� '��'���� ������ ������� �����, �Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- 2. EMPLOYEE���� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 3. EMPLOYEE���� �̸��� '��'�� ���ԵǾ� �ְ�, �޿��� 240���� �̻��� ������� �����, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%' AND SALARY >= '2400000';

-- 4. DEPARTMENT���� �ؿܿ������� �μ����� �μ��ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '%�ؿܿ���%';




