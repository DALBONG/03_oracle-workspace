
-- 1. 성적테이블(학번, 이름, 국, 영, 수), 학점테이블(학번, 총점수, 평균, 등수) 만들기
  -- 성적테이블 : TB_SCORE       /             학점테이블 : TB_GRADE
CREATE TABLE TB_SCORE 
    (STUDENT_NO NUMBER NOT NULL,
     STUDENT_NAME VARCHAR2(15) NOT NULL,
     KO_SCORE NUMBER,
     EN_SCORE NUMBER,
     MAT_SCORE NUMBER
    );
    
CREATE TABLE TB_GRAD
    (STUDENT_NO NUMBER,
     SUM_SCORE NUMBER,
     AVG_SCORE NUMBER, 
     RANK NUMBER
    );

-- 2. 성적테이블에 INSERT 발생하면 자동으로 학점테이블에 INSERT해주는 트리거 생성

/*
CREATE OR REPLACE TRIGGER TRG_SCORE
AFTER INSERT ON TB_SCORE
FOR EACH ROW
DECLARE 
    STU_NO TB_SCORE.STUDENT_NO%TYPE;
    SUM_SCO NUMBER := TB_SCORE(KO_SCORE + EN_SCORE + MAT_SCORE);
    AVG_SCO NUMBER := TB_SCORE(KO_SCORE + EN_SCORE + MAT_SCORE / 3);
            -- 만약, 과목의 컬럼이 추가되면 이 식은 망하지만, 일단... 머리아픙께..
    TOTAL_RANK NUMBER;
BEGIN
    INSERT INTO TB_GRADE VALUES (STU_NO, SUM_SCO, AVG_SCO, TOTAL_RANK);
END;
/
*/

CREATE OR REPLACE TRIGGER TRG_SCORE
AFTER INSERT ON TB_SCORE
FOR EACH ROW
BEGIN
    INSERT INTO TB_GRAD(STUDENT_NO, SUM_SCORE, AVG_SCORE)
    VALUES(:NEW.STUDENT_NO,
           :NEW.KO_SCORE + :NEW.EN_SCORE + :NEW.MAT_SCORE,
           (:NEW.KO_SCORE + :NEW.EN_SCORE + :NEW.MAT_SCORE)/3);
END;
/

INSERT INTO TB_SCORE VALUES(200, '김돌비', 70, 60, 60);
INSERT INTO TB_SCORE VALUES(201, '박궁예', 80, 90, 70);
INSERT INTO TB_SCORE VALUES(202, '이단군', 80, 80, 70);

-- 3. 성적테이블이 UPDATE되면 해당 국어, 영어, 수학 점수의 값이 
   -- 오라클 콘솔에 출력되는 트리거 생성
CREATE OR REPLACE TRIGGER TRG_GRADE
AFTER UPDATE ON TB_SCORE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('국어 : ' || :NEW.KO_SCORE);
    DBMS_OUTPUT.PUT_LINE('영어 : ' || :NEW.EN_SCORE);
    DBMS_OUTPUT.PUT_LINE('수학 : ' || :NEW.MAT_SCORE);
END;
/

-- 4. 성적테이블에 INSERT/ UPDATE 되면 등수를 매겨서 저장해주는 프로시저 생성
CREATE OR REPLACE PROCEDURE PROC_UPDATE_RANK IS
BEGIN
    UPDATE TB_GRAD G     --> 다중 서브쿼리식
    SET RANK = (SELECT RN  
                  FROM (SELECT STUDENT_NO, RANK()OVER(ORDER BY SUM_SCORE DESC) AS "RN"
                          FROM TB_GRAD) SUB
                 WHERE G.STUDENT_NO = SUB.STUDENT_NO
                );
END;
/
  
CREATE OR REPLACE TRIGGER TRG_TEST3
AFTER INSERT OR UPDATE ON TB_SCORE
BEGIN
    PROC_UPDATE_RANK;
END;
/
 
 -- 5. 점수 테이블에 학생 데이터가 삭제되면 학점 테이블에도 
  -- 학생 데이터 삭제 + 나머지 사람 등수 매기는 트리거 생성
CREATE OR REPLACE TRIGGER TRT_TEST4
AFTER DELETE ON TB_SCORE
FOR EACH ROW
BEGIN
    DELETE FROM TB_GRAD
     WHERE STUDENT_NO = :OLD.STUDENT_NO; 
     
    PROC_UPDATE_RANK;
END;
/
  
  

  
  