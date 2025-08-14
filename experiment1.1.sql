-- 1. Create the Authors table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    name VARCHAR(50),
    country VARCHAR(50)
);

-- 2. Create the Books table with a foreign key reference
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author_id INT REFERENCES Authors(author_id)
);

-- 3. Insert at least 3 records into Authors
INSERT INTO Authors (author_id, name, country) VALUES
(1, 'George Orwell', 'United Kingdom'),
(2, 'Haruki Murakami', 'Japan'),
(3, 'Jane Austen', 'United Kingdom');

-- 4. Insert at least 3 records into Books
INSERT INTO Books (book_id, title, author_id) VALUES
(101, '1984', 1),
(102, 'Kafka on the Shore', 2),
(103, 'Pride and Prejudice', 3);

-- 5. Retrieve a list of book titles along with author's name and country using INNER JOIN
SELECT 
    b.title AS Book_Title,
    a.name AS Author_Name,
    a.country AS Author_Country
FROM 
    Books b
INNER JOIN 
    Authors a
ON 
    b.author_id = a.author_id;
