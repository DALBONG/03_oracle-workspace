/*
    <敗呪 FUNCTION>
      穿含廃 鎮軍葵聖 石嬢級食 敗呪研 叔楳廃 衣引研 鋼発.
    
     - 舘析 楳 敗呪 : N鯵税 葵聖 石嬢級食 N鯵税 衣引葵聖 軒渡
     - 益血 敗呪 : N鯵税 葵聖 石嬢級食 1鯵税 衣引葵 軒渡
     
    * SELECT 箭拭 舘析楳 敗呪人 益血敗呪研 敗臆 紫遂馬走 公敗.
       -> 衣引 楳税 鯵呪亜 陥牽奄 凶庚
       
    * 敗呪 承 呪 赤澗 是帖 : SELECT箭, WHERE箭, ORDER BY 箭, BROPU BY 箭 HAVING 箭
*/    


/*    
    <庚切坦軒 敗呪>
    * LENGTH / LENGTHB   -> 衣引葵  NUMBER 展脊 
     LENGTH(鎮軍|'庚切伸 葵') : 背雁 庚切伸 葵税 越切 呪 鋼発
     LENGTHB(鎮軍|'庚切伸 葵') : 背雁 庚切伸 葵税 郊戚闘 呪 鋼発
     
     '沿', '蟹', 'ぁ' : 廃越切雁 3BYTE 滴奄
     '慎庚' '収切' '働庚' : 廃越切雁 1BYTE
*/

SELECT SYSDATE FROM DUAL; --亜雌砺戚鷺
SELECT LENGTH ('獣遭芭'), LENGTHB ('亀芭')
FROM DUAL;


SELECT LENGTH ('PING'), LENGTHB('PING')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;  -- 古楳原陥 陥 叔楳鞠壱 赤製 --> 舘析楳 敗呪 


/*
    INSTR
    庚切伸稽採斗 働舛 庚切税 獣拙 是帖研 達焼辞 鋼発
    INSTR(鎮軍|'庚切伸', '達壱切 馬澗 庚切', ['達聖 是帖税 獣拙葵', 授腰]) -> 衣引葵精 NUMBER 展脊
    
*/

SELECT INSTR('AABBAAABABDDBBDAAA', 'B') 
FROM DUAL;
SELECT INSTR('AABBAAABABDDBBDAAA', 'B', 1) 
FROM DUAL;
SELECT INSTR('AABBAAABABDDBBDAAA', 'B', -1) 
FROM DUAL; -- 及拭辞採斗
SELECT INSTR('AABBAAABABDDBBDAAA', 'B', 1, 2) 
FROM DUAL; -- 蒋拭辞採斗 砧腰属 B

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_税 是帖"
FROM EMPLOYEE; 

SELECT EMAIL, INSTR(EMAIL, '@', 1, 1) AS "@税 是帖"
FROM EMPLOYEE; 


/*
 SUBSTR
  庚切伸拭辞 働舛 庚切伸聖 蓄窒背辞 鋼発
    (jAVA拭辞税 SUBSTRING()五辞球人 搾汁)
    
    SUBSTR(STRING, POSITION, [LENGTH])  -> 衣引葵戚 CHAR 展脊
*/


SELECT SUBSTR('SHOWMETHEMONEY', 7)
FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2)
FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1,6)
FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3)
FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8,1) AS "失紺" 
FROM EMPLOYEE;

-- 食切 紫据幻 繕噺
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR (EMP_NO, 8, 1) IN ('2', '4');

SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR (EMP_NO, 8, 1) IN (1, 3) -- 鎧採旋生稽 切疑莫痕発 鞠嬢 ' ' 照細食亀 喫. 
ORDER BY 1;

-- 敗呪 掻淡 紫遂 
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) "ID"
FROM EMPLOYEE;

--==========================================================================
/*
    LPAD / RPAD
    庚切伸聖 繕噺拝 凶 搭析逢赤惟 繕噺馬壱切 拝 凶 紫遂.
    LPAD/RPAD(STRING, 置曽旋生稽 鋼発拝 庚切税 掩戚, [機細戚壱切 馬澗 庚切])    
*/

SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20) -- 機細戚壱切 馬澗 庚切 持繰獣 奄沙葵 因拷.
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
    庚切伸拭辞 働舛 庚切研 薦暗廃 蟹袴走 鋼発.
    
    LTRIM / RTRIM (STRING, ['薦暗拝 庚切級']) = 持繰獣 因拷 薦暗
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
TRIM([LEADING | TRAILING | BOTH] [薦暗馬壱切 馬澗 庚切級 FROM] STRING)
庚切伸税 蒋/及, 丞楕拭 赤澗 走舛廃 庚切級聖 薦暗廃 蟹袴走 庚切伸 鋼発 
*/


-- 奄沙旋生稽 丞楕拭 赤澗 庚切級 陥 達焼 薦暗
SELECT TRIM('      K   H     ') 
FROM DUAL;
--SELECT TRIM('ZZZKHZZZ', 'Z') FROM DUAL; --> 薦暗馬壱切 馬澗 庚切亜 蒋拭 人醤 敗
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL; 
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; --蒋採歳 Z 薦暗
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- 急採歳 Z 薦暗
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL; --丞新 Z 薦暗(奄沙葵)

--===================================================================
/*
    *LOWER / UPPER  / INITCAP
    
    LOWER / UPPER / INITCAP(STRING) -> 衣引葵  CHAR 展脊
*/
SELECT LOWER('WelCome To The Show') FROM DUAL;
SELECT UPPER('WelCome To The Show') FROM DUAL;
SELECT INITCAP('WelCome To The Show') FROM DUAL;

--========================================================
/*
CONCAT
庚切伸 砧鯵研 穿含閤焼 馬蟹稽 杯庁 板 衣引 鋼発 

CONCAT(STRING1, STRING2)
*/

SELECT CONCAT('ABC', '段紬軒襟') FROM DUAL;
SELECT 'ABC' || 'CHZHFFPeM' FROM DUAL;


-- SELECT CONCAT('ABC', '段紬軒襟', '言赤劃?') FROM DUAL; --> 2鯵幻 喫
SELECT 'ABC' || 'CHZHFFPeM' || 'しししぞぞ' FROM DUAL;

--===============================================================
/*
REPLACE
REPLACE (STRING, STR1, STR2)
 => 庚切伸 郊蚊爽澗 敗呪

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
収切 坦軒 敗呪
 *ABS (NUMBER)

*/

SELECT ABS(-10.6) FROM DUAL;


/*
MOD (NUMBER1, NUMBER2)
*/

SELECT MOD (10.9, 3) FROM DUAL;


/*
 ROUND
 鋼臣顕 廃 衣引 
 ROUND (NUMBER)
*/

SELECT ROUND (123.5367) FROM DUAL;
SELECT ROUND (123.5367, 1) FROM DUAL;
SELECT ROUND (123.5367, 2) FROM DUAL;


/*
CEIL 
 臣顕坦軒 背爽澗 敗呪 
 
 CEIL(NUMBER)
*/

SELECT CEIL(1445.453453) FROM DUAL;

/*
FLOOR 
社呪繊 焼掘 獄顕坦軒
*/

SELECT FLOOR(213.3525) FROM DUAL;

/*
TRUNC (箭肢馬陥)
 : 是帖 走舛 亜管廃 獄顕 坦軒背爽澗 敗呪
 
 TRUNC (NUMBER, [是帖])
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
劾促 坦軒 敗呪
SYSDATE : 獣什奴 劾促 貢 獣娃 鋼発
*/
SELECT SYSDATE FROM DUAL;



/*
MONTHS_BETWEEN(DATE1, DATE2) : 砧 劾促 紫戚税 鯵杉 呪 
*/

-- EMPLPYEE拭辞 紫据誤 脊紫析 悦巷析呪 悦巷鯵杉 呪 
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE-HIRE_DATE) || '析' "悦巷析呪"
FROM EMPLOYEE;


SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE-HIRE_DATE) || '析' "悦巷析呪", CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '鯵杉'
FROM EMPLOYEE;


/*
ADD_MONTHS(DATE, NUMBER)
 : 働舛 劾促拭 背雁 収切幻鏑税 鯵杉呪 希背辞 硝形捜
*/
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;

-- 紫据誤 脊紫析, 脊紫板 3鯵杉 吉 劾促

SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3) "呪柔 魁貝 劾促"
FROM EMPLOYEE;



/*
NEXT_DAY (DATE, 推析) : 背含 劾 戚板 亜舌 亜猿錘 推析税 劾促研 鋼発

*/

SELECT SYSDATE, NEXT_DAY(SYSDATE, '鉢推析') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '鉢') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 3) FROM DUAL;



/*
LAST_DAY (DATE): 背雁杉税 原走厳 劾促研 姥背辞 鋼発
*/
SELECT LAST_DAY(SYSDATE) FROM DUAL;
  -- 紫据誤 脊紫析 脊紫廃 含税 原走厳 劾促
  
  SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE "悦巷析 呪"
  FROM EMPLOYEE;
   -- LAST_DAY : 背雁 杉税 原走厳 劾
   
   
/*
EXTRACK : 働舛 劾促稽採斗 鰍亀 | 杉 | 析 葵聖 蓄窒背辞 鋼発

EXTRACT(YEAR FROM DATE) : 鰍亀幻 蓄窒
EXTRACT(MONTH FROM DATE) : 杉幻 蓄窒
EXTRACT(DAY FROM DATE) : 析幻 蓄窒
*/
-- 紫据誤, 脊紫鰍亀, 脊紫杉, 脊紫 析 繕噺
SELECT EMP_NAME, HIRE_DATE,
EXTRACT(YEAR FROM HIRE_DATE) AS "脊紫鰍亀",
EXTRACT(MONTH FROM HIRE_DATE) AS "脊紫 杉",
EXTRACT(DAY FROM HIRE_DATE) AS "析紫 析"
FROM EMPLOYEE
ORDER BY "脊紫鰍亀", "脊紫 杉", "析紫 析";

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
莫痕発 敗呪
 TO_CHAR : 収切, 劾促 展脊税 葵聖 庚切展脊生稽 痕発獣佃爽澗 敗呪
 
 TO_CHAR(収切|劾促, [匂庫])
*/

--収切 -> 庚切
SELECT TO_CHAR(1234) FROM DUAL; -- 収切展脊 1234 -> 庚切 展脊 '1234'
SELECT TO_CHAR(1234, '99999') FROM DUAL;
SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;
SELECT TO_CHAR(1234, '$99999') FROM DUAL;
SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999') -- 9澗 切軒研 蟹展鎧澗 鯵割
FROM EMPLOYEE;

-- 収切 展脊聖 庚切展脊生稽
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; 
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; 
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL; 

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YY-MM-DD')
FROM EMPLOYEE;

-- しししし鰍 0し杉 00析 莫縦生稽 

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"杉" MM"杉" DD"析"')
FROM EMPLOYEE;
    --> 蒸澗 匂庫 薦獣拝 匡, " "稽 広嬢爽檎 喫.

-- 鰍亀人 淫恵吉 匂庫 
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;


-- 杉拭 企廃 匂庫
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- 析拭 企廃 匂庫
SELECT TO_CHAR(SYSDATE, 'DDD'), --臣背 奄層 悟張��? 
       TO_CHAR(SYSDATE, 'DD'),  -- 杉 奄層生稽 悟張��?
       TO_CHAR(SYSDATE, 'D') -- 爽 奄層 悟張��?
FROM DUAL;

-- 推析拭 企廃 匂庫
SELECT TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')
FROM DUAL;


--==================================================================
/*
TO_DATE : 収切展脊 OR 庚切展脊 汽戚斗研 劾促 展脊生稽 痕発獣佃爽澗 敗呪

 TO_DATE(収切|庚切, [匂庫])
*/

SELECT TO_DATE(20100503) FROM DUAL;
SELECT TO_DATE(101009) FROM DUAL;
SELECT TO_DATE('090909') FROM DUAL; --拭君
  ---> 湛 越切亜 0昔井酔 巷繕闇 庚切展脊生稽 痕井馬壱 背醤 敗.

SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140620', 'YYMMDD') FROM DUAL;
SELECT TO_DATE('980620', 'YYMMDD') FROM DUAL; --> 2098 : 巷繕闇 薄仙 室奄稽 鋼慎
SELECT TO_DATE('980620', 'RRMMDD') FROM DUAL; --> 1998 
   -- RR : 背雁 砧切軒 鰍亀 葵戚 50耕幻析 井酔 薄仙室奄, 50戚雌析 井酔 戚穿室奄 鋼慎
   
   
--=======================================================
/*
TO_NUMBER : 庚切 展脊税 汽戚斗研 収切展脊生稽 痕発獣佃爽澗 敗呪
  TO_NUMBER (庚切, [匂庫])
*/

SELECT TO_NUMBER('01090115641') FROM DUAL;

SELECT '1000000' + '55000' FROM DUAL; --> 切疑莫痕発 鞠嬢 尻至背捜
SELECT '1,000,000' + '55,000' FROM DUAL; --> 収切幻 赤嬢醤 莫痕発 亜管,

SELECT TO_NUMBER ('1,000,000', '9,999,999') + TO_NUMBER('55,000', '99,999') FROM DUAL;


/*
NULL 坦軒 敗呪

NVL(鎮軍, 背雁 鎮軍 葵 NULL井酔 鋼発拝 葵)
*/

SELECT EMP_NAME, BONUS
FROM EMPLOYEE;

SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- 穿端 紫据 戚硯, 左格什 匂敗 尻裟
SELECT EMP_NAME, BONUS, (SALARY + SALARY * BONUS)*12, (SALARY + SALARY * NVL(BONUS, 0))*12
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '採辞 蒸製')
FROM EMPLOYEE;

-- NVL2(鎮軍, 鋼発葵1, 鋼発葵2)
   -- 鎮軍葵戚 糎仙拝 井酔 鋼発葵1鋼発, NULL析井酔 鋼発葵2 鋼発 (3牌尻至切人 搾汁)
SELECT EMP_NAME, NVL2(BONUS, 0.7, 0.1)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL2(DEPT_CODE, '採辞赤製', '採辞蒸製')
FROM EMPLOYEE;

-- NULLIF(搾嘘企雌1 ,  搾嘘企雌2)
  -- 砧鯵税 葵戚 析帖馬檎 NULL 鋼発, 析帖馬走 省生檎 搾嘘企雌1 葵 鋼発
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '456') FROM DUAL;

--=================================================================
/*
    <識澱 敗呪>
    DECODE(搾嘘馬壱切 馬澗 企雌, 搾嘘葵1, 衣引葵1, 搾嘘葵2, 衣引葵2,...)
    
*/
--紫腰, 紫据誤, 爽肯腰硲
SELECT EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1), 
    DECODE(SUBSTR(EMP_NO, 8, 1), 1, '害', 2, '食') AS "失紺"
FROM EMPLOYEE;

-- 送据 厭食 繕噺獣 唖 送厭紺 昔雌背辞 繕噺
 -- J7 紫据 : 厭食10% 昔雌 (SALARY * 1.1)
 -- J6 紫据 : 厭食15% 昔雌 (SALARY * 1.15)
 -- J5 紫据 : 厭食20% 昔雌 (SALARY * 1.2)
 -- 益 須 : (SALARY * 1.05)
 
 -- 紫据誤, 送厭坪球, 奄糎厭食, 昔雌厭食
 SELECT EMP_NAME, JOB_CODE, SALARY,
    DECODE(JOB_CODE, 'J7', SALARY*1.1, 'J6', SALARY*1.15, 'J5', SALARY*1.2, SALARY*1.05) "昔雌 厭食"
 FROM EMPLOYEE;


/*
CASE WHEN THEN

 CASE WHEN 繕闇縦1 THEN 衣引葵1
      WHEN 繕闇縦2 THEN 衣引葵2
      ...
      ELSE 衣引葵N 
   END
*/

SELECT EMP_NAME, SALARY,
    CASE WHEN SALARY >= 5000000 THEN '壱厭 鯵降切'
         WHEN SALARY >= 3500000 THEN '掻厭 鯵降切'
         ELSE '段厭 鯵降切'
    END
FROM EMPLOYEE;



/*
 益血 敗呪
  1. SUM(収切 展脊鎮軍) : 背雁
 
*/
-- 穿端 紫据税 恥 厭食 杯
SELECT SUM(SALARY)  --> 穿端 紫据備 廃 益血生稽 広食 葵戚 馬蟹幻 蟹身.
FROM EMPLOYEE;

-- 害切紫据級税 恥 厭食 杯
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3'); --> 害切紫据級戚 馬蟹税 益血生稽 広績

-- 採辞坪球亜 D5昔 紫据級税 恥 尻裟 杯
SELECT SUM(SALARY*12)
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5';


 -- 2. AVG(収切 展脊) : 背雁 鎮軍葵級税 汝液 葵
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;


 -- 3. MIN (食君 展脊) : 背雁 鎮軍葵級 掻 亜舌 拙精 葵 姥背辞 鋼発
 SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
 FROM EMPLOYEE;
 
 -- 4. MAX 
 SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
 FROM EMPLOYEE;
 
 -- 5. COUNT (*| 鎮軍| DISTINCT 鎮軍) : 繕噺吉 楳 鯵呪級 室辞 鋼発 
  -- 1) COUNT(*) : 繕噺吉 衣引税 乞窮 楳 鯵呪 鋼発
SELECT COUNT(*)
FROM EMPLOYEE;

  -- 2) COUND(鎮軍) : 鎮軍 葵戚 NULL戚 焼観 依幻 楳 鯵呪 鋼発
SELECT COUNT(BONUS) -- 左格什研 閤澗 紫据 呪
FROM EMPLOYEE;

-- 害切 紫据 掻 左格什研 閤澗 紫据 呪
SELECT COUNT(BONUS)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3'); 

-- 採辞 壕帖研 閤精 紫据 呪
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- 3) COUNT(DISTINCT 鎮軍) : 背雁 鎮軍葵 掻差 薦暗 板 楳 鯵呪 鋼発
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE; -- 薄 紫据級戚 護鯵税 採辞拭 歳匂鞠嬢赤澗走.


 
 
 
 
 
 

