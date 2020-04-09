SELECT id
       ,age
       ,coins_needed
       ,power 
FROM   (
        SELECT w.id
               ,wp.age
               ,w.coins_needed
               ,w.power
               ,RANK() OVER (PARTITION BY w.power, wp.age ORDER BY w.coins_needed ASC) rn
        FROM   wands w
               INNER JOIN wands_property wp
               USING(code)
        WHERE  wp.is_evil = 0
        )
WHERE    rn =1
ORDER BY power DESC
         ,age DESC;






