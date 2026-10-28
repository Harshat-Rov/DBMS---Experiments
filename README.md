# DBMS Practical Experiments (MySQL)

## Student Details

- **Student Name:** Harshat Rov
- **Student ID / Roll Number:** 25LBCS3358
- **Semester:** 03
- **Course Name:** Database Management System
- **Course Code:** 25CSH-210
- **Program:** B.Tech – CSE (AI & ML)

---

## Objectives

The primary objectives of these lab experiments are:

- Designing conceptual and logical database models using Entity-Relationship (ER) modeling and relational schemas.
- Applying schema constraints and domain integrity rules (Primary Key, Foreign Key, Unique, Check, Not Null, Default).
- Writing complex SQL queries involving aggregations, group filtering, joins, nested subqueries, and set operations.
- Constructing database views and recursive Common Table Expressions (CTEs) for hierarchical organizational data.
- Automating business logic and data auditing using stored procedures and event-driven triggers.
- Identifying functional dependencies and normalizing relational data from UNF through 1NF, 2NF, 3NF, and BCNF, while checking lossless joins and dependency preservation.
- Implementing transaction control with COMMIT, ROLLBACK, and SAVEPOINT, and examining isolation levels and concurrency anomalies.
- Evaluating indexing strategies, query execution plans, and performance using single-column and composite indexes, `EXPLAIN`, and query rewriting.

---

## Repository Description

This repository contains SQL implementation scripts for **Experiments 1 through 10** of the Database Management System practical curriculum, based on the **25CSH-210 lecture plan**. Each `.sql` script includes structured DDL/DML statements where applicable, along with inline comments detailing expected query execution results and sample output formats.

---

## Requirements

- **Database Engine:** MySQL Server 8.0+ (required for recursive CTEs and other modern SQL features used in these experiments)
- **Client Interface:** MySQL Workbench 8.0+, MySQL CLI, or compatible SQL IDE
- **For Experiment 8:** Two concurrent MySQL sessions to demonstrate transaction isolation and concurrency anomalies

---

## Repository Files

| **File Name** | **Description** |
| --- | --- |
| `Experiment_01.sql` | E-commerce ER model design for Customer, Product, Order, OrderItem, Seller, Category, Payment, Delivery, and Address, including keys, attributes, weak entities, specialization, and participation constraints. |
| `ER_Diagram.png` | Entity-Relationship diagram visual reference for Experiment 1. |
| `Experiment_02.sql` | ER-to-relational schema conversion with primary/foreign keys, `NOT NULL`, `UNIQUE`, cascading/set-null delete rules, sample data, and referential integrity tests. |
| `Experiment_03.sql` | Employee–Department–Project schema with at least 30 employees, 5 departments, and 8 projects; selection, projection, aggregates, `GROUP BY`, `HAVING`, `CASE`, and `ORDER BY`. |
| `Experiment_04.sql` | `INNER JOIN`, `LEFT JOIN`, self-joins, three-way joins, correlated subqueries, `EXISTS`, simulated `INTERSECT`/`EXCEPT`, and `EXPLAIN` analysis. |
| `Experiment_05.sql` | Department salary and employee hierarchy views, view updatability tests, and recursive CTEs for employee reporting chains. |
| `Experiment_06.sql` | `transfer_employee` stored procedure with validation and error handling, salary-validation triggers, audit logging, and edge-case testing. |
| `Experiment_07.sql` | Sales-table normalization from UNF to 1NF, 2NF, 3NF, and BCNF, including functional dependencies, lossless-join verification, and dependency preservation checks. |
| `Experiment_08.sql` | Banking-style transactions with `BEGIN`, `COMMIT`, `ROLLBACK`, and `SAVEPOINT`; partial-failure tests, isolation levels, and two-session concurrency demonstrations. |
| `Experiment_09.sql` | Railway Booking dataset with at least 5,000 records; performance comparison before and after single-column/composite indexing using `EXPLAIN`. |
| `Experiment_10.sql` | Dataset with at least 10,000 rows; analysis and optimization of five slow queries using `EXPLAIN`, indexing, query rewriting, and execution-time comparisons. |

---

## Recommended Execution Order

To maintain relational integrity and satisfy foreign key dependencies, execute the scripts in the following order:

1. **`Experiment_01.sql`**: Execute independently to create and populate the initial E-commerce schema and refer to `ER_Diagram.png` for its conceptual model.
2. **`Experiment_02.sql`**: Run to implement the ER-to-relational mapping and constraint validation models.
3. **`Experiment_03.sql`**: **Required dependency.** Builds the foundational Employee, Department, and Project schemas used by subsequent experiments.
4. **`Experiment_04.sql`**: Depends on the tables and sample data created in Experiment 3.
5. **`Experiment_05.sql`**: Extends the Employee schema from Experiment 3 with views and recursive employee hierarchy CTEs.
   > **Note:** When rerunning `Experiment_05.sql`, drop or replace existing views as appropriate (for example, using `DROP VIEW IF EXISTS ...`) to avoid definition conflicts.
6. **`Experiment_06.sql`**: Adds the `transfer_employee` stored procedure and trigger-based validation/auditing rules to the Employee schema.
7. **`Experiment_07.sql`**: Run the Sales normalization exercise with its denormalized sample data; verify each normalization stage and its lossless-join/dependency properties.
8. **`Experiment_08.sql`**: Run the banking transaction exercise. Use **two separate MySQL sessions** for the isolation-level and concurrency demonstrations.
9. **`Experiment_09.sql`**: Create/populate the Railway Booking dataset (at least 5,000 records), record baseline query performance, add indexes, and compare the execution plans.
10. **`Experiment_10.sql`**: Generate at least 10,000 rows, analyze five slow queries, apply indexes/query rewrites, and compare execution times before and after optimization.

> **Note:** Experiments 4–6 build on the Employee schema from Experiment 3. Experiments 7–10 introduce separate practical scenarios and should be run against their respective schemas/datasets, unless a particular script explicitly specifies other dependencies.

---

## Conclusion

These ten experiments cover core relational database concepts—from ER modeling, relational schema design, integrity enforcement, and advanced SQL to stored procedures, triggers, normalization, transaction management, concurrency control, indexing, and query optimization using MySQL 8.0+.

---

**DBMS-Practical-Experiments**
