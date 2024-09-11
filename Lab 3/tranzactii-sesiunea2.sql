/* Folosind tabelele create la Tema 1, creati scripturile necesare pentru tranazactii care sa genereze: 
    - Nonrepeatable Read  
    - Phantom Read
*/
--Sesiunea 2

-- 1. Nonrepeatable Read 
-- Sesiune 1...

-- Modificare date citite de Sesiunea 1
UPDATE MBMBD1R31.cafes SET nr_employees = nr_employees + 1 WHERE cafe_name = 'Cafe Bliss';
COMMIT;

-- Sesiune 1...



-- 2. Phantom Read 
-- Sesiune 1...
-- Adaugare inregistrare noua in tabel
INSERT INTO MBMBD1R31.cafes (cafe_name, address, cafe_size, nr_tables, nr_employees) VALUES ('New Cafe', '123 New Street', 60, 5, 10);
COMMIT;
-- Sesiune 1...


