/*
    <�Լ� FUNCTION>
      ������ �÷����� �о�鿩 �Լ��� ������ ����� ��ȯ.
    
     - ���� �� �Լ� : N���� ���� �о�鿩 N���� ������� ����
     - �׷� �Լ� : N���� ���� �о�鿩 1���� ����� ����
     
    * SELECT ���� ������ �Լ��� �׷��Լ��� �Բ� ������� ����.
       -> ��� ���� ������ �ٸ��� ����
       
    * �Լ� �� �� �ִ� ��ġ : SELECT��, WHERE��, ORDER BY ��, BROPU BY �� HAVING ��
*/    


/*    
    <����ó�� �Լ�>
    * LENGTH / LENGTHB   -> �����  NUMBER Ÿ�� 
     LENGTH(�÷�|'���ڿ� ��') : �ش� ���ڿ� ���� ���� �� ��ȯ
     LENGTHB(�÷�|'���ڿ� ��') : �ش� ���ڿ� ���� ����Ʈ �� ��ȯ
     
     '��', '��', '��' : �ѱ��ڴ� 3BYTE ũ��
     '����' '����' 'Ư��' : �ѱ��ڴ� 1BYTE
*/

SELECT SYSDATE FROM DUAL; --�������̺�
SELECT LENGTH ('������'), LENGTHB ('����')
FROM DUAL;


SELECT LENGTH ('PING'), LENGTHB('PING')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;  -- ���ึ�� �� ����ǰ� ���� --> ������ �Լ� 


/*
    INSTR
    ���ڿ��κ��� Ư�� ������ ���� ��ġ�� ã�Ƽ� ��ȯ
    INSTR(�÷�|'���ڿ�', 'ã���� �ϴ� ����', ['ã�� ��ġ�� ���۰�', ����]) -> ������� NUMBER Ÿ��
    
*/

SELECT INSTR('AABBAAABABDDBBDAAA', 'B') 
FROM DUAL;
SELECT INSTR('AABBAAABABDDBBDAAA', 'B', 1) 
FROM DUAL;
SELECT INSTR('AABBAAABABDDBBDAAA', 'B', -1) 
FROM DUAL; -- �ڿ�������
SELECT INSTR('AABBAAABABDDBBDAAA', 'B', 1, 2) 
FROM DUAL; -- �տ������� �ι�° B

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_�� ��ġ"
FROM EMPLOYEE; 

SELECT EMAIL, INSTR(EMAIL, '@', 1, 1) AS "@�� ��ġ"
FROM EMPLOYEE; 


/*
 SUBSTR
  ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ
    (jAVA������ SUBSTRING()�޼���� ���)
    
    SUBSTR(STRING, POSITION, [LENGTH])  -> ������� CHAR Ÿ��
*/


SELECT SUBSTR('SHOWMETHEMONEY', 7)
FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2)
FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1,6)
FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3)
FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8,1) AS "����" 
FROM EMPLOYEE;

-- ���� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR (EMP_NO, 8, 1) IN ('2', '4');

SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR (EMP_NO, 8, 1) IN (1, 3) -- ���������� �ڵ�����ȯ �Ǿ� ' ' �Ⱥٿ��� ��. 
ORDER BY 1;

-- �Լ� ��ø ��� 
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) "ID"
FROM EMPLOYEE;

--==========================================================================
/*
    LPAD / RPAD
    ���ڿ��� ��ȸ�� �� ���ϰ��ְ� ��ȸ�ϰ��� �� �� ���.
    LPAD/RPAD(STRING, ���������� ��ȯ�� ������ ����, [�����̰��� �ϴ� ����])    
*/

SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20) -- �����̰��� �ϴ� ���� ������ �⺻�� ����.
FROM EMPLOYEE; 

SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT RPAD(SUBSTR(EMP_NO, 1, 8),14, '*')
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8) || '******'
FROM EMPLOYEE;
--===============================================================

/*
    LTRIM / RTRIM
    ���ڿ����� Ư�� ���ڸ� ������ ������ ��ȯ.
    
    LTRIM / RTRIM (STRING, ['������ ���ڵ�']) = ������ ���� ����
*/
SELECT LTRIM('      K H     ') 
FROM DUAL;
SELECT LTRIM('112484', '123') 
FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') 
FROM DUAL;

SELECT RTRIM('1234KH1234', '12341234') 
FROM DUAL;

/*
TRIM([LEADING | TRAILING | BOTH] [�����ϰ��� �ϴ� ���ڵ� FROM] STRING)
���ڿ��� ��/��, ���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ 
*/


-- �⺻������ ���ʿ� �ִ� ���ڵ� �� ã�� ����
SELECT TRIM('      K   H     ') 
FROM DUAL;
--SELECT TRIM('ZZZKHZZZ', 'Z') FROM DUAL; --> �����ϰ��� �ϴ� ���ڰ� �տ� �;� ��
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL; 
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; --�պκ� Z ����
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- �޺κ� Z ����
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL; --�翷 Z ����(�⺻��)

--===================================================================
/*
    *LOWER / UPPER  / INITCAP
    
    LOWER / UPPER / INITCAP(STRING) -> �����  CHAR Ÿ��
*/
SELECT LOWER('WelCome To The Show') FROM DUAL;
SELECT UPPER('WelCome To The Show') FROM DUAL;
SELECT INITCAP('WelCome To The Show') FROM DUAL;

--========================================================
/*
CONCAT
���ڿ� �ΰ��� ���޹޾� �ϳ��� ��ģ �� ��� ��ȯ 

CONCAT(STRING1, STRING2)
*/

SELECT CONCAT('ABC', '���ݸ���') FROM DUAL;
SELECT 'ABC' || 'CHZHFFPeM' FROM DUAL;


-- SELECT CONCAT('ABC', '���ݸ���', '���ֳ�?') FROM DUAL; --> 2���� ��
SELECT 'ABC' || 'CHZHFFPeM' || '����������' FROM DUAL;

--===============================================================
/*
REPLACE
REPLACE (STRING, STR1, STR2)
 => ���ڿ� �ٲ��ִ� �Լ�

*/

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'GMAIL.COM')
FROM EMPLOYEE;


--=================================================================
--==============================================================--
--==============================================================--
--==============================================================--
--==============================================================--
--==============================================================--
--==============================================================--
--==============================================================--
--==============================================================--
--==============================================================--
--==============================================================--
--==============================================================--
--==============================================================--
--==============================================================--
--==============================================================--
--==============================================================--
--==============================================================--
--==============================================================--
/*
���� ó�� �Լ�
 *ABS (NUMBER)

*/

SELECT ABS(-10.6) FROM DUAL;


/*
MOD (NUMBER1, NUMBER2)
*/

SELECT MOD (10.9, 3) FROM DUAL;


/*
 ROUND
 �ݿø� �� ��� 
 ROUND (NUMBER)
*/

SELECT ROUND (123.5367) FROM DUAL;
SELECT ROUND (123.5367, 1) FROM DUAL;
SELECT ROUND (123.5367, 2) FROM DUAL;


/*
CEIL 
 �ø�ó�� ���ִ� �Լ� 
 
 CEIL(NUMBER)
*/

SELECT CEIL(1445.453453) FROM DUAL;

/*
FLOOR 
�Ҽ��� �Ʒ� ����ó��
*/

SELECT FLOOR(213.3525) FROM DUAL;

/*
TRUNC (�����ϴ�)
 : ��ġ ���� ������ ���� ó�����ִ� �Լ�
 
 TRUNC (NUMBER, [��ġ])
*/

SELECT TRUNC (1252.1234373) FROM DUAL;
SELECT TRUNC (1252.1234373, 1) FROM DUAL;
SELECT TRUNC (1252.1234373, 3) FROM DUAL;

--====================================================================
--====================================================================
--====================================================================
--====================================================================
--====================================================================
--====================================================================
--====================================================================
--====================================================================
--====================================================================
--====================================================================
--====================================================================
--====================================================================
--====================================================================
--====================================================================
--====================================================================
--====================================================================
--====================================================================
--====================================================================

/*
��¥ ó�� �Լ�
SYSDATE : �ý��� ��¥ �� �ð� ��ȯ
*/
SELECT SYSDATE FROM DUAL;



/*
MONTHS_BETWEEN(DATE1, DATE2) : �� ��¥ ������ ���� �� 
*/

-- EMPLPYEE���� ����� �Ի��� �ٹ��ϼ� �ٹ����� �� 
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE-HIRE_DATE) || '��' "�ٹ��ϼ�"
FROM EMPLOYEE;


SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE-HIRE_DATE) || '��' "�ٹ��ϼ�", CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '����'
FROM EMPLOYEE;


/*
ADD_MONTHS(DATE, NUMBER)
 : Ư�� ��¥�� �ش� ���ڸ�ŭ�� ������ ���ؼ� �˷���
*/
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;

-- ����� �Ի���, �Ի��� 3���� �� ��¥

SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3) "���� ���� ��¥"
FROM EMPLOYEE;



/*
NEXT_DAY (DATE, ����) : �ش� �� ���� ���� ����� ������ ��¥�� ��ȯ

*/

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'ȭ����') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'ȭ') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 3) FROM DUAL;



/*
LAST_DAY (DATE): �ش���� ������ ��¥�� ���ؼ� ��ȯ
*/
SELECT LAST_DAY(SYSDATE) FROM DUAL;
  -- ����� �Ի��� �Ի��� ���� ������ ��¥
  
  SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE "�ٹ��� ��"
  FROM EMPLOYEE;
   -- LAST_DAY : �ش� ���� ������ ��
   
   
/*
EXTRACK : Ư�� ��¥�κ��� �⵵ | �� | �� ���� �����ؼ� ��ȯ

EXTRACT(YEAR FROM DATE) : �⵵�� ����
EXTRACT(MONTH FROM DATE) : ���� ����
EXTRACT(DAY FROM DATE) : �ϸ� ����
*/
-- �����, �Ի�⵵, �Ի��, �Ի� �� ��ȸ
SELECT EMP_NAME, HIRE_DATE,
EXTRACT(YEAR FROM HIRE_DATE) AS "�Ի�⵵",
EXTRACT(MONTH FROM HIRE_DATE) AS "�Ի� ��",
EXTRACT(DAY FROM HIRE_DATE) AS "�ϻ� ��"
FROM EMPLOYEE
ORDER BY "�Ի�⵵", "�Ի� ��", "�ϻ� ��";

--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================
--=============================================================================

/*
����ȯ �Լ�
 TO_CHAR : ����, ��¥ Ÿ���� ���� ����Ÿ������ ��ȯ�����ִ� �Լ�
 
 TO_CHAR(����|��¥, [����])
*/

--���� -> ����
SELECT TO_CHAR(1234) FROM DUAL; -- ����Ÿ�� 1234 -> ���� Ÿ�� '1234'
SELECT TO_CHAR(1234, '99999') FROM DUAL;
SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;
SELECT TO_CHAR(1234, '$99999') FROM DUAL;
SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999') -- 9�� �ڸ��� ��Ÿ���� ����
FROM EMPLOYEE;

-- ���� Ÿ���� ����Ÿ������
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; 
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; 
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL; 

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YY-MM-DD')
FROM EMPLOYEE;

-- ���������� 0���� 00�� �������� 

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"')
FROM EMPLOYEE;
    --> ���� ���� ������ ��, " "�� �����ָ� ��.

-- �⵵�� ���õ� ���� 
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;


-- ���� ���� ����
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- �Ͽ� ���� ����
SELECT TO_CHAR(SYSDATE, 'DDD'), --���� ���� ��ĥ��? 
       TO_CHAR(SYSDATE, 'DD'),  -- �� �������� ��ĥ��?
       TO_CHAR(SYSDATE, 'D') -- �� ���� ��ĥ��?
FROM DUAL;

-- ���Ͽ� ���� ����
SELECT TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')
FROM DUAL;


--==================================================================
/*
TO_DATE : ����Ÿ�� OR ����Ÿ�� �����͸� ��¥ Ÿ������ ��ȯ�����ִ� �Լ�

 TO_DATE(����|����, [����])
*/

SELECT TO_DATE(20100503) FROM DUAL;
SELECT TO_DATE(101009) FROM DUAL;
SELECT TO_DATE('090909') FROM DUAL; --����
  ---> ù ���ڰ� 0�ΰ�� ������ ����Ÿ������ �����ϰ� �ؾ� ��.

SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140620', 'YYMMDD') FROM DUAL;
SELECT TO_DATE('980620', 'YYMMDD') FROM DUAL; --> 2098 : ������ ���� ����� �ݿ�
SELECT TO_DATE('980620', 'RRMMDD') FROM DUAL; --> 1998 
   -- RR : �ش� ���ڸ� �⵵ ���� 50�̸��� ��� ���缼��, 50�̻��� ��� �������� �ݿ�
   
   
--=======================================================
/*
TO_NUMBER : ���� Ÿ���� �����͸� ����Ÿ������ ��ȯ�����ִ� �Լ�
  TO_NUMBER (����, [����])
*/

SELECT TO_NUMBER('01090115641') FROM DUAL;

SELECT '1000000' + '55000' FROM DUAL; --> �ڵ�����ȯ �Ǿ� ��������
SELECT '1,000,000' + '55,000' FROM DUAL; --> ���ڸ� �־�� ����ȯ ����,

SELECT TO_NUMBER ('1,000,000', '9,999,999') + TO_NUMBER('55,000', '99,999') FROM DUAL;


/*
NULL ó�� �Լ�

NVL(�÷�, �ش� �÷� �� NULL��� ��ȯ�� ��)
*/

SELECT EMP_NAME, BONUS
FROM EMPLOYEE;

SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- ��ü ��� �̸�, ���ʽ� ���� ����
SELECT EMP_NAME, BONUS, (SALARY + SALARY * BONUS)*12, (SALARY + SALARY * NVL(BONUS, 0))*12
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '�μ� ����')
FROM EMPLOYEE;

-- NVL2(�÷�, ��ȯ��1, ��ȯ��2)
   -- �÷����� ������ ��� ��ȯ��1��ȯ, NULL�ϰ�� ��ȯ��2 ��ȯ (3�׿����ڿ� ���)
SELECT EMP_NAME, NVL2(BONUS, 0.7, 0.1)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL2(DEPT_CODE, '�μ�����', '�μ�����')
FROM EMPLOYEE;

-- NULLIF(�񱳴��1 ,  �񱳴��2)
  -- �ΰ��� ���� ��ġ�ϸ� NULL ��ȯ, ��ġ���� ������ �񱳴��1 �� ��ȯ
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '456') FROM DUAL;

--=================================================================
/*
    <���� �Լ�>
    DECODE(���ϰ��� �ϴ� ���, �񱳰�1, �����1, �񱳰�2, �����2,...)
    
*/
--���, �����, �ֹι�ȣ
SELECT EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1), 
    DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��') AS "����"
FROM EMPLOYEE;

-- ���� �޿� ��ȸ�� �� ���޺� �λ��ؼ� ��ȸ
 -- J7 ��� : �޿�10% �λ� (SALARY * 1.1)
 -- J6 ��� : �޿�15% �λ� (SALARY * 1.15)
 -- J5 ��� : �޿�20% �λ� (SALARY * 1.2)
 -- �� �� : (SALARY * 1.05)
 
 -- �����, �����ڵ�, �����޿�, �λ�޿�
 SELECT EMP_NAME, JOB_CODE, SALARY,
    DECODE(JOB_CODE, 'J7', SALARY*1.1, 'J6', SALARY*1.15, 'J5', SALARY*1.2, SALARY*1.05) "�λ� �޿�"
 FROM EMPLOYEE;


/*
CASE WHEN THEN

 CASE WHEN ���ǽ�1 THEN �����1
      WHEN ���ǽ�2 THEN �����2
      ...
      ELSE �����N 
   END
*/

SELECT EMP_NAME, SALARY,
    CASE WHEN SALARY >= 5000000 THEN '��� ������'
         WHEN SALARY >= 3500000 THEN '�߱� ������'
         ELSE '�ʱ� ������'
    END
FROM EMPLOYEE;



/*
 �׷� �Լ�
  1. SUM(���� Ÿ���÷�) : �ش�
 
*/
-- ��ü ����� �� �޿� ��
SELECT SUM(SALARY)  --> ��ü ����� �� �׷����� ���� ���� �ϳ��� ����.
FROM EMPLOYEE;

-- ���ڻ������ �� �޿� ��
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3'); --> ���ڻ������ �ϳ��� �׷����� ����

-- �μ��ڵ尡 D5�� ������� �� ���� ��
SELECT SUM(SALARY*12)
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5';


 -- 2. AVG(���� Ÿ��) : �ش� �÷������� ��� ��
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;


 -- 3. MIN (���� Ÿ��) : �ش� �÷����� �� ���� ���� �� ���ؼ� ��ȯ
 SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
 FROM EMPLOYEE;
 
 -- 4. MAX 
 SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
 FROM EMPLOYEE;
 
 -- 5. COUNT (*| �÷�| DISTINCT �÷�) : ��ȸ�� �� ������ ���� ��ȯ 
  -- 1) COUNT(*) : ��ȸ�� ����� ��� �� ���� ��ȯ
SELECT COUNT(*)
FROM EMPLOYEE;

  -- 2) COUND(�÷�) : �÷� ���� NULL�� �ƴ� �͸� �� ���� ��ȯ
SELECT COUNT(BONUS) -- ���ʽ��� �޴� ��� ��
FROM EMPLOYEE;

-- ���� ��� �� ���ʽ��� �޴� ��� ��
SELECT COUNT(BONUS)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3'); 

-- �μ� ��ġ�� ���� ��� ��
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- 3) COUNT(DISTINCT �÷�) : �ش� �÷��� �ߺ� ���� �� �� ���� ��ȯ
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE; -- �� ������� ��� �μ��� �����Ǿ��ִ���.


 
 
 
 
 
 

