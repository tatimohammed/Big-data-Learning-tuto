
USE project;

CREATE TABLE fatalities_by_year AS
SELECT
    date_year AS year,
    COUNT(*) AS fatalities
FROM data
GROUP BY date_year
ORDER BY year;

CREATE TABLE fatalities_by_age AS
SELECT
    age AS age,
    COUNT(*) AS fatalities
FROM data
GROUP BY age
ORDER BY age;


