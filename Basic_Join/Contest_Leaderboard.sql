SELECT hacker_id
       ,name
       ,SUM(score) AS total
FROM
        (
        SELECT DISTINCT h.hacker_id
                        ,h.name
                        ,s.challenge_id
                        ,s.score
                        ,RANK() OVER (PARTITION BY s.hacker_id, s.challenge_id ORDER BY s.score DESC) rnk
        FROM hackers h
             INNER JOIN submissions s
             ON h.hacker_id = s.hacker_id
        )
WHERE    rnk = 1
         AND
         score > 0
GROUP BY hacker_id
         ,name
ORDER BY sum(score) DESC
         ,hacker_id;
