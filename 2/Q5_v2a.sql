-- PostgreSQL 11.4 on x86_64-apple-darwin18.6.0, compiled by Apple LLVM version 10.0.1 (clang-1001.0.46.4), 64-bit

SELECT
   X.instructor 
FROM
   (
      SELECT
         i.instructor,
         count(distinct(subject)) AS subcount 
      FROM
         instructor_canditates i 
         INNER JOIN
         subject s 
         ON 
            i.subject = s.name 
      GROUP BY
         i.instructor 
   )
   X 
WHERE
   X.subcount = 
   (
      SELECT
         count(distinct(name)) 
      FROM
         subject 
   )
;


/*
EXPLANATION

Its a problem where we can use DIVIDE relational set operator!
We're dividing by entries present in subject (divisor) table, using instructor_canditates as dividend.

1. Basic idea is to do inner join on instructor_canditates and subject tables using instructor_canditates.subject and subject.name.
2. Once joined, group by instructor_canditates.instructor to get count of distinct subjects taught by him.
      --SELECT i.instructor, count(distinct(subject)) as subcount FROM instructor_canditates i, subject s WHERE i.subject = s.name GROUP BY i.instructor
3. Use 2 as subquery from which we pick instructor column to output and use subcount to compare with count of distinct subjects present in subject table.
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