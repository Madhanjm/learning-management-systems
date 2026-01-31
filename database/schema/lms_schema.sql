--Database created
CREATE DATABASE LMS;

USE LMS;

--Schema created
CREATE SCHEMA lms;

--Create user table
CREATE TABLE lms.Users(
	user_id INT PRIMARY KEY,
	user_name VARCHAR(20) NOT NULL,
	user_email VARCHAR(40) UNIQUE NOT NULL,
	user_phone VARCHAR(15) UNIQUE NOT NULL
	);

--Create Course table
CREATE TABLE lms.Courses(
	course_id VARCHAR(10),
	course_title VARCHAR(30) NOT NULL,
	course_duration INT NOT NULL,

	CONSTRAINT PK_Courses PRIMARY KEY(course_id)
);

--Create Lesson table
CREATE TABLE lms.Lessons(
	lesson_id INT,
	lesson_title VARCHAR(30) NOT NULL,
	course_id VARCHAR(10) NOT NULL,

	CONSTRAINT PK_Lessons PRIMARY KEY(lesson_id),
	CONSTRAINT FK_Lessons_Course 
		FOREIGN KEY(course_id)
		REFERENCES lms.Courses(course_id)
		
);

--Create Enrollment tabel
CREATE TABLE lms.Enrollments(
	enrollment_id INT,
	enrollment_date DATE NOT NULL,
	user_id INT NOT NULL,
	course_id VARCHAR(10) NOT NULL,

	CONSTRAINT PK_Enrollments PRIMARY KEY(enrollment_id),

	CONSTRAINT FK_Enrollments_User
		FOREIGN KEY(user_id)
		REFERENCES lms.Users(user_id),

	CONSTRAINT FK_Enrollments_Courses
		FOREIGN KEY(course_id)
		REFERENCES lms.Courses(course_id),

	CONSTRAINT UQ_User_Course UNIQUE(user_id,course_id)

	);

--Create Assessments table

CREATE TABLE lms.Assessments(
	assessment_id INT,
	assessment_title VARCHAR(50) NOT NULL,
	max_score INT NOT NULL,
	lesson_id INT NOT NULL,

	CONSTRAINT PK_Assessments PRIMARY KEY(assessment_id),

	CONSTRAINT FK_assessments_Lesson
		FOREIGN KEY(lesson_id)
		REFERENCEs lms.Lessons(lesson_id)
);

--Create User Activity Table
CREATE TABLE lms.User_Activity(
	activity_id INT,
	user_id INT,
	lesson_id INT,
	activity_timestamp DATETIME2,

	CONSTRAINT PK_User_Activity PRIMARY KEY(activity_id),

	CONSTRAINT FK_User_Activity_User
        FOREIGN KEY (user_id)
        REFERENCES lms.Users(user_id),

	CONSTRAINT FK_User_Activity_Lesson
        FOREIGN KEY (lesson_id)
        REFERENCES lms.Lessons(lesson_id)
);

--Create Assessment Submission table

CREATE TABLE lms.Assessment_Submissions(
	assessment_id INT NOT NULL,
	user_id INT NOT NULL,
	marks_scored INT,
	submitted_date DATETIME2,
	 status VARCHAR(20) NOT NULL,

    CONSTRAINT FK_Submission_Assessment
        FOREIGN KEY (assessment_id)
        REFERENCES lms.Assessments(assessment_id),

    CONSTRAINT FK_Submission_User
        FOREIGN KEY (user_id)
        REFERENCES lms.Users(user_id),

    CONSTRAINT UQ_Assessment_User UNIQUE (assessment_id, user_id)
);


