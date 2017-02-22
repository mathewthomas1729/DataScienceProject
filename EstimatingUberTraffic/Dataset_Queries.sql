--move dataset to data directory without headers;

delete  from tweet_dataset;

copy tweet_dataset from 'C:\Program Files\PostgreSQL\9.6\data\sample_streamed.txt' with delimiter E'\t';

select * from tweet_dataset;

select * from tweet_Dataset where tweet_text like '%traffic%';

select * from tweet_Dataset where tweet_text like '%concert%';



