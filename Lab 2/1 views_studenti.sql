/* 1. Folosind tabelul "studenti" creat in primul laborator, creati un view ce contine, pentru fiecare 
student: nume, prenume, cod_sectia, denumire_sectia, an_studiu, grupa, media */

SELECT * FROM studenti

CREATE OR REPLACE VIEW informatii_studenti AS 
    SELECT nume, prenume, cod_sectia, denumire_sectia, an_studiu, grupa, media
    FROM studenti
    
SELECT * FROM informatii_studenti

/* Folosind acest view, se cer view-uri pentru urmatoarele probleme (se rezolva usor cu functiile analitice): 
a) Pentru fiecare student se cere: nume, prenume, grupa, media, media sectiei din care face parte, 
distanta fata de medie (varianta), pozitia studentului in anul din care face parte (in ordonarea 
studentilor descrescator dupa medie). */


CREATE OR REPLACE VIEW info_medii_studenti AS
    SELECT nume, prenume, grupa, media,
        AVG(media) OVER (PARTITION BY cod_sectia) AS media_sectiei,
        VARIANCE(media) OVER (PARTITION BY cod_sectia) as varianta,
        ROW_NUMBER() OVER (PARTITION BY an_studiu ORDER BY media DESC) AS poz_student
    FROM informatii_studenti;
    
SELECT * FROM info_medii_studenti;

-- b) Studentii care au primele 3 medii cele mai mari din fiecare grupa. 
CREATE OR REPLACE VIEW top_3_medii AS
    WITH local_view_poz_student AS(
        SELECT nume, prenume, grupa, media,
            ROW_NUMBER() OVER (PARTITION BY grupa ORDER BY media DESC) AS poz_student_grupa
        FROM informatii_studenti
    )
    SELECT nume, prenume, grupa, media
    FROM local_view_poz_student
    WHERE poz_student_grupa <= 3;
    
SELECT * FROM top_3_medii;
