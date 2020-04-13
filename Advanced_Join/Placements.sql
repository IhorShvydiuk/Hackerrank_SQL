SELECT   s.name
FROM     students s
         INNER JOIN friends f
         USING (id)
         INNER JOIN packages p
         USING (id)
         INNER JOIN packages p2
         ON f.friend_id = p2.id
WHERE    p.salary < p2.salary
ORDER BY p2.salary;
