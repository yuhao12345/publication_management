--show the number of article in each subject if the number is larger than 3

select subject,count(*) from article group by subject having count(*)>3;


--show the average length of article in each subject

select subject,avg(length) from article group by subject;


--select the articles with longest length in their respective subject

select article.subject,title as article_title,length from article 
join (select subject,max(length) from article group by subject) as a 
on article.length=a.max and article.subject=a.subject;