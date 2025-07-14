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