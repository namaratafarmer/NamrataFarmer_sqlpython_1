CREATE database student_info;
USE student_info;

CREATE TABLE student_performance(
student_id INT PRIMARY KEY auto_increment,
student_name VARCHAR(50),
subject VARCHAR(50),
marks decimal(5,2),
attendance INT);

INSERT INTO student_performance(student_name, subject, marks, attendance) VALUES
('Aarav Sharma', 'Python', 85.5, 91),
('Ayesha Khan', 'SQL', 78.2, 88),
('John Mathew', 'Excel', 82.7, 85),
('Gurpreet Singh', 'Python', 90.1, 94),
('Rohan Patel', 'SQL', 74.6, 80),
('Fatima Sheikh', 'Excel', 88.9, 92),
('David Dsouza', 'Python', 92.4, 96),
('Simran Kaur', 'SQL', 65.3, 72),
('Ali Hussain', 'Excel', 76.8, 84),
('Neha Joshi', 'Python', 89.7, 93),

('Michael Fernandes', 'SQL', 81.5, 87),
('Harpreet Singh', 'Excel', 69.2, 75),
('Priya Shah', 'Python', 95.6, 98),
('Imran Pathan', 'SQL', 67.4, 70),
('Rachel Thomas', 'Excel', 84.3, 89),
('Karan Mehta', 'Python', 73.9, 78),
('Zara Ali', 'SQL', 86.8, 91),
('Manpreet Kaur', 'Excel', 77.1, 83),
('Arjun Verma', 'Python', 68.5, 74),
('Sana Mirza', 'SQL', 91.2, 95),

('Daniel Paul', 'Excel', 60.4, 68),
('Yash Gupta', 'Python', 87.9, 90),
('Nusrat Jahan', 'SQL', 72.6, 79),
('Joseph George', 'Excel', 83.5, 88),
('Tejinder Singh', 'Python', 79.3, 85),
('Pooja Iyer', 'SQL', 94.8, 97),
('Rehan Malik', 'Excel', 66.7, 73),
('Sneha Reddy', 'Python', 88.6, 92),
('Kabir Khan', 'SQL', 75.2, 81),
('Anjali Nair', 'Excel', 93.1, 96);

-- use SELECT
SELECT * FROM student_performance;

-- use WHERE
SELECT *
FROM student_performance
WHERE marks>70;

-- use ORDER BY
SELECT *
FROM student_performance
ORDER BY marks DESC;

-- group student depending on subject
SELECT subject, AVG(marks) AS avg_marks
FROM student_performance
GROUP BY subject;

-- us e Having
SELECT subject, AVG(marks) as avg_marks
FROM student_performance
GROUP by subject
HAVING avg(marks)>80;

-- aggregation function
SELECT
COUNT(*) AS total_student,
AVG(marks) AS avg_marks,
SUM(marks) AS total_marks
FROM student_performance;


USE student_info;

CREATE TABLE instructor(
instructor_id INT PRIMARY KEY auto_increment,
instructor_name VARCHAR(50),
subject VARCHAR(50)
);

INSERT INTO instructor(instructor_name, subject) VALUES
('Chirag Jadhav','Python'),
('Shirin Christian','SQL'),
('Sneha Shah','Excel');


-- inner join
SELECT student_performance.student_name,student_performance.subject,instructor.instructor_name
FROM student_performance
INNER JOIN instructor
ON student_performance.subject=instructor.subject;

-- add more column into table 2(instructor) to understand left join
INSERT INTO instructor(instructor_name,subject) VALUES
('Arpita Farmer','Java'),
('Shannon Mistry','C++');

-- truncate instrucure table and make new
TRUNCATE TABLE instructor;

-- insert all values again
INSERT INTO instructor(instructor_name, subject) VALUES
('Chirag Jadhav','Python'),
('Shirin Christian','SQL'),
('Sneha Shah','Excel'),
('Arpita Farmer','Java'),
('Shannon Mistry','C++');

SHOW TABLES;
 
SELECT * FROM instructor;

-- ft join
SELECT student_performance.student_name,student_performance.subject,instructor.instructor_name
FROM instructor
LEFT JOIN student_performance
ON student_performance.subject=instructor.subject;
 
 -- right join
 SELECT student_performance.student_name, student_performance.subject,instructor.instructor_name
 FROM student_performance
 RIGHT JOIN instructor
 ON student_performance.subject=instructor.subject;


 -- one view
 CREATE VIEW student_grade AS 
 SELECT
 sp.student_id,
 sp.student_name,
 sp.subject,
 sp.marks,
 sp.attendance,
 i.instructor_name,
 
 CASE
 WHEN sp.marks>=90 THEN 'A+'
 WHEN sp.marks>=80 THEN 'A'
 WHEN sp.marks>=70 THEN 'B'
 WHEN sp.marks>=60 THEN 'C'
 ELSE 'D'
 END AS grade
 
 FROM student_performance sp
 LEFT JOIN instructor i
 ON sp.subject=i.subject;
 
 SELECT * FROM student_grade;
 
 -- stored procedure
 DELIMITER //
 CREATE PROCEDURE top_student_marks(IN min_marks DECIMAL(5,2))
 BEGIN
 SELECT
 student_id,
 student_name,
 subject,
 marks,
 attendance
 FROM student_performance
 WHERE marks>=min_marks
 ORDER BY marks DESC;
 END // 
 DELIMITER ;
 
 CALL top_student_marks(90);
 
-- insert trigger
DELIMITER //
CREATE TRIGGER before_insert_marks
BEFORE UPDATE ON student_performance
FOR EACH ROW
 BEGIN
 IF NEW.marks>100 THEN
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT = 'Marks cannot be greater than 100' ;
 END IF ;
 END //
 DELIMITER ;
 
 
 