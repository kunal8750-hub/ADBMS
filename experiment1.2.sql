-- ==========================================================
-- Department-Course Subquery and Access Control Assignment
-- ==========================================================

-- 1. Create Tables (Up to 3NF)
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Departments;

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

-- 2. Insert Data (5 departments, 10 courses)
INSERT INTO Departments (dept_id, dept_name) VALUES
(1, 'Computer Science'),
(2, 'Mechanical Engineering'),
(3, 'Electrical Engineering'),
(4, 'Civil Engineering'),
(5, 'Mathematics');

INSERT INTO Courses (course_id, course_name, dept_id) VALUES
(101, 'Data Structures', 1),
(102, 'Algorithms', 1),
(103, 'Database Systems', 1),
(201, 'Thermodynamics', 2),
(202, 'Fluid Mechanics', 2),
(203, 'Machine Design', 2),
(301, 'Circuit Theory', 3),
(302, 'Power Systems', 3),
(401, 'Structural Analysis', 4),
(501, 'Linear Algebra', 5);

-- 3. Subquery: Departments offering more than 2 courses
SELECT dept_name
FROM Departments
WHERE dept_id IN (
    SELECT dept_id
    FROM Courses
    GROUP BY dept_id
    HAVING COUNT(course_id) > 2
);

-- 4. DCL: Grant SELECT access on Courses table to viewer_user
-- (Make sure the user exists in your DB before running this)
GRANT SELECT ON Courses TO 'viewer_user'@'localhost';
