SELECT   h.hacker_id
         ,h.name
         ,COUNT(c.challenge_id)
FROM     hackers h
         INNER JOIN challenges c
         ON h.hacker_id = c.hacker_id
GROUP BY h.hacker_id
         ,h.name
HAVING   COUNT(c.challenge_id) NOT IN (
            SELECT COUNT(challenge_id) 
            FROM challenges
            WHERE hacker_id != h.hacker_id 
            GROUP BY hacker_id 
            HAVING COUNT(challenge_id) != (
                    SELECT MAX(COUNT(challenge_id)) 
                    FROM challenges 
                    GROUP BY hacker_id))
ORDER BY COUNT(c.challenge_id) DESC
         ,hacker_id;
