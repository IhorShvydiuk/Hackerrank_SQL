SELECT
         CASE
          WHEN g.grade > 7 THEN s.name 
          ELSE 'NULL' 
         END AS NameNull
         ,g.grade
         ,s.marks
FROM     students s
         INNER JOIN grades g 
         ON s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY g.grade DESC
         ,NameNull ASC
         ,s.marks ASC;
