-- 한 줄 짜리 주석
/*
   여러 줄 주석
*/

-- 현재 모든 계정들에 대해 조회하는 명령문 
SELECT * FROM DBA_USERS;  -- 관리자 계정으로 돌아왔기 때문에 보이는 것.

-- 일반 사용자 계정 생성 구문 (관리자 계정에서만 할 수 있음)
-- 표현 법 : CREATE USER 계정명 IDENTIFIED BY 비밀번호;

CREATE USER kh IDENTIFIED BY kh;  --> 계정명은 대소문자 안가림 

-- 계정 추가 오류
 -- 위에서 생성한 일반 사용자 계정에게 최소한의 권한(데이터 관리, 접속) 부여
 -- (표현법) GRANT 권한1, 권한2,.. TO 계정명
 
GRANT CONNECT, RESOURCE TO kh;











