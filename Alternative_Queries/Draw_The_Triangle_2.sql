SELECT     RPAD('*', LEVEL * 2, ' *') s
FROM       DUAL 
CONNECT BY LEVEL <= 20 
ORDER BY   s;
