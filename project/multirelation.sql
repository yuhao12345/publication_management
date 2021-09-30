--select the keyword of articles exceed 4000 words

select keyword.name as keyword,title as article_title,length 
from keyword natural join article_key natural join article where length>4000 order by length;


--select the journals with their abbreviations whose parent company is established between 1950 and 2000, order by descending established year

select journal.name as journal_name,abbr,company.name as parent_company,established_year from journal join company using (company_id) 
where established_year<2000 and established_year>1950 order by established_year desc;


--select authors who puslished work on journals with impact factor larger than 20

select author.first_name,author.last_name,abbr as journal_abbr,impact_factor from author 
join writing using (author_ID) join article using (article_ID) 
join journal using (journal_ID) where impact_factor>20;


--select journal which has editor with more than 10 year working experience

select name as journal_name from journal join (select * from journal_editor 
where Editor_ID in (select Editor_ID from Editor where working_year>10)) as a using (journal_id);

--select all articles written by author whose last name contains 'or'

select title,first_name,last_name from  (select * from author where last_name like '%or%') as a
join writing on a.author_ID=writing.author_ID join article using (article_ID);


