SELECT DISTINCT CITY
FROM   STATION
WHERE  REGEXP_LIKE(CITY, '^[AEIOU]')
ORDER BY CITY;
