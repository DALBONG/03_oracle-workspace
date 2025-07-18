SELECT * FROM TBL_BUY;
SELECT * FROM TBL_CUSTOM;
SELECT * FROM TBL_PRODUCT;
/*
COMMENT ON COLUMN TBL_BUY.BUY_IDX IS '구매코드';COMMENT ON COLUMN TBL_BUY.CUSTOMID IS '구매자아이디';COMMENT ON COLUMN TBL_BUY.PCODE IS '구매코드';COMMENT ON COLUMN TBL_BUY.QUANTITY IS '구매수량';COMMENT ON COLUMN TBL_BUY.BUY_DATE IS '구매날짜';COMMENT ON COLUMN TBL_CUSTOM.CUSTOM_ID IS '회원아이디';COMMENT ON COLUMN TBL_CUSTOM.NAME IS '회원이름';COMMENT ON COLUMN TBL_CUSTOM.EMAIL IS '회원이메일';COMMENT ON COLUMN TBL_CUSTOM.AGE IS '회원나이';COMMENT ON COLUMN TBL_CUSTOM.REG_DATE IS '주문날짜';COMMENT ON COLUMN TBL_PRODUCT.PCODE IS '물품코드';COMMENT ON COLUMN TBL_PRODUCT.CATEGORY IS '물품종류';COMMENT ON COLUMN TBL_PRODUCT.PNAME IS '물품명';COMMENT ON COLUMN TBL_PRODUCT.PRICE IS '물품가격';
*/
---------------------------------------------------------------------------------

/* A조  */
--A-1. 'mina012' 가 구매한 상품 금액 합계(이광원)
SELECT SUM(PRICE) "mina012 구매 상품 총액"
FROM TBL_BUY B, TBL_PRODUCT P
WHERE B.PCODE = P.PCODE;
	  

--A-2. 이름에 '길동'이 들어가는 회원 구매한 상품 구매현황 (권태윤)
-- 데이터 추가 후 실행하세요.
SELECT NAME, PNAME
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
  AND NAME LIKE '%길동%';

			
--A-3. `25살`이상 고객님들의 `구매`한 `상품명` 조회하기 (강주찬) => 테이블 3개
SELECT NAME "25살이상 고객", PNAME "구매 상품"
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
  AND AGE >= 25;
		

--A-4. 상품명에 '사과' 단어가 포함된 상품을 구매한 고객에 대해 상품별 구매금액의 합을 구하기.(고길현)
SELECT PNAME "품명", SUM(PRICE)
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
GROUP BY PNAME
HAVING PNAME LIKE '%사과%';


--A-5. 총 구매합산 금액이 100000~200000 값인 고객 ID를 조회하시오.(김태완)
SELECT CUSTOMID "10~20 구매자 ID"
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
  AND (QUANTITY * PRICE) BETWEEN 100000 AND 200000;


/*  B조 */
--B-1. 20대 나이 고객의 구매 상품 코드와 나이를 나이순으로 정렬 조회 (이대환)
SELECT PCODE "구매 상품 코드", NAME "이름", AGE "나이"
  FROM TBL_BUY B, TBL_CUSTOM C
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND AGE LIKE '2%'
 ORDER BY 나이 ASC;

--B-2. 나이가 가장 많은 고객이 상품을 구매한 횟수를 조회하세요.-서브쿼리 사용하기 (김승한)  
SELECT COUNT(QUANTITY), MAX(AGE)
  FROM TBL_BUY B, TBL_CUSTOM C
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND AGE = (SELECT MAX(AGE)
                FROM TBL_CUSTOM);
                
--B-3. 2023년 하반기 구매금액을 고객ID별로 조회하시오. 금액이 높은 순서부터 조회하세요. (노희영)
SELECT BUY_DATE, CUSTOMID, PRICE
  FROM TBL_BUY B, TBL_PRODUCT P
 WHERE B.PCODE = P.PCODE
   AND BUY_DATE BETWEEN '23/06/01' AND '23/12/31'
 ORDER BY PRICE DESC;
 
 SELECT *
 FROM TBL_BUY;

--B-4. 2024년에 구매횟수가 1회 이상인 고객id, 고객이름, 나이,이메일을 조회하세요.(이재훈)
SELECT CUSTOMID, NAME, AGE, EMAIL
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
  AND BUY_DATE >= '24/01/01'
  AND QUANTITY >= 1;

--B-5. 고객별-상품별 구매금액을 조회하세요. 정렬도 고객ID,상품코드 오름차순으로 정렬하세요.(이예진)
SELECT NAME, PNAME, PRICE, CUSTOMID, P.PCODE
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
ORDER BY CUSTOMID ASC, P.PCODE;

/* C조 */
--C-1. 가격 1만원 이상의 상품에 대해 각각 고객들이 구매한 평균 개수를 출력하시오.상품코드 순서로 정렬 (임현범)
SELECT B.PCODE, ROUND(AVG(QUANTITY))||'개' "구매 평균 갯수"
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
  AND B.PCODE = P.PCODE
  AND PRICE >= 10000
GROUP BY B.PCODE
ORDER BY B.PCODE ASC;
	 
--C-2. 진라면을 구매한 고객의 이름, 구매수량, 구매날짜를 조회하자. (출제자 : 전예진)
SELECT NAME, QUANTITY, BUY_DATE
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND B.PCODE LIKE '%JIN%';

--C-4. 2023년에 팔린 상품의 이름과 코드, 총 판매액 그리고 총 판매개수를 상품코드 순서로 정렬하여 조회하시오. (정제원)
SELECT PNAME, B.PCODE, SUM(PRICE), SUM(QUANTITY)
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EXTRACT (YEAR FROM BUY_DATE) = 2023
 GROUP BY PNAME, B.PCODE;

--C-5. 'twice'와 'hongGD'는 한집에 살고 있습니다. 이들이 구매한 상품,수량,가격을 조회하세요.-가격이 높은순서부터 정렬 (장성우)
SELECT PNAME, QUANTITY, PRICE
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND CUSTOMID IN ('twice', 'hongGD');


/* D조 */
--D-1. 진라면을 가장 많이 구매한 회원을 구매금액이 높은 순으로 회원아이디와 총 진라면 구매금액을 보여주세요.(조하연)
-- ㄴ 서브쿼리 없이 조인만 사용
SELECT CUSTOMID, (PRICE * QUANTITY) "총 진라면 구매금액"
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND PNAME LIKE '%진라면%'
 ORDER BY (PRICE * QUANTITY) DESC;
 
--D-2. 판매 갯수가 가장 많은 순서로 상품을 정렬하고 총 팔린 금액을 출력하시오.(한진만)
-- 	   판매 개수가 같으면 상품 코드 순서로 정렬합니다.			ㄴ 동등 조인으로 조회
SELECT B.PCODE, PNAME ||' '|| QUANTITY ||'개' "인기 상품" , PRICE, (QUANTITY*PRICE) "총 판매 금액"  
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
 ORDER BY B.QUANTITY DESC, B.PCODE DESC;

--D-3. 진라면을 구매한 고객들의 평균 나이를 제품코드(PCODE)와 함께출력해 주세요.(황병훈)
SELECT B.PCODE, AVG(AGE) "평균나이" --, ROUND(AVG(AGE))
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND PNAME LIKE '%진라면%'
   GROUP BY B.PCODE;


--D-4. 30세 미만 회원별 구매금액을 구하고 회원으로 그룹바이해서 구매금액 합계가 큰 순으로 정렬(조지수)
-- 						ㄴ 3개의 테이블 조인

SELECT AGE, SUM(PRICE)
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
 HAVING AGE < 30
 GROUP BY AGE
 ORDER BY SUM(PRICE) DESC;






