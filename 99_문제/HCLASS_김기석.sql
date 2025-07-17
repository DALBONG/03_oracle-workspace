SELECT * FROM TBL_BUY;
SELECT * FROM TBL_CUSTOM;
SELECT * FROM TBL_PRODUCT;
/*
COMMENT ON COLUMN TBL_BUY.BUY_IDX IS '�����ڵ�';COMMENT ON COLUMN TBL_BUY.CUSTOMID IS '�����ھ��̵�';COMMENT ON COLUMN TBL_BUY.PCODE IS '�����ڵ�';COMMENT ON COLUMN TBL_BUY.QUANTITY IS '���ż���';COMMENT ON COLUMN TBL_BUY.BUY_DATE IS '���ų�¥';COMMENT ON COLUMN TBL_CUSTOM.CUSTOM_ID IS 'ȸ�����̵�';COMMENT ON COLUMN TBL_CUSTOM.NAME IS 'ȸ���̸�';COMMENT ON COLUMN TBL_CUSTOM.EMAIL IS 'ȸ���̸���';COMMENT ON COLUMN TBL_CUSTOM.AGE IS 'ȸ������';COMMENT ON COLUMN TBL_CUSTOM.REG_DATE IS '�ֹ���¥';COMMENT ON COLUMN TBL_PRODUCT.PCODE IS '��ǰ�ڵ�';COMMENT ON COLUMN TBL_PRODUCT.CATEGORY IS '��ǰ����';COMMENT ON COLUMN TBL_PRODUCT.PNAME IS '��ǰ��';COMMENT ON COLUMN TBL_PRODUCT.PRICE IS '��ǰ����';
*/
---------------------------------------------------------------------------------

/* A��  */
--A-1. 'mina012' �� ������ ��ǰ �ݾ� �հ�(�̱���)
SELECT SUM(PRICE) "mina012 ���� ��ǰ �Ѿ�"
FROM TBL_BUY B, TBL_PRODUCT P
WHERE B.PCODE = P.PCODE;
	  

--A-2. �̸��� '�浿'�� ���� ȸ�� ������ ��ǰ ������Ȳ (������)
-- ������ �߰� �� �����ϼ���.
SELECT NAME, PNAME
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
  AND NAME LIKE '%�浿%';

			
--A-3. `25��`�̻� ���Ե��� `����`�� `��ǰ��` ��ȸ�ϱ� (������) => ���̺� 3��
SELECT NAME "25���̻� ��", PNAME "���� ��ǰ"
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
  AND AGE >= 25;
		

--A-4. ��ǰ�� '���' �ܾ ���Ե� ��ǰ�� ������ ���� ���� ��ǰ�� ���űݾ��� ���� ���ϱ�.(�����)
SELECT PNAME "ǰ��", SUM(PRICE)
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
GROUP BY PNAME
HAVING PNAME LIKE '%���%';


--A-5. �� �����ջ� �ݾ��� 100000~200000 ���� �� ID�� ��ȸ�Ͻÿ�.(���¿�)
SELECT CUSTOMID "10~20 ������ ID"
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
  AND (QUANTITY * PRICE) BETWEEN 100000 AND 200000;


/*  B�� */
--B-1. 20�� ���� ���� ���� ��ǰ �ڵ�� ���̸� ���̼����� ���� ��ȸ (�̴�ȯ)
SELECT PCODE "���� ��ǰ �ڵ�", NAME "�̸�", AGE "����"
  FROM TBL_BUY B, TBL_CUSTOM C
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND AGE LIKE '2%'
 ORDER BY ���� ASC;

--B-2. ���̰� ���� ���� ���� ��ǰ�� ������ Ƚ���� ��ȸ�ϼ���.-�������� ����ϱ� (�����)  
SELECT COUNT(PCODE), MAX(AGE)
  FROM TBL_BUY B, TBL_CUSTOM C
 WHERE B.CUSTOMID = C.CUSTOM_ID
 GROUP BY PCODE;
 
 SELECT MAX(AGE)
 FROM TBL_CUSTOM;
--B-3. 2023�� �Ϲݱ� ���űݾ��� ��ID���� ��ȸ�Ͻÿ�. �ݾ��� ���� �������� ��ȸ�ϼ���. (����)




--B-4. 2024�⿡ ����Ƚ���� 1ȸ �̻��� ��id, ���̸�, ����,�̸����� ��ȸ�ϼ���.(������)


--B-5. ����-��ǰ�� ���űݾ��� ��ȸ�ϼ���. ���ĵ� ��ID,��ǰ�ڵ� ������������ �����ϼ���.(�̿���)




/* C�� */
--C-1. ���� 1���� �̻��� ��ǰ�� ���� ���� ������ ������ ��� ������ ����Ͻÿ�.��ǰ�ڵ� ������ ���� (������)

	 
--C-2. ������� ������ ���� �̸�, ���ż���, ���ų�¥�� ��ȸ����. (������ : ������)


--C-4. 2023�⿡ �ȸ� ��ǰ�� �̸��� �ڵ�, �� �Ǹž� �׸��� �� �ǸŰ����� ��ǰ�ڵ� ������ �����Ͽ� ��ȸ�Ͻÿ�. (������)


--C-5. 'twice'�� 'hongGD'�� ������ ��� �ֽ��ϴ�. �̵��� ������ ��ǰ,����,������ ��ȸ�ϼ���.-������ ������������ ���� (�强��)



/* D�� */
--D-1. ������� ���� ���� ������ ȸ���� ���űݾ��� ���� ������ ȸ�����̵�� �� ����� ���űݾ��� �����ּ���.(���Ͽ�)
-- �� �������� ���� ���θ� ���


 
--D-2. �Ǹ� ������ ���� ���� ������ ��ǰ �� �����ϰ� �� �ȸ� �ݾ��� ����Ͻÿ�.(������)
-- 	   �Ǹ� ������ ������ ��ǰ �ڵ� ������ �����մϴ�.			�� ���� �������� ��ȸ




--D-3. ������� ������ ������ ��� ���̸� ��ǰ�ڵ�(PCODE)�� �Բ������ �ּ���.(Ȳ����)


--D-4. 30�� �̸� ȸ���� ���űݾ��� ���ϰ� ȸ������ �׷�����ؼ� ���űݾ� �հ谡 ū ������ ����(������)
-- 						�� 3���� ���̺� ����





-- ȫ�浿���� ���ֵ��� �����մϴ�. ��� ǰ�� ����, �갣 ������ �ֹ��� 10�� �Ŀ� ��۵Ǿ��� ������,
 -- ȫ�浿���� �ֹ��� ��ǰ���� ��۹��� ��¥, ��ǰ���� ã�ƺ��ö�.(2��).
 -- ��, �⵵ ���� '-�� -��'�� ���� �� �ְ��Ѵ�.
 
SELECT EXTRACT(MONTH FROM(BUY_DATE + 10)) ||'��'|| EXTRACT(DAY FROM(BUY_DATE + 10))||'��' "��۳�¥", PNAME "��ǰ��"
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
  AND NAME = 'ȫ�浿';
  
  
-- �⵵�� �� ��ǰ�� �� ������ ���ϰ�, ��ü ȿ�� ��ǰ�� ��ü ���� ��ǰ�� �ݾ� ���̸� ���Ͻÿ�


