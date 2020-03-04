-- PostgreSQL 11.4 on x86_64-apple-darwin18.6.0, compiled by Apple LLVM version 10.0.1 (clang-1001.0.46.4), 64-bit

SELECT
   A.instructor 
FROM
   (
      SELECT
         X.instructor,
         string_agg(X.Subject, ',' ORDER BY X.Subject) AS subjectsTaught 
      FROM
         (
            SELECT
               * 
            FROM
               instructor_canditates 
            WHERE
               Subject IN 
               (
                  SELECT name FROM subject 
               )
         )
         AS X 
      GROUP BY
         X.instructor 
   )
   AS A 
WHERE
   A.subjectsTaught IN 
   (
      SELECT
         string_agg(name, ','  ORDER BY name) AS subjectsRequired 
      FROM
         subject 
   )
;

/*
ASSUMPTION
There wont be rows repeating, for eg.: 'Bit', 'JavaScript' should exist only once in the "instructor_canditates" table. 
There wont be subjects repeated in "subject" table. */



/*
EXPLANATION

We use string manipulation to generate resultset, by comparing the length of strings formed by manipulations.

Tables: 
1. instructor_canditates (Columns: instructor, subject)
2. subject (Column: name)


[Note: I will use the comment number to refer to the actual SQL query from that comment.]

(1) We have stored the minimum subjects needed by instructors to get hired in table "subject", any instructor can only get hired if he/she teaches all the subject.name present in subject table.
(2) We are doing string matching of subjects expertised by intructors ("instructor_candidates.subject") with all subjects present in "subject" table. 
(3) "subjectsTaught" is an alias which is denoting the list of subjects being taught by an instructor needed to get hired (only from subject.name column) after using string_agg on instructor_candidates.subject (and ordering by subject's name), and grouping by instructor_candidates.instructor.
		-- SELECT X.instructor, string_agg(X.Subject, ',' ORDER BY X.Subject) AS subjectsTaught FROM (SELECT * FROM instructor_candidates where Subject IN (SELECT name FROM subject ) ) AS X GROUP BY X.instructor
(4) Finding "subjectsTaught" is done by creating a subquery, at FROM level.
(5) "subjectsTaught" is then used to find instructors whose "subjectsTaught" is equal to all subjects present in "subject" table. 
		-- SELECT A.instructor FROM (3) WHERE A.subjectsTaught IN (SELECT string_agg(name, ',' ORDER BY name) AS subjectsRequired FROM subject ); 
(6) Both "subjectsTaught" and "subjectsRequired" are formed by using string_agg function, with delimiter as comma (",") and sorted by subject.name. 
NOTE : for instructor_canditates.subject, we will only consider subjects present in "subject" table's "subject.name" column.
(7) The above gives us the final result of instructors who have expertise in all the required subjects to get hired.
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
