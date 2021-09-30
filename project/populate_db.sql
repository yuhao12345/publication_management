--copy all table from csv files

\copy article (title,subject,length,journal_ID) from 'article_small.csv' with DELIMITER ',' CSV HEADER;


\copy journal (name,abbr,impact_factor,acception_rate,company_ID) from 'journal_small.csv' with DELIMITER ',' CSV HEADER;


\copy Editor (first_name,last_name,working_year) from 'Editor_small.csv' with DELIMITER ',' CSV HEADER;


\copy author(first_name,last_name,email) from 'author_small.csv' with DELIMITER ',' CSV HEADER;


\copy affliation(name,country,established_year,description) from 'affliation_small.csv' with DELIMITER ',' CSV HEADER;


\copy company(name, established_year,address) from 'company_small.csv' with DELIMITER ',' CSV HEADER;


\copy keyword(name, description) from 'keyword_small.csv' with DELIMITER ',' CSV HEADER;


\copy journal_editor from 'journal_editor_small.csv' with DELIMITER ',' CSV HEADER;


\copy writing from 'writing_small.csv' with DELIMITER ',' CSV HEADER;


\copy employer from 'employer_small.csv' with DELIMITER ',' CSV HEADER;


\copy article_key from 'article_key_small.csv' with DELIMITER ',' CSV HEADER;


\copy evaluate from 'evaluate_small.csv' with DELIMITER ',' CSV HEADER;