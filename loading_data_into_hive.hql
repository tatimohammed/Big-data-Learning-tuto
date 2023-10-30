CREATE DATABASE IF NOT EXISTS project;
USE project;


CREATE TABLE data (
    date_year VARCHAR(200),
    age INT,
    citizenship VARCHAR(200),
    event_location VARCHAR(200),
    event_location_district VARCHAR(200),
    event_location_region VARCHAR(200),
    gender VARCHAR(2),
    took_part_in_the_hostilities VARCHAR(200),
    type_of_injury VARCHAR(200),
    ammunition VARCHAR(200),
    killed_by VARCHAR(200)
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

LOAD DATA INPATH 'hdfs://36c3d670ced2:9000/projects/palestine/transformed_data.csv' OVERWRITE INTO TABLE data;

