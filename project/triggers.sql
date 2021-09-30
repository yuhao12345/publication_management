--check the format of email in table author is correct

drop trigger if exists check_email on author;
create trigger check_email
before update or insert
on author
for each row
execute procedure valid_author_email();



--the table article_audits is a log file contains article_id/title from table article
--in addition, it keeps track of the change of journal_ID


drop table if exists article_audits;
create table article_audits(
article_id int primary key,
title varchar(50) not null, 
old_journal_ID int,
new_journal_ID int);

drop trigger if exists article_change on article;
create trigger article_change
before update
on article
for each row
execute procedure log_journalID_changes();




--comment the journal for each insertion based on the impact_factor and acception_rate

drop trigger if exists journal_comment on journal;
create trigger journal_comment
before insert
on journal
for each row
execute procedure journal_eval();

