--Add mean_rank for each author based on the rank in evaluation
--function mean_rank_author(author_ID integer) and 
-- subfunction mean_rank_article(article_ID integer) are used
--only show the results for the first 20 authors

select *,mean_rank_author(author_ID) as mean_rank from author
where author_ID<=20 
order by mean_rank desc;