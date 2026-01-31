--11. For each course, calculate: 
--○ Total number of enrolled users 
--○ Total number of lessons 
--○ Average lesson duration 
SELECT
    c.course_id,
    c.course_title,
    COUNT(DISTINCT e.user_id) AS total_enrolled_users,
    COUNT(DISTINCT l.lesson_id) AS total_lessons,
    c.course_duration*1.0 / NULLIF(COUNT(DISTINCT l.lesson_id),0) AS avg_lesson_duration
FROM lms.Courses c
LEFT JOIN lms.Enrollments e
    ON c.course_id=e.course_id
LEFT JOIN lms.Lessons l
    ON c.course_id=l.course_id
GROUP BY
    c.course_id,
    c.course_title,
    c.course_duration;

--12. Identify the top three most active users based on total activity count. 
SELECT TOP 3
     u.user_id,
     u.user_name,
    COUNT(ua.activity_id) as total_activity_count 
FROM lms.Users u
INNER JOIN lms.User_Activity ua
    ON u.user_id=ua.user_id
GROUP BY u.user_id,u.user_name
ORDER BY total_activity_count DESC;

--13. Calculate course completion percentage per user based on lesson activity. 

WITH total_lesson AS (
    SELECT  
        course_id,
        COUNT(lesson_id) as total_lessons
    FROM lms.Lessons
    GROUP BY course_id
),
complted_lesson AS (
    SELECT      
        e.user_id,
        e.course_id,
        COUNT(DISTINCT ua.lesson_id) AS completed_lessons
    FROM lms.Enrollments e
    LEFT JOIN lms.Lessons l
        ON l.course_id=e.course_id
    LEFT JOIN lms.User_Activity ua
        ON ua.lesson_id=l.lesson_id
        AND ua.user_id=e.user_id
        GROUP BY e.user_id,e.course_id
)
SELECT  
    c.user_id,
    c.course_id,
    ISNULL(c.completed_lessons,0) * 100.0 / t.total_lessons AS completion_percentage
FROM complted_lesson c
JOIN total_lesson t
    ON c.course_id=t.course_id;

--14. Find users whose average assessment score is higher than the course average. 
WITH user_avg AS(
    SELECT
        s.user_id,
        l.course_id,
        AVG(s.marks_scored*1.0) AS user_avg_score
    FROM lms.Assessment_Submissions s
    JOIN lms.Assessments a
        ON a.assessment_id=s.assessment_id
    JOIN lms.Lessons l
        ON l.lesson_id=a.lesson_id
    GROUP BY s.user_id,l.course_id
),
course_avg AS(
     SELECT
        l.course_id,
        AVG(s.marks_scored*1.0) AS course_avg_score
    FROM lms.Assessment_Submissions s
    JOIN lms.Assessments a
        ON a.assessment_id=s.assessment_id
    JOIN lms.Lessons l
        ON l.lesson_id=a.lesson_id
    GROUP BY l.course_id
)
SELECT
    u.user_id,
    u.course_id,
    u.user_avg_score,
    c.course_avg_score
FROM user_avg u
JOIN course_avg c
    ON u.course_id = c.course_id
WHERE u.user_avg_score > c.course_avg_score;


--15. List courses where lessons are frequently accessed but assessments are never 
--attempted. 
WITH lesson_access AS (
    SELECT
        l.course_id,
        COUNT(ua.activity_id) AS total_accesses
    FROM lms.Lessons l
    JOIN lms.User_Activity ua
        ON ua.lesson_id = l.lesson_id
    GROUP BY l.course_id
),
assessment_attempts AS (
    SELECT DISTINCT
        l.course_id
    FROM lms.Assessments a
    JOIN lms.Lessons l
        ON a.lesson_id = l.lesson_id
    JOIN lms.Assessment_Submissions s
        ON s.assessment_id = a.assessment_id
)
SELECT
    la.course_id,
    la.total_accesses
FROM lesson_access la
LEFT JOIN assessment_attempts aa
    ON la.course_id = aa.course_id
WHERE la.total_accesses > 15
  AND aa.course_id IS NULL; 

--16. Rank users within each course based on their total assessment score.

WITH user_total_score AS (
    SELECT
        s.user_id,
        l.course_id,
        SUM(s.marks_scored) AS total_score
    FROM lms.Assessment_Submissions s
    JOIN lms.Assessments a
        ON s.assessment_id = a.assessment_id
    JOIN lms.Lessons l
        ON a.lesson_id = l.lesson_id
    GROUP BY s.user_id, l.course_id
)
SELECT
    user_id,
    course_id,
    total_score,
    RANK() OVER (
        PARTITION BY course_id
        ORDER BY total_score DESC) AS rank_within_course
FROM user_total_score
ORDER BY course_id, rank_within_course;

--17. Identify the first lesson accessed by each user for every course. 

WITH first_lesson_per_user AS(
    SELECT 
       ua.user_id,
       l.course_id,
       ua.lesson_id,
       ua.activity_timestamp ,
       ROW_NUMBER() OVER (
           PARTITION BY ua.user_id, l.course_id
           ORDER BY ua.activity_timestamp ASC
       ) AS row_number
    FROM lms.User_Activity ua
    JOIN lms.Lessons l
        ON ua.lesson_id = l.lesson_id
)
SELECT
    user_id,
    course_id,
    lesson_id,
    activity_timestamp AS first_accessed
FROM first_lesson_per_user
WHERE row_number = 1
ORDER BY user_id, course_id;

--18. Find users with activity recorded on at least five consecutive days. 
WITH distinct_activity AS (
    SELECT DISTINCT
        user_id,
        CAST(activity_timestamp AS DATE) AS activity_date
    FROM lms.User_Activity
),
date_groups AS (
    SELECT
        user_id,
        activity_date,
        DATEADD(DAY,ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY activity_date),activity_date) AS grp
    FROM distinct_activity
)
SELECT
    user_id,
    COUNT(*) AS consecutive_days
FROM date_groups
GROUP BY user_id, grp
HAVING COUNT(*) >= 1;


--19. Retrieve users who enrolled in a course but never submitted any assessment. 

SELECT
    u.user_id,
    u.user_name,
    e.course_id
FROM lms.Users u
JOIN lms.Enrollments e
    ON u.user_id = e.user_id
WHERE NOT EXISTS (
    SELECT 1
    FROM lms.Lessons l
    JOIN lms.Assessments a
        ON l.lesson_id = a.lesson_id
    JOIN lms.Assessment_Submissions s
        ON s.assessment_id = a.assessment_id
       AND s.user_id = e.user_id
    WHERE l.course_id = e.course_id
);


--20. List courses where every enrolled user has submitted at least one assessment.

SELECT
    c.course_id,
    c.course_title
FROM lms.Courses c
WHERE NOT EXISTS (
    SELECT 1
    FROM lms.Enrollments e
    WHERE e.course_id = c.course_id
      AND NOT EXISTS (
          SELECT 1
          FROM lms.Lessons l
          JOIN lms.Assessments a
              ON l.lesson_id = a.lesson_id
          JOIN lms.Assessment_Submissions s
              ON s.assessment_id = a.assessment_id
             AND s.user_id = e.user_id
          WHERE l.course_id = c.course_id)
);

