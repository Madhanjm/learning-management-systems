--1. List all users who are enrolled in more than three courses.

SELECT 
	u.user_id,
	u.user_name,
	COUNT(e.course_id) as total_count
	FROM lms.Users u
	INNER JOIN lms.Enrollments e
	ON u.user_id=e.user_id
	GROUP BY u.user_id,user_name
	HAVING COUNT(e.course_id)>3;
	
--2. Find courses that currently have no enrollments. 

SELECT 
	c.course_id,
	c.course_title
FROM lms.Courses c
LEFT JOIN lms.Enrollments e
ON c.course_id=e.course_id
WHERE e.enrollment_id IS NULL;

--3. Display each course along with the total number of enrolled users. 

SELECT 
	c.course_id,
	c.course_title,
	COUNT(e.user_id) as total_enrolled_users
FROM lms.Courses c
LEFT JOIN lms.Enrollments e
ON c.course_id=e.course_id
GROUP BY c.course_id,course_title
ORDER BY total_enrolled_users DESC;

--4. Identify users who enrolled in a course but never accessed any lesson. 

SELECT DISTINCT
    e.user_id,
    e.course_id
FROM lms.Enrollments e
LEFT JOIN lms.Lessons l
    ON l.course_id = e.course_id
LEFT JOIN lms.User_Activity ua
    ON ua.lesson_id = l.lesson_id
   AND ua.user_id = e.user_id
WHERE ua.lesson_id IS NULL;

--5. Fetch lessons that have never been accessed by any user. 

SELECT
	l.lesson_id,
	l.lesson_title,
	l.course_id
FROM lms.Lessons l
LEFT JOIN lms.User_Activity ua
	ON ua.lesson_id=l.lesson_id
where ua.lesson_id IS NULL;

--6. Show the last activity timestamp for each user. 
SELECT	
	user_id,
	MAX(activity_timestamp) AS last_timestamp
FROM lms.User_Activity
	GROUP BY user_id;

--7. List users who submitted an assessment but scored less than 50 percent of the 
--maximum score. 

SELECT	
	ass.assessment_id,
	ass.user_id,
	ass.marks_scored,
	a.max_score,
	(CAST(ass.marks_scored AS float)/a.max_score)*100 as percentage
FROM lms.Assessment_Submissions ass
LEFT JOIN lms.Assessments a
	ON a.assessment_id=ass.assessment_id
where ass.marks_scored<a.max_score *0.50 ;

--8. Find assessments that have not received any submissions. 

SELECT 
	a.assessment_id,
	a.assessment_title,
	a.max_score
FROM lms.Assessments a
LEFT JOIN lms.Assessment_Submissions s
	ON s.assessment_id=a.assessment_id
where s.assessment_id IS NULL;

--9. Display the highest score achieved for each assessment. 

SELECT 
	assessment_id,
	MAX(marks_scored) as highest_score
FROM lms.Assessment_Submissions
GROUP BY assessment_id; 

--10. Identify users who are enrolled in a course but have an inactive enrollment status. 

SELECT
	u.user_id,
	u.user_name,
	e.course_id
FROM lms.Enrollments e
INNER JOIN lms.Users u
	ON u.user_id=e.user_id
LEFT JOIN lms.User_Activity ua
	ON ua.user_id=e.user_id
WHERE ua.user_id IS NULL;



