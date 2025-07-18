-- 홍길동씨는 제주도에 거주합니다. 모든 품목 제주, 산간 지방은 주문후 10일 후에 배송되었다 했을때,
 -- 홍길동씨가 주문한 물품들을 배송받은 날짜, 물품명을 찾아보시라.(2점).
 -- 단, 년도 제외 '-월 -일'로 나올 수 있게한다.
 
SELECT EXTRACT(MONTH FROM(BUY_DATE + 10)) ||'월'|| EXTRACT(DAY FROM(BUY_DATE + 10))||'일' "배송날짜", PNAME "물품명"
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
  AND NAME = '홍길동';
  
-- 메일의@ 앞자리가 3글자이면서, @와 .사이의 글자가 5글자인 사람인 고객들에게 팔린 물품은 무엇인가? 
-- 그 고객의 이름, 메일, 구매 물품을 찾아보시오! (2.4점)

SELECT NAME, EMAIL, PNAME
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
  AND EMAIL LIKE '___@%'
  AND INSTR(EMAIL,'.') - INSTR(EMAIL, '@') = 6;
  -- AND EMAIL LIKE '___@_____.%';