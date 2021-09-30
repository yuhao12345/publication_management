--the mean and max of impactor factor of journals for each subject

select subject,avg(impact_factor),max(impact_factor),count(*) 
from article natural join journal 
group by subject;


--for the subject with more than 3 articles, calculate the average working year of their editors

select subject,count(*),avg(working_year) as avg_working_year 
from article join evaluate using (article_ID) join Editor using (editor_ID)
group by subject 
having count(*)>3;


--use view editorjournal, 
--list the article,journal and correspoding editor where
--the acception rate of journal<0.3 and length of article>1000

select * from article natural join 
(select * from editorjournal where acception_rate<0.3) as temp
where length>1000;


--use view journal_old, 
--list all information about journal whose parent company is before 1990
--and list all editors even though they do not work for these journals


select * from journal_old full outer join journal_editor using (journal_ID) 
full outer join editor using (editor_ID);



--use view longarticle
--list author who wrote the articles in view longarticle after year 1990

select * from longarticle natural join writing 
join author using (author_ID) 
where writing_year>1990 order by writing_year;




--create temp table 

create temporary table tmp as
select * from article where subject!='music' 
and journal_ID is not null;


--based on the temp tabel, add length label for each article and list their evalation

select title,subject,length,journal_ID,notes,editor_ID,
case when length<2000 then 'short'
when length>5000 then 'long'
else 'middle'
end as lengthlabel 
from tmp join evaluate on tmp.article_ID=evaluate.article_ID;