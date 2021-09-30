drop table if exists article cascade;
create table article(
article_ID serial primary key, 
title varchar(50) not null, 
subject varchar(10), 
length int, 
journal_ID int);

drop table if exists journal cascade;
create table journal(
journal_ID serial primary key,
name varchar(20),
abbr varchar(5),
impact_factor decimal(4,2),
acception_rate decimal(4,2),
company_ID int);

drop table if exists Editor cascade;
create table Editor(
Editor_ID serial primary key,
first_name varchar(20), 
last_name varchar(20), 
working_year int);

drop table if exists author cascade;
create table author(
author_ID serial primary key, 
first_name varchar(20) not null, 
last_name varchar(20) not null, 
email varchar(50));

drop table if exists affliation cascade;
create table affliation(
affliation_ID serial primary key,
name varchar(50) not null,
country varchar(60),
established_year int,
description varchar(50));

drop table if exists company cascade;
create table company(
company_ID serial primary key,
name varchar(50),
established_year int,
address varchar(100));

drop table if exists keyword cascade;
create table keyword(
keyword_ID serial primary key, 
name varchar(20), 
description varchar(50));

drop table if exists journal_editor;
create table journal_editor(
journal_ID int, 
Editor_ID int,
foreign key(journal_ID) references journal ON UPDATE CASCADE ON DELETE CASCADE,
foreign key(Editor_ID) references Editor ON UPDATE CASCADE ON DELETE CASCADE,
primary key(journal_ID,Editor_ID));

drop table if exists writing;
create table writing(
article_ID int, 
author_ID int,
writing_year decimal(4,0),
foreign key(article_ID) references article ON UPDATE CASCADE ON DELETE CASCADE,
foreign key(author_ID) references author ON UPDATE CASCADE ON DELETE CASCADE,
primary key(article_ID,author_ID));

drop table if exists employer;
create table employer(
author_ID int, 
affliation_ID int,
foreign key(author_ID) references author ON UPDATE CASCADE ON DELETE CASCADE,
foreign key(affliation_ID) references affliation ON UPDATE CASCADE ON DELETE CASCADE,
primary key(author_ID,affliation_ID));

drop table if exists article_key;
create table article_key(
article_ID int, 
keyword_ID int, 
primary key(article_ID,keyword_ID),
foreign key(article_ID) references article ON UPDATE CASCADE ON DELETE CASCADE,
foreign key(keyword_ID) references keyword ON UPDATE CASCADE ON DELETE CASCADE);

drop table if exists evaluate;
create table evaluate(
Editor_ID int, 
article_ID int, 
rank int,
primary key(Editor_ID,article_ID),
foreign key(article_ID) references article ON UPDATE CASCADE ON DELETE CASCADE,
foreign key(Editor_ID) references Editor ON UPDATE CASCADE ON DELETE CASCADE,
notes varchar(500));