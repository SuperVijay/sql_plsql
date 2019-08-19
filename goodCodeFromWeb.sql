
create or replace function split (i_str in varchar2, i_delimiter in varchar2 default ',') 
  return sys.odcivarchar2list
  pipelined
  as
    l_current_string varchar2(4000) := i_str;
    l_pos            binary_integer;
  begin
    if i_str is null then
        return;
    end if;
    loop
      l_pos := nullif(instr(l_current_string, i_delimiter), 0);
      pipe row(substr(l_current_string, 1, nvl(l_pos - 1, length(l_current_string))));
      exit when l_pos is null;
      l_current_string := substr(l_current_string, l_pos + length(i_delimiter));
  end loop;
end split;

select initcap(column_value) as name,
       length(column_value) as name_length
from   table(split('paris,london,rome,madrid'))
order  by column_value

NAME	NAME_LENGTH
London	6
Madrid	6
Paris	5
Rome	4

select * 
from table(split('Paris, France@@London, UK@@Rome, Italy@@Madrid, Spain','@@'))



CREATE OR REPLACE FUNCTION TOKENS_PER_ROW (V_STRING VARCHAR2,N_TOKENS NUMBER:=1,V_DELIMITED VARCHAR2:=',')    
RETURN SYS.ODCIVARCHAR2LIST PIPELINED    
AS    
     V_INDEX NUMBER:=0;     
     V_TOKENS VARCHAR2(4000);    
     TYPE TOKEN IS TABLE OF VARCHAR2(4000) INDEX BY PLS_INTEGER;    
     INDEX_TOKEN TOKEN;        
     I NUMBER;    
     STR_AGRUP_TOKENS VARCHAR2(32767);    
     X NUMBER:=0;    
     FUNCTION GET_TOKEN     
    (     
       string  IN VARCHAR2,     
       token  IN PLS_INTEGER,     
       delimited IN VARCHAR2     
    )     
      RETURN VARCHAR2     
    IS     
        string1 VARCHAR2(32767) := delimited || string;     
        index1 PLS_INTEGER;     
        index2 PLS_INTEGER;     
    BEGIN     
           index1 := INSTR(string1,delimited ,1,token);     
            IF index1 >0 THEN     
                index2 := INSTR(string1,delimited ,1,token+1);     
                  IF index2 = 0 THEN     
                    index2 := LENGTH(string1)+1;     
                  END IF;     
                  RETURN REPLACE((SUBSTR(string1,index1,index2-index1)),delimited ,'');     
              ELSE     
                 RETURN NULL;     
               END IF;     
    END;     
 BEGIN    
            BEGIN     
                FOR I IN 1..REGEXP_COUNT(V_STRING,'\'||V_DELIMITED)+1 LOOP    
                 V_TOKENS := GET_TOKEN(V_STRING,I,V_DELIMITED);    
                -- DBMS_OUTPUT.PUT_LINE(V_TOKENS);   
                 /*POPULATE ASSOCIATIVE ARRAY*/                    
                 INDEX_TOKEN(V_INDEX) := TRIM(V_TOKENS); -- REMOVE SPACES    
                 V_INDEX:=V_INDEX+1;    
                END LOOP;    
            END;    
   I:=INDEX_TOKEN.FIRST;     
   LOOP    
     EXIT WHEN I IS NULL;     
     IF I>=X AND I<X+N_TOKENS THEN     
        STR_AGRUP_TOKENS:= STR_AGRUP_TOKENS||INDEX_TOKEN(I)||V_DELIMITED;    
        IF I=X+N_TOKENS-1 THEN    
               -- ADD N TOKENS PER ROW    
               PIPE ROW(SUBSTR(STR_AGRUP_TOKENS,1,LENGTH(STR_AGRUP_TOKENS)-LENGTH(V_DELIMITED)));    
         -- CLEAN N TOKENS    
         STR_AGRUP_TOKENS:='';    
         X:=X+N_TOKENS;    
        END IF;    
     END IF;    
       I := INDEX_TOKEN.NEXT(I);    
   END LOOP;    
   -- ADD REST OF STRING    
   IF STR_AGRUP_TOKENS IS NOT NULL THEN    
             PIPE ROW(SUBSTR(STR_AGRUP_TOKENS,1,LENGTH(STR_AGRUP_TOKENS)-LENGTH(V_DELIMITED)));   
   END IF;    
   INDEX_TOKEN.DELETE;    
    EXCEPTION WHEN OTHERS THEN    
    DBMS_OUTPUT.PUT_LINE(SQLERRM);    
    RETURN;    
 END; 

Usage:
SELECT 
COLUMN_VALUE 
names 
FROM TABLE(TOKENS_PER_ROW('JOAO,LUIS,HUGO,DUARTE,TÓ,MIGUEL,JOSÉ,MARIA,CARLOS'))


SELECT   
COLUMN_VALUE names   
FROM   
TABLE(TOKENS_PER_ROW('JOAO,LUIS,HUGO,DUARTE,TÓ,MIGUEL,JOSÉ,MARIA,CARLOS',2))

delimited: ###
SELECT 
COLUMN_VALUE 
names 
FROM 
TABLE(TOKENS_PER_ROW('JOAO###LUIS###HUGO###DUARTE###TÓ###MIGUEL###JOSÉ###MARIA###CARLOS',6,'###'))

