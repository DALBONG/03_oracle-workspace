/*
    <PL / SQL >
    PROCEDURE LANGUAGE EXTENSION TO SQL (절차적)
    오라클 자체에 내장되어 있는 절차적 언어 (위에서 아래로 읽음)
    
    SQL문장 내, 변수의 정의 및 조건처리 (IF), 반복처리(LOOP, FOR, WHILE)등을 지원하여 SQL 단점 보완
    -> 다수의 SQL문을 한번에 실행 가능 + 예외 처리 가능.
    
    *PL/SQL 구조 
    - [선언부]     : DEQLARE로 시작, 변수나 상수를 선언 및 초기화
    - 실행부       : BEGIN으로 시작, 무조건 있어야 함,  SQL문 또는 제어문(조건,반복문)등의 로직을 기술 
    - [예외처리부]  : EXCEPTION으로 시작, 예외 발생시 해결하기 위한 구문을 미리 기술
*/


-- 화면에 HELLO ORACLE 출력

SET SERVEROUTPUT ON;  --> 콘솔 켜기

BEGIN 
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/
-----------------------------------------
/*
        1. DECLARE 선언부
         : 변수 및 상수 선언하는 공간 (선언과 초기화)
           일반 타입 변수, 레퍼런스 타입 변수, LOW 타입 변수
           
        1_1) 일반타입 변수 선언 및 초기화
            [표현식] : 변수명 [CONSTANT 상수가 됨] 자료형 [:= 값];
*/

DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    --EID := 800;
    --ENAME := '주지웅';
    
    EID := &숫자;
    ENAME := '&이름';
    
    DBMS_OUTPUT.PUT_LINE('EID :' || EID );
    DBMS_OUTPUT.PUT_LINE('ENAME :' || ENAME );
    DBMS_OUTPUT.PUT_LINE('PI :' || PI );
END;
/

-- Q. 아까 실행부에서 한 것 변수명 := &자료형;

-------------------------------------------
-- 1_2) 레퍼런스 타입 변수 선언 및 초기화 (어떤 테이블의 어떤 컬럼의 데이터타입 참조해서 그 타입으로 지정)
--      [표현식] 변수명 테이블명.컬럼명%TYPE;


--> 자료형을 참조하는 것 
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    --EID := 300;
    --ENAME := '김달봉';
    --SAL := 3000000;
    
    --사번이 200번인 사원의 사번, 사원명, 급여조회해서 각 변수에 대입
    SELECT EMP_ID, EMP_NAME, SALARY
        INTO EID, ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/
------------------------- 실습 문제

/*
    레퍼런스 타입 변수로 EID, ENAME, JCODE, SAL, DTITLE을 선언
    각 자료형 EMPLOYEE, DEPARTMENT 테이블들의 컬럼들을 참조
    
    사용자가 입력한 사번의 사원, 사번, 사원명, 직급코드, 급여, 부서명 조회 한 후 각 변수에 담아 출력
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
        INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE E, DEPARTMENT D
    WHERE E.DEPT_CODE = D.DEPT_ID
      AND EMP_ID  = &사번;
    
    DBMS_OUTPUT.PUT_LINE(EID);
    DBMS_OUTPUT.PUT_LINE(ENAME);
    DBMS_OUTPUT.PUT_LINE(JCODE);
    DBMS_OUTPUT.PUT_LINE(SAL);
    DBMS_OUTPUT.PUT_LINE(DTITLE);

END;
/

---------------------------------------
--  1_3) ROWTYPE 변수
--      : 테이블의 한 행에 대한 모든 컬럼의 데이터 타입을 한꺼번에 담을 수 있는 변수
--      [표현식] 변수명 테이블명%ROWTYPE;

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
        INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사원명 : '|| E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '|| E.SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스 : '|| NVL(E.BONUS, 0));
END;
/


-------------------------------------------
--  2. BEGIN 실행부
--  <조건문>


-- 1) IF 조건식 THEN 실행내용 END IF; (단독 IF문)

-- 사번 입력 받은 후 해당 사원의 사번, 이름, 급여, 보너스 율(%) 출력.
-- 단 보너스, 받지 않는 사원은 부너스 율 출력 전 '보너스 지급받지 않는 사원입니다' 출력
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SLA EMPLOYEE.SALARY%TYPE;
    BN EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
      INTO EID, ENAME, SLA, BN
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE(EID);
    DBMS_OUTPUT.PUT_LINE(ENAME);
    DBMS_OUTPUT.PUT_LINE(SLA);
    
    IF BN = 0
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE ('보너스율 :' || BN * 100 || '%');
END;
/

-- 2) IF 조건식 THEN 실행내용 ELSE 실행내용 수행 END IF;
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SLA EMPLOYEE.SALARY%TYPE;
    BN EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
      INTO EID, ENAME, SLA, BN
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE(EID);
    DBMS_OUTPUT.PUT_LINE(ENAME);
    DBMS_OUTPUT.PUT_LINE(SLA);
    
    IF BN = 0
        THEN DBMS_OUTPUT.PUT_LINE('보너스 없음');
    ELSE 
            DBMS_OUTPUT.PUT_LINE('보너스율 : ' || BN * 100 || '%');
    END IF;
END;
/

-- 실문 --------------
DECLARE
    -- 레퍼런스 타입 변수 EID, ENAME, DTITLE, NCODE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    -- 참조 테이블 EMPLOYEE, DEPARTMENT, LOCATION
    -- 일반 타입 변수 TEAM 문자열 -> 국내팀 OR 해외팀 담길 예정
    TEAM VARCHAR(20);
BEGIN
    -- 사용자가 입력한 사번이 가지고 있는 사원의 사번, 이름, 부서명, 근무국가코드 조회 후 각 변수에 대입.
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
      INTO EID, ENAME, DTITLE, NCODE
      FROM EMPLOYEE E, DEPARTMENT D, LOCATION L 
     WHERE E.DEPT_CODE = D.DEPT_ID
       AND D.LOCATION_ID = L.LOCAL_CODE
       AND EMP_ID = &사번;
       
    
    IF NCODE = 'KO'
        THEN TEAM := '국내팀';
    ELSE 
        TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(EID);
    DBMS_OUTPUT.PUT_LINE(ENAME);
    DBMS_OUTPUT.PUT_LINE(DTITLE);
    DBMS_OUTPUT.PUT_LINE(TEAM);

    -- NCODE의 값이 KO일 경우 TEAM에 국내팀
    -- 아닐경우 TEAM 해외팀 
    -- 사번, 이름, 부서명, 소속에 대해 출력
    
END;
/
-----------------------------------------------------
-- 3) IF 조건식1 THEN 실행내용1 ELS IF 조건식2 THEN 실행내용2 ELSE 실행내용3 END IF; 

-- 점수 입력 받아 SCORE 변수에 저장
-- 90점 이상 : A / 80~89 : B / 70~79 : C / 60~69 : D / 60점 미만은 F로 처리
-- GRADE 변수에 저장
-- 당신의 점수는 XX 점이고, 학점은 X 학점 입니다. 

DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(1);

BEGIN
    SCORE := &점수;
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D'; 
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE ('당신의 점수는' || SCORE ||'점이고, ' || '학점은 '|| GRADE ||'학점 입니다.');

END;
/


-- 내가 입력한 사번의 사원의 급여가 500 이상이면 GRADE 고급, 300이상이면 GRADE 중급, 300 미만이면 초급
 -- 해당 사원의 급여 등급은 ㅇ급 입니다.
 
 DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;

    GRADE VARCHAR2(10);
 BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
      INTO EID, ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
 
    IF SAL >= 5000000 THEN GRADE := '고급'; 
     ELSIF SAL >= 3000000 THEN GRADE := '중급';
     ELSE GRADE := '초급';
     END IF;
     
     DBMS_OUTPUT.PUT_LINE(ENAME || ' 사원의 급여 등급은 ' || GRADE || '입니다.');
    
 END;
 /
--------------------------------------------------------------
-- 4) CASE 비교대상자 WHEN 동등비교할값 1 THEN 결과값1 WHEN 동등비교할값2 THEN 결과값2,... ELSE 결과값M END;

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30); --부서명 보관
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DNAME := CASE EMP.DEPT_CODE
        WHEN 'D1' THEN '인사팀'
        WHEN 'D2' THEN '회계팀'
        WHEN 'D3' THEN '마케팅팀'
        WHEN 'D4' THEN '국내영업팀'
        WHEN 'D9' THEN '총무팀'
        ELSE '해외영업팀'
    END;
    
    DBMS_OUTPUT.PUT_LINE (EMP.EMP_NAME || '은(는) ' || DNAME || '입니다');
                            
END;
/

-------------------
-- 1. 사원의 연봉을 구하는 프록시져 작성
    -- 보너스가 있는 사원은 보너스도 포함해서 계산, 
    -- 보너스가 없으면 미포함 연봉.
    -- 출력 예시 : 급여 이름 W999,999,999 (--> 8000000 선동일 원화기호124,333,444)
    
    
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    SALARY NUMBER;
BEGIN
    SELECT *
      INTO EMP
      FROM EMPLOYEE
      WHERE EMP_ID = &사번;
      
    /*
     SALARY := CASE EMP_BONUS
        WHEN EMP_(NVL(BONUS, 0) = 0 THEN (SALARY+SALARY*0)*12
        WHEN 
    */
    IF EMP.BONUS IS NULL
        THEN SALARY := EMP.SALARY *12;
        ELSE SALARY :=(EMP.SALARY + EMP.SALARY * EMP.BONUS)*12;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(EMP.SALARY || '' || EMP.EMP_NAME || TO_CHAR(SALARY, 'L999,999,999'));

END;
/

---------------------------------------------------------
--  반복문

/*
    1) BASIC LOOP문
    [표현식]
    LOOP 
        반복적으로 실행할 구문
        * 반복문 빠져나갈 수 있는 구문
    END LOOP;
    
    *반복문 빠져나가는 구문
    1) IF 조건식 THEN EXIT;
    2) EXIT WHEN 조건식;
*/

-- 1~5까지 순차적으로 1씩 증가

DECLARE
    I NUMBER := 1;
BEGIN
    LOOP 
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1; 
        --IF I = 6 THEN EXIT; 
        --END IF;
        EXIT WHEN I = 6;
    END LOOP;
END;
/

---------------
/*
        2) FOR LOOP문
        
        [표현식]
        FOR 변수 IN 초기값.. 최종값 --(1..5)
        LOOP
            반복적으로 실행할 구문
        END LOOP;
*/

BEGIN 
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

--> 값을 더 작아지게 하고싶을 때
/*
        FOR 변수 IN REVERSE 초기값.. 최종값 --(1..5)
        LOOP
            반복적으로 실행할 구문
        END LOOP;
*/
BEGIN  
    FOR I IN REVERSE 1..5  --> 초기값이 더 클 수 없음
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

DROP TABLE TEST;

CREATE TABLE TEST (
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
);

SELECT * FROM TEST;

DROP SEQUENCE SEQ_TNO;

CREATE SEQUENCE SEQ_TNO
START WITH 1
INCREMENT BY 2
MAXVALUE 100
NOCYCLE
NOCACHE;

BEGIN 
    FOR I IN 1..100
    LOOP 
        INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL, SYSDATE);
    END LOOP;
END;
/

SELECT * FROM SEQ_TNO;


-----------------------------------------------
/*
        3) WHILE LOOP문
        [표현식]
        WHILE 반복문이 수행될 조건
        LOOP
            반복적으로 실행할 구문
        END LOOP;
*/

DECLARE
    I NUMBER := 1;
BEGIN
    WHILE I <=6
    LOOP
        DBMS_OUTPUT.PUT_LINE (I);
        I := I + 1;
    END LOOP;
END;
/

----------------------------
/*
        3. 예외 처리 부
        
        [표현식]
        EXCEPTION 실행중 발생하는 오류 
            WHEN 예외명1 THEN 예외처리구문1;
            WHEN 예외명2 THEN 예외처리구문2;
            ...
            WHEN OTHERS THEN 예외처리구문N;
            
        * 예외명, 시스템예외 (오라클에서 미리 정의해둔 예외)
         - NO_DATA_FOUND : SELECT한 결과가 한 행도 없을 때
         - TOO_MANY_RESULT : SELECT한 결과가 여러 행일 경우
         - ZERO_DIVIDE : 0으로 나누려 할 때
         - DUP_VAL_ON_INDEX : UNIQUE 제약조건에 위배되었을 경우
*/

-- 사용자가 입력한 수로 나눗셈 연산한 결과 출력
DECLARE
    RESULT NUMBER;
BEGIN
    RESULT := 10 / &숫자;
    DBMS_OUTPUT.PUT_LINE ('결과 : ' || RESULT);
EXCEPTION
    -- WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없음');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없음');
END;
/


-- UNIQUE 제약제건 위배
BEGIN 
    UPDATE EMPLOYEE
    SET EMP_ID = &변경할사번
    WHERE EMP_NAME = '노옹철';
    
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번!');
END;
/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID = &사수사번; --211 장쯔위, 200 많음, 202 없음
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    
    EXCEPTION
    --WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('너무 많음!');
    --WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('해당 사수 가진 사람 없음!');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('결과 없음!');
END;
/





