/* Folosind tabelele create la Tema 1, creati scripturile necesare pentru tranzactii care sa genereze: 
    - Nonrepeatable Read  
    - Phantom Read
*/
--Sesiunea 1

-- 1. Nonrepeatable Read 
-- Citirea initiala a datelor
SELECT * FROM MBMBD1R31.cafes WHERE cafe_name = 'Cafe Bliss';

-- Asteapta dupa sesiune 2...

-- A doua citire, dupa modificarea din Sesiunea 2
SELECT * FROM MBMBD1R31.cafes WHERE cafe_name = 'Cafe Bliss';



-- 2. Phantom Read
-- Citirea initiala a datelor
SELECT * FROM MBMBD1R31.cafes WHERE cafe_size > 50;

-- Asteapta dupa sesiune 2...

-- A doua citire, dupa modificarea din Sesiunea 2
SELECT * FROM MBMBD1R31.cafes WHERE cafe_size > 50;
