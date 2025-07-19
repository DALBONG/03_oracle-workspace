-- ������
--1. ���� �� ���� �ݾװ� ���� �Ǽ��� ��ȸ(��ID, �� �̸�, �� ���� �Ǽ�, �� ���� �ݾ��� ����ϰ� �� ���� �ݾ��� ���� ������ ����)	
SELECT CUSTOMID, NAME, SUM(PRICE) "���űݾ�", COUNT(BUY_IDX) "���ŰǼ�"
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
 GROUP BY NAME, CUSTOMID
 ORDER BY ���űݾ� DESC;
--2. 23�⿡ ���Ű� �̷���� ��� ��ǰ�� ������ �ش� ���� �̸��� ��ȸ 
  --(�ߺ����� �� ���� �Ǹ��� �� �پ� ��µǵ��� �ϸ� ������ ���� �������� ����)
SELECT B.PCODE "��ǰ�ڵ�", PNAME "��ǰ��", PRICE "��ǰ����", NAME
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EXTRACT (YEAR FROM BUY_DATE) = 2023;
  

-- ���ش�
--1. �̸��� @���ڸ��� m�� ���� ������ �̸��� ������ �� ������ �̸� �� ���������� ��ȸ�Ͻÿ�.(�̸����� ������������ ����)	
SELECT NAME, PNAME, SUM(PRICE)
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EMAIL LIKE 'm%'
   GROUP BY NAME, PNAME;
   
--2. ��ǰ��ȣ�� 7�ڸ��� ������ ������ ������ �̸��� ���� �⵵ �� ��ǰ�� �̸��� ��ȸ�Ͻÿ�.	
SELECT NAME, EXTRACT(YEAR FROM BUY_DATE) "���ų⵵", PNAME "��ǰ��"
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND B.PCODE LIKE '_______';

-- ������ 
--1. 23�⵵��  ����� ������ ���� �̸��� �̸����� ���ϼ���	
SELECT NAME, EMAIL
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EXTRACT(YEAR FROM BUY_DATE) = 2023
   AND PNAME LIKE '%���%';
   
--2. �� �ȸ� �ݾ��� ���� ���� ��ǰ��� �ȸ� �ݾ��� ���ϼ���
SELECT PNAME, �ְ����
  FROM (SELECT PNAME, MAX(QUANTITY*PRICE) "�ְ����", RANK()OVER(ORDER BY MAX(QUANTITY*PRICE) DESC) "�ְ�������"
          FROM TBL_BUY B, TBL_PRODUCT P
         WHERE B.PCODE = P.PCODE
         GROUP BY PNAME)
  WHERE �ְ������� = 1;

-- ������ 
--1. �̸����� daum����  ���� �ʴ� ������� ��� ���̸� ���Ͻÿ� ( ���̰� 0�� ��� ����)
SELECT AVG(AGE)
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EMAIL NOT LIKE '%daum%'
   AND AGE != 0;

--2. ȫ�浿���� �ڸ�𾾰� ��� ���ΰ����� �Ѵ� �� Ŀ���� ���� �Ѿ��� ? (IN�� Ȱ��)	
SELECT SUM(PRICE)
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND NAME IN ('ȫ�浿', '�ڸ��');

-- ������ 
--1. ����, ��ǰ�� ���� ���űݾ�, �� ���űݾ��� ��ȸ�ϼ���.(��, ��ǰ�� ���� ���� �ݾ��� 20000�� �̻� ��ȸ)	
SELECT ����_��_�ݾ�, ��ǰ��_��_�ݾ�
FROM (SELECT NAME ||' '|| SUM(PRICE) "����_��_�ݾ�"
          FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
         WHERE B.CUSTOMID = C.CUSTOM_ID
           AND B.PCODE = P.PCODE
           AND PRICE > 20000
         GROUP BY NAME)
         , (SELECT PNAME ||' '|| SUM(PRICE) "��ǰ��_��_�ݾ�"
          FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
         WHERE B.CUSTOMID = C.CUSTOM_ID
           AND B.PCODE = P.PCODE
           AND PRICE > 20000
         GROUP BY PNAME);
 
--2. CATEGORY�� 'B1'�� ��ǰ�� ������ ���� �̸�, ��ǰ��, ����, ���ų�¥�� ��ȸ�ϼ���.(��, ���ų�¥�� �ֽ��ΰͺ��� ���)	
SELECT NAME, PNAME, QUANTITY "���ż���", BUY_DATE "���ų�¥"
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
AND B.PCODE = P.PCODE
AND CATEGORY = 'B1'
ORDER BY BUY_DATE DESC;


-- ���ϴ�
--1. "2024�� 2�� 10��, ī�װ����� 'B'�� �����ϴ� ��ǰ���� �߾Ϲ����� �߰ߵǾ���. 
    --�̿� ���� �ش� ��ǰ�� ���� �����Ϸκ��� 2���� �̳��� �ش��ϴ� ���Űǿ� ���� ������ ����Ǿ���. 
    --������ ���Ź�ȣ�� 10,000��, ��ǰ ������ 2,000���� ���� ��� ���, �׸��� ��ǰ ������ ȯ�ҷ� �����ȴ�. 
    --�� ��ǿ� �ش��ϴ� ��ǰ����  **��ǰ�� �ս� �ݾ�(���� + ȯ�� + ��� ���)**�� ����� ��, 
    --�ս� �ݾ��� ���� ū ���� 2�� ��ǰ�� '��ǰ��'�� '�ս� �ݾ�'�� '�ս� �ݾ��� ū ��'���� ����Ͻÿ�."
SELECT PNAME "�߾�_��ǰ", ǰ��_�ս�_�ݾ�
FROM (SELECT PNAME, SUM((PRICE*QUANTITY) + (SUBSTR(CATEGORY, 2, 1) * 10000) + (QUANTITY*2000)) "ǰ��_�ս�_�ݾ�", RANK() OVER(ORDER BY SUM((PRICE*QUANTITY) + (SUBSTR(CATEGORY, 2, 1) * 10000) + (QUANTITY*2000)) DESC) "�սǾ�_����"
        FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
        WHERE B.CUSTOMID = C.CUSTOM_ID
        AND B.PCODE = P.PCODE
        AND CATEGORY LIKE 'B%'
        GROUP BY PNAME)
WHERE �սǾ�_���� IN (1, 2);

--2. "������(1�Ϻ��� ����)�κ��� ���� ��� ���� �ݾ��� ���� ���� �� �� 1���� 
    --'�̸�'�� �� ��� ���� �ݾ��� (����)1���� �Ǳ� ���� '�����ؾ��� �ݾ�'�� ����ϼ���."	
    
  
-- ������    
--1. 23�⿡ ��ǰ�� �� ����� �̸��� ������ ��ǰ�� ������ ���
SELECT NAME, PNAME, QUANTITY
    FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
    WHERE B.CUSTOMID = C.CUSTOM_ID
    AND B.PCODE = P.PCODE
    AND EXTRACT(YEAR FROM BUY_DATE) = 2023;
--2. ������ �� ��ǰ�� Ȯ���� �� �ֵ��� ����, ��ǰ�̸�, ����, ���Գ�¥�� VIEW�� ���
    -- (�� �̸� VW_TBL, ���Գ�¥ ����� 0000��, 00��, 00��)							
/*    
CREATE VIEW VW_TBL
AS SELECT NAME, PNAME, QUANTITY, BUY_DATE
     FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
    WHERE B.CUSTOMID = C.CUSTOM_ID
      AND B.PCODE = P.PCODE;
*/
SELECT * FROM VW_TBL;
    
-- ���ƴ�			
--1. 2023�⿡ �Ǹŵ��� �ʴ� ��ǰ�� ��ǰ�ڵ������ �����Ͽ� ����Ѵ�.
SELECT B.PCODE, PNAME
    FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
    WHERE B.CUSTOMID = C.CUSTOM_ID
    AND B.PCODE = P.PCODE
    AND EXTRACT(YEAR FROM BUY_DATE) != 2023
    ORDER BY B.PCODE ASC;
--2. ���Ź�ȣ�� ¦���� �ŷ� ������ �������, �� ��ǰ�� �Ǹ� ������ 
    -- ��ü �Ǹŷ����� �����ϴ� ������ ����Ͽ� ����Ѵ�.	
SELECT SUM(PRICE*QUANTITY) "¦��_�Ǹ�_����"
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND SUBSTR(BUY_IDX, 4, 1) IN (2, 4, 6, 8, 0);
   
SELECT SUM(PRICE*QUANTITY) "��ü_�Ǹ�_����"
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE;
   
SELECT ROUND(¦��_�Ǹ�_����/��ü_�Ǹ�_����*100, 1) "¦��_�Ǹ���"
  FROM (SELECT SUM(PRICE*QUANTITY) "��ü_�Ǹ�_����"
          FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
         WHERE B.CUSTOMID = C.CUSTOM_ID
           AND B.PCODE = P.PCODE)
      ,(SELECT SUM(PRICE*QUANTITY) "¦��_�Ǹ�_����"
          FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
         WHERE B.CUSTOMID = C.CUSTOM_ID
           AND B.PCODE = P.PCODE
           AND SUBSTR(BUY_IDX, 4, 1) IN (2, 4, 6, 8, 0));
   
-- ������						
--1. �������� 2021���� ������� ������ ��ǰ�� �ݾ��� ������ ���Ͻÿ�. (������ ������������ �����Ѵ�.)
SELECT PNAME, SUM(PRICE*QUANTITY) "��ǰ��_�ݾ�_����"
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EXTRACT(YEAR FROM REG_DATE) = 2021
 GROUP BY PNAME
 ORDER BY ��ǰ��_�ݾ�_���� DESC;
   
--2. �Ϸ翡 ��ǰ�� 3�� �̻� ������ ������ �ִ� ������� ��� ���̸� ���Ͻÿ� (���������� �̿�)	
SELECT AVG(AGE)
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE 
   AND 3 <= ANY (SELECT QUANTITY
               FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
              WHERE B.CUSTOMID = C.CUSTOM_ID
                AND B.PCODE = P.PCODE);

-- �����
--1. TBL_BUY ���̺��� 2024�� 1�� 1�� ���Ŀ� ������ �� ��. ���� ���� ������ 3�� �̻��� ���� 
    -- CUSTOMID, �� �̸�(NAME), �ش� ���� ������ ��ǰ ���� ��(�ߺ� ���� ��ǰ ����)�� ����Ͻÿ�. 
    -- (��, ���� ���� ���� ������������ ������ ��)"					
--2. TBL_CUSTOM ���̺��� ����(AGE)�� 30�� �̻��� �� ��. 
    -- �̸��� �ּҰ� ''korea.com' �������� �����ϴ� ���� 
    -- CUSTOM_ID, NAME, EMAIL, AGE�� �ش� ������ �ֱ� ������ ��¥(BUY_DATE)�� ����ϰ�, 
    -- ���� ���� ����� ������ '���ű�Ͼ���'���� ǥ���Ͻÿ�. 
    -- (�� ����� ���� ��������, �̸� ������������ ������ ��)	
SELECT CUSTOMID, NAME, EMAIL, AGE, BUY_DATE
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND AGE >= 30
   AND EMAIL LIKE '%korea.com%'
   ORDER BY AGE DESC, NAME ASC;

-- ��������
--1. ���� �����̷��� ����, 23�⵵�� ������ ������ ������ ������� ����ϼ��� . ��) 23�⵵ �� ��?
SELECT COUNT(NAME)||'��' "23�� ���� ���"
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EXTRACT(YEAR FROM BUY_DATE) = 2023;

--2. ���� ǰ�� �� û�ۻ�� 5kg, ���ż��� 2��, ���� 20���� ������ ����ϼ���.	
SELECT NAME
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND PNAME LIKE '%û�ۻ��%'
   AND QUANTITY = 2
   AND AGE = 20;
		
-- �켮��
--1. ���� ȸ�������� �ϸ�, �����Ϸκ��� 30�� �̳��� ����� �� �ִ� ���������� 1�� �ڵ����� �߱޵ǰ�, 
  -- �ش� ������ ���� �� �ڵ����� ����ȴٰ� �����Ѵ�.  
  -- �� ���ǿ� ����, ���� �� 30�� �̳��� ��ǰ�� �����Ͽ� ������ ����� ������ ID�� �ߺ� ���� ��ȸ�Ͻÿ�.
SELECT DISTINCT(CUSTOMID)
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND MONTHS_BETWEEN(BUY_DATE, REG_DATE) <= 1;
    
--2. ���̵� ���� �� ����� ������(���� �� ���̵� ���� ����� �Ѹ� �ִٰ� ����) ��ǰ�� �� ������ ���Ͻÿ�.
SELECT CUSTOMID, ��_���̵�, ����_��ǰ_�Ѱ���
  FROM (SELECT CUSTOMID, LENGTH(CUSTOMID) "��_���̵�", RANK() OVER(ORDER BY LENGTH(CUSTOMID) DESC) "��_���̵�_����", PRICE*QUANTITY "����_��ǰ_�Ѱ���"
          FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
         WHERE B.CUSTOMID = C.CUSTOM_ID
           AND B.PCODE = P.PCODE)
 WHERE ��_���̵�_���� IN 1;
        					
-- ���ش�                         		
--1. �̸����� ������ ���� ���� �̸�, ������ ��ǰ��, �� ��ǰ�� ���� ������ ��ȸ�ϼ���. 
  -- (�̸����� ������ ����)
SELECT NAME, PNAME, QUANTITY
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EMAIL LIKE '%daum%';
--2. ���̰� 0��� ������ ����� ���̸� 24��� ��ġ����.
SELECT AGE, NAME
  FROM TBL_CUSTOM
 WHERE AGE = 0;
 
 UPDATE TBL_CUSTOM
    SET AGE = 24
  WHERE AGE = 0; 
  
  SELECT *
    FROM TBL_CUSTOM;
-- ��ȫ��
--1. 2022�� Ȥ�� 2024�⿡ ������ ������ ���� �̸� �� ��ǰ�� �����Ͻÿ�
SELECT NAME, PNAME--, BUY_DATE
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EXTRACT(YEAR FROM BUY_DATE) IN (2022, 2024);
--2. ī�װ��� 'A'�� �����ϴ� ������ ������ ���� �̸��� ��ǰ���� ����ϼ���.
SELECT NAME, PNAME--, CATEGORY
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND CATEGORY LIKE 'A%';

-- ������
--1. ���� �ֱٿ� ������ ��ǰ�� ��ǰ��� ������ �̸�, �������� ��ȸ�ϼ���.
SELECT ��ǰ��, ������, ������
  FROM (SELECT PNAME "��ǰ��", NAME "������", RANK()OVER (ORDER BY BUY_DATE DESC)"�ֱ�_���ż�", BUY_DATE "������"
          FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
         WHERE B.CUSTOMID = C.CUSTOM_ID
           AND B.PCODE = P.PCODE)
 WHERE �ֱ�_���ż� IN 1;

--2. �� ��ǰ�� ��� ���� ������ ���ϰ�, �� ����� 2�� �̻��� ��ǰ�� ��ǰ�ڵ�, ��ǰ��� �Բ� ����ϼ���.	
 SELECT ��ǰ�ڵ�, ��ǰ��
   FROM (SELECT PNAME "��ǰ��", AVG(QUANTITY) "���ż���", B.PCODE "��ǰ�ڵ�"
           FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
          WHERE B.CUSTOMID = C.CUSTOM_ID
            AND B.PCODE = P.PCODE
          GROUP BY PNAME, B.PCODE) -- ��, ��ġ, ����, �޹�, ����, �ָ�
  WHERE ���ż��� >= 2;

-- ������
--1. 24�⵵ ������ ������ ���� �� �ѱ��ż����� ���� ���� ���� 
  -- �̸�, �̸���, �ѱ��Ű���, �ѱ��ż����� ����ϼ���.							
--2. ���� �ѱ��ż����� ���� ������� ���� �̸�, ����, �ѱ��ż���, �ѱ��Ű����� ����ϼ���.
    --(���ϰ� �ߺ����� �ο� �� ���������� �ߺ������� ������� ���������� ���� �ο�) 

-- ���δ�
--1. ��ǰ �ڵ忡 N�� ���� ��ǰ�� �з��ϰ� �� ��ǰ�� �� ������ ��ǰ ������ �������ּ���.(��ǰ��, ����, ��ǰ���� ����)							
--2. �� ���� ������ 10���� �̻��� ������� �̸��� �̸��� �ּҸ� ���ϼ���.				

   




