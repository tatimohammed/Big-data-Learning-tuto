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

-- Check for null values in each column
null_name = FILTER data BY name IS NULL;
null_date_of_event = FILTER data BY date_of_event IS NULL;
null_age = FILTER data BY age IS NULL;
null_citizenship = FILTER data BY citizenship IS NULL;
null_event_location = FILTER data BY event_location IS NULL;
null_event_location_district = FILTER data BY event_location_district IS NULL;
null_event_location_region = FILTER data BY event_location_region IS NULL;
null_date_of_death = FILTER data BY date_of_death IS NULL;
null_gender = FILTER data BY gender IS NULL;
null_took_part = FILTER data BY took_part_in_the_hostilities IS NULL;
null_place_of_residence = FILTER data BY place_of_residence IS NULL;
null_place_of_residence_district = FILTER data BY place_of_residence_district IS NULL;
null_type_of_injury = FILTER data BY type_of_injury IS NULL;
null_ammunition = FILTER data BY ammunition IS NULL;
null_killed_by = FILTER data BY killed_by IS NULL;
null_notes = FILTER data BY notes IS NULL;

-- Count the number of null values in each column
null_name_count = FOREACH (GROUP null_name ALL) GENERATE 'name' as colname, COUNT(null_name) as null_count;
null_date_of_event_count = FOREACH (GROUP null_date_of_event ALL) GENERATE 'date_of_event' as colname, COUNT(null_date_of_event) as null_count;
null_age_count = FOREACH (GROUP null_age ALL) GENERATE 'age' as colname, COUNT(null_age) as null_count;
null_citizenship_count = FOREACH (GROUP null_citizenship ALL) GENERATE 'citizenship' as colname, COUNT(null_citizenship) as null_count;
null_event_location_count = FOREACH (GROUP null_event_location ALL) GENERATE 'event_location' as colname, COUNT(null_event_location) as null_count;
null_event_location_district_count = FOREACH (GROUP null_event_location_district ALL) GENERATE 'event_location_district' as colname, COUNT(null_event_location_district) as null_count;
null_event_location_region_count = FOREACH (GROUP null_event_location_region ALL) GENERATE 'event_location_region' as colname, COUNT(null_event_location_region) as null_count;
null_date_of_death_count = FOREACH (GROUP null_date_of_death ALL) GENERATE 'date_of_death' as colname, COUNT(null_date_of_death) as null_count;
null_gender_count = FOREACH (GROUP null_gender ALL) GENERATE 'gender' as colname, COUNT(null_gender) as null_count;
null_took_part_count = FOREACH (GROUP null_took_part ALL) GENERATE 'took_part_in_the_hostilities' as colname, COUNT(null_took_part) as null_count;
null_place_of_residence_count = FOREACH (GROUP null_place_of_residence ALL) GENERATE 'place_of_residence' as colname, COUNT(null_place_of_residence) as null_count;
null_place_of_residence_district_count = FOREACH (GROUP null_place_of_residence_district ALL) GENERATE 'place_of_residence_district' as colname, COUNT(null_place_of_residence_district) as null_count;
null_type_of_injury_count = FOREACH (GROUP null_type_of_injury ALL) GENERATE 'type_of_injury' as colname, COUNT(null_type_of_injury) as null_count;
null_ammunition_count = FOREACH (GROUP null_ammunition ALL) GENERATE 'ammunition' as colname, COUNT(null_ammunition) as null_count;
null_killed_by_count = FOREACH (GROUP null_killed_by ALL) GENERATE 'killed_by' as colname, COUNT(null_killed_by) as null_count;
null_notes_count = FOREACH (GROUP null_notes ALL) GENERATE 'notes' as colname, COUNT(null_notes) as null_count;

-- Union all the results to get the final output
result = UNION 
    null_name_count,
    null_date_of_event_count,
    null_age_count,
    null_citizenship_count,
    null_event_location_count,
    null_event_location_district_count,
    null_event_location_region_count,
    null_date_of_death_count,
    null_gender_count,
    null_took_part_count,
    null_place_of_residence_count,
    null_place_of_residence_district_count,
    null_type_of_injury_count,
    null_ammunition_count,
    null_killed_by_count,
    null_notes_count;

-- Dump or store the 'result' relation as needed
DUMP result;

