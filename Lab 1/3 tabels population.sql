/*3. Sa se foloseasca instructuni pentru: adaugarea, modificarea, stergerea de date in tabelele 
definite. Se va observa modul in care se folosesc restrictiile definite, prin cereri de 
executare a unor instructiuni care nu le respecta. (1p)*/

-- Instructions that work on cafes table
INSERT INTO MBMBD1R31.cafes (cafe_name, address, cafe_size, nr_tables, nr_employees) VALUES ('Starbucks', '123 Main St', 50, 10, 5);
INSERT INTO MBMBD1R31.cafes (cafe_name, address, cafe_size, nr_employees) VALUES ('Cafe Zen', '789 Pine St', 35, 3);
INSERT INTO MBMBD1R31.cafes (cafe_name, address, cafe_size, nr_tables, nr_employees) VALUES ('Cafe Bliss', '456 Elm St', 60, 20, 10);
INSERT INTO MBMBD1R31.cafes (cafe_name, address, cafe_size, nr_tables, nr_employees) VALUES ('Cafe Nova', '1012 Oak St', 45, 5, 2);
INSERT INTO MBMBD1R31.cafes (cafe_name, address, cafe_size, nr_tables, nr_employees) VALUES ('Starbucks', '157 Silver St', 50, 10, 5);
INSERT INTO MBMBD1R31.cafes (cafe_name, address, cafe_size, nr_tables, nr_employees) VALUES ('5ToGo', '164 Melody St', 100, 30, 12);
INSERT INTO MBMBD1R31.cafes (cafe_name, address, cafe_size, nr_tables, nr_employees) VALUES ('Starbucks', '163 Jane', 50, 15, 3);
INSERT INTO MBMBD1R31.cafes (cafe_name, address, cafe_size, nr_tables, nr_employees) VALUES ('5ToGo', '13 Golden St', 35, 10, 2);
INSERT INTO MBMBD1R31.cafes (cafe_name, address, cafe_size, nr_tables, nr_employees) VALUES ('Cafe Deja Brew', '789 Maple Ave', 40, 12, 6);
INSERT INTO MBMBD1R31.cafes (cafe_name, address, cafe_size, nr_tables, nr_employees) VALUES ('Coffee Junction', '456 Oak St', 50, 18, 8);
INSERT INTO MBMBD1R31.cafes (cafe_name, address, cafe_size, nr_tables, nr_employees) VALUES ('Bean and Brew', '101 Espresso Blvd', 55, 22, 10);
UPDATE MBMBD1R31.cafes SET cafe_size = 40 WHERE cafe_name = 'Cafe Bliss';
DELETE FROM MBMBD1R31.cafes WHERE cafe_name = 'Cafe Zen';

SELECT * FROM MBMBD1R31.cafes

-- Instructions that do not work on cafes table
INSERT INTO MBMBD1R31.cafes (cafe_name, address, cafe_size, nr_tables, nr_employees) VALUES ('Wrong Cafe 1', '123 Narrow St', 20, 0, 1);
INSERT INTO MBMBD1R31.cafes (cafe_name, address, cafe_size, nr_tables, nr_employees) VALUES ('Wrong Cafe 2', '123 Narrow St', 50, -1, 1);
INSERT INTO MBMBD1R31.cafes (cafe_name, address, cafe_size, nr_tables, nr_employees) VALUES ('Wrong Cafe 3', '123 Narrow St', 20, 5, -2);
UPDATE MBMBD1R31.cafes SET cafe_size = -1 WHERE cafe_name = 'Cafe Bliss';

-- Instructions that work on suppliers table
INSERT INTO MBMBD1R31.suppliers (supplier_name, address, website, delivered_products, rating) VALUES ('Beans Unlimited', '123 Bean St', 'www.beansunlimited.com', 'coffee', 5);
INSERT INTO MBMBD1R31.suppliers (supplier_name, address, website, delivered_products, rating) VALUES ('Espresso Parts', '456 Part Ave', 'www.espressoparts.com', 'espressors', 4);
INSERT INTO MBMBD1R31.suppliers (supplier_name, address, website, delivered_products, rating) VALUES ('Cup Supplies', '789 Cup Rd', 'www.cupsupplies.com', 'supplies', 3);
INSERT INTO MBMBD1R31.suppliers (supplier_name, address, website, delivered_products, rating) VALUES ('Bean Roasters', '101 Bean St', 'www.beanroasters.com', 'coffee', 5);
INSERT INTO MBMBD1R31.suppliers (supplier_name, address, website, delivered_products, rating) VALUES ('Coffee Heaven', '888 Brew St', 'www.coffeeheaven.com', 'coffee', 2);
INSERT INTO MBMBD1R31.suppliers (supplier_name, address, website, delivered_products, rating) VALUES ('Espresso Masters', '555 Espresso Ave', 'www.espressomasters.com', 'espressors', 5);
INSERT INTO MBMBD1R31.suppliers (supplier_name, address, website, delivered_products, rating) VALUES ('Cup World', '444 Mug Rd', 'www.cupworld.com', 'supplies', 3);
INSERT INTO MBMBD1R31.suppliers (supplier_name, address, website, delivered_products, rating) VALUES ('Bean King', '777 Bean Blvd', 'www.beanking.com', 'coffee', 1);
INSERT INTO MBMBD1R31.suppliers (supplier_name, address, website, delivered_products, rating) VALUES ('Espresso Innovations', '123 Espresso St', 'www.espresso-innovations.com', 'espressors', 3);
INSERT INTO MBMBD1R31.suppliers (supplier_name, address, website, delivered_products, rating) VALUES ('Cup Central', '666 Central Ave', 'www.cupcentral.com', 'supplies', 2);
INSERT INTO MBMBD1R31.suppliers (supplier_name, address, website, delivered_products, rating) VALUES ('Bean Boutique', '999 Bean Blvd', 'www.beanboutique.com', 'coffee', 3);
UPDATE MBMBD1R31.suppliers SET rating = 4 WHERE supplier_name = 'Beans Unlimited';
DELETE FROM MBMBD1R31.suppliers WHERE website = 'www.beanboutique.com';

SELECT * FROM MBMBD1R31.suppliers

-- Instructions that do not work on suppliers table
INSERT INTO MBMBD1R31.suppliers (supplier_name, address, website, delivered_products, rating) VALUES ('Wrong Suppliers 1', '456 Supply Rd', 'genericsupplies.com', 'food', 2);
INSERT INTO MBMBD1R31.suppliers (supplier_name, address, website, delivered_products, rating) VALUES ('Wrong Suppliers 2', '456 Supply Rd', 'genericsupplies.com', 'coffee', 6);
UPDATE MBMBD1R31.suppliers SET delivered_products='flowers' WHERE supplier_name = 'Beans Unlimited';


-- Instructions that work on cafes_suppliers table
INSERT INTO MBMBD1R31.cafes_suppliers (cafe_id, supplier_id, contract_start_date, contract_months, contract_value) VALUES (3, 1, TO_DATE('2024/03/08', 'yyyy/mm/dd'), 12, 5000.00);
INSERT INTO MBMBD1R31.cafes_suppliers (cafe_id, supplier_id, contract_start_date, contract_months, contract_value) VALUES (4, 7, TO_DATE('2024-01-01', 'yyyy/mm/dd'), 18, 6000.00);
INSERT INTO MBMBD1R31.cafes_suppliers (cafe_id, supplier_id, contract_start_date, contract_months, contract_value) VALUES (5, 8, TO_DATE('2023-11-20', 'yyyy/mm/dd'), 12, 7000.00);
INSERT INTO MBMBD1R31.cafes_suppliers (cafe_id, supplier_id, contract_start_date, contract_months, contract_value) VALUES (6, 9, TO_DATE('2024-02-10', 'yyyy/mm/dd'), 24, 10000.00);
INSERT INTO MBMBD1R31.cafes_suppliers (cafe_id, supplier_id, contract_start_date, contract_months, contract_value) VALUES (3, 7, TO_DATE('2023-12-01', 'yyyy/mm/dd'), 12, 3000.00);
INSERT INTO MBMBD1R31.cafes_suppliers (cafe_id, supplier_id, contract_start_date, contract_months, contract_value) VALUES (7, 2, TO_DATE('2024-01-01', 'yyyy/mm/dd'), 12, 5000.00);
INSERT INTO MBMBD1R31.cafes_suppliers (cafe_id, supplier_id, contract_start_date, contract_months, contract_value) VALUES (10, 4, TO_DATE('2023-09-15', 'yyyy/mm/dd'), 12, 6000.00);
INSERT INTO MBMBD1R31.cafes_suppliers (cafe_id, supplier_id, contract_start_date, contract_months, contract_value) VALUES (11, 10, TO_DATE('2024-02-20', 'yyyy/mm/dd'), 24, 8000.00);
INSERT INTO MBMBD1R31.cafes_suppliers (cafe_id, supplier_id, contract_start_date, contract_months, contract_value) VALUES (5, 3, TO_DATE('2024-02-20', 'yyyy/mm/dd'), 24, 9000.00);
UPDATE MBMBD1R31.cafes_suppliers SET contract_months = 24 WHERE cafe_id = 5 AND supplier_id = 3;
DELETE FROM MBMBD1R31.cafes_suppliers WHERE cafe_id = 11 AND supplier_id = 10;

SELECT * FROM MBMBD1R31.cafes_suppliers

-- Instructions that do not work on cafes_suppliers table
INSERT INTO MBMBD1R31.cafes_suppliers (cafe_id, supplier_id, contract_start_date, contract_months, contract_value) VALUES (1, 1, DATE '2023-01-01', -2, 1000.00);
INSERT INTO MBMBD1R31.cafes_suppliers (cafe_id, supplier_id, contract_start_date, contract_months, contract_value) VALUES (1, 1, DATE '2023-01-01', 5, -1000.00);
UPDATE MBMBD1R31.cafes_suppliers SET contract_months = -24 WHERE cafe_id = 5 AND supplier_id = 8;
DELETE FROM MBMBD1R31.suppliers WHERE supplier_id = 7;

SELECT * FROM MBMBD1R31.cafes;
SELECT * FROM MBMBD1R31.suppliers;
SELECT * FROM MBMBD1R31.cafes_suppliers;


