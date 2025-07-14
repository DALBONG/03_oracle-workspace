/*
<GROUP BY��>
�׷� ������ ������ �� �ִ� ����(�ش� �׷���غ��� ���� �׷��� ���� �� ����)
�������� ������ �ϳ��� �׷����� ���� ó���� �������� ���
*/

SELECT SUM(SALARY)
FROM EMPLOYEE; -- ��ü ����� �ϳ��� �׷����� ���� ������ ���� ���

    -- �� �μ��� �� �޿� ��
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

-- �� �μ��� ��� ��
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- ���޺� �� �����, �޿� ��
SELECT JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- �� ���޺� �� �����, ���ʽ� �޴� �����, �޿� �հ�, ��� �޿�, �ִ� �޿�, ���� �޿�
SELECT JOB_CODE, COUNT(*) "�� �����", COUNT(BONUS) "���ʽ� �޴� ���", SUM(SALARY) "�޿� �հ�", FLOOR(AVG(SALARY)) "�޿� ���", MAX(SALARY) "�ִ� �޿�", MIN(SALARY) "���� �޿�"  
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

-- ���� �� 
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 1 , '��', 2, '��') , COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);
-- GROUP BY ���� �Լ��� ��� ����

-- GROUP BY ���� ���� �÷� ��� ����
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE -- DEPT �̸鼭, JOB �� ��� ��
ORDER BY 1;

--============================================================================
/*
    < HAVING �� > 
    �׷� ������ ������ �� ���Ǵ� ���� (�׷��Լ����� ������ ������ ������ �� ���)
*/

-- �� �μ��� ��� �޿� ��ȸ
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;

-- �� �μ��� ��� �޿��� 300�̻��� �μ��� ��ȸ
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) --4
FROM EMPLOYEE --1
-- WHERE AVG(SAL) >= 3000000 --> WHERE���� �׷��Լ� ���� �ۼ�X,  HAVING ���!
GROUP BY DEPT_CODE  --2 
HAVING AVG(SALARY) >= 3000000 --3
ORDER BY 1;  --5

-- ���ﺰ �� �޿���(�� ���޺� �޿����� 1000���� �̻��� ���޸��� ��ȸ)
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- �μ��� ���ʽ��� �޴� ����� ���� �μ����� ��ȸ (�μ��ڵ�, ���ʽ� �޴� ���)
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

--=======================================================================
--=======================================================================
/*
    <SELECT�� ���� ����>
    5. SELECT *  | ��ȸ �÷� [��Ī]  |  �����  | �Լ��� |
    1. FROM ��ȸ ���̺� ��
    2. WHERE ���ǽ�(������ ������ ���)
    3. GROUP BY �׷� �������� ���� �÷�  |  �Լ��� ���� �÷�
    4. HAVING �׷��Լ��� ������ ����� ���ǽ� 
    6. ORDER BY �÷���  |  ��Ī  |  ���� ���� ����
*/

--========================================================================
--========================================================================
--========================================================================

/*
    <���� �Լ�>
    �׷캰 ����� ������� �߰� ���踦 ������ִ� �Լ�
    
    ROLLUP(�÷�1, �÷�2) : �÷� 1�� ������ �ٽ� �߰����踦 ���� �Լ� + �÷� 2 �߰����� 
      => GROUP BY ���� ����ϴ� �Լ�
*/

-- �� ���޺� �޿� ��
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE);

--========================================================================
/* 
    <���� ������ == SET OPERATION >
    �������� �������� ������ �ϳ��� ���������� ����� ������
    
    - UNION(������) : A OR B (�� ������ ���� ��� ���� ��, �ߺ��Ǵ� ���� �ѹ��� ����������)
    - INTERSECT(������) : AND (�� ������ ���� ����� �ߺ��� �����) 
    - UNION ALL(��+��) : �ߺ� �Ǵ� �κ��� �ι� ǥ���� �� ����. 
    - MINUS(������) : ���� ��������� ���� ������� �� ������
*/

-- 1.UNION
    --�μ��ڵ尡 D5�� ��� �Ǵ� �޿��� 300�� �ʰ��� ����� ��ȸ(���, �̸�, �μ��ڵ�, �޿�)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'; -- 6���� (����, ����, �ؼ�, ����, ����, ��ȥ)

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8���� (����,����,��ö,���,����,����,��ȥ,����)

    -- �� ���� UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
/*
 --> OR�ᵵ �ذ� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;
*/

-- 2. INTERSECT (������)
    -- �μ��ڵ尡 D5�̸鼭 �޿��� 300�� �ʰ��� ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

/* 
    --> AND�� �ᵵ �ذ� ����!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;
*/

 -- UNION ���� ���ǻ���
-- 1) �� �������� �÷� ������ �����ؾ� ��.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 2) �÷� Ÿ�Ե� �����ؾ� ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- Ÿ���� ������ ����� �ǳ�, �̻��� �� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, BONUS
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- ORDER BY���� ���̰��� �Ѵٸ� �������� ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_NAME; 

--========================================================================
--========================================================================

 -- 3. UNION ALL  : ������ ���� ����� ��� �� ���ϴ� ������
 SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 4. MINUS : ���� SELECT ������� ���� SELECT ����� �� ������(������)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'-- 6���� (����, ����, �ؼ�, ����, ����, ��ȥ)
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8���� (����,����,��ö,���,����,����,��ȥ,����)
/*
    --> �̷��Ե� ����!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY < 3000000;
*/

