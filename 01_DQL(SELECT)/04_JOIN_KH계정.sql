/*
    <JOIN>
    2�� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ����� �ϳ��� �����(Result Set)�� ����
    
    ������ �����ͺ��̽��� �ּ����� �����ͷ� ������ ���̺� �����͸� ��� ����
    (�ߺ� �ּ�ȭ �ϱ� ���� �ִ��� �ɰ��� ����)
    
  -- � ����� � �μ��� �����ִ��� �ñ��ϳ�
    => ������ �����ͺ��̽����� SQL���� �̿��� ���̺��� ���踦 �δ� ���
     (�� ��ȸ�� �ؿ��°� �ƴ϶�, �� ���̺� ����� �����͸� ��Ī���� ��ȸ)
     
            JOIN��, "����Ŭ ���� ����"  ��   "ANSI(�̱�����ǥ����ȸ) ����" (ASCII�ڵ� ���� ��)
            
                                [JOIN ��� ����]
         [����Ŭ ���� ����]             ||                 [ANSI ����]
         =============================================================================
         � ���� (EQUAL JOIN)        ||  ���� ���� INNER(JOIN) // �ڿ� ����(NATURAL JOIN)
         ------------------------------------------------------------------------------
            ���� ����                  ||  ���� �ܺ� ���� (LEFT OUTER JOIN)
          (LEFT OUTER)                ||  ������ �ܺ� ���� (RIGHT OUTER JOIN)
          (RIGHT OUTER)               ||  ��ü �ܺ� ���� (FULL OUTER JOIN)
         ------------------------------------------------------------------------------
         ��ü ���� (SELF JOIN)         || JOIN ON
         �� ����(NON EQUAL JOIN)   ||
*/


-- ��ü ������� ���, �����, �μ��ڵ�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- ��ü ������� ���, �����, �����ڵ�, ���޸� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;

/*
    1. � ���� (EQUAL JOIN)  / ���� ����(INNER JOIN)
        : �����Ű�� �÷� ���� ��ġ�ϴ� ��鸸 ���εǾ� ��ȸ 
         (��ġ�ϴ� ���� ���� ���� ��ȸ���� ����)
*/
-- @@ ����Ŭ ���� ����Ȱ��
    -- FROM���� ��ȸ�ϰ��� �ϴ� ���̺� ���� ( ',' �����ڷ� )
    -- WHERE���� ��Ī��ų �÷�(�����)�� ���� ������ ����.
    
-- 1) ������ �� �÷� ���� �ٸ� ��� (EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID)
    -- ���, �����, �μ��ڵ�, �μ��� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID; -- ��ġ�ϴ� ���� ���� 2���� NULL�� ��ȸ���� ����, 

-- 2) ���� �� �� �÷� ���� ���� ��� (EMPLOYEE, JOB ���̺� �Ѵ� : JOB_CODE)
    -- ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE = JOB_CODE; --> ambiguously (�ָ���, ��ȣ��) 

--> �ذ��� A : ���̺�� �̿�
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE; 

--> �ذ��� B : ���̺� ��Ī�ο��Ͽ� �̿�
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE; 

--@@@
--@@@@
--@@@@@
--@@@@@@
--@@@@@@  
    -- @ANSI ����
    -- FROM���� ������ �Ǵ� ���̺��� �ϳ� ��� ��, 
    -- JOIN ���� ���� ��ȸ�ϰ��� �ϴ� ���̺� ��� + ��Ī��ų �÷��� ���� ����
        -- JOIN USING, JOIN ON

-- 1) ������ �� �÷����� �ٸ� ��� (EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID)
    -- JOIN ON �������θ� ����.
-- ���, �����, �μ��ڵ�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 2) ������ �� �÷����� ������� ((EMPLOYEE, JOB ���̺� �Ѵ� : JOB_CODE)
    -- JOIN ON, JOIN USING ���� ��� ����
-- ���, �����, �����ڵ�, ���� ��
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB ON (JOB_CODE = JOB_CODE);

-- �ذ��� A) ���̺� �� �Ǵ� ��Ī �̿� ���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

-- �ذ��� B) JOIN USING ���� Ȱ��
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

--- 3. �ڿ� ���� [�������, ���� ������ ����]
    -- NATURAL JOIN : �� ���̺��� ������ �÷��� �Ѱ��� ������ ���.
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- �߰��� ���� ����
-- ���޸��� �븮�� ����� �̸�, ���޸�, �޿� ��ȸ
--@����Ŭ ����
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND J.JOB_NAME = '�븮';

--@�Ⱦ� ����
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮';


--============================[�ǽ� ����]==================================
--1. �μ��� �λ�������� ������� ���, �̸�, ���ʽ� ��ȸ
--@ ����Ŭ
    -- DEPT_ID
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE = '�λ������';

--@ �Ⱦ�
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID AND DEPT_TITLE = '�λ������';


--2. DEPARTMENT�� LOCATION�� �����Ͽ� ��ü �μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ
--@ ����Ŭ
SELECT DEPT_CODE, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME 
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE;

--@ �Ⱦ�
SELECT DEPT_CODE, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME 
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ 
--@ ����Ŭ
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND BONUS IS NOT NULL;

--@ �Ⱦ�
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID AND BONUS IS NOT NULL;

--4. �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿�, �μ��� ��ȸ
--@ ����Ŭ
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE <> '�ѹ���';

--@ �Ⱦ�
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID AND DEPT_TITLE <> '�ѹ���';
    --> ���� DEPT_CODE�� NULL�� �͵��� ������ �ʰ� ����.


/*
    2. �������� / �ܺ� ���� (OUTER JOIN)
        : �� ���̺��� JOIN�� ��ġ���� �ʴ� �൵ ���Խ��� ��ȸ ����
         ��, LEFT / RIGHT �����ؾ� �� (������ �Ǵ� ���̺� ����)
*/

-- �����, �μ���, �޿�, ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; 
    -- �μ���ġ�� �ȵ� ���(NULL) + �μ��� ������ ����� ���� �μ� ��ȸ X

--@ �Ⱦ� ����
-- 1) LEFT [OUTER] JOIN
    -- : �� ���̺��� ���ʿ� ����� ���̺� �������� JOIN
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE --> EMPLOYEE ���̺��� �� ����.
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
    --> �μ���ġ ���� ���� 2���� ��� ������ ��ȸ
    
--@ ����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- �������� ����� �ϴ� ���̺��� �ݴ��� �÷� �ڿ� '+' ���̱�

-- 2) RIGHT [OUTER] JOIN

    --@ �Ⱦ� ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; 

    --@ ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID; 

-- 3) FULL [OUTER] JOIN
    -- : �� ���̺��� ��� �� ��ȸ (��, �Ⱦ��������θ� ����)
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; 


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


--  3.��ü ���� (SELF ����)
    -- : ���� ���̺��� �ٽ� �ѹ� �����ϴ� ���

SELECT * FROM EMPLOYEE;

--��ü ����� ���, �����, ����μ��ڵ带 ���ϰ�,        --> EMPLOYEE E 
    -- ����� �ִٸ�, ����� ���, �����, ����μ� �ڵ�. --> EMPLOYEE M 
    
--@ ����Ŭ ���� ����

SELECT E.EMP_ID "������", E.EMP_NAME "����̸�", E.DEPT_CODE, M.EMP_ID "������", M.EMP_NAME "����̸�", M.DEPT_CODE
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID
ORDER BY 1;

--@ �Ⱦ� ����
SELECT E.EMP_ID "������", E.EMP_NAME "����̸�", E.DEPT_CODE "����μ�", M.EMP_ID "������", M.EMP_NAME "����̸�", M.DEPT_CODE "����μ�"
FROM EMPLOYEE E
JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID
ORDER BY 1;


/*
    < ���� ���� >
    2�� �̻��� ���̺��� ������ JOIN
*/

SELECT * FROM EMPLOYEE; -- DEPT_CODE, JOB_CODE 
SELECT * FROM DEPARTMENT; -- DEPT_ID
SELECT * FROM JOB;

--@ ����Ŭ ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

--@ �Ⱦ� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID 
JOIN JOB J USING (JOB_CODE);


-- ���, �����, �μ���, ������
SELECT * FROM EMPLOYEE; -- DEPT_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID, LOCATION_ID
SELECT * FROM LOCATION; -- LOCAL_CODE

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE;

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

--=================[�ǽ� ����]========================
-- 1. ���, �����, �μ���, ������, ������ ��ȸ
--@ ����Ŭ ���� ����
SELECT * FROM EMPLOYEE; -- DEPT_CODE 
SELECT * FROM DEPARTMENT; -- DEPT_ID, LOCATION_ID
SELECT * FROM LOCATION;             -- LOCAL_CODE, NATIONAL_CODE
SELECT * FROM NATIONAL;                         -- NATIONAL_CODE, 

SELECT EMP_ID "���", EMP_NAME "��� ��", DEPT_TITLE "�μ���", LOCAL_NAME "������", NATIONAL_NAME "������"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND L.NATIONAL_CODE = N.NATIONAL_CODE;

--@ �Ⱦ� ����
SELECT EMP_ID "���", EMP_NAME "��� ��", DEPT_TITLE "�μ���", LOCAL_NAME "������", NATIONAL_NAME "������"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
JOIN NATIONAL N USING (NATIONAL_CODE);

-- 2. ���, �����, �μ���, ���޸�, ������, ������, �ش� �޿� ��޿��� ���� �� �ִ� �ִ� �ݾ� ��ȸ 
SELECT * FROM JOB;         -- JOB_CODE 
SELECT * FROM EMPLOYEE;   -- JOB_CODE, DEPT_CODE, SAL_LEVEL
SELECT * FROM DEPARTMENT;              -- DEPT_ID, LOCATION_ID
SELECT * FROM LOCATION;                         -- LOCAL_CODE, NATIONAL_CODE
SELECT * FROM NATIONAL;                                      --NATIONAL_CODE
SELECT * FROM SAL_GRADE;                        -- SAL_LEVEL

--@ ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE "�μ���", JOB_NAME "���޸�", LOCAL_NAME "������", NATIONAL_NAME "������", MAX_SAL "�ִ� �ݾ�"
FROM JOB J, EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE E.JOB_CODE = J.JOB_CODE 
AND E.SAL_LEVEL = S.SAL_LEVEL
AND E.DEPT_CODE = D.DEPT_ID
AND D.LOCATION_ID = L.LOCAL_CODE
AND L. NATIONAL_CODE = N.NATIONAL_CODE;

--@ �Ⱦ� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE "�μ���", JOB_NAME "���޸�", LOCAL_NAME "������", NATIONAL_NAME "������", MAX_SAL "�ִ� �ݾ�"
FROM JOB J
JOIN EMPLOYEE E USING (JOB_CODE)
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
JOIN NATIONAL N ON L. NATIONAL_CODE = N.NATIONAL_CODE
JOIN SAL_GRADE S USING (SAL_LEVEL);























