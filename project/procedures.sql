--check the validity of email
--if the email is null, notify the user to enter email
--if the format of email is wrong, raise error

create or replace function valid_author_email()
returns trigger as
$$
begin
if new.email = '' or new.email is null then
	raise notice 'please input email for: % %',new.first_name, new.last_name;
elsif new.email is not null and new.email not like '%@%.%' then
	raise exception 'input email: % is invalid',new.email;
end if;
return new;
end;
$$
language plpgsql;



--keep track of the change of journal_ID
--save the log file to table article_audits

create or replace function log_journalID_changes()
returns trigger as
$$
begin
	if new.journal_ID != old.journal_ID then
		insert into article_audits(article_ID,title,old_journal_ID,new_journal_ID)
		values(old.article_ID,old.title,old.journal_ID,new.journal_ID);
	end if;
return new;
end;
$$
language plpgsql;


--comment journal based on impact_factor and acception_rate

create or replace function journal_eval()
returns trigger as
$$
begin
	if new.impact_factor>20 and new.acception_rate<0.1 then
		raise notice '%: high impact hard journal',new.name;
	elsif new.impact_factor>20 then
		raise notice '%: high impact journal',new.name;
	elsif new.acception_rate>0.5 then
		raise notice '%: easy journal',new.name;
	end if;
	return new;
end;
$$
language plpgsql;


--Calculate the average rank of articles written by the given author. The average rank is calculated as follows:

--1. each article has several rank given by editor, 
--if the number of evaluations is larger or equal three, 
--then the average rank is the average of rankings exclude the min and max value,
--otherwise, just give the average rank
--if there is no evaluation for this article, the avg rank for this article is 0

--2. calculate the average of rank of all articles written by this author

--function mean_rank_author calculates the average rank for a given author_ID
--which includes a sub-function mean_rank_article which calculates the average rank for the individual article


create or replace function mean_rank_author(author_ID integer)
returns NUMERIC(3,2) as 
$$
declare
	v record;
	v2 record;
	art_ID integer;
	sum_rank NUMERIC(6,2) :=0;
	count integer :=0;
begin
	for v in select * from writing loop
		if v.author_ID=author_ID then 
			art_ID=v.article_ID;
			count=count+1;
			sum_rank=sum_rank+mean_rank_article(art_ID);
		end if;
	end loop;
	if count=0 then
		return 0;
	else
		return cast(sum_rank/count as decimal(3,2));
	end if;
end;
$$
language plpgsql;


--subfunction

create or replace function mean_rank_article(article_ID integer)
returns decimal(3,2) as
$$
declare
	v record; 
	count integer :=0;
	sum_rank_individual_article integer :=0;
	min integer :=10000;
	max integer :=0;
begin
	for v in select * from evaluate loop
		if v.article_ID=article_ID then
			sum_rank_individual_article=sum_rank_individual_article+v.rank;
			count=count+1;
			if v.rank>max then
				max=v.rank;
			end if;
			if v.rank<min then
				min=v.rank;
			end if;
		end if;
	end loop;

	if count>=3 then
		return cast((sum_rank_individual_article-min-max)/(count-2) as decimal(3,2));
	elsif count=0 then
		return 0;
	else 
		return cast(sum_rank_individual_article/count as decimal(3,2));
	end if;
end;
$$
language plpgsql;
					
	