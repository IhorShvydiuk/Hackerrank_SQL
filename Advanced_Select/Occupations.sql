SELECT DOCTOR 
       ,PROFESSOR
       ,SINGER
       ,ACTOR
FROM  (
      SELECT NAME
             ,OCCUPATION
             ,ROW_NUMBER() OVER (PARTITION BY OCCUPATION ORDER BY NAME ASC) RN
      FROM OCCUPATIONS
      )
PIVOT
     (
      MAX(NAME) 
      FOR OCCUPATION 
      IN ('Doctor' as DOCTOR
         ,'Professor' as PROFESSOR
         ,'Singer' as SINGER
         ,'Actor' as ACTOR)
     )
ORDER BY RN;
