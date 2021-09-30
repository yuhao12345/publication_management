drop index if exists article_sub;
drop index if exists key_asc;
drop index if exists evaluate_rank_asc;


--facilitates operation of equality and range on certain attribute

--index on multiple attributes: subject,length for table article
--accelerate the filter such as subject='cs' and length>300


create index article_sub on article (subject,length);

--index on rank,article_ID for table evaluate
--can get evaluation with a specific rank quickly
create index evaluate_rank_asc on evaluate (rank asc,article_ID);

--index on keyword_ID for table article_key
create index key_asc on article_key (keyword_ID asc);


