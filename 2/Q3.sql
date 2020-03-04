-- PostgreSQL 11.4 on x86_64-apple-darwin18.6.0, compiled by Apple LLVM version 10.0.1 (clang-1001.0.46.4), 64-bit


SELECT PID FROM project WHERE PID IN (SELECT DISTINCT(PID) FROM project WHERE Step = 0 AND Status = 'C') AND Step = 1 AND Status = 'W';



/*
Assumption:
1. A project cannot just have one row entry with Step = 0 and Status = 'C'.
*/

/*
--Required DDL and DML:
--Creating PRIMARY KEY of PID,Step

CREATE TABLE project (
PID VARCHAR(10) NOT NULL,
Step INTEGER NOT NULL,
Status CHAR(1) NOT NULL,
PRIMARY KEY(PID, Step)
);

INSERT INTO project VALUES ('P100',0,'C');
INSERT INTO project VALUES ('P100',1,'W');
INSERT INTO project VALUES ('P100',2,'W');
INSERT INTO project VALUES ('P201',0,'C');
INSERT INTO project VALUES ('P201',1,'C');
INSERT INTO project VALUES ('P333',0,'W');
INSERT INTO project VALUES ('P333',1,'W');
INSERT INTO project VALUES ('P333',2,'W');
INSERT INTO project VALUES ('P333',3,'W');
*/