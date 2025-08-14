-- ========================================
-- Transaction Management and Savepoint Simulation in Student Enrollments
-- ========================================

-- Step 1: Create tables (Normalized schema up to 3NF)
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    dob DATE
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    title VARCHAR(100)
);

CREATE TABLE Enrollments (
    enroll_id INT PRIMARY KEY,
    student_id INT REFERENCES Students(student_id),
    course_id INT REFERENCES Courses(course_id),
    grade VARCHAR(2)
);

-- Step 2: Insert sample data
INSERT INTO Students VALUES
(1, 'Alice', '2000-05-12'),
(2, 'Bob', '1999-03-08'),
(3, 'Charlie', '2001-07-22');

INSERT INTO Courses VALUES
(101, 'Database Systems'),
(102, 'Computer Networks'),
(103, 'Data Structures');

INSERT INTO Enrollments VALUES
(1, 1, 101, 'A'),
(2, 2, 102, 'B');

-- Step 3: Transaction with SAVEPOINT simulation
BEGIN;

-- First valid insert
INSERT INTO Enrollments VALUES (3, 3, 101, 'A');

-- Set SAVEPOINT
SAVEPOINT before_second_insert;

-- Second insert (intentional error: duplicate primary key '3')
INSERT INTO Enrollments VALUES (3, 2, 103, 'A'); -- This will cause an error

-- Rollback only the faulty insert
ROLLBACK TO SAVEPOINT before_second_insert;

-- Correct second insert
INSERT INTO Enrollments VALUES (4, 2, 103, 'A');

-- Commit the transaction
COMMIT;

-- Step 4: Final JOIN query
SELECT s.name AS student_name,
       c.title AS course_title,
       e.grade
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id;
