--26. Propose constraints to ensure a user cannot submit the same assessment more than once. 

/*
The following unique constraint is added to the Assessment_Submissions table to ensure that
a user cannot submit the same assessment more than once.
*/

ALTER TABLE lms.Assessment_Submissions
ADD CONSTRAINT UQ_Assessment_User 
UNIQUE (assessment_id, user_id);

--27. Ensure that assessment scores do not exceed the defined maximum score. 

/*
The following check and triger constraints can be used to ensure that assessment scores 
do not exceed the defined maximum score.

*/

ALTER TABLE lms.Assessment_Submissions
ADD CONSTRAINT check_max_score
CHECK(marks_scored BETWEEN 0 AND 100);

--OR

CREATE TRIGGER trig_check_max_score
ON lms.Assessment_Submissions
AFTER INSERT,UPDATE
AS
BEGIN
    IF EXISTS(
        SELECT 1
        FROM inserted i
        JOIN lms.Assessments a
        ON i.assessment_id = a.assessment_id
        WHERE i.marks_scored > a.max_score
    )
    BEGIN 
        RAISERROR('Marks scored cannot exceed maximum score defined for the assessment.',16,1);
        ROLLBACK TRANSACTION;
    END 
END;

--28. Prevent users from enrolling in courses that have no lessons. 

/*
The following trigger constraint can be used to prevent users from enrolling in
courses that have no lessons.
*/

CREATE TRIGGER trig_prevent_enroll_course_no_lessons
ON lms.Enrollments
AFTER INSERT
AS
    BEGIN
        IF EXISTS(
            SELECT 1
            FROM inserted i
            LEFT JOIN lms.Lessons l
            ON l.course_id = i.course_id
            WHERE l.lesson_id IS NULL
        )
        BEGIN
            RAISERROR('Cannot enroll in courses that have no lessons.',16,1);
            ROLLBACK TRANSACTION;
        END
    END;

--29. Ensure that only instructors can create courses.

/*
To ensure that only instructors can create courses
-we can add a user_role column to the Users table 
-Add check constraint to ensure user_role is either 'student' or 'instructor'
-Create column created_by in Courses table to track who created the course
-Add foreign key constraint on created_by refars Users table
-Create trigger for only instructors can create courses
*/

--Add coulmn user_role to Users table
ALTER TABLE lms.Users
ADD user_role VARCHAR(20) NOT NULL 
DEFAULT 'student';

--Add check constraint to ensure user_role is valid
ALTER TABLE lms.Users
ADD CONSTRAINT check_user_role
CHECK(user_role IN ('student','instructor'));

 --Add created_by column to Courses table
 ALTER TABLE lms.Courses
 ADD created_by INT  NULL;

 SELECT * FROM lms.Courses
  SELECT * FROM lms.Users


 INSERT INTO lms.Users(user_id, user_name, user_email, user_phone, user_role)
 VALUES (10001,'Madhan','madhan@gmail.com',9875641235,'instructor')

UPDATE lms.Courses
SET created_by = 10001;

ALTER TABLE lms.Courses
ALTER COLUMN created_by INT NOT NULL;

--Add foreign key constraint to ensure only instructors can create courses
 ALTER TABLE lms.Courses
 ADD CONSTRAINT FK_Courses_CreatedBy
 FOREIGN KEY (created_by)
 REFERENCES lms.Users(user_id);

--Create trigger for only instructors can create courses

 CREATE TRIGGER trig_only_instructors_create_courses
 ON lms.Courses
 AFTER INSERT
 AS
 BEGIN
    IF EXISTS(
        SELECT 1
        FROM inserted i
        JOIN lms.Users u
        ON i.created_by = u.user_id
        WHERE u.user_role <> 'instructor'
    )
    BEGIN
        RAISERROR('Only instructors can create courses.',16,1);
        ROLLBACK TRANSACTION;
    END
 END;



--30. Describe a safe strategy for deleting courses while preserving historical data. 

/*
-We have soft delete for preserving historical data
    -Add a flag column in courses
    -Insted of delting a course mark it as deleted
    -Write the Query to retrieve deleted courses
*/

--Add a flag column in courses

ALTER TABLE lms.Courses
ADD is_deleted BIT NOT NULL DEFAULT 0;

--Insted of delting a course mark it as deleted

UPDATE lms.Courses
SET is_deleted=1
WHERE course_id='C001';

--Write the Query to retrieve deleted courses
SELECT * FROM lms.Courses
WHERE is_deleted = 0;