-- PostgreSQL 11.4 on x86_64-apple-darwin18.6.0, compiled by Apple LLVM version 10.0.1 (clang-1001.0.46.4), 64-bit


CREATE TABLE ProjectRoomBookings
(roomNum INTEGER NOT NULL,
startTime INTEGER NOT NULL,
endTime INTEGER NOT NULL,
groupName CHAR(10) NOT NULL,
PRIMARY KEY (roomNum, startTime),
CONSTRAINT endTimeGreaterCheck CHECK (endTime > startTime));



CREATE OR REPLACE FUNCTION trigger_function_projectroombookings_constraints()
RETURNS trigger 
AS $BODY$
DECLARE 
   t_row ProjectRoomBookings%rowtype;
BEGIN
	if NEW.startTime < 0 OR NEW.startTime > 23 OR NEW.endTime < 0 OR NEW.endTime > 23 THEN
		raise exception 'Invalid data entry, "startTime" and "endTime" have to be between 0 and 23';
	end if;
	FOR t_row in SELECT * FROM ProjectRoomBookings LOOP
		if t_row.startTime < NEW.endTime AND t_row.endTime > NEW.startTime AND t_row.roomNum = NEW.roomNum THEN
			raise exception 'Please choose some other time, room % is occupied from %00hrs to %00hrs', NEW.roomNum, t_row.startTime, t_row.endTime;
		end if;
    END LOOP;
	return NEW;
END;
$BODY$
LANGUAGE plpgsql;


CREATE TRIGGER trigger_projectroombookings_constraints
BEFORE INSERT OR UPDATE ON ProjectRoomBookings
FOR EACH ROW EXECUTE PROCEDURE trigger_function_projectroombookings_constraints();




/*
Assumption:
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
