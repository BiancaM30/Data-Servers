import cx_Oracle

cx_Oracle.init_oracle_client(
    lib_dir='C:/Program Files/Oracle Client Python/instantclient-basic-windows.x64-21.13.0.0.0dbru/instantclient_21_13')
ip = '193.231.20.20'
port = 15211
SID = 'orcl19c'
dsn_tns = cx_Oracle.makedsn(ip, port, SID)
conn = cx_Oracle.connect(user='mbmbd1r31', password='mbmbd1r31', dsn=dsn_tns)

def option_1():
    cursor = conn.cursor()
    query = "SELECT table_name, tablespace_name FROM USER_ALL_TABLES"
    cursor.execute(query)
    for row in cursor:
        print(f"Table Name: {row[0]}, Tablespace Name: {row[1]}")
    cursor.close()


def option_2():
    cursor = conn.cursor()
    query = "SELECT owner, table_name FROM ALL_ALL_TABLES"
    cursor.execute(query)
    for row in cursor:
        print(f"Owner: {row[0]}, Table Name: {row[1]}")
    cursor.close()


def option_3(table_name):
    cursor = conn.cursor()
    query = "SELECT constraint_name, constraint_type, search_condition FROM user_constraints WHERE table_name = :1"
    cursor.execute(query, (table_name.upper(),))
    for row in cursor:
        print(f"Constraint Name: {row[0]}, Constraint Type: {row[1]}, Search Condition: {row[2]}")
    cursor.close()


def option_4(table_name):
    cursor = conn.cursor()
    query = "SELECT index_name, uniqueness FROM user_indexes WHERE table_name = :1"
    cursor.execute(query, (table_name.upper(),))
    for row in cursor:
        print(f"Index Name: {row[0]}, Uniqueness: {row[1]}")
    cursor.close()


def option_5(table_name):
    cursor = conn.cursor()
    query = "SELECT column_name, data_type FROM user_tab_columns WHERE table_name = :1"
    cursor.execute(query, (table_name.upper(),))
    for row in cursor:
        print(f"Column Name: {row[0]}, Data Type: {row[1]}")
    cursor.close()


def option_6():
    cursor = conn.cursor()
    query = "SELECT nume_schema, nume_procedura FROM lista_proceduri_user"
    cursor.execute(query)
    for row in cursor:
        print(f"Schema Name: {row[0]}, Procedure Name: {row[1]}")
    cursor.close()


def option_6():
    cursor = conn.cursor()
    query = "SELECT nume_schema, nume_procedura FROM lista_proceduri_user"
    cursor.execute(query)
    for row in cursor:
        print(f"Schema Name: {row[0]}, Procedure Name: {row[1]}")
    cursor.close()


def option_7(schema_name, proc_name):
    cursor = conn.cursor()
    # uses ref cursor
    ref_cursor = cursor.var(cx_Oracle.CURSOR)
    cursor.callproc('vezi_sursa_procedura', [schema_name, proc_name, ref_cursor])
    cursor_result = ref_cursor.getvalue()
    for row in cursor_result:
        print(row[0])
    cursor.close()


def option_8(procent):
    cursor = conn.cursor()
    # uses dbms output
    cursor.callproc("dbms_output.enable")

    cursor.callproc('procent_studenti', [procent])
    statusVar = cursor.var(cx_Oracle.NUMBER)
    lineVar = cursor.var(cx_Oracle.STRING)

    while True:
        cursor.callproc("dbms_output.get_line", (lineVar, statusVar))
        if statusVar.getvalue() != 0:
            break
        print(lineVar.getvalue())
    cursor.close()


if __name__ == "__main__":
    while (True):
        print("\nMENU")
        print("1. View - tabelele definite de userul curent")
        print("2. View - tabelele la care are acces userul curent")
        print("3. View - restrictii tabel")
        print("4. View - indexuri tabel")
        print("5. View - coloane tabel")
        print("6. View - procedurile pentru userul curent")
        print("7. Procedura - vezi text sursa")
        print("8. Procedura - calcul procent studenti")
        cmd = int(input(">>"))
        if cmd == 1:
            option_1()
        elif cmd == 2:
            option_2()
        elif cmd == 3:
            table_name = input("Introdu numele tabelului: ")
            option_3(table_name)
        elif cmd == 4:
            table_name = input("Introdu numele tabelului: ")
            option_4(table_name)
        elif cmd == 5:
            table_name = input("Introdu numele tabelului: ")
            option_5(table_name)
        elif cmd == 6:
            option_6()
        elif cmd == 7:
            schema_name = input("Introdu numele schemei: ")
            proc_name = input("Introdu numele procedurii: ")
            option_7(schema_name, proc_name)
        elif cmd == 8:
            procent = int(input("Introdu procentul: "))
            option_8(procent)
        else:
            break
    conn.close()
