-- PostgreSQL 11.4 on x86_64-apple-darwin18.6.0, compiled by Apple LLVM version 10.0.1 (clang-1001.0.46.4), 64-bit


SELECT
   instructor 
FROM
   instructor_canditates 
WHERE
   subject IN 
   (
      SELECT
         name 
      FROM
         subject 
   )
GROUP BY
   instructor 
HAVING
   count(distinct(subject)) = 
   (
      SELECT
         count(distinct(name)) 
      FROM
         subject
   )
;




/*
EXPLANATION:

Its a problem where we can use DIVIDE relational set operator!
We're dividing by entries present in subject (divisor) table, using instructor_canditates as dividend.

Tables: 
1. instructor_canditates (Columns: instructor, subject)
2. subject (Column: name)


[Note: I will use the comment number to refer to the actual SQL query from that comment.]

(1) First filter out by grouping by instructor, only those entries in instructor_canditates table where instructor_canditates.subject is present in "subject" table, i.e select valid candidate rows or we can say neglect any rows with non-needed subject expertise.
    --SELECT instructor FROM instructor_canditates WHERE subject IN (SELECT name FROM subject ) GROUP BY instructor
(2) Then use HAVING clause to find instructor_canditates.instructor who are teaching same number of subjects as present in subject table (with distinct).
    -- (1) HAVING count(distinct(subject)) = (SELECT count(distinct(name)) FROM subject ); 
(3) Using distinct for instructor_canditates.subject so as to take care of cases where same entry is present for an instructor, and doing distinct for subject.name so as to take care of multiple entries of same subject in subject table.
(4) Only those instructors will be returned who are having expertise in all the subjects (having same count) present in subject table.
*/

/*
Required DDL and DML:


CREATE TABLE instructor_canditates (
instructor VARCHAR(100) NOT NULL,
Subject VARCHAR(25) NOT NULL
);

INSERT INTO instructor_canditates VALUES ('Aleph', 'Scratch');
INSERT INTO instructor_canditates VALUES ('Aleph', 'Java');
INSERT INTO instructor_canditates VALUES ('Aleph', 'Processing');
INSERT INTO instructor_canditates VALUES ('Bit', 'Python');
INSERT INTO instructor_canditates VALUES ('Bit', 'JavaScript');
INSERT INTO instructor_canditates VALUES ('Bit', 'Java');
INSERT INTO instructor_canditates VALUES ('CRC', 'Python');
INSERT INTO instructor_canditates VALUES ('CRC', 'JavaScript');
INSERT INTO instructor_canditates VALUES ('Dat', 'Scratch');
INSERT INTO instructor_canditates VALUES ('Dat', 'Python');
INSERT INTO instructor_canditates VALUES ('Dat', 'JavaScript');
INSERT INTO instructor_canditates VALUES ('Emscr', 'Scratch');
INSERT INTO instructor_canditates VALUES ('Emscr', 'Processing');
INSERT INTO instructor_canditates VALUES ('Emscr', 'JavaScript');
INSERT INTO instructor_canditates VALUES ('Emscr', 'Python');


CREATE TABLE subject(
name VARCHAR(25) NOT NULL
);

INSERT INTO subject VALUES ('JavaScript');
INSERT INTO subject VALUES ('Scratch');
INSERT INTO subject VALUES ('Python');
*/
