-- ȫ�浿���� ���ֵ��� �����մϴ�. ��� ǰ�� ����, �갣 ������ �ֹ��� 10�� �Ŀ� ��۵Ǿ��� ������,
 -- ȫ�浿���� �ֹ��� ��ǰ���� ��۹��� ��¥, ��ǰ���� ã�ƺ��ö�.(2��).
 -- ��, �⵵ ���� '-�� -��'�� ���� �� �ְ��Ѵ�.
 
SELECT EXTRACT(MONTH FROM(BUY_DATE + 10)) ||'��'|| EXTRACT(DAY FROM(BUY_DATE + 10))||'��' "��۳�¥", PNAME "��ǰ��"
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
  AND NAME = 'ȫ�浿';
  
-- ������@ ���ڸ��� 3�����̸鼭, @�� .������ ���ڰ� 5������ ����� ���鿡�� �ȸ� ��ǰ�� �����ΰ�? 
-- �� ���� �̸�, ����, ���� ��ǰ�� ã�ƺ��ÿ�! (2.4��)

SELECT NAME, EMAIL, PNAME
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
  AND EMAIL LIKE '___@%'
  AND INSTR(EMAIL,'.') - INSTR(EMAIL, '@') = 6;
  -- AND EMAIL LIKE '___@_____.%';