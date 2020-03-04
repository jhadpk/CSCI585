1. Tables
	* STUDENT : 
		1. Captures details about a student.
		2. PK is the STUDENT_ID.
		3. Stores FIRST_NAME, LAST_NAME, EMAIL, DOB, GENDER etc.
		4. Metadata for a student.

	* INSTRUCTOR
		1. Captures details about an instructor.
		2. PK is the INSTRUCTOR_ID.
		3. Stores FIRST_NAME, LAST_NAME, EMAIL, DOB, GENDER etc.
	 	4. Metadata for an instructor.

	* CLASS
		1. Captures details about the courses offered to students.
		2. PK is CLASS_ID.
		3. Stores COURSE_NAME, LANGUAGE_ID, ROOM_ID.
		4. LANGUAGE_ID is a foreign key and is referenced from CODING_LANGUAGE table.
		5. ROOM_ID is a foreign_key and is referenced from the ROOM table.

	* LECTURE
		1. Stores details about lecture sessions (since payment is done based on hours, need to keep track of all lecture sessions). 
		2. It maintains all the transactions entries for lectures.
		3. PK is LECTURE_ID.
	 	4. Stores INSTRUCTOR_ID(FK, is referenced from INSTRUCTOR) , CLASS_ID (FK, referenced from CLASS), ATTENDANCE, STARTED_AT, ENDED_AT.

	* PROJECT
		1. Captures details about the projects offered to students.
		2. PK is PROJECT_ID.
		3. Stores PROJECT_NAME, DESCRIPTION, MC_ID, ROOM_ID.
		4. MC_ID is a foreign key and is referenced from the MICROCONTROLLER table.
		5. ROOM_ID is a foreign_key and is referenced from the ROOM table.

	* MICROCONTROLLER
		1. Stores types of microcontrollers that could be used with their MC_NAME.
		2. PK is MC_ID

	* BOOK
		1. Stores details about a book - TITLE, AUTHOR, SUBJECT.
		2. PK is BOOK_ID.

	* GROUP
		1. Captures details about various groups in which students get split.
		2. PK is GROUP_ID.

	* TABLE_INFO
		1. Captures details about the table, student gets assigned to.
		2. PK is TABLE_ID (incremental value).

	* ROOM
		1. PK is ROOM_ID
		2. Also stores ROOM_NUM, CAPACITY, BLDG_ID, referenced from BUILDING table to get complete address.

	* BUILDING
		1. Is used to store metadata about a building.
		2. PK is BLDG_ID and captures details like NAME, ADDRESS.

	* BOX
		1. One BOX entity stores the details about the box
		2. PK is BOX_ID.

	* ITEM
		1. Captures details about an item.
		2. PK is ITEM_ID.
		3. Note : LEDs can be sold by different vendors (at different prices), hence ITEM table will have two entries with different ITEM_ID.
		4. Stores NAME, ITEM_TYPE (can be a microcontroller or hardware) and PRICE for each item. 

	* OWNER
		1. Stores metadata about an owner who is authorized to place an order to a vendor.
		2. PK is OWNER_ID.
		3. Captures details like FIRST_NAME, LAST_NAME, EMAIL.

	* VENDOR
		1. Stores details about a vendor.
		2. PK is VENDOR_ID.
		3. Stores NAME, ADDRESS, TELEPHONE.

	* ORDER
		1. Captures details about a specific order placed by OWNER to a VENDOR.
		2. PK is ORDER_ID.
		3. Captures OWNER_ID, VENDOR_ID, ORDER_AMOUNT, PLACED_AT.

	* PURCHASES
		1. Captures details about specific things purchased in an order.
		2. PK is PURCHASED_ID.
		3. Captures ORDER_ID (FK, referenced from ORDER), ITEM_ID (FK, referenced from ITEM), COUNT, AMOUNT.

	* CODING_LANGUAGE
		1. Details about coding languages offered during courses.
		2. PK is LANGUAGE_ID.

	* ROOM_SLOT
		1. Entity to capture slot availability of rooms.
		2. PK is ROOM_SLOT_ID.
		3. Captures ROOM_ID, AVAILABLE_ON (day of week), TIME_SLOT

	* RATE
		1. Stores INSTRUCTION_TYPE wise RATE.
		2. PK is RATE_ID

	* PAYMENT
		1. Stores details about the payment to be done to an instructor, at a granularity of session level.
		2. To get complete payment for an Instructor, you need to do a range query for a time period and sum(AMOUNT).

	* RATING
		1. Captures details about rating given by a student for each INSTRUCTOR, Course, Project.
		2. Rating is a supertype, with subtypes as CLASS_RATING, PROJECT_RATING, INSTRUCTOR_RATING.
		3. It is a total distinct subtype relationship with RATING_TYPE being the subtype discriminator.









2. Bridge Entities
	* CLASS_ENROLLMENT
		1. Is used to represent M:N relationship between STUDENT and CLASS.
		2. PK is a composite PK of STUDENT_ID, CLASS_ID.
		3. Captures ENROLLED_AT (timestamp), GRADE.

	* PROJECT_ENROLLMENT
		1. Is used to represent M:N relationship between STUDENT and PROJECT.
		2. PK is a composite PK of STUDENT_ID, PROJECT_ID.
		3. Captures GROUP_ID (is a FK and references GROUP), TABLE_ID (is a FK and references TABLE), ENROLLED_AT (timestamp) GRADE.

	* TEACHES
		1. Is used to represent M:N relationship between INSTRUCTOR and CLASS.
		2. PK is a composite PK of INSTRUCTOR_ID, CLASS_ID.
		3. Captures ROOM_SLOT_ID (is a FK and referenced from ROOM_SLOT), BOOK_ID (is a FK referenced from BOOK) - the book specified by INSTRUCTOR for the lecture.

	* SUPERVISES
		1. Is used to represent M:N relationship between INSTRUCTOR and PROJECT.
		2. PK is a composite PK of INSTRUCTOR_ID, PROJECT_ID.
		3. Captures STARTED_AT, ENDED_AT to keep track of hours.

	* BOX_ASSIGNMENT
		1. Is used to represent M:N relationship between BOX and GROUP.
		2. PK is a composite PK of BOX_ID, GROUP_ID.
		3. CapturesASSIGNED_ON, RETURNED_ON.

	* ITEM_ASSIGNMENT
		1. Is used to represent M:N relationship between BOX and ITEM.
		2. PK is a composite PK of BOX_ID, ITEM_ID.
		3. Captures ITEM_COUNT, ASSIGNED_ON.

	* BROKEN_ITEMS
		1. Captures details about items returned broken by a group.
		2. PK is composite PK of GROUP_ID, ITEM_ID.
		3. Stores, COUNT, TOTAL_COST (which is derived from BROKEN_ITEMS.COUNT * ITEM.PRICE).

	* ISSUES
		1. Is used to represent M:N relationship between STUDENT and BOOK.
		2. PK is a composite PK of STUDENT_ID, BOOK_ID.
		3. Captures ISSUED_ON, RETURNED_ON, LATE_RETURN (boolean, can be set to TRUE if returned after 2 weeks).
		4. Cardinality with STUDENT is (0,4) as STUDENT can at max issue 4 books, or he may not issue a book at all (assumed).










3. ENUMS
	* ITEM_TYPE :
		1. MICROCONTROLLER
		2. HARDWARE

	* STARS_TYPE
		1. 1_STAR
		2. 2_STAR
		3. 3_STAR
		4. 4_STAR

	* INSTRUCTION_TYPE
		1. CLASS
		2. PROJECT












Design
	1. Students under the organization will have their data stored under the STUDENT table.
	2. Classes offered by the organization will be stored under the CLASS table. It will also capture the language which will be taught in the class using the LANGUAGE_ID as FK referencing CODING_LANGUAGE.LANGUAGE_ID. It will also have the details of the room in which the class would get organized using ROOM_ID as FK, referencing ROOM.ROOM_ID.
	3. Projects offered by the organization will be stored under the PROJECT table. It will store the PROJECT_NAME, DESCRIPTION, microcontroller type to be used for the project under MC_ID, which will be FK, referencing MICROCONTROLLER.MC_ID.
	4. Instructors in the organization will have their data stored under the INSTRUCTOR table.
	5. When a student enrolls for a class, the enrollment details will get stored under CLASS_ENROLLMENT table, with PK being the composite PK of STUDENT_ID and CLASS_ID. Every row will represent an enrollment of a student under a class.
	6. When a student enrolls for a project, the enrollment details would get stored under PROJECT_ENROLLMENT, with PK being the composite PK of STUDENT_ID and PROJECT_ID. It will also capture details of the group in which the student is assigned using GROUP_ID, which will be FK referencing GROUP.GROUP_ID. Table details using TABLE.TABLE_ID as FK, along with other details like ENROLLED_AT and GRADE secured. Every row would represent a project enrollment for a student.
	7. Details of an instructor teaching a class, would be stored under the TEACHES table, with INSTRUCTOR_ID and CLASS_ID being the composite PK. CLASS and INSTRUCTOR both will have 1:M relationship with TEACHES since once class can be taught by many instructors and one instructor can teach many classes.
	8. Any lecture taken by an instructor will be a teaching transaction and details of it will get stored in the LECTURE table, with LECTURE_ID as PK. It will store details about a lecture - INSTRUCTOR_ID, CLASS_ID, ATTENDANCE, STARTED_AT, ENDED_AT, which would help to keep track of hours taught. INSTRUCTOR to LECTURE and CLASS to LECTURE will be 1:M relationship.
	9. When a teacher is free of classes, he/she can supervise projects, and that details will be stored under the SUPERVISES table, which will have INSTRUCTOR_ID, PROJECT_ID composite PK. This table will also store the STARTED_AT and ENDED_AT to keep track of hours supervised. INSTRUCTOR and SUPERVISES relationship will have cardinality as (0,m) since an instructor may not have time to supervise a project. PROJECT to SUPERVISES will be 1:M relationship.
	10. OWNER will place an ORDER from VENDOR, with details of order stored with ORDER_ID as PK in the ORDER table. It will pertain to a particular order, storing OWNER_ID, owner who placed it and VENDOR_ID, vendor from whom the order is placed. It will also store the ORDER_AMOUNT and timestamp of order PLACED_AT. OWNER to ORDER will be 1:M relationship whereas VENDOR to ORDER will be either 0 or many, as owners may not place any order to VENDOR.
	11. Any order placed will have details about the products purchased under PURCHASES table, with PURCHASE_ID as PK, ORDER_ID as FK, ITEM_ID as FK, count of item and amount. ORDER to PURCHASES will be 1:M relationship.
	12. Details about items will get stored under the ITEM table, with ITEM_ID as primary. Note: if the same item (eg LED) is sold by different vendors, it will be different entries in this table as both of them can have different prices for different vendors. Items can be either purchased or not purchased and hence it will have cardinality of (0,m) with PURCHASES.
	13. BOX table will store details about a particular box, with BOX_ID as PK. Items assigned to a box will have details stored in the ITEM_ASSIGNMENT table, which will have BOX_ID, ITEM_ID as composite PK, ITEM_COUNT in the box and timestamp of ASSIGNED_ON.
	14. A box can be assigned to a GROUP and that detail would get stored in BOX_ASSIGNMENT table with GROUP_ID, BOX_ID as composite PK. It will also store the timestamp of ASSIGNED_ON and RETURNED_ON.
	15. Any details of broken items on return, will get populated in BROKEN_ITEMS, with GROUP_ID, ITEM_ID as composite PK. Stores, COUNT, TOTAL_COST (which is derived from BROKEN_ITEMS.COUNT * ITEM.PRICE).
	16. Room details will get stored in the ROOM table. It will have a 1:M relationship with ROOM_SLOT which would capture details of availability for a room. This would be utilised to schedule classes and projects in rooms.
	17. Instructor payment would be stored in the PAYMENT table with PAYMENT_ID being PK. It will have an entry for every session (class or project) instructor takes. It will have INSTRUCTOR_ID as FK, RATE_ID as FK. RATE table would store rate for each instruction type - CLASS, PROJECT. To get complete payment for an Instructor, you need to do a range query for a time period and sum(AMOUNT).
	18. RATING table captures details about rating given by a student for each Instructor, Course, Project. Rating is a supertype, with subtypes as CLASS_RATING, PROJECT_RATING, INSTRUCTOR_RATING. It is a total distinct subtype relationship with RATING_TYPE being the subtype discriminator. CLASS to CLASS_RATING, PROJECT to PROJECT_RATING and INSTRUCTOR to INSTRUCTOR_RATING will be 1:M relationship.
	19. STUDENT to BOOK (library issue) relationship is captured in the ISSUES table which is used to represent their M:N relationship. PK is a composite PK of STUDENT_ID, BOOK_ID. Captures ISSUED_ON, RETURNED_ON, LATE_RETURN (boolean, can be set to TRUE if returned after 2 weeks). Cardinality with STUDENT is (0,4) as STUDENT can at max issue 4 books, or he may not issue a book at all (assumed).










Assumptions
	1. One class will always happen in a single room.
	2. Suppliers and Vendors are the same and are captured under the VENDOR table.
	3. Students apart from issuing books from the Library, can buy too or study online.
	4. Same items can be bought from diff vendors.
	5. Students cannot skip any rating - he/she has to give rating for all the instructors, classes, projects enrolled. And his/her rating for Classes will be a single rating for all the courses he has taken, single rating for Instructors for all the instructors he/she has been supervised by, single rating for Projects for all the projects he/she has taken.
	6. Students will only sit in one room for the projects (they would get assigned to a table, which will only belong to one room).
	7. There has to be an instructor in a lecture (class).
	8. One room will at least have one table and tables won't be shifted in between class rooms.
	9. A building will at least have one room.
