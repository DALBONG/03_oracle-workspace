-- 3. �������� 25�� �̻��� å ��ȣ�� �������� ȭ�鿡 ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT BOOK_NO, BOOK_NM
FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >= 25;

-- 4. �޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� �� ���� ���� ǥ�õǴ� 
    -- �۰� �̸��� �繫�� ��ȭ��ȣ, �� ��ȭ��ȣ, �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
  FROM TB_WRITER 
 WHERE MOBILE_NO LIKE '019%'
   AND WRITER_NM LIKE '��%'
 ORDER BY WRITER_NM;
 
SELECT ROWNUM, WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
  FROM (SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
          FROM TB_WRITER 
         WHERE MOBILE_NO LIKE '019%'
           AND WRITER_NM LIKE '��%'
         ORDER BY WRITER_NM)
 WHERE ROWNUM =1;
 
-- 5. ���� ���°� ���ű衱�� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
  --  (��� ����� ���۰�(��)������ ǥ�õǵ��� �� ��)
SELECT COUNT(DISTINCT(WRITER_NO))|| '��' "�۰�(��)"
  FROM TB_BOOK_AUTHOR
 WHERE COMPOSE_TYPE = '�ű�';

-- 6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
  -- (���� ���°� ��ϵ��� ���� ���� ������ ��)
  
SELECT COMPOSE_TYPE, COUNT(*)
  FROM TB_BOOK_AUTHOR 
 WHERE COMPOSE_TYPE IS NOT NULL 
HAVING COUNT(*) >= 300
 GROUP BY COMPOSE_TYPE;
 
-- 7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT BOOK_NM, ISSUE_DATE, RANK() OVER(ORDER BY ISSUE_DATE DESC) "ž�߰�", PUBLISHER_NM
  FROM TB_BOOK;
  
SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
  FROM (SELECT BOOK_NM, ISSUE_DATE, RANK() OVER(ORDER BY ISSUE_DATE DESC) "ž�߰�", PUBLISHER_NM
          FROM TB_BOOK)
 WHERE ž�߰� = 1;


-- 8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
   -- ��, ��������(��٣���) �۰��� ���ٰ� �����Ѵ�. (��� ����� ���۰� �̸���, ���� ������ ǥ�õǵ��� �Ұ�)
SELECT WRITER_NM "�۰�", COUNT(BOOK_NO) "��" 
  FROM TB_WRITER W, TB_BOOK_AUTHOR BA
 WHERE W.WRITER_NO = BA.WRITER_NO
 GROUP BY WRITER_NM
 ORDER BY COUNT(BOOK_NO) DESC;
 
SELECT �۰�_�̸�, ��_��
  FROM (SELECT WRITER_NM "�۰�_�̸�", COUNT(BOOK_NO) "��_��" 
          FROM TB_WRITER W, TB_BOOK_AUTHOR BA
         WHERE W.WRITER_NO = BA.WRITER_NO
         GROUP BY WRITER_NM
         ORDER BY COUNT(BOOK_NO) DESC)
 WHERE ROWNUM IN (1, 2, 3); 
   

-- 9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ���. ������ ������� ���� 
   -- �� �۰��� ������ ���ǵ����� �����ϰ� ������ ��¥���� �����Ű�� SQL ������ �ۼ��Ͻÿ�. (COMMIT ó���� ��)

SELECT WRITER_NM, MIN(ISSUE_DATE) "���ʹ�����"
  FROM TB_WRITER
  JOIN TB_BOOK_AUTHOR USING (WRITER_NO)
  JOIN TB_BOOK USING (BOOK_NO)
 GROUP BY WRITER_NM;
 
UPDATE TB_WRITER W
   SET REGIST_DATE = (SELECT MIN(B.ISSUE_DATE)
                        FROM TB_BOOK_AUTHOR BA
                        JOIN TB_BOOK B USING (BOOK_NO)
                       WHERE BA.WRITER_NO = W.WRITER_NO
                      );
 
 SELECT REGIST_DATE FROM TB_WRITER;

COMMIT;

   
-- 10. ���� �������� ���� ���̺��� ������ �������� ���� ���� �����ϰ� �ִ�. �����δ� �������� ���� �����Ϸ��� �Ѵ�. 
   -- ���õ� ���뿡 �°� ��TB_BOOK_ TRANSLATOR�� ���̺��� �����ϴ� SQL ������ �ۼ��Ͻÿ�.
   -- (Primary Key ���� ���� �̸��� ��PK_BOOK_TRANSLATOR���� �ϰ�, Reference ���� ���� �̸���
   -- ��FK_BOOK_TRANSLATOR_01��, ��FK_BOOK_TRANSLATOR_02���� �� ��)

CREATE TABLE TB_BOOK_TRANSLATOR
    (
     BOOK_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_01 REFERENCES TB_BOOK(BOOK_NO)
     , WRITER_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_02 REFERENCES TB_WRITER(WRITER_NO)
     , TRANS_LANG VARCHAR2(60)
     , CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY (BOOK_NO, WRITER_NO)
     );
 
 COMMENT ON COLUMN TB_BOOK_TRANSLATOR.BOOK_NO IS '���� ��ȣ';
 COMMENT ON COLUMN TB_BOOK_TRANSLATOR.WRITER_NO IS '�۰� ��ȣ';
 COMMENT ON COLUMN TB_BOOK_TRANSLATOR.TRANS_LANG IS '���� ���';
 
 
-- 11. ���� ���� ����(compose_type)�� '�ű�', '����', '��', '����'�� �ش��ϴ� �����ʹ�
  -- ���� ���� ���� ���̺��� ���� ���� ���� ���̺�(TB_BOOK_ TRANSLATOR)�� �ű�� SQL
  -- ������ �ۼ��Ͻÿ�. ��, ��TRANS_LANG�� �÷��� NULL ���·� �ε��� �Ѵ�.    
 -- (�̵��� �����ʹ� �� �̻� TB_BOOK_AUTHOR ���̺� ���� ���� �ʵ��� ������ ��)
 /*
 UPDATE TB_BOOK_TRANSLATOR
    SET (BOOK_NO, WRITER_NO) = (SELECT BOOK_NO, WRITER_NO
                              FROM TB_BOOK_AUTHOR 
                             WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����'));
*/
INSERT INTO TB_BOOK_TRANSLATOR (BOOK_NO, WRITER_NO)(SELECT BOOK_NO, WRITER_NO
                                                  FROM TB_BOOK_AUTHOR 
                                                 WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����'));

SELECT *
  FROM TB_BOOK_TRANSLATOR;

        
DELETE FROM TB_BOOK_AUTHOR
 WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����');

SELECT BOOK_NO, WRITER_NO
FROM TB_BOOK_AUTHOR 
WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����');
                 
                 
 -- 12. 2007�⵵�� ���ǵ� ������ �̸��� ������(����)�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT BOOK_NM, WRITER_NM
  FROM TB_BOOK B, TB_BOOK_TRANSLATOR BT, TB_WRITER W
 WHERE B.BOOK_NO = BT.BOOK_NO
   AND W.WRITER_NO = BT.WRITER_NO
   AND EXTRACT(YEAR FROM ISSUE_DATE) = 2007;
 
 -- 13. 12�� ����� Ȱ���Ͽ� ��� ���������� �������� ������ �� ������ �ϴ� �並 �����ϴ�
   -- SQL ������ �ۼ��Ͻÿ�. (�� �̸��� ��VW_BOOK_TRANSLATOR���� �ϰ� 
   -- ������, ������, �������� ǥ�õǵ��� �� ��)

--GRANT CREATE VIEW TO final;
   
CREATE VIEW VW_BOOK_TRANSLATOR AS 
SELECT BOOK_NM, WRITER_NM, ISSUE_DATE 
  FROM (SELECT BOOK_NM, WRITER_NM, ISSUE_DATE
          FROM TB_BOOK B, TB_BOOK_TRANSLATOR BT, TB_WRITER W
         WHERE B.BOOK_NO = BT.BOOK_NO
           AND W.WRITER_NO = BT.WRITER_NO
           AND EXTRACT(YEAR FROM ISSUE_DATE) = 2007);
           
SELECT * FROM VW_BOOK_TRANSLATOR;

 -- 14. ���ο� ���ǻ�(�� ���ǻ�)�� �ŷ� ����� �ΰ� �Ǿ���. ���õ� ���� ������ �Է��ϴ� 
   -- SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
   -- ���ǻ� : �� ���ǻ�     /    �繫�� ��ȭ��ȣ : 02-6710-3737     / �ŷ�����  DEFAULT ��.
   
INSERT INTO TB_PUBLISHER VALUES ('�� ���ǻ�', '02-6710-3737', DEFAULT);

SELECT * FROM TB_PUBLISHER;
 
 -- 15. ��������(��٣���) �۰��� �̸��� ã������ �Ѵ�. �̸��� �������� ���ڸ� ǥ���ϴ� 
   -- SQL ������ �ۼ��Ͻÿ�.

SELECT W.WRITER_NM, COUNT(*)
  FROM TB_WRITER W, TB_WRITER WB
 WHERE W.WRITER_NM = WB.WRITER_NM
   AND W.WRITER_NO != WB.WRITER_NO
 GROUP BY W.WRITER_NM;
 
 -- 16. ������ ���� ���� �� ���� ����(compose_type)�� ������ �����͵��� ���� �ʰ� �����Ѵ�. 
   -- �ش� �÷��� NULL�� ��� '����'���� �����ϴ� SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
UPDATE TB_BOOK_AUTHOR
   SET COMPOSE_TYPE = '����'
 WHERE COMPOSE_TYPE IS NULL;
 
SELECT COMPOSE_TYPE
  FROM TB_BOOK_AUTHOR
 WHERE COMPOSE_TYPE IS NOT NULL;
 
 COMMIT;

 -- 17. �������� �۰� ������ �����Ϸ��� �Ѵ�. �繫���� �����̰�, 
   -- �繫�� ��ȭ ��ȣ ������ 3�ڸ��� �۰��� �̸��� �繫�� ��ȭ ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT WRITER_NM, OFFICE_TELNO
  FROM TB_WRITER
 WHERE OFFICE_TELNO LIKE '02%'
   AND OFFICE_TELNO LIKE '%-___-%'; 

   
   
-- 18. 2006�� 1�� �������� ��ϵ� �� 31�� �̻� �� �۰� �̸��� �̸������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT WRITER_NM, MONTHS_BETWEEN('06/01/01', REGIST_DATE)
  FROM TB_WRITER
 WHERE MONTHS_BETWEEN('06/01/01', REGIST_DATE) >= 372
 ORDER BY WRITER_NM ASC;
 
SELECT WRITER_NM
  FROM (SELECT WRITER_NM, MONTHS_BETWEEN('06/01/01', REGIST_DATE)
          FROM TB_WRITER
         WHERE MONTHS_BETWEEN('06/01/01', REGIST_DATE) >= 372
         ORDER BY WRITER_NM ASC);  --> �켱... 10�� ���� �� ����... 16���� ���Ŀ�..


-- 19. ���� ��� �ٽñ� �α⸦ ��� �ִ� 'Ȳ�ݰ���' ���ǻ縦 ���� ��ȹ���� ������ �Ѵ�. 
  -- 'Ȳ�ݰ���' ���ǻ翡�� ������ ���� �� ��� ������ 10�� �̸��� ������� ����, �����¸� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. 
  -- ��� ������ 5�� �̸��� ������ ���߰��ֹ��ʿ䡯��, �������� ���ҷ��������� ǥ���ϰ�, 
  -- �������� ���� ��, ������ ������ ǥ�õǵ��� �Ѵ�.
SELECT BOOK_NM "������"
       , PRICE "����"
       , CASE WHEN STOCK_QTY < 5 THEN '�߰��ֹ� �ʿ�'
              ELSE '�ҷ� ����'
         END "������"
  FROM TB_BOOK
 WHERE PUBLISHER_NM = 'Ȳ�ݰ���'
   AND STOCK_QTY < 10
 ORDER BY STOCK_QTY DESC, ������ ASC;
 
-- 20. '��ŸƮ��' ���� �۰��� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. 
   -- (��� ����� ��������,�����ڡ�,�����ڡ��� ǥ���� ��)
SELECT BOOK_NO
  FROM TB_BOOK
 WHERE BOOK_NM = '��ŸƮ��';

SELECT *
  FROM TB_BOOK_AUTHOR
 WHERE BOOK_NO = (SELECT BOOK_NO
                  FROM TB_BOOK
                 WHERE BOOK_NM = '��ŸƮ��');
   


-- 21. ���� �������� ���� �����Ϸκ��� �� 30���� ����ǰ�, ��� ������ 90�� �̻��� ������ ���� 
   -- ������, ��� ����, ���� ����, 20% ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. 
   -- (��� ����� ��������, ����� ������, ������(Org)��, ������(New)���� ǥ���� ��. 
   -- ��� ������ ���� ��, ���� ������ ���� ��, ������ ������ ǥ�õǵ��� �� ��)
SELECT BOOK_NM "������", STOCK_QTY "������", PRICE "����(Org)", PRICE*0.8 "����(New)"
  FROM TB_BOOK
 WHERE STOCK_QTY >= 90
HAVING MONTHS_BETWEEN(SYSDATE, MIN(ISSUE_DATE)) >= 360
 GROUP BY BOOK_NM, STOCK_QTY, PRICE
 ORDER BY ������ DESC, '����(New)' DESC, ������ ASC;  ---> ��.. �ð��� �����Ƿ� �ϴ�... 
 
 
 
 
 
 
 