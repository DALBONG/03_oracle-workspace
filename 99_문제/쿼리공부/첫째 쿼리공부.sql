/*�̰Ž� ���� ����*/

--############################### QUIZ 1 #####################################--
-- ���ʽ��� �ȹ����� �μ���ġ�� �� ��� ��ȸ 
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE = NULL;
    --> NULL���� ���� ���������� ��ó��X
    --> NULL�� ���� �� �ܼ��� �Ϲ� �� ������ ���� �� X IS NULL or IS NOT NULL ���
-- ��_
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;
--############################### QUIZ 2 #####################################--
-- �˻��ϰ��� �ϴ� ����
    -- JOB_CODE�� J7 �̰ų� J6 �̸鼭 SALARY���� 200 �̻�, BONUS�� �ְ�, �����̸�, �̸��� _�տ� 3���ڸ� �ִ� ����� 
    -- EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS�� ��ȸ
    -- ���� ��ȸ�� �ȴٸ� �������� 2���̿��� ��

-- ���� ������ �����Ű���� �ۼ��� SQL���� �Ʒ��� ����.
SELECT EMP_NAME, EMAIL, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
    AND EMAIL LIKE '____%' AND BONUS IS NULL;
    -- ������ 
    -- 1. AND ������, OR �����ڰ� ���� ��� AND �����ڰ� ���� (OR���� ���� ����Ǿ�� ��)
    -- 2. �޿� �񱳰� �߸��Ǿ� ���� �̻��ε�, �ʰ��� ����.
    -- 3. BONUS�� �ִ� �����ε� IS NULL�� �ۼ�, IS NOT NULL�� ���ؾ� ��.
    -- 4. ���ڿ� ���� ���� ����
    -- 5. ���� �񱳽� �׹�° �ڸ��� _�� ����ϱ� ���ؼ� ���ϵ�ī�� �ο��Ͽ� ESCAPE�ɼ� �ο��ؾ� ��
--> ��)

SELECT EMP_NAME, EMAIL, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
    AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL
    AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4');
    
--############################### QUIZ 3 #####################################--
-- [���� ���� ����] CREATE USER ������ IDENTIFIED BY ��й�ȣ;
-- ������ SCOTT, ��й�ȣ TIGER ������ �����ϰ� ����.
-- �̶� �Ϲ� ����� ������ �����Ͽ� �����,
-- CREATE USER SCOTT; �����ϴ� �����߻�
    -- ������1. ����� ���� ���� ��, ������ ���������� ����.  -> ��ġ 1: ������ �������� ����
         -- 2. SQL���� �߸��Ǿ���. ��й�ȣ���� �Է��ؾ� ��. -> ��ġ 2: CREAT USER SCOTT IDENTIFIED BY TIGER; ����

-- ���� SQL�� ���� �� ������ ����� ������ �Ϸ� �ߴ��� ����.
-- �Ӹ� �ƴ϶�, �ش� ������ ���̺� ������ ���� ����.
    -- ������1. ����� ���� ������ �ּ����� ���� �ο��� �ȵ�. -> ��ġ 1: GRANT CONNECT, RESOURCE TO SCOTT;
    