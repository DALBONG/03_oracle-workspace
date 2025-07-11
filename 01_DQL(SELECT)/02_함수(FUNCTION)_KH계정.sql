/*
    <함수 FUNCTION>
      전달한 컬럼값을 읽어들여 함수를 실행한 결과를 반환.
    
     - 단일 행 함수 : N개의 값을 읽어들여 N개의 결과값을 리턴
     - 그룹 함수 : N개의 값을 읽어들여 1개의 결과값 리턴
     
    * SELECT 절에 단일행 함수와 그룹함수를 함께 사용하지 못함.
       -> 결과 행의 개수가 다르기 때문
       
    * 함수 쓸 수 있는 위치 : SELECT절, WHERE절, ORDER BY 절, BROPU BY 절 HAVING 절
*/    


/*    
    <문자처리 함수>
    * LENGTH / LENGTHB   -> 결과값  NUMBER 타입 
     LENGTH(컬럼|'문자열 값') : 해당 문자열 값의 글자 수 반환
     LENGTHB(컬럼|'문자열 값') : 해당 문자열 값의 바이트 수 반환
     
     '김', '나', 'ㄱ' : 한글자당 3BYTE 크기
     '영문' '숫자' '특문' : 한글자당 1BYTE
*/

SELECT SYSDATE FROM DUAL; --가상테이블
SELECT LENGTH ('시진핑'), LENGTHB ('도핑')
FROM DUAL;


SELECT LENGTH ('PING'), LENGTHB('PING')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;  -- 매행마다 다 실행되고 있음 --> 단일행 함수 


/*
    INSTR
    문자열로부터 특정 문자의 시작 위치를 찾아서 반환
    INSTR(컬럼|'문자열', '찾고자 하는 문자', ['찾을 위치의 시작값', 순번]) -> 결과값은 NUMBER 타입
    
*/

SELECT INSTR('AABBAAABABDDBBDAAA', 'B') 
FROM DUAL;
SELECT INSTR('AABBAAABABDDBBDAAA', 'B', 1) 
FROM DUAL;
SELECT INSTR('AABBAAABABDDBBDAAA', 'B', -1) 
FROM DUAL; -- 뒤에서부터
SELECT INSTR('AABBAAABABDDBBDAAA', 'B', 1, 2) 
FROM DUAL; -- 앞에서부터 두번째 B

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_의 위치"
FROM EMPLOYEE; 

SELECT EMAIL, INSTR(EMAIL, '@', 1, 1) AS "@의 위치"
FROM EMPLOYEE; 


/*
 SUBSTR
  문자열에서 특정 문자열을 추출해서 반환
    (jAVA에서의 SUBSTRING()메서드와 비슷)
    
    SUBSTR(STRING, POSITION, [LENGTH])  -> 결과값이 CHAR 타입
*/


SELECT SUBSTR('SHOWMETHEMONEY', 7)
FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2)
FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1,6)
FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3)
FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8,1) AS "성별" 
FROM EMPLOYEE;

-- 여자 사원만 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR (EMP_NO, 8, 1) IN ('2', '4');

SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR (EMP_NO, 8, 1) IN (1, 3) -- 내부적으로 자동형변환 되어 ' ' 안붙여도 됨. 
ORDER BY 1;

-- 함수 중첩 사용 
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) "ID"
FROM EMPLOYEE;

--==========================================================================
/*
    LPAD / RPAD
    문자열을 조회할 때 통일갑있게 조회하고자 할 때 사용.
    LPAD/RPAD(STRING, 최종적으로 반환할 문자의 길이, [덧붙이고자 하는 문자])    
*/

SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20) -- 덧붙이고자 하는 문자 생략시 기본값 공백.
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
    문자열에서 특정 문자를 제거한 나머지 반환.
    
    LTRIM / RTRIM (STRING, ['제거할 문자들']) = 생략시 공백 제거
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
TRIM([LEADING | TRAILING | BOTH] [제거하고자 하는 문자들 FROM] STRING)
문자열의 앞/뒤, 양쪽에 있는 지정한 문자들을 제거한 나머지 문자열 반환 
*/


-- 기본적으로 양쪽에 있는 문자들 다 찾아 제거
SELECT TRIM('      K   H     ') 
FROM DUAL;
--SELECT TRIM('ZZZKHZZZ', 'Z') FROM DUAL; --> 제거하고자 하는 문자가 앞에 와야 함
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL; 
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; --앞부분 Z 제거
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- 뒷부분 Z 제거
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL; --양옆 Z 제거(기본값)

--===================================================================
/*
    *LOWER / UPPER  / INITCAP
    
    LOWER / UPPER / INITCAP(STRING) -> 결과값  CHAR 타입
*/
SELECT LOWER('WelCome To The Show') FROM DUAL;
SELECT UPPER('WelCome To The Show') FROM DUAL;
SELECT INITCAP('WelCome To The Show') FROM DUAL;

--========================================================
/*
CONCAT
문자열 두개를 전달받아 하나로 합친 후 결과 반환 

CONCAT(STRING1, STRING2)
*/

SELECT CONCAT('ABC', '초콜리뜨') FROM DUAL;
SELECT 'ABC' || 'CHZHFFPeM' FROM DUAL;


-- SELECT CONCAT('ABC', '초콜리뜨', '맛있냐?') FROM DUAL; --> 2개만 됨
SELECT 'ABC' || 'CHZHFFPeM' || 'ㅇㅇㅇㅎㅎ' FROM DUAL;

--===============================================================
/*
REPLACE
REPLACE (STRING, STR1, STR2)
 => 문자열 바꿔주는 함수

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
숫자 처리 함수
 *ABS (NUMBER)

*/

SELECT ABS(-10.6) FROM DUAL;


/*
MOD (NUMBER1, NUMBER2)
*/

SELECT MOD (10.9, 3) FROM DUAL;


/*
 ROUND
 반올림 한 결과 
 ROUND (NUMBER)
*/

SELECT ROUND (123.5367) FROM DUAL;
SELECT ROUND (123.5367, 1) FROM DUAL;
SELECT ROUND (123.5367, 2) FROM DUAL;


/*
CEIL 
 올림처리 해주는 함수 
 
 CEIL(NUMBER)
*/

SELECT CEIL(1445.453453) FROM DUAL;

/*
FLOOR 
소수점 아래 버림처리
*/

SELECT FLOOR(213.3525) FROM DUAL;

/*
TRUNC (절삭하다)
 : 위치 지정 가능한 버림 처리해주는 함수
 
 TRUNC (NUMBER, [위치])
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
날짜 처리 함수
SYSDATE : 시스템 날짜 및 시간 반환
*/
SELECT SYSDATE FROM DUAL;



/*
MONTHS_BETWEEN(DATE1, DATE2) : 두 날짜 사이의 개월 수 
*/

-- EMPLPYEE에서 사원명 입사일 근무일수 근무개월 수 
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE-HIRE_DATE) || '일' "근무일수"
FROM EMPLOYEE;


SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE-HIRE_DATE) || '일' "근무일수", CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월'
FROM EMPLOYEE;


/*
ADD_MONTHS(DATE, NUMBER)
 : 특정 날짜에 해당 숫자만큼의 개월수 더해서 알려줌
*/
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;

-- 사원명 입사일, 입사후 3개월 된 날짜

SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3) "수습 끝난 날짜"
FROM EMPLOYEE;



/*
NEXT_DAY (DATE, 요일) : 해달 날 이후 가장 가까운 요일의 날짜를 반환

*/

SELECT SYSDATE, NEXT_DAY(SYSDATE, '화요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '화') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 3) FROM DUAL;



/*
LAST_DAY (DATE): 해당월의 마지막 날짜를 구해서 반환
*/
SELECT LAST_DAY(SYSDATE) FROM DUAL;
  -- 사원명 입사일 입사한 달의 마지막 날짜
  
  SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE "근무일 수"
  FROM EMPLOYEE;
   -- LAST_DAY : 해당 월의 마지막 날
   
   
/*
EXTRACK : 특정 날짜로부터 년도 | 월 | 일 값을 추출해서 반환

EXTRACT(YEAR FROM DATE) : 년도만 추출
EXTRACT(MONTH FROM DATE) : 월만 추출
EXTRACT(DAY FROM DATE) : 일만 추출
*/
-- 사원명, 입사년도, 입사월, 입사 일 조회
SELECT EMP_NAME, HIRE_DATE,
EXTRACT(YEAR FROM HIRE_DATE) AS "입사년도",
EXTRACT(MONTH FROM HIRE_DATE) AS "입사 월",
EXTRACT(DAY FROM HIRE_DATE) AS "일사 일"
FROM EMPLOYEE
ORDER BY "입사년도", "입사 월", "일사 일";

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
형변환 함수
 TO_CHAR : 숫자, 날짜 타입의 값을 문자타입으로 변환시켜주는 함수
 
 TO_CHAR(숫자|날짜, [포맷])
*/

--숫자 -> 문자
SELECT TO_CHAR(1234) FROM DUAL; -- 숫자타입 1234 -> 문자 타입 '1234'
SELECT TO_CHAR(1234, '99999') FROM DUAL;
SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;
SELECT TO_CHAR(1234, '$99999') FROM DUAL;
SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999') -- 9는 자리를 나타내는 개념
FROM EMPLOYEE;

-- 숫자 타입을 문자타입으로
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; 
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; 
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL; 

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YY-MM-DD')
FROM EMPLOYEE;

-- ㅇㅇㅇㅇ년 0ㅇ월 00일 형식으로 

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"월" MM"월" DD"일"')
FROM EMPLOYEE;
    --> 없는 포맷 제시할 땐, " "로 묶어주면 됨.

-- 년도와 관련된 포맷 
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;


-- 월에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- 일에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'DDD'), --올해 기준 며칠쨰? 
       TO_CHAR(SYSDATE, 'DD'),  -- 월 기준으로 며칠쨰?
       TO_CHAR(SYSDATE, 'D') -- 주 기준 며칠쨰?
FROM DUAL;

-- 요일에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')
FROM DUAL;


--==================================================================
/*
TO_DATE : 숫자타입 OR 문자타입 데이터를 날짜 타입으로 변환시켜주는 함수

 TO_DATE(숫자|문자, [포맷])
*/

SELECT TO_DATE(20100503) FROM DUAL;
SELECT TO_DATE(101009) FROM DUAL;
SELECT TO_DATE('090909') FROM DUAL; --에러
  ---> 첫 글자가 0인경우 무조건 문자타입으로 변경하고 해야 함.

SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140620', 'YYMMDD') FROM DUAL;
SELECT TO_DATE('980620', 'YYMMDD') FROM DUAL; --> 2098 : 무조건 현재 세기로 반영
SELECT TO_DATE('980620', 'RRMMDD') FROM DUAL; --> 1998 
   -- RR : 해당 두자리 년도 값이 50미만일 경우 현재세기, 50이상일 경우 이전세기 반영
   
   
--=======================================================
/*
TO_NUMBER : 문자 타입의 데이터를 숫자타입으로 변환시켜주는 함수
  TO_NUMBER (문자, [포맷])
*/

SELECT TO_NUMBER('01090115641') FROM DUAL;

SELECT '1000000' + '55000' FROM DUAL; --> 자동형변환 되어 연산해줌
SELECT '1,000,000' + '55,000' FROM DUAL; --> 숫자만 있어야 형변환 가능,

SELECT TO_NUMBER ('1,000,000', '9,999,999') + TO_NUMBER('55,000', '99,999') FROM DUAL;


/*
NULL 처리 함수

NVL(컬럼, 해당 컬럼 값 NULL경우 반환할 값)
*/

SELECT EMP_NAME, BONUS
FROM EMPLOYEE;

SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- 전체 사원 이름, 보너스 포함 연봉
SELECT EMP_NAME, BONUS, (SALARY + SALARY * BONUS)*12, (SALARY + SALARY * NVL(BONUS, 0))*12
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '부서 없음')
FROM EMPLOYEE;

-- NVL2(컬럼, 반환값1, 반환값2)
   -- 컬럼값이 존재할 경우 반환값1반환, NULL일경우 반환값2 반환 (3항연산자와 비슷)
SELECT EMP_NAME, NVL2(BONUS, 0.7, 0.1)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL2(DEPT_CODE, '부서있음', '부서없음')
FROM EMPLOYEE;

-- NULLIF(비교대상1 ,  비교대상2)
  -- 두개의 값이 일치하면 NULL 반환, 일치하지 않으면 비교대상1 값 반환
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '456') FROM DUAL;

--=================================================================
/*
    <선택 함수>
    DECODE(비교하고자 하는 대상, 비교값1, 결과값1, 비교값2, 결과값2,...)
    
*/
--사번, 사원명, 주민번호
SELECT EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1), 
    DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') AS "성별"
FROM EMPLOYEE;

-- 직원 급여 조회시 각 직급별 인상해서 조회
 -- J7 사원 : 급여10% 인상 (SALARY * 1.1)
 -- J6 사원 : 급여15% 인상 (SALARY * 1.15)
 -- J5 사원 : 급여20% 인상 (SALARY * 1.2)
 -- 그 외 : (SALARY * 1.05)
 
 -- 사원명, 직급코드, 기존급여, 인상급여
 SELECT EMP_NAME, JOB_CODE, SALARY,
    DECODE(JOB_CODE, 'J7', SALARY*1.1, 'J6', SALARY*1.15, 'J5', SALARY*1.2, SALARY*1.05) "인상 급여"
 FROM EMPLOYEE;


/*
CASE WHEN THEN

 CASE WHEN 조건식1 THEN 결과값1
      WHEN 조건식2 THEN 결과값2
      ...
      ELSE 결과값N 
   END
*/

SELECT EMP_NAME, SALARY,
    CASE WHEN SALARY >= 5000000 THEN '고급 개발자'
         WHEN SALARY >= 3500000 THEN '중급 개발자'
         ELSE '초급 개발자'
    END
FROM EMPLOYEE;



/*
 그룹 함수
  1. SUM(숫자 타입컬럼) : 해당
 
*/
-- 전체 사원의 총 급여 합
SELECT SUM(SALARY)  --> 전체 사원히 한 그룹으로 묶여 값이 하나만 나옴.
FROM EMPLOYEE;

-- 남자사원들의 총 급여 합
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3'); --> 남자사원들이 하나의 그룹으로 묶임

-- 부서코드가 D5인 사원들의 총 연봉 합
SELECT SUM(SALARY*12)
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5';


 -- 2. AVG(숫자 타입) : 해당 컬럼값들의 평균 값
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;


 -- 3. MIN (여러 타입) : 해당 컬럼값들 중 가장 작은 값 구해서 반환
 SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
 FROM EMPLOYEE;
 
 -- 4. MAX 
 SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
 FROM EMPLOYEE;
 
 -- 5. COUNT (*| 컬럼| DISTINCT 컬럼) : 조회된 행 개수들 세서 반환 
  -- 1) COUNT(*) : 조회된 결과의 모든 행 개수 반환
SELECT COUNT(*)
FROM EMPLOYEE;

  -- 2) COUND(컬럼) : 컬럼 값이 NULL이 아닌 것만 행 개수 반환
SELECT COUNT(BONUS) -- 보너스를 받는 사원 수
FROM EMPLOYEE;

-- 남자 사원 중 보너스를 받는 사원 수
SELECT COUNT(BONUS)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3'); 

-- 부서 배치를 받은 사원 수
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- 3) COUNT(DISTINCT 컬럼) : 해당 컬럼값 중복 제거 후 행 개수 반환
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE; -- 현 사원들이 몇개의 부서에 분포되어있는지.


 
 
 
 
 
 

