# Creating a DATABASE
CREATE DATABASE IF NOT EXISTS my_db;

USE my_db;
CREATE TABLE student (
    rollno INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT NOT NULL ,
    Grade VARCHAR(1),
    CITY VARCHAR(20) 
);

SELECT * FROM student;

INSERT INTO student 
VALUES 
(101,"anil",76,"C","PUNE"),
(102,"bhumika",93,"A","Mumbai"),
(103,"chetan",85,"B","Delhi"),
(104,"dhruv",96,"A","PUNE"),
(105,"emanuel",12,"F","banglore"),
(106,"farah",82,"B","PUNE");

SELECT name,marks FROM student;

## DISTINCT means UNIQUE

SELECT DISTINCT CITY
FROM student
WHERE CITY LIKE 'P%';

## WHERE clause

SELECT * FROM student WHERE Grade != "F";

## Operators

# AND 
SELECT * FROM student 
WHERE marks > 90 AND CITY = "PUNE";

## OR 
SELECT * FROM student 
WHERE marks > 90 OR CITY = "PUNE";

## BETWEEN

SELECT * FROM student
WHERE marks BETWEEN 80 and 90;

## IN

SELECT * FROM student
WHERE CITY IN ("PUNE","Mumbai");

## NOT
SELECT * FROM student
WHERE CITY NOT IN ("PUNE","Mumbai");


## LIMIT  ( it will give only 3 students data)
SELECT * FROM student LIMIT 3;

## Order BY

SELECT * FROM student     # we are getting top three student marks 
ORDER BY marks DESC
LIMIT 3;

## AGGREGATE FUNCTIONS
# COUNT
SELECT COUNT(marks) FROM student
WHERE marks > 80;

# MAX
SELECT MAX(marks) FROM student ;

## AVG

SELECT AVG(marks) FROM student;

## GROUP BY Clause
# It Groups rows that have same values into summary rows 
# It collects data from multiple records and groups the result by one or more column
# GEnerally we use GROUP BY with some AGGREGATE FUNCTIONS.

SELECT CITY,count(name)
FROM student
GROUP BY CITY;

## Q) Write the query to find the avg marks in each city in ascending ORDER 

SELECT CITY , AVG(marks)
FROM student 
GROUP BY CITY 
ORDER BY CITY ASC;

SELECT mode , count(customer)
FROM PAYMENT
GROUP BY mode ;


## Having clause  ( similar to where but when we want to apply cond after group by then we use this )

SELECT CITY ,count(name),marks FROM student
GROUP BY CITY,marks
HAVING MAX(marks) > 80;
 
## GENERAL ORDER

# SELECT
# FROM
# WHERE - make CONDITION on ROWS
# GROUP BY
# HAVING - CONDITION on GROUPS
# ORDER BY

# EXAMPLE

SELECT CITY ,count(name),marks FROM student
WHERE Grade = "A"
GROUP BY CITY ,marks
HAVING max(marks) > 90;

## UPDATE ( to update existing rows)

UPDATE student 
SET Grade = "A"
where Grade = "O";

UPDATE student
SET marks = 99 , Grade="A"
WHERE rollno=101;

SELECT * FROM student;

UPDATE student 
SET marks = 72 , Grade = "B"
WHERE rollno = 105;

## DELETE

DELETE FROM student
WHERE name = "emanuel";

## REVISITING FOREIGN KEY

## parent table 

CREATE TABLE dept (
    id INT PRIMARY KEY ,
    deptname VARCHAR(50)
);

## child table 

## As two tables are connected with FOREIGN key so Whenever any update happens parent table it will 
## reflect on child table as well and for that we have use ON UPDATE CASCADE and ON DELETE CASCADE commands.

CREATE TABLE course (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES dept(id)
    ON UPDATE CASCADE   
    ON DELETE CASCADE
);


## More table related queries :
# ALTER ( TO change the schema means design)
# ADD COLUMN

ALTER TABLE student
ADD COLUMN age INT NOT NULL DEFAULT 19;
ALTER TABLE student
ADD COLUMN AGE INT NOT NULL DEFAULT 18;

SELECT * FROM student;


## DROP COLUMN
ALTER TABLE student
DROP COLUMN AGE;
 ALTER TABLE student
 DROP COLUMN n_age;

 ## RENAME TABLE
ALTER TABLE NEW_NAME
RENAME to student;
 ALTER TABLE student 
 RENAME TO NEW_NAME;

## CHANGE COLUMN ( To change name ,data type and constraints of column)

 ALTER TABLE table_name
 CHANGE COLUMN old_name new_name new_datatype new_constraint;

 ALTER TABLE student
 CHANGE COLUMN  CITY City VARCHAR(20);
SELECT * FROM student;
 ## MODIFY COLUMN ( To modify datatype / constraint)

 ALTER TABLE table_name
 MODIFY col_name new_datatype new_constraint;

 # EXAMPLE

 ALTER TABLE student
 MODIFY age VARCHAR(2);

INSERT INTO student (rollno,name,marks,age) 
VALUES (111,"abcd",73,34);

SELECT * FROM student;

## TO DELETE TABLE DATA 

TRUNCATE TABLE student;

## PRACTICE question
# Q) In student table 
# a) change the name of column 'name' to 'full_name'
# b) delete all the studnts who scores marks less than 80
# c) Delete the column for grades

# a)

ALTER TABLE student
CHANGE COLUMN name full_name VARCHAR(50);

# b) 

DELETE FROM student
where marks < 80;
# c) 
ALTER TABLE student
DROP COLUMN Grade;
SELECT * FROM student;



 ## JOINS IN SQL

# joins in SQL used to combine rows from two or more tables based on a related column between them.

## INNER JOIN ( to get the common data from two tables)

# making a two table first

CREATE TABLE company (id INT PRIMARY KEY,
Name VARCHAR(30) NOT NULL,
Dept VARCHAR(30) UNIQUE
);

INSERT INTO company (id,Name,Dept) 
VALUES
(1,"ABC","A"),
(2,"AWS","BBA"),
(3,"AZURE","SERVER"),
(4,"SQL","DATA");

SELECT * FROM company;

CREATE TABLE emp (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    Dept VARCHAR(30) 
);

ALTER TABLE emp
MODIFY Dept VARCHAR(30) UNIQUE;

DROP TABLE emp;

SELECT * FROM emp;

TRUNCATE emp;

INSERT INTO emp (id,name,Dept) 
VALUES
(1,"SAEED","A"),
(2,"SHAIKH","BBA"),
(3,"NOOR","SERVER"),
(4,"NNN","DATA");

DELETE FROM emp
WHERE id =4;

SELECT * FROM emp;
## LEFT JOIN
SELECT c.Dept FROM company as c
LEFT JOIN emp  as e
ON c.Dept = e.Dept;

# RIGHT JOIN
SELECT c.Dept FROM company as c
RIGHT JOIN emp  as e
ON c.Dept = e.Dept;

SELECT * FROM company 
RIGHT JOIN emp
ON company.Dept = emp.Dept
UNION
SELECT * FROM company as c
LEFT JOIN emp  as e
ON c.Dept = e.Dept;



UPDATE emp 
SET Dept ="AI"
WHERE id = 4;


## FULL JOIN
SELECT company.Name,emp.name FROM company
LEFT JOIN emp
ON company.Dept = emp.Dept
UNION
SELECT company.Name,emp.name FROM company
RIGHT JOIN emp
ON company.Dept = emp.Dept;


## LEFT EXCLUSIVE JOIN (Only part in left data exclusively that is not on co incide with right )

SELECT * FROM company as c
LEFT JOIN emp as e
ON c.Dept = e.Dept
WHERE e.Dept IS NULL;
 
## RIGHT EXCLUSIVE JOIN  ( Only part in right data exclusively that is not on co incide with left)

SELECT * FROM company as C
RIGHT JOIN emp as E 
ON C.Dept=E.Dept   
WHERE C.Dept IS NULL;

## SELF JOIN ( it joins table with itself)

SELECT * 
FROM company as C_1
JOIN company as C_2
ON C_1.Dept = C_2.Dept;

SELECT * FROM company;


CREATE TABLE ABC (
    id INT PRIMARY KEY,
    Name VARCHAR(30),
    man_id INT
);


INSERT INTO ABC (id,Name,man_id) 
VALUES
(1,"SAEED",1),
(2,"NOOR",1),
(3,"AMOL",2),
(4,"Budyy",3);

SELECT A.Name as man_name,B.Name as emp_name
FROM ABC as A
JOIN ABC as B
ON A.id=B.man_id;


SELECT * FROM student;

## SQL sub-queries 
# Sub-queries can be written in WHERE , FROM  and SELECT
## Q) list of student whos marks are greater than average marks   

SELECT AVG(marks) FROM student;

SELECT name ,marks FROM student
WHERE marks > (SELECT AVG(marks) FROM student)
ORDER BY marks DESC;

# Q) list of student with even roll no: 
SELECT rollno,name FROM student
WHERE rollno IN (SELECT rollno FROM student WHERE rollno%2=0);

# Another way 
SELECT rollno,name FROM student
WHERE rollno%2=0;


## sub queries USING FROM

# finding max marks from pune student

SELECT * FROM student
WHERE City="PUNE";

SELECT MAX(marKs) FROM (SELECT * FROM student
WHERE City="PUNE") AS temp;

SELECT MAX(marks) FROM student
WHERE City="PUNE";


## MYSQL VIEWS 
## we can create a virtual views or tables from database it can be all data or part of the data we want to create as view.
 
CREATE VIEW view1 AS 
SELECT name,marks FROM student;

SELECT name as NAMES FROM view1
WHERE marks>90;

DROP VIEW view1;

