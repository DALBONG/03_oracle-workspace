/*
    시퀀스
     : 자동으로 번호 발생시켜주는 역할을 하는 객체
     - 정수값을 순차적으로 일정값씩 증가시키면서 생성해줌 (기본적으로 1씩 증가)
*/

/*
        1. 시퀀스 객체 생성
        [표현식]
        CREATE SEQUENCE 시퀀스명
        
        [상세 표현식]
        CREATE SEQUENCE 시퀀스명 
        [START WITH 시작숫자] -- 처음 발생시킬 시작값 지정, 기본값 1
        [INCREMENT BY 숫자]  -- 몇 씩 증가시킬 것인지, 기본값 1
        [MAXVALUE 숫자]      -- 최대값 지정, 기본값 겁나 큼
        [MINVALUE 숫자]      -- 최소값 지정, 기본값 1 = 최대값 찍고 첨부터 다시 시작하게 할 수 있음.
        [CYCLE | NOCYCLE]   -- 값 순환 여부 지정, 기본값 NOCYCLE
        [NOCACHE | CACHE 바이트 크기] -- 캐시메모리 할당 (기본값 CACHE 20)
        
        * 캐시 메모리 : 임시공간 (미리 발생될 값들을 생성해서 저장해두는 공간)
            - 매번 호출될 때마다 새로 번호를 생성X, 캐시메모리 공간에 생성된 값들을 가져다 쓸 수 있음. 
              ㄴ 접속 해제시, 캐시메모리에 만들어 둔 번호들은 날라감 
*/

CREATE SEQUENCE SEQ_TEST;
-- 참고 : 현재 계정이 소유하고 있는 시퀀스 구조를 볼 때
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 330
NOCYCLE
NOCACHE;

/*
        2. 시퀀스 사용
        시퀀스명.CURRVAL : 현재 시퀀스의 값 (마지막 성공적 수행된 NEXTVAL의 값)
        시퀀스명.NEXTVAL : 시퀀스 값에 일정값을 증가시켜 발생된 값 (기본적으로 1번은 해줘야 함)
                         
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
    -- ORA-08002: sequence SEQ_EMPNO.CURRVAL is not yet defined in this session
    -- *Action:   select NEXTVAL from the sequence before selecting CURRVAL

-- SELECT 여러번 치지 말기
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 마지막 성공적으로 수행된 NEXTVAL값
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 305 > 310 ...330 이후 오류 : 지정 MAX값 초과, 에러
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 330 

/*
        3. 시퀀스 구조 변경
        ALTER SEQUENCE 시퀀스명  --> START WITH는 변경 불가
        [INCREMENT BY 숫자]  -- 몇 씩 증가시킬 것인지, 기본값 1
        [MAXVALUE 숫자]      -- 최대값 지정, 기본값 겁나 큼
        [MINVALUE 숫자]      -- 최소값 지정, 기본값 1 = 최대값 찍고 첨부터 다시 시작하게 할 수 있음.
        [CYCLE | NOCYCLE]   -- 값 순환 여부 지정, 기본값 NOCYCLE
        [NOCACHE | CACHE 바이트 크기] -- 캐시메모리 할당 (기본값 CACHE 20)
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; 
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;

--      4. 시퀀스 삭제
DROP SEQUENCE SEQ_EMPNO;
------------------------------------------------
-- 사원 번호로 활용할 시퀀스 생성
CREATE SEQUENCE SEQ_EID
START WITH 400
NOCACHE;

INSERT 
 INTO EMPLOYEE
    (
      EMP_ID
    , EMP_NAME
    , EMP_NO
    , JOB_CODE
    , SAL_LEVEL
    , HIRE_DATE
    )
    VALUES 
    (
      SEQ_EID.NEXTVAL
    , '홍길당'
    , '990101-1111111'
    , 'J7'
    , 'S1'
    , SYSDATE
    );
    
SELECT * FROM EMPLOYEE;


INSERT 
 INTO EMPLOYEE
    (
      EMP_ID
    , EMP_NAME
    , EMP_NO
    , JOB_CODE
    , SAL_LEVEL
    , HIRE_DATE
    )
    VALUES 
    (
      SEQ_EID.NEXTVAL
    , '홍당무'
    , '990101-2222222'
    , 'J6'
    , 'S1'
    , SYSDATE
    );

-------------------------
-- 실전에서 
INSERT 
 INTO EMPLOYEE
    (
      EMP_ID
    , EMP_NAME
    , EMP_NO
    , JOB_CODE
    , SAL_LEVEL
    , HIRE_DATE
    )
    VALUES 
    (
      SEQ_EID.NEXTVAL
    , ?
    , ?
    , ?
    , ?
    , SYSDATE
    );




