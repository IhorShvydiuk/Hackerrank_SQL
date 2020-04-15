SELECT submission_date
       ,cnt
       ,hacker_id
       ,name
FROM   (
        SELECT submission_date
               ,cnt
               ,hacker_id
               ,name
               ,cnt2
               ,ROW_NUMBER() OVER (PARTITION BY submission_date ORDER BY cnt2 DESC, hacker_id) rnmbr
        FROM   (
                SELECT qtwo.submission_date
                       ,qtwo.cnt
                       ,s1.hacker_id
                       ,h.name
                       ,COUNT(s1.hacker_id) OVER (PARTITION BY s1.submission_date, s1.hacker_id ORDER BY s1.hacker_id) cnt2
                FROM   (
                       SELECT  submission_date
                               ,COUNT(DISTINCT hacker_id) cnt
                       FROM    (
                               SELECT hacker_id
                                      ,submission_date
                                      ,ROW_NUMBER() OVER (PARTITION BY hacker_id ORDER BY submission_date) rhs
                               FROM   (
                                       SELECT DISTINCT hacker_id
                                                       ,submission_date 
                                       FROM submissions
                                      ) qone
                               )
                       WHERE    EXTRACT(day FROM submission_date) = rhs
                       GROUP BY submission_date
                       ORDER BY submission_date
                       ) qtwo
                       INNER JOIN submissions s1
                       ON qtwo.submission_date = s1.submission_date
                       INNER JOIN hackers h
                       ON s1.hacker_id = h.hacker_id
                ) qthree
       ) qfour
WHERE  rnmbr = 1;
