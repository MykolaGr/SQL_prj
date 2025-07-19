# SQL_prj
# 🎓 College Database SQL Tasks

This repository contains a collection of SQL queries written for Microsoft SQL Server, designed to analyze and retrieve data from a university (college) database system.

---

## 📂 Contents

This repository includes:

- **`tasks.docx`** – A document listing detailed SQL tasks to be completed on the college database.
- **`university_diagram.docx`** – The logical database diagram showing tables, relationships, and primary/foreign keys.
- **`SQLQuery.sql`** – The main SQL script containing all 22 solutions using JOINs.

---

## 🧠 Project Summary

The database models a typical university environment with entities such as:

- `students`, `lecturers`, `employees`
- `modules` (lectures), `grades`, `departments`, `student enrollments`

The  SQL tasks explore a range of operations such as:

- Finding unassigned lectures
- Matching students to modules
- Identifying missing grades
- Checking departmental mismatches
- Merging views of lecturers and students

All queries are written in **T-SQL** and tested for **SQL Server Management Studio (SSMS)**.

---

## ✅ Notes

- Queries are structured with clear comments for readability.
- All JOINs are explicit (`INNER JOIN`, `LEFT JOIN`) for clarity and control.
- If needed, you can extend this project with views or stored procedures for reuse.


The database is not included in this repository due to size and privacy concerns. All SQL queries assume that the schema matches the structure defined in `university_diagram.docx`.
You can review the logic of each query in `SQLQuery.sql`, even without running them.
