-- tasks.sql
-- SQL queries for Skill 1.2 - College Database
-- All queries use JOIN syntax, written for SQL Server Management Studio (T-SQL)

-- 12.01: Lectures (modules) that have no students enrolled
SELECT m.module_id, m.module_name
FROM modules m
LEFT JOIN students_modules sm ON m.module_id = sm.module_id
WHERE sm.student_id IS NULL
ORDER BY m.module_name DESC;

-- 12.02: Lectures with no students + lecturer names
SELECT m.module_id, m.module_name, e.surname
FROM modules m
JOIN lecturers l ON m.lecturer_id = l.lecturer_id
JOIN employees e ON l.lecturer_id = e.employee_id
LEFT JOIN students_modules sm ON m.module_id = sm.module_id
WHERE sm.student_id IS NULL
ORDER BY m.module_id;

-- 12.03: All lecturers with lectures they teach
SELECT l.lecturer_id, e.surname, m.module_name
FROM lecturers l
JOIN employees e ON l.lecturer_id = e.employee_id
JOIN modules m ON m.lecturer_id = l.lecturer_id
ORDER BY e.surname;

-- 12.04: All employees who are lecturers
SELECT e.employee_id, e.surname, e.first_name
FROM employees e
JOIN lecturers l ON e.employee_id = l.lecturer_id;

-- 12.05: All employees who are NOT lecturers
SELECT e.employee_id, e.surname, e.first_name
FROM employees e
LEFT JOIN lecturers l ON e.employee_id = l.lecturer_id
WHERE l.lecturer_id IS NULL;

-- 12.06: Students not enrolled in any lecture
SELECT s.student_id, s.first_name, s.surname, s.group_no
FROM students s
LEFT JOIN students_modules sm ON s.student_id = sm.student_id
WHERE sm.module_id IS NULL
ORDER BY s.surname, s.first_name;

-- 12.07: Students who have taken at least one exam, with dates (one per student per date)
SELECT DISTINCT s.surname, s.first_name, s.student_id, sg.exam_date
FROM student_grades sg
JOIN students s ON s.student_id = sg.student_id
ORDER BY sg.exam_date;

-- 12.08: All lectures + hours + lecturer info
SELECT m.module_name, m.no_of_hours, e.employee_id, e.surname, e.first_name
FROM modules m
JOIN lecturers l ON m.lecturer_id = l.lecturer_id
JOIN employees e ON l.lecturer_id = e.employee_id
ORDER BY m.module_name, e.surname, e.first_name;

-- 12.09: Students enrolled in 'Statistics'
SELECT s.student_id, s.surname, s.first_name
FROM students s
JOIN students_modules sm ON s.student_id = sm.student_id
JOIN modules m ON sm.module_id = m.module_id
WHERE m.module_name = 'Statistics'
ORDER BY s.surname, s.first_name;

-- 12.10: Employees from Department of Informatics
SELECT e.surname, e.first_name, l.acad_position
FROM employees e
JOIN lecturers l ON e.employee_id = l.lecturer_id
WHERE l.department = 'Department of Informatics'
ORDER BY e.surname, e.first_name;

-- 12.11: All employees, plus department name if they are lecturers
SELECT e.surname, e.first_name, l.department
FROM employees e
LEFT JOIN lecturers l ON e.employee_id = l.lecturer_id
ORDER BY e.surname ASC, e.first_name DESC;

-- 12.12: All lecturers with department info
SELECT e.surname, e.first_name, l.department
FROM lecturers l
JOIN employees e ON l.lecturer_id = e.employee_id
ORDER BY e.surname ASC, e.first_name DESC;

-- 12.13: Lecturers who don’t teach any lecture
SELECT l.lecturer_id, e.surname, e.first_name, l.acad_position
FROM lecturers l
JOIN employees e ON l.lecturer_id = e.employee_id
LEFT JOIN modules m ON l.lecturer_id = m.lecturer_id
WHERE m.module_id IS NULL
ORDER BY l.acad_position DESC;

-- 12.14: Students, their lectures, lecturers, and departments
SELECT s.first_name, s.surname, m.module_name, e.surname AS lecturer_surname, l.department
FROM students s
JOIN students_modules sm ON s.student_id = sm.student_id
JOIN modules m ON sm.module_id = m.module_id
JOIN lecturers l ON m.lecturer_id = l.lecturer_id
JOIN employees e ON l.lecturer_id = e.employee_id
ORDER BY m.module_name DESC, e.surname ASC;

-- 12.15: Lecture hours with unknown payment (lecturer missing or missing position)
SELECT SUM(m.no_of_hours) AS total_unknown_hours
FROM modules m
LEFT JOIN lecturers l ON m.lecturer_id = l.lecturer_id
WHERE m.lecturer_id IS NULL OR l.acad_position IS NULL;

-- 12.16: Lectures with unknown payment + department names
SELECT m.module_id, m.module_name, m.department
FROM modules m
LEFT JOIN lecturers l ON m.lecturer_id = l.lecturer_id
WHERE m.lecturer_id IS NULL OR l.acad_position IS NULL;

-- 12.17: Modules starting with lowercase 'computer' (no results expected)
SELECT m.module_name, m.no_of_hours, e.surname, l.department
FROM modules m
JOIN lecturers l ON m.lecturer_id = l.lecturer_id
JOIN employees e ON l.lecturer_id = e.employee_id
WHERE m.module_name LIKE 'computer%'
ORDER BY e.surname DESC;

-- 12.18: Modules starting with capital 'Computer'
SELECT m.module_name, m.no_of_hours, e.surname, l.department
FROM modules m
JOIN lecturers l ON m.lecturer_id = l.lecturer_id
JOIN employees e ON l.lecturer_id = e.employee_id
WHERE m.module_name LIKE 'Computer%'
ORDER BY e.surname DESC;

-- 12.19: Students without grades
SELECT s.student_id, s.surname, m.module_name
FROM students s
JOIN students_modules sm ON s.student_id = sm.student_id
JOIN modules m ON sm.module_id = m.module_id
LEFT JOIN student_grades sg ON sg.student_id = s.student_id AND sg.module_id = m.module_id
WHERE sg.grade IS NULL
ORDER BY s.student_id;

-- 12.20: Students with grades, by module, descending by grade
SELECT s.student_id, s.surname, m.module_name, sg.grade
FROM student_grades sg
JOIN students s ON sg.student_id = s.student_id
JOIN modules m ON sg.module_id = m.module_id
ORDER BY s.student_id, m.module_name, sg.grade DESC;

-- 12.21: Lectures taught by lecturers from other departments
SELECT m.module_name
FROM modules m
JOIN lecturers l ON m.lecturer_id = l.lecturer_id
WHERE m.department <> l.department;

-- 12.22: Combined lecturer and student info per module
SELECT e.surname, e.first_name, e.PESEL AS [pesel/grupa], m.module_name, 'wykladowca' AS [student/wykladowca]
FROM modules m
JOIN lecturers l ON m.lecturer_id = l.lecturer_id
JOIN employees e ON l.lecturer_id = e.employee_id

UNION

SELECT s.surname, s.first_name, s.group_no, m.module_name, 'student'
FROM students_modules sm
JOIN students s ON sm.student_id = s.student_id
JOIN modules m ON sm.module_id = m.module_id
ORDER BY m.module_name, [student/wykladowca];
