--======================= JOIN �� �������� ���� ================================= 

-- 1. 70��� ��(1970~1979) �� �����̸鼭 ������ ����� �̸��� �ֹι�ȣ, �μ� ��, ���� ��ȸ 

SELECT * FROM EMPLOYEE; -- DEPT_CODE, JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID , 
SELECT * FROM JOB;        -- JOB_CODE


SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE = J.JOB_CODE
AND (DECODE(SUBSTR(EMP_NO, 8, 1), 2, '����', 4, '����'), EMP_NAME) 
    = ANY (SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 2, '����', 4, '����'), EMP_NAME
           FROM EMPLOYEE
           WHERE EMP_NAME LIKE '��%' AND DECODE(SUBSTR(EMP_NO, 8, 1), 2, '����', 4, '����') IS NOT NULL);
           

-- 2. ���� �� ���� ������ ��� �ڵ�, ��� ��, ����, �μ� ��, ���� �� ��ȸ 
SELECT EMP_ID, EMP_NAME, FLOOR(FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RR.MM.DD')))/12) "����", DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

/*
SELECT EMP_NAME, MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RR.MM.DD')
FROM EMPLOYEE;

SELECT EMP_NAME, EMP_NO, FLOOR(FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RR.MM.DD')))/12)
FROM EMPLOYEE;
*/


-- 3. �̸��� �������� ���� ����� ��� �ڵ�, ��� ��, ���� ��ȸ 
SELECT EMP_ID, EMP_NAME, JOB_NAME -- JOB_CODE
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND EMP_NAME LIKE '%��%';

-- 4. �μ��ڵ尡 D5�̰ų� D6�� ����� ��� ��, ���� ��, �μ� �ڵ�, �μ� �� ��ȸ 
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE 
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE = J.JOB_CODE
AND DEPT_CODE IN ('D5', 'D6');

-- 5. ���ʽ��� �޴� ����� ��� ��, �μ� ��, ���� �� ��ȸ 
    -- E : DEPT_CODE
    -- D : DEPT_ID, , LOCATION_ID 
    -- L : LOCAL_CODE 

SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND BONUS IS NOT NULL;

-- 6. ��� ��, ���� ��, �μ� ��, ���� �� ��ȸ
    -- E : DEPT_CODE, JOB_CODE
    -- J :            JOB_CODE
    -- D : DEPT_ID, , LOCATION_ID 
    -- L : LOCAL_CODE 

SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE 
    AND E.DEPT_CODE = D.DEPT_ID
    AND LOCATION_ID = LOCAL_CODE;

-- 7. �ѱ��̳� �Ϻ����� �ٹ� ���� ����� ��� ��, �μ� ��, ���� ��, ���� �� ��ȸ 
    -- E : DEPT_CODE,     JOB_CODE
        -- J :            JOB_CODE
    -- D : DEPT_ID, , LOCATION_ID 
    -- L : LOCAL_CODE, NATIONAL_CODE
    -- N :             NATIONAL_CODE 
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID 
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND NATIONAL_NAME IN (SELECT NATIONAL_NAME
                         FROM NATIONAL
                         WHERE NATIONAL_NAME IN ('�ѱ�', '�Ϻ�'));

-- 8. �� ����� ���� �μ����� ���ϴ� ����� �̸� ��ȸ 
SELECT * FROM EMPLOYEE;

SELECT E.EMP_NAME, E.DEPT_CODE, M.EMP_NAME
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.DEPT_CODE = M.DEPT_CODE
    AND E.EMP_NAME != M.EMP_NAME
ORDER BY 1;


-- 9. ���ʽ��� ���� ���� �ڵ尡 J4�̰ų� J7�� ����� �̸�, ���� ��, �޿� ��ȸ(NVL �̿�) 
    -- E : DEPT_CODE,     JOB_CODE
    -- J :                JOB_CODE
    -- D : DEPT_ID, , LOCATION_ID 
    -- L : LOCAL_CODE, NATIONAL_CODE
    -- N :             NATIONAL_CODE 
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
    AND E.BONUS IS NULL
    AND E.JOB_CODE IN ('J4', 'J7');
    
    
                                                                    -- 10. ���ʽ� ������ ������ ���� 5���� ���, �̸�, �μ� ��, ����, �Ի���, ���� ��ȸ 


-- 11. �μ� �� �޿� �հ谡 ��ü �޿� �� ���� 20%���� ���� �μ��� �μ� ��, �μ� �� �޿� �հ� ��ȸ 
    -- 11-1. JOIN�� HAVING ��� 
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
    
SELECT DEPT_TITLE, SUM(SALARY) "�μ��� �޿� �հ�"
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
GROUP BY D.DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY)*0.2
                     FROM EMPLOYEE);
                     
                                                                   -- 11-2. �ζ��� �� ��� 

-- 12. �μ� ��� �μ� �� �޿� �հ� ��ȸ 



