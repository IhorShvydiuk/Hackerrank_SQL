SELECT DISTINCT CITY
FROM   STATION
WHERE  NOT REGEXP_LIKE(CITY, '[aeiou]$', 'i')
       AND
       NOT REGEXP_LIKE(CITY, '^[AEIOU]')
ORDER BY CITY;
