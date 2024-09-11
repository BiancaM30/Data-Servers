SET SERVEROUTPUT ON;

/* 6. Se cere un view care determina lista procedurilor (nume schema, nume procedura) pe care 
le poate folosi utilizatorul curent. (0.5p) */
CREATE OR REPLACE VIEW lista_proceduri_user AS
    SELECT OWNER AS nume_schema, OBJECT_NAME AS nume_procedura
    FROM ALL_PROCEDURES
    WHERE object_type = 'PROCEDURE'

/    
SELECT * from lista_proceduri_user


/* 7. Se cere o procedura care are ca parametri un nume de schema si un nume de procedura si 
determina textul sursa cu care s-a definit procedura, in aceeasi ordine a liniilor. (1p) */
CREATE OR REPLACE PROCEDURE vezi_sursa_procedura(nume_schema IN VARCHAR2, nume_procedura IN VARCHAR2, rc OUT SYS_REFCURSOR) IS
BEGIN
    OPEN rc FOR
        SELECT TEXT 
        FROM ALL_SOURCE 
        WHERE OWNER = UPPER(nume_schema) AND NAME = UPPER(nume_procedura)
        ORDER BY LINE;
END;
/


// fara ref cursor
SELECT TEXT 
FROM ALL_SOURCE 
WHERE OWNER = UPPER('MBMBD1R31') AND NAME = UPPER('vezi_sursa_procedura')
ORDER BY LINE;


