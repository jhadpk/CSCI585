-- PostgreSQL 11.4 on x86_64-apple-darwin18.6.0, compiled by Apple LLVM version 10.0.1 (clang-1001.0.46.4), 64-bit


CREATE TABLE ProjectRoomBookings
(roomNum INTEGER NOT NULL,
startTime INTEGER NOT NULL,
endTime INTEGER NOT NULL,
groupName CHAR(10) NOT NULL,
PRIMARY KEY (roomNum, startTime),
CONSTRAINT endTimeGreaterCheck CHECK (endTime > startTime),
CONSTRAINT validTimeRangeCheck CHECK (startTime >= 7 AND startTime <= 17 AND endTime >=8 AND endTime <= 18),
CONSTRAINT timeOverlapCheck check(check_time_overlap(roomNum, startTime, endTime) = 0));


CREATE OR REPLACE FUNCTION check_time_overlap(room_num in INTEGER, start_time in INTEGER, end_time in INTEGER)
RETURNS INTEGER 
AS $BODY$
DECLARE count INTEGER;
BEGIN
    SELECT 
    	count(*) into count 
    FROM 
    	ProjectRoomBookings
    WHERE 
    	roomNum = room_num AND 
 		((startTime < end_time) AND (endTime > start_time));
    return count;
END;
$BODY$ LANGUAGE plpgsql;




/*
Assumption:
1. As mentioned by TA (on https://piazza.com/class/k53tdrrr6sp62z?cid=330) and written in spec, expecting startTime to be 7 to 17 and endTime 8 to 18.

"Because of this statement => For further simplicity, all bookings start and end 'on the hour', so, ints between 7 (7AM) and 18 (6PM) should be sufficient.
startTime range is 7 to 17 and endTime range is 8 to 18."


2. One group can book non conflicting rooms at conflicting times. Assuming members of a group can split between them and book different rooms for the same timeframe.
3. There will be only inserts and delete as per https://piazza.com/class/k53tdrrr6sp62z?cid=486.
*/


/*
Explanation:
endTimeGreaterCheck : this constraint makes sure endTime inserted/updated is always greater than startTime;
validTimeRangeCheck : this constraint makes sure the times entered in startTime (7 to 17) and endTime (8 to 18) are valid.
timeOverlapCheck : this constrain calls check_time_overlap function with roomNum, startTime and endTIme, and flags if function returns != 0.

check_time_overlap:
This function returns the count of rows with roomNum same as roomNum of the row to be inserted and having time clash.
Purpose of this method is to return a value 0, if no rows of overlapping time is found, else return the count of such rows (<> 0).
Overlap is found using clauses : roomNum = room_num AND ((startTime < end_time) AND (endTime > start_time)), where the latter clause returns true for case of timeclash.
*/



/*
Checks:

INSERT INTO ProjectRoomBookings VALUES (1, 8, 10, 'ABC');
INSERT INTO ProjectRoomBookings VALUES (1, 10, 15, 'ABC');
INSERT INTO ProjectRoomBookings VALUES (1, 15, 17, 'ABC');
INSERT INTO ProjectRoomBookings VALUES (2, 8, 10, 'ABC');
INSERT INTO ProjectRoomBookings VALUES (2, 10, 15, 'ABC');
INSERT INTO ProjectRoomBookings VALUES (2, 15, 17, 'ABC');
INSERT INTO ProjectRoomBookings VALUES (1, 17, 18, 'ABC');


INSERT INTO ProjectRoomBookings VALUES (1, 5, 9, 'ABC'); --exception
INSERT INTO ProjectRoomBookings VALUES (1, 18, 19, 'ABC'); --exception
INSERT INTO ProjectRoomBookings VALUES (3, -1, 2, 'ABC'); --exception
INSERT INTO ProjectRoomBookings VALUES (3, 0, 24, 'ABC'); --exception
INSERT INTO ProjectRoomBookings VALUES (1, 1, 23, 'ABC'); --exception
INSERT INTO ProjectRoomBookings VALUES (1, 15, 10, 'ABC'); --exception
INSERT INTO ProjectRoomBookings VALUES (2, 8, 12, 'ABC'); --exception
INSERT INTO ProjectRoomBookings VALUES (1, 12, 15, 'ABC'); --exception
INSERT INTO ProjectRoomBookings VALUES (2, 12, 15, 'ABC'); --exception
UPDATE ProjectRoomBookings SET startTime = 12 WHERE roomNum = 2 and startTime = 8; --exception
UPDATE ProjectRoomBookings SET startTime = 12 WHERE roomNum = 2 and startTime = 15; --exception
UPDATE ProjectRoomBookings SET startTime = 9 where roomNum = 1 and startTime = 10; --exception
UPDATE ProjectRoomBookings SET startTime = 10 where roomNum = 2 and endTime = 10; --exception

*/
