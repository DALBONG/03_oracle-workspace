-- 수정님
--1. 고객별 총 구매 금액과 구매 건수를 조회(고객ID, 고객 이름, 총 구매 건수, 총 구매 금액을 출력하고 총 구매 금액이 높은 순으로 정렬)	
SELECT CUSTOMID, NAME, SUM(PRICE) "구매금액", COUNT(BUY_IDX) "구매건수"
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
 GROUP BY NAME, CUSTOMID
 ORDER BY 구매금액 DESC;
--2. 23년에 구매가 이루어진 모든 상품의 정보와 해당 고객의 이름을 조회 
  --(중복없이 각 구매 건마다 한 줄씩 출력되도록 하며 구매일 기준 오름차순 정렬)
SELECT B.PCODE "상품코드", PNAME "물품명", PRICE "물품가격", NAME
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EXTRACT (YEAR FROM BUY_DATE) = 2023;
  

-- 우준님
--1. 이메일 @앞자리에 m이 들어가는 고객들의 이름과 고객들이 산 물건의 이름 및 가격의합을 조회하시오.(이름기준 오름차순으로 정렬)	
SELECT NAME, PNAME, SUM(PRICE)
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EMAIL LIKE 'm%'
   GROUP BY NAME, PNAME;
   
--2. 상품번호가 7자리인 물건을 구매한 고객들의 이름과 구매 년도 및 상품의 이름을 조회하시오.	
SELECT NAME, EXTRACT(YEAR FROM BUY_DATE) "구매년도", PNAME "상품명"
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND B.PCODE LIKE '_______';

-- 윤정님 
--1. 23년도에  사과를 구입한 고객의 이름과 이메일을 구하세요	
SELECT NAME, EMAIL
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EXTRACT(YEAR FROM BUY_DATE) = 2023
   AND PNAME LIKE '%사과%';
   
--2. 총 팔린 금액이 제일 높은 상품명과 팔린 금액을 구하세요
SELECT PNAME, 최고매출
  FROM (SELECT PNAME, MAX(QUANTITY*PRICE) "최고매출", RANK()OVER(ORDER BY MAX(QUANTITY*PRICE) DESC) "최고매출순위"
          FROM TBL_BUY B, TBL_PRODUCT P
         WHERE B.PCODE = P.PCODE
         GROUP BY PNAME)
  WHERE 최고매출순위 = 1;

-- 이찬님 
--1. 이메일을 daum으로  쓰지 않는 사람들의 평균 나이를 구하시오 ( 나이가 0인 경우 제외)
SELECT AVG(AGE)
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EMAIL NOT LIKE '%daum%'
   AND AGE != 0;

--2. 홍길동씨와 박모모씨가 사실 연인관계라고 한다 이 커플의 구매 총액은 ? (IN절 활용)	
SELECT SUM(PRICE)
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND NAME IN ('홍길동', '박모모');

-- 혜지님 
--1. 고객별, 상품별 누적 구매금액, 총 구매금액을 조회하세요.(단, 상품별 누적 구매 금액이 20000원 이상만 조회)	
SELECT 고객별_총_금액, 물품별_총_금액
FROM (SELECT NAME ||' '|| SUM(PRICE) "고객별_총_금액"
          FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
         WHERE B.CUSTOMID = C.CUSTOM_ID
           AND B.PCODE = P.PCODE
           AND PRICE > 20000
         GROUP BY NAME)
         , (SELECT PNAME ||' '|| SUM(PRICE) "물품별_총_금액"
          FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
         WHERE B.CUSTOMID = C.CUSTOM_ID
           AND B.PCODE = P.PCODE
           AND PRICE > 20000
         GROUP BY PNAME);
 
--2. CATEGORY가 'B1'인 상품을 구매한 고객의 이름, 상품명, 수량, 구매날짜를 조회하세요.(단, 구매날짜가 최신인것부터 출력)	
SELECT NAME, PNAME, QUANTITY "구매수량", BUY_DATE "구매날짜"
FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
WHERE B.CUSTOMID = C.CUSTOM_ID
AND B.PCODE = P.PCODE
AND CATEGORY = 'B1'
ORDER BY BUY_DATE DESC;


-- 선일님
--1. "2024년 2월 10일, 카테고리명이 'B'로 시작하는 상품에서 발암물질이 발견되었다. 
    --이에 따라 해당 상품에 대해 구매일로부터 2개월 이내에 해당하는 구매건에 대해 보상이 진행되었다. 
    --보상은 구매번호당 10,000원, 상품 개수당 2,000원의 자쳬 폐기 비용, 그리고 상품 개수당 환불로 구성된다. 
    --이 사건에 해당하는 상품들의  **상품별 손실 금액(보상 + 환불 + 폐기 비용)**을 계산한 후, 
    --손실 금액이 가장 큰 상위 2개 상품의 '상품명'과 '손실 금액'을 '손실 금액이 큰 순'으로 출력하시오."
SELECT PNAME "발암_상품", 품별_손실_금액
FROM (SELECT PNAME, SUM((PRICE*QUANTITY) + (SUBSTR(CATEGORY, 2, 1) * 10000) + (QUANTITY*2000)) "품별_손실_금액", RANK() OVER(ORDER BY SUM((PRICE*QUANTITY) + (SUBSTR(CATEGORY, 2, 1) * 10000) + (QUANTITY*2000)) DESC) "손실액_순위"
        FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
        WHERE B.CUSTOMID = C.CUSTOM_ID
        AND B.PCODE = P.PCODE
        AND CATEGORY LIKE 'B%'
        GROUP BY PNAME)
WHERE 손실액_순위 IN (1, 2);

--2. "가입일(1일부터 시작)로부터 연간 평균 구매 금액이 가장 낮은 고객 중 1명의 
    --'이름'과 연 평균 구매 금액이 (공동)1등이 되기 위해 '구매해야할 금액'을 출력하세요."	
    
  
-- 찬형이    
--1. 23년에 상품을 산 사람들 이름과 각각의 상품과 개수를 출력
SELECT NAME, PNAME, QUANTITY
    FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
    WHERE B.CUSTOMID = C.CUSTOM_ID
    AND B.PCODE = P.PCODE
    AND EXTRACT(YEAR FROM BUY_DATE) = 2023;
--2. 고객들이 산 상품을 확인할 수 있도록 고객명, 상품이름, 개수, 구입날짜를 VIEW로 출력
    -- (뷰 이름 VW_TBL, 구입날짜 출력은 0000년, 00월, 00일)							
/*    
CREATE VIEW VW_TBL
AS SELECT NAME, PNAME, QUANTITY, BUY_DATE
     FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
    WHERE B.CUSTOMID = C.CUSTOM_ID
      AND B.PCODE = P.PCODE;
*/
SELECT * FROM VW_TBL;
    
-- 현아님			
--1. 2023년에 판매되지 않는 상품을 상품코드순으로 정렬하여 출력한다.
SELECT B.PCODE, PNAME
    FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
    WHERE B.CUSTOMID = C.CUSTOM_ID
    AND B.PCODE = P.PCODE
    AND EXTRACT(YEAR FROM BUY_DATE) != 2023
    ORDER BY B.PCODE ASC;
--2. 구매번호가 짝수인 거래 내역을 대상으로, 각 상품의 판매 수량이 
    -- 전체 판매량에서 차지하는 비율을 계산하여 출력한다.	
SELECT SUM(PRICE*QUANTITY) "짝수_판매_수익"
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND SUBSTR(BUY_IDX, 4, 1) IN (2, 4, 6, 8, 0);
   
SELECT SUM(PRICE*QUANTITY) "전체_판매_수익"
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE;
   
SELECT ROUND(짝수_판매_수익/전체_판매_수익*100, 1) "짝수_판매율"
  FROM (SELECT SUM(PRICE*QUANTITY) "전체_판매_수익"
          FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
         WHERE B.CUSTOMID = C.CUSTOM_ID
           AND B.PCODE = P.PCODE)
      ,(SELECT SUM(PRICE*QUANTITY) "짝수_판매_수익"
          FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
         WHERE B.CUSTOMID = C.CUSTOM_ID
           AND B.PCODE = P.PCODE
           AND SUBSTR(BUY_IDX, 4, 1) IN (2, 4, 6, 8, 0));
   
-- 가영님						
--1. 가입일이 2021년인 사람들이 구매한 물품별 금액의 총합을 구하시오. (총합은 내림차순으로 정렬한다.)
SELECT PNAME, SUM(PRICE*QUANTITY) "물품별_금액_총합"
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EXTRACT(YEAR FROM REG_DATE) = 2021
 GROUP BY PNAME
 ORDER BY 물품별_금액_총합 DESC;
   
--2. 하루에 물품을 3개 이상 구매한 내역이 있는 사람들의 평균 나이를 구하시오 (서브쿼리를 이용)	
SELECT AVG(AGE)
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE 
   AND 3 <= ANY (SELECT QUANTITY
               FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
              WHERE B.CUSTOMID = C.CUSTOM_ID
                AND B.PCODE = P.PCODE);

-- 수용님
--1. TBL_BUY 테이블에서 2024년 1월 1일 이후에 구매한 고객 중. 구매 수량 총합이 3개 이상인 고객의 
    -- CUSTOMID, 고객 이름(NAME), 해당 고객이 구매한 상품 종류 수(중복 없는 상품 개수)를 출력하시오. 
    -- (단, 구매 수량 총합 내림차순으로 정렬할 것)"					
--2. TBL_CUSTOM 테이블에서 나이(AGE)가 30세 이상인 고객 중. 
    -- 이메일 주소가 ''korea.com' 도메인을 포함하는 고객의 
    -- CUSTOM_ID, NAME, EMAIL, AGE와 해당 고객들이 최근 구매한 날짜(BUY_DATE)를 출력하고, 
    -- 만약 구매 기록이 없으면 '구매기록없음'으로 표시하시오. 
    -- (단 결과는 나이 내림차순, 이름 오름차순으로 정렬할 것)	
SELECT CUSTOMID, NAME, EMAIL, AGE, BUY_DATE
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND AGE >= 30
   AND EMAIL LIKE '%korea.com%'
   ORDER BY AGE DESC, NAME ASC;

-- 세욱형님
--1. 고객의 구매이력을 통해, 23년도에 구매한 고객들의 총합은 몇명인지 출력하세요 . 예) 23년도 몇 명?
SELECT COUNT(NAME)||'명' "23년 구매 명수"
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EXTRACT(YEAR FROM BUY_DATE) = 2023;

--2. 구매 품목 중 청송사과 5kg, 구매수량 2개, 나이 20살인 고객명을 출력하세요.	
SELECT NAME
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND PNAME LIKE '%청송사과%'
   AND QUANTITY = 2
   AND AGE = 20;
		
-- 우석님
--1. 고객이 회원가입을 하면, 가입일로부터 30일 이내에 사용할 수 있는 웰컴쿠폰이 1장 자동으로 발급되고, 
  -- 해당 쿠폰은 구매 시 자동으로 적용된다고 가정한다.  
  -- 이 조건에 따라, 가입 후 30일 이내에 상품을 구매하여 쿠폰을 사용한 고객들의 ID를 중복 없이 조회하시오.
SELECT DISTINCT(CUSTOMID)
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND MONTHS_BETWEEN(BUY_DATE, REG_DATE) <= 1;
    
--2. 아이디가 가장 긴 사람이 구매한(가장 긴 아이디를 가진 사람은 한명만 있다고 가정) 물품의 총 가격을 구하시오.
SELECT CUSTOMID, 긴_아이디, 구매_물품_총가격
  FROM (SELECT CUSTOMID, LENGTH(CUSTOMID) "긴_아이디", RANK() OVER(ORDER BY LENGTH(CUSTOMID) DESC) "긴_아이디_순위", PRICE*QUANTITY "구매_물품_총가격"
          FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
         WHERE B.CUSTOMID = C.CUSTOM_ID
           AND B.PCODE = P.PCODE)
 WHERE 긴_아이디_순위 IN 1;
        					
-- 민준님                         		
--1. 이메일을 다음을 쓰는 고객의 이름, 구매한 상품명, 각 상품별 구매 개수를 조회하세요. 
  -- (이름빠른 순서로 정렬)
SELECT NAME, PNAME, QUANTITY
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EMAIL LIKE '%daum%';
--2. 나이가 0살로 나오는 사람의 나이를 24살로 고치세요.
SELECT AGE, NAME
  FROM TBL_CUSTOM
 WHERE AGE = 0;
 
 UPDATE TBL_CUSTOM
    SET AGE = 24
  WHERE AGE = 0; 
  
  SELECT *
    FROM TBL_CUSTOM;
-- 재홍님
--1. 2022년 혹은 2024년에 물건을 구매한 고객의 이름 과 물품을 추출하시오
SELECT NAME, PNAME--, BUY_DATE
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND EXTRACT(YEAR FROM BUY_DATE) IN (2022, 2024);
--2. 카테고리가 'A'로 시작하는 물건을 구매한 고객의 이름과 물품명을 출력하세요.
SELECT NAME, PNAME--, CATEGORY
  FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
 WHERE B.CUSTOMID = C.CUSTOM_ID
   AND B.PCODE = P.PCODE
   AND CATEGORY LIKE 'A%';

-- 다은님
--1. 가장 최근에 구매한 상품의 상품명과 구매자 이름, 구매일을 조회하세요.
SELECT 상품명, 구매자, 구매일
  FROM (SELECT PNAME "상품명", NAME "구매자", RANK()OVER (ORDER BY BUY_DATE DESC)"최근_구매순", BUY_DATE "구매일"
          FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
         WHERE B.CUSTOMID = C.CUSTOM_ID
           AND B.PCODE = P.PCODE)
 WHERE 최근_구매순 IN 1;

--2. 각 상품의 평균 구매 수량을 구하고, 그 평균이 2개 이상인 상품만 상품코드, 상품명과 함께 출력하세요.	
 SELECT 상품코드, 상품명
   FROM (SELECT PNAME "상품명", AVG(QUANTITY) "구매수량", B.PCODE "상품코드"
           FROM TBL_BUY B, TBL_CUSTOM C, TBL_PRODUCT P
          WHERE B.CUSTOMID = C.CUSTOM_ID
            AND B.PCODE = P.PCODE
          GROUP BY PNAME, B.PCODE) -- 쌀, 참치, 간식, 햇반, 진람, 애망
  WHERE 구매수량 >= 2;

-- 다현님
--1. 24년도 이전에 가입한 고객들 중 총구매수량이 가장 높은 고객의 
  -- 이름, 이메일, 총구매가격, 총구매수량을 출력하세요.							
--2. 고객별 총구매수량이 높은 순서대로 순위 이름, 나이, 총구매수량, 총구매가격을 출력하세요.
    --(동일값 중복순위 부여 후 다음순위는 중복순위와 상관없이 순차적으로 순위 부여) 

-- 세민님
--1. 제품 코드에 N가 들어가는 상품을 분류하고 이 제품을 산 사람들과 제품 개수를 나열해주세요.(제품명, 고객명, 제품개수 순서)							
--2. 총 구매 가격이 10만원 이상인 사람들의 이름과 이메일 주소를 구하세요.				

   




