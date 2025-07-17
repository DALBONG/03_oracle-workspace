/*
    TCL (트랜젝션)
      : DB의 논리적 연산 단위
    - 데이터의 변경사항(DML, 추가, 수정, 삭제)들을 하나의 트랜젝션에 묶어 처리
        (DML문 한 개 수행 : 트랜젝션이 존재하면 해당 트랜젝션에 묶여 들어가고, 
                          트랜젝션 존재하지 않으면 트랜젝션을 만들어 묶음 
                          COMMIT(확정)하기 전 까지 변경사항들을하나의 트랜젝션에 담게 되고,
                          COMMIT(확정)을 해줘야 실제 DB에 반영이 됨.
                          
                          
     - 트랜젝션의 대상이 되는 SQL : INSERT, UPDATE, DELETE(DML) 
       
      COMMIT(트랜젝션 종료 처리 후 확정)
      ROLLBACK (트랜젝션 취소)
      SAVEPOINT (임시 저장)
      
      - COMMIT 진행 : 한 트랜젝션에 담긴 변경사항을 실제 DB에 반영시키겠다는 의미 
        (커밋 후 트랜젝션은 사라짐)
      - ROLLBACK 진행 : 한 트랜젝션에 담겨있는 모든 변경사항들을 삭제(취소)한 후 
         마지막 COMMIT 시점으로 돌아감.
      - SAVEPOINT 포인트명; : 현재 이 시점에 해당 포인트명으로 임시 저장점을 정의해 두는 것.
        
        ROLLBACK; 진행시 전체 변경사항 다 삭제,
        SAVEPOINT는 지정 지점까지 롤백 
*/


SELECT * FROM EMP_O1;
-- 사번이 900번인 사원 지우기
DELETE FROM EMP_O1
WHERE EMP_ID = 900;
DELETE FROM EMP_O1
WHERE EMP_ID = 901;

ROLLBACK; 
    -- 변경사항 취소되고, 트랜젝션도 없어짐. (데이터가 다시 되살아 난 것으로 보임)

-- 200번 사원 지우기
DELETE FROM EMP_O1
WHERE EMP_ID = 200;

SELECT * FROM EMP_O1;

-- 800번 안효섭 총무부 사원 추가
INSERT INTO EMP_O1 VALUES (900, '안휴섬', '총무부');

COMMIT; -- 실제 DB에 반영

ROLLBACK; --> 마지막 커밋 시점으로 돌아감, 이미 커밋에서 못돌아감ㅣ. 
----------------------------------------

-- 217, 216, 214 사원 삭제
DELETE FROM EMP_O1
WHERE EMP_ID IN (217, 216, 214);

-- 임시 저장점 잡기
SAVEPOINT SP;

SELECT * FROM EMP_O1;
-- 801, 황민현, 인사관리부 사원 추가
INSERT INTO EMP_01 VALUES (801, '황미년', '인사관리부');

DELETE FROM EMP_O1
WHERE EMP_ID = 218;

SELECT * FROM EMP_O1;

ROLLBACK TO SP;
     --> 그냥 롤백해버리면 전부 취소되고, 마지막 커밋 시점으로 돌아감. 

COMMIT;

------------------------------------------
-- 900, 901 사원 삭제
DELETE FROM EMP_O1
WHERE EMP_ID IN (900, 901);


DELETE FROM EMP_O1
WHERE EMP_ID = 218;

SELECT * FROM EMP_O1;

-- DDL 문 수행
CREATE TABLE TEST (TID NUMBER);

ROLLBACK;

-- DDL문 수행하는 순간 트랜젝션이 실에 DB에 반영이 되고, ,DDL문이 수행
    -- DDL을 수행하는 순간 기존에 틀내젝션에 있던 변경사항들이 무조건 COMMIT
    -- 즉, DDL문 수행 전 변경사항들이 있었다면 정확히 픽스(COMMIT)후 수정
    
    





