/* 3. Sa se creeze un pachet utilizator care sa contina cel putin 3 functii/proceduri care sa poata: 
a) sa afiseze date din view-urile de la punctul 1, datele fiind filtrate dupa cel putin 2 parametri 
de intrare*/

SELECT * FROM studenti;

CREATE OR REPLACE PACKAGE studenti_pkg IS
  -- get student information by section and minimum average grade
  FUNCTION get_students_by_sectie_medie(cod_sectia_in studenti.cod_sectia%TYPE, 
                                        min_media_in studenti.media%TYPE) 
                                        RETURN SYS_REFCURSOR;
  -- get students from a given group whose average grade is within a specified range
  FUNCTION get_students_by_grupa_medie(grupa_in studenti.grupa%TYPE, 
                                          min_media_in studenti.media%TYPE, 
                                          max_media_in studenti.media%TYPE) 
                                          RETURN SYS_REFCURSOR;
                                          
  -- get the top 3 students by group and minimum average grade                      
  FUNCTION get_top_students_by_grupa_min_media(grupa_in studenti.grupa%TYPE,
                                               min_media_in studenti.media%TYPE)
                                               RETURN SYS_REFCURSOR;  
                                               
  PROCEDURE log_function_call(function_name IN VARCHAR2, 
                              start_time IN TIMESTAMP, 
                              end_time IN TIMESTAMP, 
                              is_success IN CHAR, 
                              error_message IN VARCHAR2);
                              
  PROCEDURE handle_error(error_code IN VARCHAR2, error_message IN VARCHAR2);
END studenti_pkg;


CREATE OR REPLACE PACKAGE BODY studenti_pkg IS

  FUNCTION get_students_by_sectie_medie(cod_sectia_in studenti.cod_sectia%TYPE, 
                                           min_media_in studenti.media%TYPE) 
                                           RETURN SYS_REFCURSOR IS
    cur SYS_REFCURSOR;
    l_start_time TIMESTAMP;
    l_end_time TIMESTAMP;
    l_error_msg VARCHAR2(4000) := NULL;
  BEGIN
    l_start_time := SYSTIMESTAMP;
    -- get student information by section and minimum average grade
    OPEN cur FOR
      SELECT nume, prenume, cod_sectia, media
      FROM informatii_studenti
      WHERE cod_sectia = cod_sectia_in AND media >= min_media_in;
    l_end_time := SYSTIMESTAMP;
    log_function_call('get_students_by_sectie_medie', l_start_time, l_end_time, 'Y', NULL);
    RETURN cur;
  EXCEPTION
    WHEN OTHERS THEN
      l_end_time := SYSTIMESTAMP;
      handle_error(SQLCODE, SQLERRM);
      log_function_call('get_students_by_sectie_medie', l_start_time, l_end_time, 'N', SQLERRM);
      RAISE;
  END get_students_by_sectie_medie;
  
  ---------------------------------------------------------------------------------------------------------
  
  FUNCTION get_students_by_grupa_medie(grupa_in studenti.grupa%TYPE, 
                                    min_media_in studenti.media%TYPE, 
                                    max_media_in studenti.media%TYPE) 
                                    RETURN SYS_REFCURSOR IS
  cur SYS_REFCURSOR;
  l_start_time TIMESTAMP;
  l_end_time TIMESTAMP;
  l_error_msg VARCHAR2(4000) := NULL;
  BEGIN
    l_start_time := SYSTIMESTAMP;
    -- get students from a given group whose average grade is within a specified range
    OPEN cur FOR
      SELECT nume, prenume, grupa, media, media_sectiei, varianta, poz_student
      FROM info_medii_studenti
      WHERE grupa = grupa_in AND media BETWEEN min_media_in AND max_media_in;
    l_end_time := SYSTIMESTAMP;
    log_function_call('get_students_by_grupa_medie', l_start_time, l_end_time, 'Y', NULL);
    RETURN cur;
  EXCEPTION
    WHEN OTHERS THEN
      l_end_time := SYSTIMESTAMP;
      handle_error(SQLCODE, SQLERRM);
      log_function_call('get_students_by_grupa_medie', l_start_time, l_end_time, 'N', SQLERRM);
      RAISE;
  END get_students_by_grupa_medie;

  ---------------------------------------------------------------------------------------------------------
  
  FUNCTION get_top_students_by_grupa_min_media(grupa_in studenti.grupa%TYPE,
                                               min_media_in studenti.media%TYPE)
                                               RETURN SYS_REFCURSOR IS
  cur SYS_REFCURSOR;
  l_start_time TIMESTAMP;
  l_end_time TIMESTAMP;
  l_error_msg VARCHAR2(4000) := NULL;
  BEGIN
    l_start_time := SYSTIMESTAMP;
    -- get the top 3 students by group and minimum average grade                      
    OPEN cur FOR
      SELECT nume, prenume, grupa, media
      FROM top_3_medii
      WHERE grupa = grupa_in AND media > min_media_in;
    l_end_time := SYSTIMESTAMP;
    log_function_call('get_top_students_by_grupa_min_media', l_start_time, l_end_time, 'Y', NULL);
    RETURN cur;
  EXCEPTION
    WHEN OTHERS THEN
      l_end_time := SYSTIMESTAMP;
      handle_error(SQLCODE, SQLERRM);
      log_function_call('get_top_students_by_grupa_min_media', l_start_time, l_end_time, 'N', SQLERRM);
      RAISE;
  END get_top_students_by_grupa_min_media;
  
  ---------------------------------------------------------------------------------------------------------

  PROCEDURE log_function_call(function_name IN VARCHAR2, start_time IN TIMESTAMP, end_time IN TIMESTAMP, is_success IN CHAR, error_message IN VARCHAR2) AS
      l_interval INTERVAL DAY TO SECOND;
      nr_seconds NUMBER;
  BEGIN
      l_interval := end_time - start_time;
      nr_seconds := EXTRACT(DAY FROM l_interval) * 86400 + 
                    EXTRACT(HOUR FROM l_interval) * 3600 + 
                    EXTRACT(MINUTE FROM l_interval) * 60 + 
                    EXTRACT(SECOND FROM l_interval);
      INSERT INTO function_log(log_id, function_name, start_time, end_time, nr_seconds, is_success, error_message)
      VALUES (function_log_seq.NEXTVAL, function_name, start_time, end_time, nr_seconds, is_success, NVL(error_message, 'No Errors'));
  END log_function_call;

  
  ---------------------------------------------------------------------------------------------------------

  PROCEDURE handle_error(error_code IN VARCHAR2, error_message IN VARCHAR2) IS
  BEGIN
    RAISE_APPLICATION_ERROR(-20000, error_message);
  END handle_error;
  
END studenti_pkg;



/* b) sa contina o functie de jurnalizare/log (inserarea de inregistrari intr-o tabela numita 
jurnal/log, la fiecare apel de porcedura/functie de la punctul a), la inceputul si/sau sfarsitul ei, 
pentru a calcula durata, fie la terminare cu succes, fie cu eroare; tabela trebuie sa contina 
detalii despre functia rulata, durata, daca rularea a fost cu succes sau eroare, si eroarea).*/
CREATE TABLE function_log (
  log_id         NUMBER PRIMARY KEY,
  function_name  VARCHAR2(100),
  start_time     TIMESTAMP,
  end_time       TIMESTAMP,
  nr_seconds       NUMBER,
  is_success        CHAR(1), -- (Y - succes / N - failure)
  error_message  VARCHAR2(4000)
);

SELECT * FROM function_log;

CREATE SEQUENCE function_log_seq START WITH 1;
