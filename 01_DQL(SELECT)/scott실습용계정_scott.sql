--SCOTT_��������
--1. EMP���̺��� COMM �� ���� NULL�� �ƴ� ���� ��ȸ
SELECT *
FROM EMP
WHERE COMM IS NOT NULL;

--2. EMP���̺��� Ŀ�̼��� ���� ���ϴ� ���� ��ȸ
SELECT *
FROM EMP
WHERE COMM IS NULL;

--3. EMP���̺��� �����ڰ� ���� ���� ���� ��ȸ
SELECT *
FROM EMP
WHERE MGR IS NULL;

--4. EMP���̺��� �޿��� ���� �޴� ���� ������ ��ȸ
SELECT *
FROM EMP 
ORDER BY SAL DESC;

--5. EMP���̺��� �޿��� ���� ��� Ŀ�̼��� �������� ���� ��ȸ
SELECT *
FROM EMP
ORDER BY SAL ASC, COMM DESC;

--6. EMP���̺��� �����ȣ, �����,����, �Ի��� ��ȸ (��, �Ի����� �������� ���� ó��)
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
ORDER BY HIREDATE ASC;

--7. EMP���̺��� �����ȣ, ����� ��ȸ (�����ȣ ���� �������� ����)
SELECT EMPNO, ENAME
FROM EMP
ORDER BY EMPNO DESC;

--8. EMP���̺��� ���, �Ի���, �����, �޿� ��ȸ
-- (�μ���ȣ�� ���� ������, ���� �μ���ȣ�� ���� �ֱ� �Ի��� ������ ó��)
SELECT EMPNO, HIREDATE, ENAME, SAL, DEPTNO
FROM EMP
ORDER BY DEPTNO ASC, HIREDATE DESC;

--9. ���� ��¥�� ���� ���� ��ȸ
SELECT SYSDATE
FROM EMP;

--10. EMP���̺��� ���, �����, �޿� ��ȸ
-- (��, �޿��� 100���������� ���� ��� ó���ϰ� �޿� ���� �������� ����)
SELECT EMPNO, ENAME, SAL, /*SUBSTR(TO_CHAR(SAL), -4, 3),*/ 
        -- LENGTH ���̰� 3�ϰ�� SUBSTR �տ��� ���ڸ� ��ȯ, 4�� ��� �տ��� ���ڸ� ��ȯ 
        TO_NUMBER(CASE WHEN LENGTH(SAL) = 3 THEN SUBSTR(TO_CHAR(SAL), 1, 2)
            ELSE SUBSTR(TO_CHAR(SAL), 1, 3)
        END) "�޿�" 
FROM EMP
ORDER BY "�޿�" DESC;

--11. EMP���̺��� �����ȣ�� Ȧ���� ������� ��ȸ
SELECT *
FROM EMP
WHERE SUBSTR(EMPNO, -1, 1) IN ('1', '3', '5', '7', '9');

--12. EMP���̺��� �����, �Ի��� ��ȸ (��, �Ի����� �⵵�� ���� �и� �����ؼ� ���)
SELECT ENAME, HIREDATE "�Ի� ��", EXTRACT(YEAR FROM HIREDATE) "�Ի� ��", EXTRACT(MONTH FROM HIREDATE) "�ϻ� ��"
FROM EMP;

--13. EMP���̺��� 9���� �Ի��� ������ ���� ��ȸ
SELECT *
FROM EMP
WHERE  EXTRACT(MONTH FROM HIREDATE) = '9';

--14. EMP���̺��� 81�⵵�� �Ի��� ���� ��ȸ
SELECT *
FROM EMP
WHERE EXTRACT(YEAR FROM HIREDATE) = 1981;

--15. EMP���̺��� �̸��� 'E'�� ������ ���� ��ȸ
SELECT *
FROM EMP 
WHERE SUBSTR(ENAME, -1, 1) = 'E';

--16. EMP���̺��� �̸��� �� ��° ���ڰ� 'R'�� ������ ���� ��ȸ
--16-1. LIKE ���
SELECT *
FROM EMP
WHERE ENAME LIKE '__R%';

--16-2. SUBSTR() �Լ� ���
SELECT *
FROM EMP
WHERE SUBSTR(ENAME, 3, 1) = 'R';

--17. EMP���̺��� ���, �����, �Ի���, �Ի��Ϸκ��� 40�� �Ǵ� ��¥ ��ȸ
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 480) "�Ի� 40����"--, EXTRACT(YEAR FROM ADD_MONTHS(HIREDATE, 480))
FROM EMP;

--18. EMP���̺��� �Ի��Ϸκ��� 38�� �̻� �ٹ��� ������ ���� ��ȸ
SELECT ENAME, HIREDATE--, MONTHS_BETWEEN(SYSDATE, HIREDATE)
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) >= 456;

--19. ���� ��¥���� �⵵�� ����
SELECT SYSDATE "���� ��¥", EXTRACT(YEAR FROM SYSDATE) "���� �⵵"
FROM EMP;

--===================================================================
--===================================================================
--===================================================================
--�߰� ����

--EMP ���̺��� ��� ������ �޿�(SAL) ����� ���ϼ���.
SELECT TO_CHAR(FLOOR(AVG(SAL)), '$9,999') "�� ���� �޿� ���"
FROM EMP;

--EMP ���̺��� ����(JOB)�� 'SALESMAN'�� �������� �̸��� �޿��� ��ȸ�ϼ���.
SELECT ENAME, SAL
FROM EMP
WHERE JOB = 'SALESMAN';

--EMP ���̺��� ��� ������ �̸�(ENAME) �������� �������� ������ ��ȸ�ϼ���.
SELECT *
FROM EMP
ORDER BY ENAME ASC;

--EMP ���̺��� Ŀ�̼�(COMM)�� NULL�� ���� ���� ���ϼ���.
SELECT COUNT(*)
FROM EMP
WHERE COMM IS NULL;

--EMP ���̺��� �޿��� ���� ���� ������ �޿��� �̸�(ENAME)�� ����ϼ���.
SELECT ENAME, �ְ�޿�
FROM (SELECT RANK() OVER (ORDER BY SAL DESC)"����", SAL "�ְ�޿�", ENAME
        FROM EMP)
 WHERE ���� = 1;

--EMP ���̺��� �μ���ȣ�� 10 �Ǵ� 30�̸鼭 �޿��� 1500 �̻��� �������� �̸�, ����, �޿��� ��ȸ�ϼ���.
SELECT ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE /*DEPTNO = 10 OR DEPTNO = 30;*/ (DEPTNO IN(10, 30)) AND SAL >= 1500; 

--EMP ���̺��� �� �μ��� �ִ� �޿�, �ּ� �޿�, ��� �޿��� ����ϼ���.
SELECT DISTINCT DEPTNO (MAX(SAL), MIN(SAL), FLOOR(AVG(SAL)))
FROM EMP;

--EMP ���̺��� �޿�(SAL)�� 2000 �̻��� �������� �̸��� �μ���ȣ(DEPTNO)�� ��ȸ�ϼ���.
SELECT ENAME, DEPTNO, SAL
FROM EMP
WHERE SAL >= 2000;

--EMP ���̺��� Ŀ�̼�(COMM)�� NULL�� �ƴ� �������� �̸��� Ŀ�̼��� ��ȸ�ϼ���.
SELECT ENAME, COMM
FROM EMP
WHERE COMM IS NOT NULL;

--EMP ���̺��� �޿�(SAL)�� �������� �������� ������ ���� �̸��� �޿��� ��ȸ�ϼ���.
SELECT ENAME, SAL
FROM EMP
ORDER BY SAL DESC;

--EMP ���̺��� �μ���ȣ(DEPTNO) ��������, �޿� ������������ ���� ������ ��ȸ�ϼ���.
SELECT DEPTNO, SAL
FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;

--EMP ���̺��� Ŀ�̼�(COMM)�� ������������ �����ϰ�, Ŀ�̼��� ���� ��� �޿��� ������������ ������ ��ȸ�ϼ���.
SELECT *
FROM EMP
ORDER BY COMM DESC NULLS LAST, SAL ASC;







