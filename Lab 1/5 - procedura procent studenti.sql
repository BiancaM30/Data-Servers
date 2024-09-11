SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE procent_studenti(p IN NUMBER)IS
    procent_stanga NUMBER := 50 - p/2;
    procent_dreapta NUMBER := 50 + p/2;
    pozitie_stanga NUMBER;
    pozitie_dreapta NUMBER;
    
    CURSOR crs_sectii IS
        SELECT DISTINCT cod_sectia 
        FROM MBMBD1R31.STUDENTI
        WHERE media>5;
        
    total_studenti_sectie NUMBER;
    poz_crt NUMBER;
            
    BEGIN
        FOR sectie_idx IN crs_sectii
        LOOP
            SELECT COUNT(*) INTO total_studenti_sectie
            FROM MBMBD1R31.STUDENTI
            WHERE cod_sectia = sectie_idx.cod_sectia AND media > 5;
            
            pozitie_stanga := ROUND(procent_stanga * total_studenti_sectie/100);
            pozitie_dreapta := ROUND(procent_dreapta * total_studenti_sectie/100);
            
            DBMS_OUTPUT.PUT_LINE('Cod Sectie: ' || sectie_idx.cod_sectia || ', Total studenti (medii>5) : ' || total_studenti_sectie || ', Interval afisare [' || pozitie_stanga || ', ' || pozitie_dreapta || ')');
            
            poz_crt := 1;
            FOR stud IN (SELECT nume, prenume, cod_sectia, media 
                         FROM MBMBD1R31.STUDENTI
                         WHERE cod_sectia=sectie_idx.cod_sectia AND media>5
                         ORDER BY media DESC, nume, prenume
                        )
            LOOP
                IF poz_crt >= pozitie_stanga AND poz_crt < pozitie_dreapta
                THEN
                    DBMS_OUTPUT.PUT_LINE(stud.nume || ' ' || stud.prenume || ', Sectia: ' || stud.cod_sectia || ', Media: ' || stud.media);
                END IF;
                poz_crt := poz_crt + 1;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE(' ');
        END LOOP;
    END;
/

EXECUTE procent_studenti(20);