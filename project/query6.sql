--For editor who has evaluated more than 30 articles, 
--list 10 of them who give the highest average rank
--and articles they evaluated whose rank=5

with evaluate_30 as(
select * from evaluate 
where Editor_ID in
(select Editor_ID from evaluate group by Editor_ID having count(*)>30)
),
article_30 as(
select * from
(evaluate_30 join article
using(article_ID)))

select Editor_ID,avg as avg_rank,first_name,last_name,title as article from
(select Editor_ID,avg(rank)
from article_30
group by Editor_ID
order by avg desc limit 10) as tmp1
join Editor
using(Editor_ID)
join 
(select * from article_30
where rank=5) as tmp2
using (Editor_ID)
order by Editor_ID limit 15;


--list articles that have less than 10 authors,
--and at least three of them work in the same affliations

with article_affliation as(
select article_ID,author_ID,affliation_ID from
(select article_id,count(*) from writing
group by article_id
having count(*)<10) as tmp
natural join 
writing
natural join 
employer)

select * from
(select distinct a1.article_ID,a1.author_ID,a2.author_ID,a3.author_ID,a1.affliation_ID from 
article_affliation a1,
article_affliation a2,
article_affliation a3
where (a1.article_ID=a2.article_ID
and a2.article_ID=a3.article_ID
and a1.author_ID<a2.author_ID
and a2.author_ID<a3.author_ID
and a1.affliation_ID=a2.affliation_ID
and a2.affliation_ID=a3.affliation_ID)) as tmp2
natural join 
(select article_ID,title from article) as tmp3
order by article_ID
limit 15;


--The following two queries compare the effect of index



--find authors who write articles in physics with article_length>300,
--and the article_ID<100 and receive rank 3 in the evaluation

--use index article_sub, evaluate_rank_asc
--these two indices are both on multiple attributes
--For instance, index evaluate_rank_asc is on rank asc,article_ID
--the sorted rank in the index faciliates to retrive data with rank=3

--without index, Execution time: 6.13 ms
--with index, Execution time: 4.12 ms

--explain analyze
select * from
((select article_ID from evaluate 
where rank=3
and article_ID<100)
intersect
(select article_ID from article 
where subject='phys'
and length>3000)) as tmp
join writing
using(article_ID)
join author
using(author_ID);



--find keyword appears in cs and 500<keyword_ID<600 

--use index article_sub, key_asc
--without index, Execution time: 7.4 ms
--with index, Execution time: 2.73 ms

--explain analyze
select * from 
(select article_ID from article
where subject='cs') as tmp
join
(select * from article_key
where keyword_ID<600
and keyword_ID>500) as tmp2
using (article_ID)
join keyword
using (keyword_ID);




 