-- PostgreSQL 11.4 on x86_64-apple-darwin18.6.0, compiled by Apple LLVM version 10.0.1 (clang-1001.0.46.4), 64-bit


SELECT ClassName, COUNT(*) AS StudentCount FROM enrollment GROUP BY ClassName ORDER BY StudentCount DESC;


/*
--Required DDL and DML:
--Creating PrimaryKey of SID,ClassName


CREATE TABLE enrollment (
SID INTEGER NOT NULL,
ClassName VARCHAR(100) NOT NULL,
Grade CHAR(1),
PRIMARY KEY(SID, ClassName)
);

INSERT INTO enrollment VALUES (123, 'Processing', 'A');
INSERT INTO enrollment VALUES (123, 'Python', 'B');
INSERT INTO enrollment VALUES (123, 'Scratch', 'B');
INSERT INTO enrollment VALUES (662, 'Java', 'B');
INSERT INTO enrollment VALUES (662, 'Python', 'A');
INSERT INTO enrollment VALUES (662, 'JavaScript', 'A');
INSERT INTO enrollment VALUES (662, 'Scratch', 'B');
INSERT INTO enrollment VALUES (345, 'Scratch', 'A');
INSERT INTO enrollment VALUES (345, 'JavaScript', 'B');
INSERT INTO enrollment VALUES (345, 'Python', 'A');
INSERT INTO enrollment VALUES (555, 'Python', 'B');
INSERT INTO enrollment VALUES (555, 'JavaScript', 'B');
*/