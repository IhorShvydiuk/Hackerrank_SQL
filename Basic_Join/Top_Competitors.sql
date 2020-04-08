SELECT  hacker_id
        ,name
FROM    (
         SELECT   s.hacker_id
                  ,h.name
                  ,count(s.hacker_id) cn
         FROM     submissions s
                  INNER JOIN hackers h
                  ON s.hacker_id = h.hacker_id
                  INNER JOIN challenges c
                  ON s.challenge_id = c.challenge_id
                  INNER JOIN difficulty d
                  ON c.difficulty_level = d.difficulty_level
                  AND s.score = d.score
         GROUP BY s.hacker_id
                  ,h.name
         )
WHERE    cn > 1
ORDER BY cn DESC,
         hacker_id;
