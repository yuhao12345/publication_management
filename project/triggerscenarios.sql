--1. For trigger check_email


--trigger has effects
--remind user to enter email for the 1st inserted turple
--raise exception due to the format error of email for the 2nd turple

insert into author(first_name,last_name,email)
values
('bob','toy','');


insert into author(first_name,last_name,email)
values
('lily','jon','ahJSK@yahoocom');



--query
--only 'bob toy' is inserted
--'lily join' is not inserted due to format problem
select * from author
where author_ID >1990;

--trigger has no effect

insert into author(first_name,last_name,email)
values
('david','ali','ayuyed@google.com'),
('alice','ali','ayaef@google.com');

--query
--david and alice are both inserted into table
select * from author
where author_ID >1990;




--2. For trigger article_change 

--trigger has effects, the log table article_audits records the change of journal_ID
update article
set journal_ID=5
where article_ID=3 or article_ID=5;

--query
--table article_audits records both old and new journal_ID
select * from article_audits;

--trigger has no effect since journal_ID is not changed

update article
set length=1000
where article_ID=3 or article_ID=5;

--query
--there is no new records in article_audits
select * from article_audits;





--3. For trigger journal_comment

--trigger has effects, gives evaluation for the inserted journals
--the notice appear during the insertion
insert into journal(name,impact_factor,acception_rate)
values
('adsf',23,0.1),
('fdggs',15,0.6);

--query, records are inserted
select * from journal 
where journal_ID>45;


--trigger has no effect

insert into journal(name,impact_factor,acception_rate)
values
('addfsf',10,0.3),
('fdgedsgs',15,0.4);

--query, records are inserted
select * from journal 
where journal_ID>45;



