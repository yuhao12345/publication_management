--create a view which contains editor's information and journal's information, simplify the later query

drop view if exists editorjournal;
create view editorjournal as
select journal_ID,concat(first_name,' ',last_name) as name,working_year,abbr,impact_factor,acception_rate
from editor join journal_editor using (editor_ID) join journal using (journal_ID);


--create a view with all journals whose parent company is established before 1990, simplify the later query

drop view if exists journal_old;
create view journal_old as
select journal_ID,journal.abbr as journal_abbr,company.name as company_name,established_year
from journal inner join company on journal.company_ID=company.company_ID
where established_year<1990;

--create view the contains the longest and second longest articles for each subject, simplify the query and hide the information of short articles

drop view if exists longarticle;
create view longarticle as
select * from (select *,rank() over(partition by subject order by length desc) as rank 
from article) as ranking 
where ranking.rank<=2;


