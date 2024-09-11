/* 4. Se vor folosi view-uri sistem pentru a obtine informatii cu privire la: tabelele definite,  
tabelele la care se are acces, restrictiile definite, indexurile construite, coloanele dintr-un 
anumit tabel (denumire, tip). (0.5p)*/

// All object tables and relational tables owned by the current user. This view does not display the OWNER column. (current schema)
SELECT * FROM USER_ALL_TABLES;

// All object tables and relational tables accessible to the current user. (all schemas)
SELECT * FROM ALL_ALL_TABLES;

SELECT constraint_name, constraint_type, search_condition FROM user_constraints WHERE table_name = 'CAFES';
SELECT index_name, uniqueness FROM user_indexes WHERE table_name = 'CAFES';
SELECT column_name, data_type FROM user_tab_columns WHERE table_name = 'CAFES';

SELECT constraint_name, constraint_type, search_condition FROM user_constraints WHERE table_name = 'SUPPLIERS';
SELECT index_name, uniqueness FROM user_indexes WHERE table_name = 'SUPPLIERS';
SELECT column_name, data_type FROM user_tab_columns WHERE table_name = 'SUPPLIERS';

SELECT constraint_name, constraint_type, search_condition FROM user_constraints WHERE table_name = 'CAFES_SUPPLIERS';
SELECT index_name, uniqueness FROM user_indexes WHERE table_name = 'CAFES_SUPPLIERS';
SELECT column_name, data_type FROM user_tab_columns WHERE table_name = 'CAFES_SUPPLIERS';

SELECT constraint_name, constraint_type, search_condition FROM user_constraints WHERE table_name = 'STUDENTI';
SELECT index_name, uniqueness FROM user_indexes WHERE table_name = 'STUDENTI';
SELECT column_name, data_type FROM user_tab_columns WHERE table_name = 'STUDENTI'