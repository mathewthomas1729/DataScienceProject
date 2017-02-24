--move dataset to data directory without headers;

delete  from tweet_dataset;

copy tweet_dataset from 'C:\Program Files\PostgreSQL\9.6\data\nyc_streamed_dataset.txt' with delimiter E'\t';

select * from tweet_dataset;

select * from tweet_Dataset where tweet_text like '%Incident%';

select * from tweet_Dataset where tweet_text like '%concert%';



select case  when uber_estimate<0 then 'Invalid'
when uber_estimate>=0 and uber_estimate<10 then '0-30'
when uber_estimate>=10 and uber_estimate<20 then '30-60'
when uber_estimate>=20 and uber_estimate<30 then '60-90'
when uber_estimate>=30 and uber_estimate<40 then '90-120'
when uber_estimate>=40 and uber_estimate<50 then '120-150'
when uber_estimate>=50 and uber_estimate<60 then '150-180'
when uber_estimate>=60 and uber_estimate<70 then '180-210'
when uber_estimate>=70 and uber_estimate<80 then '210-240'
else '240 & Above' end as estimate_range,count(*)
from tweet_Dataset
group by estimate_range


select case  when uber_estimate<0 then 'Invalid'
when uber_estimate>=0 and uber_estimate<30 then '0-30'
when uber_estimate>=30 and uber_estimate<60 then '30-60'
when uber_estimate>=60 and uber_estimate<90 then '60-90'
when uber_estimate>=90 and uber_estimate<120 then '90-120'
when uber_estimate>=120 and uber_estimate<150 then '120-150'
when uber_estimate>=150 and uber_estimate<180 then '150-180'
when uber_estimate>=180 and uber_estimate<210 then '180-210'
when uber_estimate>=210 and uber_estimate<240 then '210-240'
else '240 & Above' end as estimate_range,count(*)
from tweet_Dataset
group by estimate_range


select tweet_text from tweet_Dataset
where uber_estimate>>90

drop table nyc_twitter_data

tweet_id	tweet_text	tweet_coordinates	lat_origin	long_origin	uber_estimate	zip_code	eastern_time	hours	weekday	day_hour	Is_Traffic_Related

delete * from nyc_twitter_data
create table nyc_twitter_data
(
    tweet_id varchar,
    tweet_text text,
    tweet_coordinates text,
    lat_origin	float,
    long_origin	float,
    uber_estimate float,
    zip_code	varchar,
    eastern_time timestamp with time zone,
    hours integer,
    weekday integer,
    day_hour integer,
    Is_Traffic_Related boolean
    )
	
	copy nyc_twitter_data from 'C:\Program Files\PostgreSQL\9.6\data\final_dataframe_dataset_with_zip_code.txt' with delimiter E'\t';
	
	select distinct t.* from nyc_twitter_data limit 5;
	
copy (select distinct t.* from nyc_twitter_data as t) to 'C:\Program Files\PostgreSQL\9.6\data\final_op.txt' with csv header;

create table nyc_zip_codes
(
county varchar,
zip_code varchar,
Neighbourhood varchar,
NeighbourHood_Code varchar)

copy nyc_zip_codes from 'C:\Program Files\PostgreSQL\9.6\data\nyc_zip_codes.txt' with delimiter E'\t';

copy (select t.*,nyc_zip_codes.county from nyc_twitter_data t
 join nyc_zip_codes
on t.zip_code=nyc_zip_codes.zip_code ) to 'C:\Program Files\PostgreSQL\9.6\data\final_op.txt' with delimiter E'\t';

select county,count(*) from nyc_twitter_data t
 join nyc_zip_codes
on t.zip_code=nyc_zip_codes.zip_code 
group by county

select t.zip_code,count(*) from nyc_twitter_data t
join nyc_zip_codes
on t.zip_code=nyc_zip_codes.zip_code 
WHERE county='New York'
group by t.zip_code
order by count(*) desc

update nyc_zip_codes
set county='Manhattan' where county='New York'