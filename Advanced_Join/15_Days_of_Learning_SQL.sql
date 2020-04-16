SELECT submission_date
       ,cnt
       ,hacker_id
       ,name
FROM   (
        --we need only the first hacker who takes part in max num of submissions so row_num gives us that number
        SELECT submission_date
               ,cnt
               ,hacker_id
               ,name
               ,cnt2
               ,ROW_NUMBER() OVER (PARTITION BY submission_date ORDER BY cnt2 DESC, hacker_id) rnmbr
        FROM   (
               -- joined tables for looking the hacker id, name who takes part in max number of submissions per day
                SELECT qtwo.submission_date
                       ,qtwo.cnt
                       ,s1.hacker_id
                       ,h.name
                       ,COUNT(s1.hacker_id) OVER (PARTITION BY s1.submission_date, s1.hacker_id ORDER BY s1.hacker_id) cnt2
                FROM   (
                       -- if day submission = row_num it means that hacker takes part each day and these hackers we need to count
                       SELECT  submission_date
                               ,COUNT(DISTINCT hacker_id) cnt
                       FROM    (
                               --get data with ROW_NUMBER(). It is needed for comparing submission day with row_num
                               SELECT hacker_id
                                      ,submission_date
                                      ,ROW_NUMBER() OVER (PARTITION BY hacker_id ORDER BY submission_date) rhs
                               FROM   (
                                       --get data without duplicates
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
