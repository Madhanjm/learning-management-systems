LMS Database SQL Project
📌 Project Overview

This project focuses on designing and querying a Learning Management System (LMS) database using SQL. The goal is to analyze courses, users, enrollments, lessons, and assessments to answer common business and academic questions such as user participation, course structure, and performance metrics.

The project demonstrates practical SQL skills including:

Table relationships and joins

Aggregations and grouping

Handling missing data

Writing analytical queries for reporting

🗂️ Database Schema Overview

The schema represents a Learning Management System (LMS) with the following core entities:

Users – Learners and instructors using the platform

Courses – Educational courses created by instructors

Lessons – Individual learning units within a course

Enrollments – Mapping between users and courses

User_Activity – Tracks lesson access and engagement

Assessments – Exams or quizzes associated with courses

Assessment_Submissions – User submissions and scores for assessments

🔗 Key Relationships

Users enroll in courses

Courses contain lessons and assessments

Users perform activities on lessons

Users submit assessments and receive scores

Understanding these relationships is essential before writing analytical SQL queries.

📘 Section 1: Intermediate SQL Queries

This section focuses on multi-table joins, filtering, aggregation, and identifying missing or inactive data.

Covered problems include:

Users enrolled in more than three courses

Courses with no enrollments

Total enrolled users per course

Enrolled users with no lesson access

Lessons never accessed by any user

Last activity timestamp per user

Users scoring less than 50% in assessments

Assessments with no submissions

Highest score per assessment

Inactive enrollments despite course registration

These queries test understanding of JOIN, GROUP BY, HAVING, and LEFT JOIN patterns.

📗 Section 2: Advanced SQL and Analytics

This section introduces analytical thinking, window functions, ranking, and behavioral analysis.

Key analytics include: 11. Course-level metrics (enrollments, lessons, average duration) 12. Top three most active users 13. Course completion percentage per user 14. Users outperforming course-average assessment scores 15. Courses with high lesson activity but no assessment attempts 16. Ranking users within courses by assessment scores 17. First lesson accessed per user per course 18. Users active on at least five consecutive days 19. Enrolled users with no assessment submissions 20. Courses where every enrolled user attempted an assessment

These queries typically involve window functions, CTEs, and subqueries.

📙 Section 3: Performance and Optimization

This section focuses on scalability and performance tuning.

Topics addressed: 21. Index recommendations for dashboards and analytics 22. Identifying performance bottlenecks in user activity queries 23. Optimizing queries for large user_activity tables 24. Use cases for materialized views 25. Partitioning strategies for user_activity

This section demonstrates real-world database optimization skills.

📕 Section 4: Data Integrity and Constraints

This section ensures data correctness and business rule enforcement.

Constraints discussed include: 26. Preventing duplicate assessment submissions 27. Ensuring assessment scores do not exceed maximum limits 28. Blocking enrollment into courses without lessons 29. Restricting course creation to instructors only 30. Safe course deletion while preserving historical data

These rules are enforced using constraints, triggers, and role-based access control.

📒 Section 5: Transactions and Concurrency

This section covers reliability in concurrent environments.

Key concepts include: 31. Transaction flow for course enrollment 32. Safe handling of concurrent assessment submissions 33. Managing partial failures during submissions 34. Choosing appropriate transaction isolation levels 35. Preventing phantom reads in analytics queries

This section reflects production-grade database thinking.

📓 Section 6: Database Design and Architecture

This section explores long-term scalability and extensibility.

Design considerations include: 36. Supporting course completion certificates 37. Efficient tracking of video progress at scale 38. Normalization vs denormalization trade-offs 39. Reporting-friendly schema design 40. Evolving the schema for millions of users

This section demonstrates system design and architectural foresight.