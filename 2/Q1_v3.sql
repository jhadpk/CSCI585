-- PostgreSQL 11.4 on x86_64-apple-darwin18.6.0, compiled by Apple LLVM version 10.0.1 (clang-1001.0.46.4), 64-bit



CREATE EXTENSION btree_gist;

CREATE TABLE ProjectRoomBookings
(roomNum INTEGER NOT NULL,
startTime INTEGER NOT NULL,
endTime INTEGER NOT NULL,
groupName CHAR(10) NOT NULL,
PRIMARY KEY (roomNum, startTime),
CONSTRAINT endTimeGreater CHECK (endTime > startTime), 
CONSTRAINT validTimeRangeCheck CHECK (startTime >= 0 AND startTime <= 23 AND endTime >=0 AND endTime <= 23),
EXCLUDE USING gist (roomNum WITH =, numrange(startTime, endTime) WITH &&));




/*
Assumption
endTime will always be greater than startTime, both cant be equal.
*/


/*
Checks:


INSERT INTO ProjectRoomBookings VALUES (1, 10, 15, 'ABC');
INSERT INTO ProjectRoomBookings VALUES (2, 10, 15, 'ABC');
INSERT INTO ProjectRoomBookings VALUES (1, 15, 17, 'ABC');
INSERT INTO ProjectRoomBookings VALUES (1, 8, 10, 'ABC');
INSERT INTO ProjectRoomBookings VALUES (2, 8, 10, 'ABC');
INSERT INTO ProjectRoomBookings VALUES (2, 15, 17, 'ABC');

INSERT INTO ProjectRoomBookings VALUES (3, -1, 2, 'ABC'); --exception
INSERT INTO ProjectRoomBookings VALUES (3, 0, 24, 'ABC'); --exception
INSERT INTO ProjectRoomBookings VALUES (1, 1, 23, 'ABC'); --exception
INSERT INTO ProjectRoomBookings VALUES (1, 15, 10, 'ABC'); --exception
INSERT INTO ProjectRoomBookings VALUES (2, 8, 12, 'ABC'); --exception
INSERT INTO ProjectRoomBookings VALUES (1, 12, 15, 'ABC'); --exception
INSERT INTO ProjectRoomBookings VALUES (2, 12, 15, 'ABC'); --exception
*/