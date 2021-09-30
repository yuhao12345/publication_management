--return editors whose working experience is between 10 and 20 years, show their ID, first name and correspoding working years

select editor_id,first_name,working_year from editor where working_year<20 and working_year>10;




--return the whole information of authors whose first name contains 'ch' or last name contains 'rt'

select * from author where (first_name like '%ch%' or last_name like '%rt%');



--list all journals whose impact factor>10, order them by descendent acception rate 

select * from journal where impact_factor>10 order by acception_rate desc;