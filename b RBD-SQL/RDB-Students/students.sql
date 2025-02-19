-- Consultas DML a base de datos SIN NORMALIZAR

SELECT * FROM Students WHERE Department = 'Physics' LIMIT 2;
SELECT Department, COUNT(*) as StudentCount FROM Students GROUP BY Department LIMIT 2;
SELECT * FROM Students WHERE GPA > 3.5 LIMIT 2;
SELECT Department, AVG(Age) as AverageAge FROM Students GROUP BY Department LIMIT 2;
SELECT * FROM Students WHERE GraduationYear = 2025 LIMIT 2;
SELECT * FROM Students ORDER BY GPA DESC LIMIT 2;
SELECT COUNT(*) as TotalStudents FROM Students LIMIT 2;
SELECT Name, Email FROM Students ORDER BY Name LIMIT 2;
SELECT AVG(GPA) as AverageGPA FROM Students LIMIT 2;
SELECT * FROM Students WHERE Name LIKE 'A%' LIMIT 2;


-- CONSULTAS DDL PARA NORMALIZAR LA BASE DE DATOS
SELECT DISTINCT(Department) FROM Students
CREATE TABLE IF NOT EXISTS Departments (
        DepartmentID INTEGER PRIMARY KEY,
        DepartmentName TEXT
);
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES (?, ?);
ALTER TABLE Students 
    ADD COLUMN DepartmentID INTEGER;
UPDATE Students 
        SET DepartmentID = ?
        WHERE Department = ?;
SELECT * FROM Departments;

CREATE TABLE Students_temp AS
    SELECT StudentID, Name, Age, GPA, GraduationYear, DepartmentID
    FROM Students;

DROP TABLE Students;
ALTER TABLE Students_temp RENAME TO Students;
SELECT * FROM Departments;
SELECT * FROM Students;


-- Consultas DML a base de datos normalizada
 SELECT s.StudentID, s.Name, s.Age, s.GPA, s.GraduationYear, d.DepartmentName
    FROM Students s
    JOIN Departments d ON s.DepartmentID = d.DepartmentID LIMIT 2;
SELECT d.DepartmentName, COUNT(*) as StudentCount
    FROM Students s
    JOIN Departments d ON s.DepartmentID = d.DepartmentID
    GROUP BY d.DepartmentName LIMIT 2;
SELECT d.DepartmentName, AVG(s.Age) as AverageAge
    FROM Students s
    JOIN Departments d ON s.DepartmentID = d.DepartmentID
    GROUP BY d.DepartmentName
    LIMIT 2;