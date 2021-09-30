--INSERT a single tuple to article

insert into article (title,subject,length,journal_ID) values('sasfffgw','cs',2000,5);


--INSERT a single tuple to journal

insert into journal(journal_ID,name,impact_factor)
values(35,'sdgfdewwg',10);


--INSERT company established after 1995 into affliation

insert into affliation(name,established_year)
select name,established_year from company
where company.established_year>1995;


--insert Editor whose first contains 'aw' into author

insert into author(first_name,last_name)
select first_name,last_name from Editor
where first_name like '%aw%';



--DELETE author whose first name contain 'al'

delete from author
where first_name like '%al%';


--delete affliation established before 1950 or after 2000

delete from affliation 
where established_year<1950 
or established_year>2000;



--increase 5 year if established_year<1970

update affliation
set established_year=established_year+5
where established_year<1970;

--change impact_factor for journal 'rYIUP'

update journal
set impact_factor=impact_factor*2
where abbr='rYIUP';