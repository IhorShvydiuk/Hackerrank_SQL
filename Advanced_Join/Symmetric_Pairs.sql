SELECT  x
        ,y
FROM    (
        SELECT   f.x
                 ,f.y
                 ,COUNT(*) cnt
        FROM     functions f
                 INNER JOIN functions f1
                 ON f.x = f1.y AND f.y = f1.x
        WHERE    f.x <= f.y
        GROUP BY f.x
                 ,f.y
        )
WHERE   (x < y) 
        OR
        (x = y AND cnt > 1)
ORDER BY x;
