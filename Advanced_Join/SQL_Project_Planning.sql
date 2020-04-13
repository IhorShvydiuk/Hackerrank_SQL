--Tabibitosan Method


SELECT   MIN(start_date)
         ,MAX(start_date) + 1
FROM     (
         SELECT start_date
                ,start_date - ROW_NUMBER() OVER (ORDER BY start_date) rownumb
         FROM   projects
         )
GROUP BY rownumb
ORDER BY MAX(start_date) - MIN(start_date)
         ,MAX(start_date);
