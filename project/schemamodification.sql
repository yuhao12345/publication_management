--add column age

alter table author 
add age int default 0;


--change column last_name's type to varchar(100)

alter table author alter column last_name type  varchar(100);

--drop age column from author

alter table author drop age;