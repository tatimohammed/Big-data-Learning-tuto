-- Load the CSV file into a relation with your specified schema
data = LOAD 'fatalities_isr_pse_conflict_2000_to_2023.csv' USING PigStorage(',') AS (
    name: chararray,
    date_of_event: chararray,
    age: int,
    citizenship: chararray,
    event_location: chararray,
    event_location_district: chararray,
    event_location_region: chararray,
    date_of_death: chararray,
    gender: chararray,
    took_part_in_the_hostilities: chararray,
    place_of_residence: chararray,
    place_of_residence_district: chararray,
    type_of_injury: chararray,
    ammunition: chararray,
    killed_by: chararray,
    notes: chararray
);

-- Extract the year from the date_of_event field
-- Drop the columns: name, date_of_death and notes 
data_with_year = FOREACH data GENERATE
    SUBSTRING(date_of_event, 0, 4) AS year,
    age AS age,
    citizenship,
    event_location,
    event_location_district,
    event_location_region,
    gender,
    took_part_in_the_hostilities,
    type_of_injury,
    ammunition,
    killed_by;

-- Store the data as a CSV file
STORE data_with_year INTO 'transformed_data' USING PigStorage(',');

