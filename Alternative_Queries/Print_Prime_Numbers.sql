WITH numb AS (
    SELECT     LEVEL + 1 col
    FROM       DUAL 
    CONNECT BY LEVEL <= 999
    )
SELECT LISTAGG(numb1.col, '&') WITHIN GROUP (ORDER BY numb1.col)
FROM   numb numb1
WHERE  NOT EXISTS (
                   SELECT NULL 
                   FROM   numb numb2  
                   WHERE  numb1.col > numb2.col 
                          AND 
                          MOD(numb1.col, numb2.col) = 0 
                          AND ROWNUM = 1
                   );
