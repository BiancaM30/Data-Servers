SELECT * FROM MASTER.cursz;

/* Se poate folosi tabela cursz din schema master. 
a) Se cer intervalele de timp in care rata de schimb (pentru moneda EURO) a scazut cel putin 10 
zile consecutive (se cere numarul de zile de scadere si diferenta de valoare de la inceputul si 
sfarsitul perioadei).*/

with curse as (select luna, an, zi, valoare from MASTER.cursz where moneda='eur')
SELECT *
FROM curse MATCH_RECOGNIZE (
     ORDER BY an, luna, zi
     MEASURES strt.an as start_an, strt.luna as start_luna, strt.zi as start_zi,
              strt.valoare as euro_inceput, LAST(scade.valoare) as euro_sfarsit,
              count(*) as nr_zile,
              strt.valoare - LAST(scade.valoare) as dif
     ONE ROW PER MATCH
     PATTERN (strt scade{10,})
     DEFINE
        scade AS scade.valoare < PREV(scade.valoare)
     ) a
ORDER BY a.start_an, a.start_luna, a.start_zi;


/* b) Se cere inca o problema care determina un anumit model (ex: sablon V, W, M, etc) folosind 
datele din acest tabel.*/ 

/* Determinarea perioadelor in care rata de schimb pentru diferite monede a prezentat un 
model de tip 'V' (scãdere -> crestere),
unde fiecare perioada (de scadere sau de crestere) are cel putin 5 zile consecutive.*/

SELECT *
FROM MASTER.cursz MATCH_RECOGNIZE (
     PARTITION BY moneda
     ORDER BY an, luna, zi
     MEASURES strt.an as start_an, strt.luna as start_luna, strt.zi as start_zi,
              LAST(scade.an) as an_min, LAST(scade.luna) as luna_min, LAST(scade.zi) as zi_min,
              count(scade.*) + 1 as nr_scade,
              LAST(creste.an) as an_sf, LAST(creste.luna) as luna_sf, LAST(creste.zi) as zi_sf,
              count(creste.*) as nr_creste,
              count(*) as nr_zile
     ONE ROW PER MATCH
     AFTER MATCH SKIP TO LAST creste
     PATTERN (strt scade{5,} creste{5,})
     DEFINE
        scade AS scade.valoare < PREV(scade.valoare),
        creste AS creste.valoare > PREV(creste.valoare)
     ) a
ORDER BY moneda, a.start_an, a.start_luna, a.start_zi;