# Data-Servers

This repository contains **PL/SQL labs** for the **Data Servers course**, organized as:

- **Lab 1:** Table creation, constraints, procedures, and views
- **Lab 2:** Analytical functions, exchange rate analysis, and user-defined packages
- **Lab 3:** Transactions, autonomous transactions, and hierarchical structures

---

## Lab 1 Requirements

1. **Create at least 3 tables**:
   - Include at least one many-to-many relationship.
   - Define integrity constraints:
     - Unique and primary keys
     - Value constraints on columns
     - Row-level constraints
     - Foreign key constraints
   - Add comments (descriptions) on tables and columns.
   - Create relevant indexes with comments on the choices made.

2. **Create a table replicating the structure and data of the `student` table** from the MASTER schema, documenting the commands used.

3. Use SQL statements for **inserting, updating, and deleting data** in the created tables, observing how defined constraints are enforced.

4. Use system views to obtain information about:
   - Defined tables
   - Accessible tables
   - Defined constraints
   - Created indexes
   - Columns of a specific table (name, type)

5. Using the `student` table, create a **procedure** that:
   - Selects students with an average grade above 5.
   - For each section, selects at most `p%` of students located in the middle interval of averages above 5 (`50 - p/2%` to `50 + p/2%`).
   - Displays: name, surname, section, and average, sorted descending by average and alphabetically.

6. Create a **view listing available procedures** (schema name, procedure name) for the current user.

7. Create a **procedure** with schema and procedure name as parameters that retrieves the source code of the specified procedure in line order.

8. Use a programming environment (PHP, Java, C#, Python) to:
   - Display data from a table
   - Display data from a view
   - Execute the created procedure

---

## Lab 2 Requirements

1. Using the `student` table:
   - Create a **view** showing: name, surname, section code, section name, study year, group, and average.
   - Create additional views:
     - For each student: name, surname, group, average, section average, deviation from section average, and ranking within the year (descending by average).
     - Students with the **top 3 averages in each group**.

2. Using the `cursz` table (daily exchange rates):
   - Find periods where the **EUR exchange rate decreased for at least 10 consecutive days**, showing:
     - Number of days
     - Value difference from the start to the end of the period
   - Identify a pattern (e.g., V, W, M) using the data.

3. Create a **user-defined package** with at least 3 functions/procedures:
   - Display data from Lab 2 views, filtered by at least 2 input parameters.
   - Implement logging by inserting entries into a `log` table each time a procedure/function is called, logging start/end times, duration, success or error status, and error details.

---

## Lab 3 Requirements

### Transactions:
- Using previously created tables, write scripts to demonstrate:
  - **Non-repeatable reads**
  - **Phantom reads**

- Modify the package created in Lab 2 so that **logging of errors uses an autonomous transaction**.

### Hierarchical Structures:
Using provided hierarchical structure files:
1. Write a query to display all products under the "Software" category and its subcategories **using the category name, not the ID**.
2. Write a query that:
   - Displays all root nodes of the structure.
   - For each root, shows the number of direct descendants.
   - Adds a column to the products table storing direct descendant info in XML format (code, name, position).
3. Display the **top 10 products located on levels 3 and 4** of the hierarchy that have at least 2 vowels in their name, ordered alphabetically within each level.
4. Write scripts (`INSERT`, `UPDATE`) to modify the hierarchy to **create at least one cycle** in the structure, and write a query to identify nodes inducing the cycle, marking them clearly.
