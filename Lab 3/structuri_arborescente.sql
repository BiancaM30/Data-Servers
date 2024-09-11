/* 1. Scrie o interogare care sa afiseze toate produsele din categoria "Software" (si din toate 
subcategoriile acesteia) fara a utiliza direct codul/id-ul categoriei (se cere folosirea numelui 
categoriei). */

//v1. nu include categoria radacina
SELECT level, p.cod, p.denumire
FROM structura s
JOIN produse p ON s.cod = p.cod
START WITH s.codp IN (SELECT cod FROM produse WHERE denumire = 'Software')
CONNECT BY PRIOR s.cod = s.codp
ORDER BY level;

//v2. include categoria radacina
SELECT level, p.cod, p.denumire
FROM structura s
RIGHT JOIN produse p ON s.cod = p.cod
START WITH p.denumire = 'Software'
CONNECT BY PRIOR p.cod = s.codp
ORDER BY level;



/* 2. Scrieti o interogare care afiseaza toate nodurile radacina ale structurii si pentru fiecare 
astfel de nod numarul de descendenti directi; adaugati o coloana tabelei produse care va stoca in 
format XML informatiile despre descendentii directi(cod, denumire, pozitie). */

SELECT p.cod, p.denumire, COUNT(s.cod) AS nr_descendenti
FROM produse p
LEFT JOIN structura s ON p.cod = s.codp
WHERE p.cod NOT IN (SELECT DISTINCT cod FROM structura)
GROUP BY p.cod, p.denumire;


ALTER TABLE produse ADD descendentii XMLTYPE;


UPDATE produse p SET p.info_descendenti = (
    SELECT XMLType(
        XMLElement("Descendenti",
            XMLAgg(
                XMLElement("Descendent",
                    XMLFOREST(
                        s.cod AS "cod",
                        REGEXP_REPLACE(
                            (SELECT denumire FROM produse WHERE cod = s.cod),
                            '[^[:alnum:][:space:]<>&"''-]',  -- allows only XML-safe characters
                            ''
                        ) AS "denumire",
                        s.pozitia AS "pozitia"
                    )
                )
            )
        ).getClobVal()
    )
    FROM structura s
    WHERE s.codp = p.cod
)
WHERE p.cod IN (SELECT DISTINCT codp FROM structura);


SELECT * FROM produse 
WHERE info_descendenti IS NOT NULL;


/* 3. Afisati primele 10 produse care se afla pe nivelele 3 si 4 ale ierarhiei si care au cel 
putin 2 vocale in denumire, ordonate alfabetic in fiecare nivel (sa fie afisat si nivelul)*/

SELECT nivel, cod, denumire FROM (
    SELECT LEVEL as nivel, p.cod, p.denumire, ROW_NUMBER() OVER (PARTITION BY LEVEL ORDER BY denumire) AS rnum
    FROM produse p
    LEFT JOIN structura s ON p.cod = s.cod
    WHERE REGEXP_COUNT(LOWER(p.denumire), '[aeiou]') >= 2
    START WITH s.codp IS NULL
    CONNECT BY PRIOR p.cod = s.codp
) WHERE nivel IN (3, 4) AND rnum <= 10
ORDER BY nivel, denumire;


/* 4. Creati scripturile necesare (INSERT-uri, UPDATE-uri)  pentru a modifica structura astfel incat sa 
obtineti in structura ierarhica cel putin un ciclu (ciclu pe care sa-l evidentati apoi in afisarea 
rezultatului unei interogari; fie cu "DA", fie cu alt string, pentru nodul care induce acel ciclu)*/

// 1111 -> 1021 -> 516 -> 1111
INSERT INTO structura(Cod, codp) VALUES (1111,516);

SELECT cod, codp,
       CASE WHEN CONNECT_BY_ISCYCLE = 1 THEN 'YES' ELSE 'NO' END AS IsCycle
FROM structura
START WITH cod = 1111
CONNECT BY NOCYCLE PRIOR cod = codp;


