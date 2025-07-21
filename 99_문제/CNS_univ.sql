SELECT *
FROM TB_CLASS;

--==============================BASIC SELECT====================================


-- 1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭" ���� ǥ���ϵ��� ����. 
SELECT DEPARTMENT_NAME "�а� ��", CATEGORY "�迭"
FROM TB_DEPARTMENT;

-- 2.  �а��� �а� ������ ������ ���� ���·� ȭ�鿡 �������. 
SELECT (DEPARTMENT_NAME || '�� ������'|| CAPACITY ||'�� �Դϴ�.') "�а��� ����"
FROM TB_DEPARTMENT;


-- 3.  "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û�� ���Դ�.
-- �����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� ������ ����) 
SELECT S.STUDENT_NAME, D.DEPARTMENT_NAME, S.ABSENCE_YN
FROM TB_STUDENT S, TB_DEPARTMENT D
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND DEPARTMENT_NAME LIKE '%�����%'
  AND ABSENCE_YN = 'Y'
  AND SUBSTR(STUDENT_SSN, 8, 1) IN (2, 4);
  
-- 4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� ����. 
  -- �� ����ڵ��� �й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
  --     A513079, A513090, A513091, A513110, A513119 
SELECT STUDENT_NAME "���� ���� ��� ��ü��"
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

-- 5. ���������� 20�� �̻� 30�� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�. 
SELECT DEPARTMENT_NAME "�а�", CATEGORY "�迭"
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

-- 6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�.  
    -- �׷� �� ������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�. 
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� ����. 
-- ��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�. 
  
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;
  
-- 8. ������û�� �Ϸ��� ����. �������� ���θ� Ȯ���ؾ� �ϴµ�, 
 -- ���������� �����ϴ� ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�. 
SELECT CLASS_NO 
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�. 
SELECT CATEGORY
FROM TB_DEPARTMENT
GROUP BY CATEGORY;

--10. 02 �й� ���� �����ڵ��� ������ ������� ����. ������ ������� ������ �������� 
-- �л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�. 
SELECT DEPARTMENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ENTRANCE_DATE LIKE '02%'
    AND STUDENT_ADDRESS LIKE '%����%'
    AND ABSENCE_YN = 'N';
    
--================================�Լ� ����======================================
--================================�Լ� ����======================================
--================================�Լ� ����======================================
--================================�Լ� ����======================================
--================================�Լ� ����======================================
--================================�Լ� ����======================================
--================================�Լ� ����======================================
--================================�Լ� ����======================================

-- 1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� 
   -- ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" �� ǥ�õǵ��� ����.)
   
SELECT STUDENT_NO "�й�", STUDENT_NAME "�̸�", TO_CHAR(ENTRANCE_DATE, 'RRRR-MM-DD') "���� �⵵"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY ENTRANCE_DATE ASC;

-- 2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� �Ѵ�. 
 -- �� ������ �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. 
 --(* �̶� �ùٸ��� �ۼ��� SQL ������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
 -- WHERE PROFESSOR_NAME NOT LIKE '%___%';
    --> %�� �ٿ� �ּ� ������ �̻��̶�� ������ �Ǿ����.
WHERE PROFESSOR_NAME NOT LIKE '___';

-- 3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
    -- �� �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. 
    -- (��, ���� �� 2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� ����. 
    -- ���̴� ���������� �������.)
 /*ABS(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6),'RRRR'))) */
 /*FLOOR(ABS(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6)))) /12)*/
SELECT PROFESSOR_NAME "�����̸�", FLOOR(ABS(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6)))) /12) "����"
    -- TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6)) --> WHERE ������ ���ǽ����� 100 - 
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = 1
ORDER BY FLOOR(ABS(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6)))) /12) ASC;
    

-- 4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
 --- ��� ����� '�̸�? �� �������� ����. (���� 2���� ���� ������ ���ٰ� �����Ͻÿ�) 

SELECT SUBSTR(PROFESSOR_NAME, 2) "�̸�"
FROM TB_PROFESSOR;

-- 5. �� ������б��� ����� �����ڸ� ���Ϸ��� ����. ��� ã�Ƴ� ���ΰ�?  
    -- �̶�, 19�쿡 �����ϸ� ����� ���� ���� ������ �A������.
                 -- �ֹι�ȣ, ���г�¥. ���̰� 228 ���� �̻��̸� ���  
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE ABS(MONTHS_BETWEEN(TO_DATE(SUBSTR(STUDENT_SSN, 1, 6)), ENTRANCE_DATE)) > 228;

-- 6. 2020�� ũ���������� ���� �����ΰ�? 
SELECT TO_DATE(201225) --> �ݿ���
FROM TB_STUDENT;

-- 7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD')  �� ���� 
    -- �� �� �� �� �� ���� �ǹ�����? �� TO_DATE('99/10/11','RR/MM/DD'), 
    -- TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ�����?

/* ��    
     TO_DATE('99/10/11','YY/MM/DD') : 2099�� 10�� 11��
     TO_DATE('49/10/11','YY/MM/DD') : 2049�� 10�� 11��
     TO_DATE('99/10/11','RR/MM/DD') : 1999�� 10�� 11��
     TO_DATE('49/10/11','RR/MM/DD') : 2049�� 10�� 11��
*/   

-- 8. �� ������б��� 2000�⵵ ���� �����ڵ��� �й��� A�� �����ϰ� �Ǿ��ִ�. 
    -- 2000�⵵ �̠� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 9. �й��� A517178 �� ���Ƹ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
 -- ��, �̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, 
 -- ������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ������.

SELECT ROUND(AVG(POINT), 1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� ������� ��µǵ��� �Ͻÿ�. 
SELECT DEPARTMENT_NO "�а���ȣ", COUNT(*) "�л���(��)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY "�а���ȣ" ASC;

-- 11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ���� �ۼ��Ͻÿ�.
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12. �й��� A112113�� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
    -- ��, �̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, 
    -- ������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ������.
SELECT SUBSTR(TERM_NO, 1, 4) "�⵵", ROUND(AVG(POINT),1) "�⵵ �� ����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY �⵵;

-- 13. �а� �� ���л� ���� �ľ��ϰ��� ����. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT D.DEPARTMENT_NO "�а� �ڵ� ��", COUNT(S.ABSENCE_YN) "���л� ��"
FROM TB_DEPARTMENT D, TB_STUDENT S
WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
    AND S.ABSENCE_YN = 'Y'
GROUP BY D.DEPARTMENT_NO
ORDER BY "�а� �ڵ� ��" ASC;

SELECT DEPARTMENT_NO
FROM TB_DEPARTMENT;


-- 14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� ����. � SQL ������ ����ϸ� �����ϰڴ°�?
SELECT DISTINCT(STUDENT_NAME), COUNT(STUDENT_NAME)
FROM TB_STUDENT
HAVING COUNT(STUDENT_NAME) != 1
GROUP BY STUDENT_NAME;

-- 15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , 
    -- �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� ǥ������.)
SELECT SUBSTR(TERM_NO, 1, 4) "�⵵", SUBSTR(TERM_NO, 5, 2) "�б�", SUM(POINT) "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2)
UNION ALL
SELECT SUBSTR(TERM_NO, 1, 4) "�⵵", NVL(SUBSTR(TERM_NO, 0, 0), ' ') "�б�", ROUND(AVG(POINT),1) "����"
  FROM TB_GRADE
 WHERE STUDENT_NO = 'A112113'
 GROUP BY SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 0, 0)
UNION ALL
SELECT NVL(SUBSTR(TERM_NO, 0, 0), ' ') "�⵵", NVL(SUBSTR(TERM_NO, 0, 0), ' ') "�б�", ROUND(AVG(POINT), 1) "����"
  FROM TB_GRADE
 WHERE STUDENT_NO = 'A112113'
 GROUP BY SUBSTR(TERM_NO, 0, 0), SUBSTR(TERM_NO, 0, 0)
 ORDER BY �⵵, �б�;

--================================�ɼ� ����======================================
--================================�ɼ� ����======================================
--================================�ɼ� ����======================================
--================================�ɼ� ����======================================
--================================�ɼ� ����======================================
--================================�ɼ� ����======================================
--================================�ɼ� ����======================================
--================================�ɼ� ����======================================

-- 1. �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�,
   -- ������ �̸����� �������� ǥ���ϵ��� ����.
SELECT STUDENT_NAME "�л� �̸�", STUDENT_ADDRESS "�ּ���"
  FROM TB_STUDENT
 ORDER BY STUDENT_NAME ASC;
 
-- 2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_SSN
  FROM TB_STUDENT
 WHERE ABSENCE_YN = 'Y' 
 ORDER BY SUBSTR(STUDENT_SSN, 1, 6) DESC;
 
-- 3. �ּ����� �������� ��⵵�� �л��� �� 1900 ��� �й��� ���� �л����� �̸��� �й�, �ּҸ� 
   -- �̸��� ������������ ȭ�鿡 ����Ͻÿ�. ��, ���������� "�л��̸�","�й�", "������ �ּ�" �� ��µǵ��� ����.
SELECT STUDENT_NAME "�л� �̸�", STUDENT_NO "�й�", STUDENT_ADDRESS "�ּ�"
  FROM TB_STUDENT
 WHERE (STUDENT_ADDRESS LIKE '%������%'
    OR STUDENT_ADDRESS LIKE '%��⵵%')
   AND STUDENT_NO LIKE '9%'
 ORDER BY 1;
 
-- 4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������ �ۼ��Ͻÿ�. 
  -- (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�Ƴ����� ����)
  
SELECT PROFESSOR_NAME, PROFESSOR_SSN
  FROM TB_DEPARTMENT D, TB_PROFESSOR P
 WHERE D.DEPARTMENT_NO = P.DEPARTMENT_NO 
   AND DEPARTMENT_NAME LIKE '%���а�%'
 ORDER BY SUBSTR(PROFESSOR_SSN, 1, 6) ASC;

-- 5. 2004 �� 2 �б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� ����. 
  -- ������ ���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������ �ۼ��غ��ÿ�.

SELECT STUDENT_NO, ROUND(POINT, 2)
  FROM TB_GRADE
 WHERE CLASS_NO = 'C3118100'
   AND TERM_NO = ANY (SELECT TERM_NO
                    FROM TB_GRADE
                   WHERE TERM_NO = 200402)
 ORDER BY ROUND(POINT, 2) DESC, STUDENT_NO ASC;
 
-- 6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
  FROM TB_DEPARTMENT D, TB_STUDENT S
 WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
 ORDER BY STUDENT_NAME ASC;
 
-- 7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT CLASS_NAME "���� �̸�", DEPARTMENT_NAME "�а� �̸�"
  FROM TB_CLASS C, TB_DEPARTMENT D
 WHERE D.DEPARTMENT_NO = C.DEPARTMENT_NO;
 
-- 8. ���� ���� �̸��� ã������ ����. ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT CLASS_NAME, PROFESSOR_NAME
  FROM TB_CLASS C, TB_PROFESSOR P, TB_CLASS_PROFESSOR CP
 WHERE C.DEPARTMENT_NO = P.DEPARTMENT_NO
   AND CP.CLASS_NO = C.CLASS_NO
 GROUP BY CLASS_NAME, PROFESSOR_NAME;

-- 9. 8 ���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ ����. 
   -- �̿� �ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�
SELECT CLASS_NAME, PROFESSOR_NAME
  FROM TB_CLASS C, TB_PROFESSOR P, TB_DEPARTMENT D
 WHERE C.DEPARTMENT_NO = P.DEPARTMENT_NO
   AND D.DEPARTMENT_NO = P.DEPARTMENT_NO
   AND CATEGORY LIKE '%�ι���ȸ%';

-- 10. �������а��� �л����� ������ ���Ϸ��� ����. �����а� �л����� "�й�", "�л� �̸�", "��ü ����"�� 
   -- ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ� ǥ������.)
SELECT S.STUDENT_NO "�й�", STUDENT_NAME "�л� �̸�", ROUND(AVG(POINT), 1) "��ü ����"
  FROM TB_DEPARTMENT D, TB_STUDENT S, TB_GRADE G
  WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
    AND S.STUDENT_NO = G.STUDENT_NO
    AND DEPARTMENT_NAME LIKE '%������%'
  GROUP BY S.STUDENT_NO, STUDENT_NAME;
  
-- 11. �й��� A313047 �� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ� ���� 
    -- �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. �̶� ����� SQL ���� �ۼ��Ͻÿ�. 
    -- ��, �������� ?�а��̸�?, ?�л��̸�?, ?���������̸�?���� ��µǵ��� ����.
SELECT DEPARTMENT_NAME "�а��̸�", STUDENT_NAME "�л��̸�", PROFESSOR_NAME "���������̸�"
  FROM TB_DEPARTMENT D, TB_STUDENT S, TB_PROFESSOR P
 WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
   AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
   AND STUDENT_NO = 'A313047';
   
-- 12. 2007 �⵵�� '�΁A�����' ������ ������ �л��� ã�� �л��̸��� �����б⸧ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME "�л��̸�", TERM_NO "�����б�"
  FROM TB_CLASS C, TB_STUDENT S, TB_GRADE G, TB_DEPARTMENT D
 WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
   AND S.STUDENT_NO = G.STUDENT_NO
   AND G.CLASS_NO = C.CLASS_NO
   AND TERM_NO LIKE '2007%'
   AND CLASS_NAME LIKE '�ΰ������';
   
-- 13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� ���� �̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT CLASS_NAME, DEPARTMENT_NAME 
  FROM TB_DEPARTMENT D, TB_CLASS C, TB_CLASS_PROFESSOR CP 
 WHERE D.DEPARTMENT_NO = C.DEPARTMENT_NO
   AND C.CLASS_NO = CP.CLASS_NO
   AND CATEGORY LIKE '%��ü��%';
   
-- 14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� ����. �л��̸��� �������� �̸��� ã�� 
   -- ���� ���� ������ ���� �л��� ��� "�������� ������?���� ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�. 
   -- ��, �������� ?�л��̸�?, ?��������?�� ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� ����
SELECT �л��̸�, ��������
  FROM (SELECT STUDENT_NO, STUDENT_NAME "�л��̸�", PROFESSOR_NAME "��������"
          FROM TB_DEPARTMENT D, TB_STUDENT S, TB_PROFESSOR P
         WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
           AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
           AND DEPARTMENT_NAME LIKE '%���ݾƾ�%'
         UNION ALL
        SELECT STUDENT_NO, STUDENT_NAME "�л��̸�", NVL(COACH_PROFESSOR_NO, '�������� ������')
          FROM TB_DEPARTMENT D, TB_STUDENT S, TB_PROFESSOR P
         WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
           AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO(+)
           AND COACH_PROFESSOR_NO IS NULL
           AND DEPARTMENT_NAME LIKE '%���ݾƾ�%')
    ORDER BY STUDENT_NO ASC;
    
--  15. ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �� �л��� �й�, �̸�, �а� �̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT G.STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME, AVG(POINT)
  FROM TB_STUDENT S, TB_DEPARTMENT D, TB_GRADE G
 WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
   AND S.STUDENT_NO = G.STUDENT_NO
   AND ABSENCE_YN = 'N'
HAVING AVG(POINT) >= 4
 GROUP BY G.STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME;
   
-- 16. �Q�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.
SELECT C.CLASS_NO, CLASS_NAME, AVG(POINT)
  FROM TB_DEPARTMENT D, TB_CLASS C, TB_GRADE G
 WHERE D.DEPARTMENT_NO = C.DEPARTMENT_NO
   AND C.CLASS_NO = G.CLASS_NO
   AND DEPARTMENT_NAME = 'ȯ�������а�'
   AND C.CLASS_TYPE LIKE '%����%'
 GROUP BY C.CLASS_NO, CLASS_NAME;
 
-- 17. �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_ADDRESS
  FROM TB_DEPARTMENT D, TB_STUDENT S 
 WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
   AND DEPARTMENT_NAME = (SELECT DEPARTMENT_NAME
                            FROM TB_DEPARTMENT D, TB_STUDENT S 
                           WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
                             AND STUDENT_NAME = '�ְ���');
    
-- 18. ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_NO
  FROM (SELECT STUDENT_NAME, G.STUDENT_NO, AVG(POINT), RANK() OVER (ORDER BY AVG(POINT) DESC) "��������"
          FROM TB_DEPARTMENT D, TB_STUDENT S, TB_GRADE G
         WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO 
           AND S.STUDENT_NO = G.STUDENT_NO
           AND DEPARTMENT_NAME LIKE '%�������%'
         GROUP BY STUDENT_NAME, G.STUDENT_NO)
 WHERE �������� = 1;
 

-- 19. �� ������б��� "�Q�������а�"�� ���� ���� �迭 �а����� �а� �� �������� ������ �ľ��ϱ� ���� ������ SQL ���� ã�Ƴ��ÿ�. 
    -- ��, �������� "�迭 �а���", "��������"���� ǥ�õǵ��� �ϰ�, ������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ��� ����
SELECT DEPARTMENT_NAME "�迭_�а���", ROUND(AVG(POINT), 1) "���� ����"
  FROM TB_DEPARTMENT D, TB_CLASS C, TB_GRADE G
 WHERE D.DEPARTMENT_NO = C.DEPARTMENT_NO
   AND C.CLASS_NO = G.CLASS_NO
   AND CLASS_TYPE LIKE '%����%'
   AND CATEGORY = (SELECT CATEGORY
                     FROM TB_DEPARTMENT
                    WHERE DEPARTMENT_NAME = 'ȯ�������а�')
 GROUP BY DEPARTMENT_NAME, CATEGORY;
 
 
 --================================DDL ����======================================
 --================================DDL ����======================================
 --================================DDL ����======================================
 --================================DDL ����======================================
 --================================DDL ����======================================

-- 1. �迭 ������ ������ ī�װ� ���̺��� ������� ����. ������ ���� ���̺��� �ۼ��Ͻÿ�
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y' CHECK(USE_YN IN('Y', 'N'))
);

-- 2. ���� ������ ������ ���̺��� ������� ����. ������ ���� ���̺��� �ۼ��Ͻÿ�.
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) CONSTRAINT NO_PK PRIMARY KEY,
    NAME VARCHAR2(10)
);

-- 3. TB_CATAGORY ���̺��� NAME �÷��� PRIMARY KEY �� �����Ͻÿ�.
  -- (KEY �̸��� �������� �ʾƵ� ������. ���� KEY �̸� �����ϰ��� ���ٸ� �̸��� ������ �˾Ƽ� ������ �̸��� �������.)
ALTER TABLE TB_CATEGORY MODIFY NAME CONSTRAINT NAME_PK PRIMARY KEY;

-- 4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�.
ALTER TABLE TB_CLASS_TYPE MODIFY NAME CONSTRAINT NAME_NN NOT NULL;

-- 5. �� ���̺��� �÷� ���� NO �� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10 ����, 
  -- �÷����� NAME �� ���� ���C������ ���� Ÿ���� �����ϸ鼭 ũ�� 20 ���� �����Ͻÿ�.

ALTER TABLE TB_CLASS_TYPE
    MODIFY NO VARCHAR2(10)
    MODIFY NAME VARCHAR2(20);
    
ALTER TABLE TB_CATEGORY
    MODIFY NAME VARCHAR2(20);
    
-- 6. �� ���̺��� NO �÷��� NAME �÷��� �̸��� �� �� TB_ �� ������ ���̺� �̸��� 
    -- �տ� ���� ���·� ��������.        (ex. CATEGORY_NAME)
SELECT * FROM TB_CATEGORY;
ALTER TABLE TB_CATEGORY RENAME COLUMN GATEGORY_NAME TO CATEGORY_NAME;
                                        --> ��Ÿ�� ���� �� ����..
SELECT * FROM TB_CLASS_TYPE;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NAME TO CLASS_TYPE_NAME;

-- 7. TB_CATAGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ���� �����Ͻÿ�.
    -- Primary Key �� �̸��� ?PK_ + �÷��̸�?���� �����Ͻÿ�. (ex. PK_CATEGORY_NAME)
ALTER TABLE TB_CATEGORY RENAME CONSTRAINT NAME_PK TO PK_CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT NO_PK TO PK_CLASS_TYPE_NO;


-- 8. ������ ���� INSERT ���� ��������.

INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����','Y');
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y');
COMMIT; 

-- 9.TB_DEPARTMENT �� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� 
  -- �θ� ������ �����ϵ��� FOREIGN KEY �� �����Ͻÿ�. �� �� KEY �̸���
  -- FK_���̺��̸�_�÷��̸����� ��������. (ex. FK_DEPARTMENT_CATEGORY )
  
ALTER TABLE TB_DEPARTMENT ADD FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);
    --�������� �� ���� ���� �ʾ� ����
ALTER TABLE TB_DEPARTMENT RENAME  CONSTRAINT SYS_C007079 TO FK_DEPARTMENT_CATEGORY;

-- 10. �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW �� ������� ����. 
    -- �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.




 --================================DML ����======================================
 --================================DML ����======================================
 --================================DML ����======================================
 --================================DML ����======================================
 --================================DML ����======================================

-- 1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�.
INSERT INTO TB_CLASS_TYPE VALUES (01, '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES (02, '��������');
INSERT INTO TB_CLASS_TYPE VALUES (03, '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES (04, '���缱��');
INSERT INTO TB_CLASS_TYPE VALUES (05, '������');

-- 2. �� ������б� �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺��� ������� ����. 
  -- �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�) 
CREATE TABLE TB_�л��Ϲ����� ADD COLUMN �й� ;
