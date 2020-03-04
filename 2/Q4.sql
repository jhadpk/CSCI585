-- PostgreSQL 11.4 on x86_64-apple-darwin18.6.0, compiled by Apple LLVM version 10.0.1 (clang-1001.0.46.4), 64-bit


DELETE FROM junkmail WHERE ID IN (SELECT SameFam FROM junkmail WHERE SameFam IS NOT NULL);


/*
Required DDL and DML:


CREATE TABLE junkmail (
Name VARCHAR(100) NOT NULL,
Address CHAR(1) NOT NULL,
ID INTEGER NOT NULL,
SameFam INTEGER
);



INSERT INTO junkmail (Name, Address, ID) VALUES ('Alice','A',10);
INSERT INTO junkmail (Name, Address, ID) VALUES ('Bob','B',15);
INSERT INTO junkmail (Name, Address, ID) VALUES ('Carmen','C',22);
INSERT INTO junkmail VALUES ('Diego','A',9,10);
INSERT INTO junkmail VALUES ('Ella','B',3,15);
INSERT INTO junkmail (Name, Address, ID) VALUES ('Farkhad','D',11);
*/