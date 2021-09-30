--copy all table from csv files

\copy article (title,subject,length,journal_ID) from 'article.csv' with DELIMITER ',' CSV HEADER;


\copy journal (name,abbr,impact_factor,acception_rate,company_ID) from 'journal.csv' with DELIMITER ',' CSV HEADER;


\copy Editor (first_name,last_name,working_year) from 'Editor.csv' with DELIMITER ',' CSV HEADER;


\copy author(first_name,last_name,email) from 'author.csv' with DELIMITER ',' CSV HEADER;


\copy affliation(name,country,established_year,description) from 'affliation.csv' with DELIMITER ',' CSV HEADER;


\copy company(name, established_year,address) from 'company.csv' with DELIMITER ',' CSV HEADER;


\copy keyword(name, description) from 'keyword.csv' with DELIMITER ',' CSV HEADER;


\copy journal_editor from 'journal_editor.csv' with DELIMITER ',' CSV HEADER;


\copy writing from 'writing.csv' with DELIMITER ',' CSV HEADER;


\copy employer from 'employer.csv' with DELIMITER ',' CSV HEADER;


\copy article_key from 'article_key.csv' with DELIMITER ',' CSV HEADER;


\copy evaluate from 'evaluate.csv' with DELIMITER ',' CSV HEADER;