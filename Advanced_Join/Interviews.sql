SELECT  *
FROM    (
        SELECT cn.*
               ,(SELECT SUM(total_submissions)
                 FROM   submission_stats s ,challenges c, colleges cl
                 WHERE  s.challenge_id = c.challenge_id
                        AND c.college_id = cl.college_id
                        AND cl.contest_id = cn.contest_id) AS total_submissions,
               (SELECT  SUM(total_accepted_submissions)
                FROM    submission_stats s, challenges c, colleges cl
                WHERE   s.challenge_id = c.challenge_id
                        AND c.college_id = cl.college_id
                        AND cl.contest_id = cn.contest_id) AS total_accepted_submissions,
               (SELECT  SUM(total_views)
                FROM    view_Stats v, challenges c, colleges cl
                WHERE   v.challenge_id = c.challenge_id
                        AND c.college_id = cl.college_id
                        AND cl.contest_id = cn.contest_id) AS total_views,
               (SELECT  SUM(total_unique_views)
                FROM    view_Stats v, challenges c, colleges cl
                WHERE   v.challenge_id = c.challenge_id
                        AND c.college_id = cl.college_id
                        AND cl.contest_id = cn.contest_id) AS total_unique_views
         FROM contests cn
         )
WHERE    total_submissions != 0
         AND total_accepted_submissions != 0
         AND total_views != 0
         AND total_unique_views != 0
ORDER BY contest_id;
