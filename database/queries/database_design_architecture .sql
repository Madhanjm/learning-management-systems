--36. Propose schema changes to support course completion certificates. 
/*
TO support course completion certificates schema
  -we need to add a new table to store certificate details
  -we need to track when a user completes a course
  -we need to store the certicifaction details
*/
CREATE TABLE lms.Course_Certificates (
    certificate_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    course_id VARCHAR(10) NOT NULL,
    completion_date DATE NOT NULL,
    issued_on DATETIME2 DEFAULT SYSDATETIME(),

    CONSTRAINT FK_Certificate_User
        FOREIGN KEY (user_id) REFERENCES lms.Users(user_id),

    CONSTRAINT FK_Certificate_Course
        FOREIGN KEY (course_id) REFERENCES lms.Courses(course_id),

    CONSTRAINT UQ_User_Course_Certificate
        UNIQUE (user_id, course_id)
);

--37. Describe how you would track video progress efficiently at scale. 

/*

To track video progress efficiently at scale:
    -Create a table video progress
    -add user deatails
    -add lesson details
    -total duration of video
    -add composite primary key for user and lesson
*/

--38. Discuss normalization versus denormalization trade-offs for user activity data. 

/*
Normaliztaion:
  -Data Redundancy is low
  -Querry speed is slower due to joins
  -Storage is less
  -Analytics is Harder

Denormalization:
  -Data Redundancy is high
  -Querry speed is faster
  -Storage is more
  -Analytics is easier
*/
--39. Design a reporting-friendly schema for analytics dashboards. 

/*
To design a reporting-friendly schema for analytics dashboards:
  -Create a star schema with fact and dimension tables
  -Fact table to store numeric data
  -Dimension tables to store descriptive data
*/

--fact table for user activity
CREATE TABLE lms.Fact_User_Activity (
    activity_id INT PRIMARY KEY,
    user_id INT,
    course_id VARCHAR(10),
    lesson_id INT,
    activity_date DATE,
    activity_count INT
);

--fact table for assessment results
CREATE TABLE lms.Fact_Assessment_Results (
    assessment_id INT,
    user_id INT,
    course_id VARCHAR(10),
    score INT,
    submission_date DATE
);

--dimension table for users
CREATE TABLE lms.Dim_User (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50),
    user_role VARCHAR(20)
);

--dimension table for courses
CREATE TABLE lms.Dim_Course (
    course_id VARCHAR(10) PRIMARY KEY,
    course_title VARCHAR(100),
    course_duration INT
);

--dimension table for lessons
CREATE TABLE lms.Dim_Lesson (
    lesson_id INT PRIMARY KEY,
    course_id VARCHAR(10),
    lesson_title VARCHAR(100)
);

--dimension table for date
CREATE TABLE lms.Dim_Date (
    date_key DATE PRIMARY KEY,
    year INT,
    month INT,
    day INT,
    week INT
);

--40. Explain how this schema should evolve to support millions of users. 

/*
To support millions of users, the schema should evolve by:
  -Implementing partitioning on large tables
  -Using indexing strategies for faster queries
  -Old data should be archived
  -Denormalization for read-heavy operations
*/