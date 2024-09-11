SELECT * FROM function_log


-- Call first function with error
DECLARE
  v_cursor SYS_REFCURSOR;
  v_nume studenti.nume%TYPE;
  v_prenume studenti.prenume%TYPE;
  v_cod_sectia studenti.cod_sectia%TYPE;
  v_media studenti.media%TYPE;
BEGIN
  v_cursor := studenti_pkg.get_students_by_sectie_medie(cod_sectia_in => 22, min_media_in => 17.0);
  
  LOOP
    FETCH v_cursor INTO v_nume, v_prenume, v_cod_sectia, v_media;
    EXIT WHEN v_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Nume: ' || v_nume || 
                         ', Prenume: ' || v_prenume || 
                         ', Cod Sectia: ' || v_cod_sectia || 
                         ', Media: ' || v_media);
  END LOOP;
  
  CLOSE v_cursor;
END;


-- Call the second function with error
DECLARE
  v_cursor SYS_REFCURSOR;
  v_nume studenti.nume%TYPE;
  v_prenume studenti.prenume%TYPE;
  v_grupa studenti.grupa%TYPE;
  v_media studenti.media%TYPE;
  v_media_sectiei info_medii_studenti.media_sectiei%TYPE;
  v_varianta info_medii_studenti.varianta%TYPE;
  v_poz_student info_medii_studenti.poz_student%TYPE;
BEGIN
  v_cursor := studenti_pkg.get_students_by_grupa_medie(grupa_in => 'ABC', min_media_in => 7.0, max_media_in => 9.0);
  LOOP
    FETCH v_cursor INTO v_nume, v_prenume, v_grupa, v_media, v_media_sectiei, v_varianta, v_poz_student;
    EXIT WHEN v_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Nume: ' || v_nume || 
                         ', Prenume: ' || v_prenume || 
                         ', Grupa: ' || v_grupa || 
                         ', Media: ' || v_media ||
                         ', Media Sectiei: ' || v_media_sectiei ||
                         ', Varianta: ' || v_varianta ||
                         ', Pozitia: ' || v_poz_student);
  END LOOP;
    CLOSE v_cursor;
END;

-- Call the third function with error
DECLARE
  v_cursor SYS_REFCURSOR;
  v_nume studenti.nume%TYPE; 
  v_prenume studenti.prenume%TYPE; 
  v_grupa studenti.grupa%TYPE;
  v_media studenti.media%TYPE;
BEGIN
  v_cursor := studenti_pkg.get_top_students_by_grupa_min_media(grupa_in => '233', 
                                                               min_media_in => -3.0);

  LOOP
    FETCH v_cursor INTO v_nume, v_prenume, v_grupa, v_media;
    EXIT WHEN v_cursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE('Nume: ' || v_nume || 
                         ', Prenume: ' || v_prenume || 
                         ', Grupa: ' || v_grupa || 
                         ', Media: ' || v_media);
  END LOOP;

  CLOSE v_cursor;
END;


