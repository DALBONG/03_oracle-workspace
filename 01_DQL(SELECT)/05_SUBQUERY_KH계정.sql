/*
    ** �������� 
    - �ϳ��� SQL�� �ȿ� ���Ե� �Ǵٸ� SELECT��
    - ���� SQL���� ���� ���� ������ �ϴ� ������
*/

-- ������ �������� ����1
    -- ���ö ����� ���� �μ��� ���� ����� ��ȸ
        -- 1) ���ö ����� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö'; 
        -- 2) �μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--> ���� 2�ܰ踦 �ϳ��� ����������
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');
                    
                    
-- ���� �������� ����2
    -- �� ������ ��� �޿����� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ
    -- 1) �� ������ ��� �޿� ��ȸ
SELECT FLOOR(AVG(SALARY))
FROM EMPLOYEE;
    --2) �޿��� 3047663�� �̻��� ��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047662;

--> ���� 2�ܰ踦 �ϳ��� ����������
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT FLOOR(AVG(SALARY))
                    FROM EMPLOYEE);
    
--============================================================================                
/*
    ** ���������� ����
        �������� ������� ����, ��̳Ŀ� ���� �з�
        
        - ������ �������� : ���������� ������� ������ ������ 1���� ��
        - ������ �������� : ���������� ������� ���� ���� ��(���� ��, �� ��)
            ==> �������� ���ö 2���� ��
        - ���߿� �������� : ���������� ������� ���� ���� ��(�� ��, ���� ��)
        - ������ ���� �� �������� : �������� ������� ������ ���� �÷��� �� (���� ��, ���� ��)
        
        --> �������� ������ ���� �������� �տ� �ٴ� �����ڰ� �޶��� 
*/  

/*
    1. ������ �������� (SINGLE ROW SUBQUERY)
        ���������� ��ȸ ������� ������ 1�� (�� ��, �� ��)
        �Ϲ� �� ������ ��� ���� (=, !=, ^= ��..)
*/
-- 1) �� ������ ��ձ޿����� �޿��� �� ���� �޴� ��������� �����, �����ڵ�, �޿� ��ȸ 
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY) 
                FROM EMPLOYEE );
                
-- 2) �޿��� ���� ���� �޴� ����� ���, �̸�, �޿�, �Ի���D
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);
                
-- 3) ���ö ����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿���ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY 
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');
                
-- 4) 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND SALARY > (SELECT SALARY 
              FROM EMPLOYEE
              WHERE EMP_NAME = '���ö');
              
              
--@ �Ⱦ� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
WHERE SALARY > (SELECT SALARY 
              FROM EMPLOYEE
              WHERE EMP_NAME = '���ö');
              
-- 4) �μ��� �޿����� ���� ū �μ��� �μ��ڵ�, �޿� ��
    -- 1) �μ��� �޿��� �߿����� ���� ū �� �ϳ� ��ȸ
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;  -- 17700000
    -- 2) �μ��� �޿����� 17700000������ �μ� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;


SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                       FROM EMPLOYEE
                       GROUP BY DEPT_CODE); 
    
-- ������ ����� ���� �μ������� ���, �����, ����, �Ի���, �μ���
    --(��, �������� ����)
--@ ����Ŭ
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID 
    AND DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME LIKE '_����%')
MINUS
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID 
    AND EMP_NAME = (SELECT EMP_NAME
                    FROM EMPLOYEE
                    WHERE EMP_NAME LIKE '_����%');

--@ �Ⱦ�
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    AND DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME LIKE '_����%')
MINUS
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID 
    AND EMP_NAME = (SELECT EMP_NAME
                    FROM EMPLOYEE
                    WHERE EMP_NAME LIKE '_����%');

--======================================================================                    
/*
    2. ������ �������� (MULTI ROW SUBQUERY)
        : ���������� ������ ��� ���� ���� ���� �� (�÷��� �Ѱ�)
        
    - IN �������� : �������� ����� �� �ϳ��� ��ġ�ϴ� ���� �ִٸ� 
    
    - > ANY �������� : ���� ����� ��, '�Ѱ���' Ŭ ���
      < ANY �������� : ���� ����� ��, '�Ѱ���' ���� ���
      => �񱳴�� > ANY (�������� ��1, ��2, ...)
      
    - > ALL �������� : �������� ��� ��� ���麸�� '���' Ŭ ���
      < ALL �������� : �������� ��� ��� ���� ���� '���' ���� ���
        
*/

-- 1) ����� �Ǵ� ������ ����� ���� ������ ������� ���, �����, �����ڵ�, �޿�
    --1_1) ���� ��ȸ
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('�����', '������'); 
    --1_2) ���� ���� ����� ��ȸ 
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME IN ('�����', '������'));
    -- �������� ��ȸ�Ǿ��� ������ = �� ���� ���� ( =�� ���� J3�� �о������ J7�� �о������ ��) 

-- ��� => �븮 => ���� => ���� => ����
-- 2) �븮 �����ӿ��� �ұ��ϰ� �������� �޿��� �� �ּ� �޿����� �� ���� �޴� ���� ��ȸ (���, �̸�, ����, �޿�)
    --2_1) ���� ���� ������� �޿� ��ȸ
SELECT SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '����'; -- 2200000~3760000
    --2_1) �븮 �鼭, �޿� ���� �� ��ϵ� ���� �ϳ��� ū ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > ANY (2200000, 2500000, 3760000);


SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > ANY (SELECT SALARY
                FROM EMPLOYEE E, JOB J
                WHERE E.JOB_CODE = J.JOB_CODE
                AND JOB_NAME = '����');
                
                
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > (SELECT MIN(SALARY)
                FROM EMPLOYEE E, JOB J
                WHERE E.JOB_CODE = J.JOB_CODE
                AND JOB_NAME = '����');
                
-- 3) ���� �����ӿ���, ���� ������ ������� ��� �޿����ٵ� �� ���� �޴� ������� ���, �����, ���޸�, �޿�
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'
AND SALARY > ALL (SELECT SALARY 
            FROM EMPLOYEE
            JOIN JOB USING(JOB_CODE)
            WHERE JOB_NAME = '����');
            
----------------------------------------------------------------------
/*
    3. ���߿� �������� 
        : ������� �� ��������, ������ �÷� ���� �������� ���.
    
*/

-- 1) ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ����� ��ȸ (�����, �μ��ڵ�, �����ڵ�, �Ի���)
    --> ������ ���������ε� ����
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '������')
AND JOB_CODE = (SELECT JOB_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '������');
                
-- ���߿� ����������!
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '������');
                                
-- �ڳ��� ����� ���� �����ڵ�, ���� ����� ������ �ִ� ������� ���, �����, �����ڵ�, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '�ڳ���');
                                
----------------------------------------------------------------------------
/*
    4. ���� ��, ���� �� ��������
        : �������� ��ȸ ��� ���� ���� ��, ���� ���
*/

-- 1) �� ���޺�, �ּұ޿��� �޴� ��� ��ȸ (���, �����,�����ڵ�, �޿�)
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 1_2)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 3700000 
    OR JOB_CODE = 'J7' AND SALARY = 1380000;
    
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) = ANY (SELECT JOB_CODE, MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);

-- �� �μ��� �ְ�޿��� �޴� ������� ���, �����, �μ��ڵ�, �޿�
SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) = ANY (SELECT DEPT_CODE, MAX(SALARY)
                                FROM EMPLOYEE
                                GROUP BY DEPT_CODE);
                                
/*
    5.�ζ��� ��
    �������� ������ ����� ���̺�ó�� ���
*/

-- ������� ���, �̸�, ���ʽ� ���� ����(��Ī�ο� : ����), �μ��ڵ� ��ȸ -> ���ʽ� ���� ������ null�� ������ �ʵ���
-- ��, ���ʽ� ���� ������ 3000 �̻��� ����鸸 ��ȸ

SELECT EMP_ID, EMP_NAME, (SALARY+SALARY*NVL(BONUS, 0))*12 "����"
FROM EMPLOYEE
WHERE  (SALARY+SALARY*NVL(BONUS, 0))*12 >= 30000000;  
        --> WHERE���� "����" ����ʹٸ�?

SELECT EMP_ID, EMP_NAME, (SALARY+SALARY*NVL(BONUS, 0))*12 "����"
FROM EMPLOYEE;  --> �����ϴ� ���̺��ΰ� ó�� ����ϱ� (�ζ��� ��)

SELECT *
FROM (SELECT EMP_ID, EMP_NAME, (SALARY+SALARY*NVL(BONUS, 0))*12 "����"
FROM EMPLOYEE)
WHERE ���� >= 30000000; 

-- ���ǻ���!!
SELECT EMP_ID, EMP_NAME -- MANAGER_ID �ζ��� �� ���� ���� �÷� ���� �Ұ�!
FROM (SELECT EMP_ID, EMP_NAME, (SALARY+SALARY*NVL(BONUS, 0))*12 "����"
FROM EMPLOYEE)
WHERE ���� >= 30000000;


--> �ζ��� �並 �ַ� ����ϴ� �� : TOP-N �м� (���� N���� �����ְ� ���� ��)
-- * ROWNUM : ����Ŭ���� �����ϴ� �÷�����, ��ȸ�� ������� 1���� ������ �ο����ִ� �÷�

-- �� ������ �޿��� ���� ���� ���� 5�� ��ȸ
SELECT ROWNUM, EMP_NAME, SALARY -- 2) ������ �Ǳ� ���� �̹� ������ �ο��� �� 
FROM EMPLOYEE -- 1)
WHERE ROWNUM <=5 -- 4)
ORDER BY SALARY DESC; -- 3)
    --> ���� ��ȸ X
    -- ORDERBY ���� �� ����� ����� ������ RUWNUM �ο�
    
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY, DEPT_CODE
        FROM EMPLOYEE
        ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;



SELECT ROWNUM, * -- *�� �÷��� ���X 
FROM (SELECT EMP_NAME, SALARY, DEPT_CODE
        FROM EMPLOYEE
        ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;
    -- ROWNUM�̶� ��ü�÷� ��ȸ�ϰ� ������? : ��Ī�ο� ���


SELECT ROWNUM, E.* 
FROM (SELECT *
        FROM EMPLOYEE
        ORDER BY SALARY DESC) E
WHERE ROWNUM <= 5;


SELECT ROWNUM, EMP_NAME, SALARY, DEPT_CODE
FROM (SELECT *
        FROM EMPLOYEE
        ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;



-- ���� �ֱ� �Ի��� ��� 5�� ��ȸ (�����, �޿�, �Ի���)
SELECT ROWNUM, EMP_NAME, SALARY, HIRE_DATE
FROM (SELECT EMP_NAME, SALARY, HIRE_DATE
        FROM EMPLOYEE
        ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <= 5;

-- �� �μ��� ��ձ޿��� ���� 3�� �μ� ��ȸ (�μ��ڵ�, ��ձ޿�)
SELECT ROWNUM, DEPT_CODE, FLOOR(��ձ޿�)
FROM (SELECT DEPT_CODE, AVG(SALARY) AS "��ձ޿�"
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY ��ձ޿� DESC)
WHERE ROWNUM <= 3;

---========================================================================
/*
    ���� �ű�� �Լ� (WINDOW FUNCTION)
    - RANK( ) OVER(���� ����) : ������ ���� ���� �� '1, 2, 3, 3, 5' �̷��� ���� ���
    
    - DENSE_RANK( ) OVER(���� ����) : ������ ���� �־, ���� ����� ������ 1�� ���� '1, 2, 3, 3, 4'
*/


-- �޿��� ���� ����� ������ �Űܼ� ��ȸ
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE; --> ���� 19���� ������ 21�� (������ ������ ��ȸ�� �� �� ����)


SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE; --> ���� 19�� ���� ������ 20�� (������ ������ ��ȸ�� �� ���� �ٸ�)

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE;
 -- WHERE ���� <= 5;
 -- WHERE RANK() OVER(ORDER BY SALARY DESC) <= 5;  �Ұ�
 
 -- �ζ��� ��� �ۿ� �� �� ����
SELECT *
FROM (SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
        FROM EMPLOYEE)
WHERE ���� <= 5;













                    
                    
                    
                    
    