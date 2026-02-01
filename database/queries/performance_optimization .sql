--21. Suggest appropriate indexes for improving performance of: 
--○ Course dashboards 
--○ User activity analytics 

/*
Course dashboards:
	How many usres are enrolled in the course
		create index for the courses in the enrollment table.
		it will directly goes to course rows enrolled by the user
	How many lessons does course have
		create index for the courses in the Lesson table.
		it will directly goes to course rows get the lessons
	Status of the assessments


User activity analytics :
	In this we can track the student behaviour
		check when was the user last active
		who is the most active user
	for that we have to create the index on the user activity table
	for the user
*/

--Indexes for course Dashboard
CREATE INDEX idx_enrollment_count
ON lms.Enrollments(course_id);

CREATE INDEX idx_lessons_course
ON lms.Lessons(course_id);

CREATE INDEX idx_assessments_lesson
ON lms.Assessments(lesson_id);

CREATE INDEX idx_submissions_assessment
ON lms.Assessment_Submissions(assessment_id);

-- Index for User Activity Analytics

CREATE INDEX idx_user_activity_user
ON lms.User_Activity(user_id);


--22. Identify potential performance bottlenecks in queries involving user activity.

/*
bottlenecks-the smallest part of the system that limits overall performance.

Queries involving the User_Activity table may face performance bottlenecks due to the following reasons:
-large volume of data or rapid growth of activity data (leading to table scan)
-heavy use of aggregation function
-frequent grouping by user id will increase cpu and memory usage
-use of distinct on activity data
-join opeartion with lesson and enrollment table
*/

--23. Explain how you would optimize queries when the user_activity table grows to millions of rows.

/*
Optimization Strategies:
-Partition the user activity table based on date ranges 
-Create pre aggregated tables for frequently used analytics
-Select only the required columns instead of select *
-Optimize join operation based on the required join
*/

--24. Describe scenarios where materialized views would be useful for this schema.

/*
Materialized views would be useful in scenarios such as:
-Course dashboard summary,Materialized views stores the pre-aggregated course statistics.
-Most active user report,Materialized views stores the total activity count per user.
-Course completion percentage per user,store precompleted completion percentage per user course
-Assessment performance summary,stores aggregated asssessment performance data
-daily user activity summary,stores daily activity counts per user
*/

--25. Explain how partitioning could be applied to user_activity. 

/*
Partitioning Strategy:
-Partitioning can be applied to the User_Activity table using range partitioning on the activity_timestamp column.
-This divides large activity data into time-based partitions
-Allows the database to scan only relevant partitions during date-based queries
Example: Create partition function for user_activity table based on activity_timestamp