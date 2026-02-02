--Section 5: Transactions and Concurrency 
--31. Design a transaction flow for enrolling a user into a course. 
/*
Transaction Flow for Course Enrollment (Concept)
When a user enrolls in a course, we must ensure:
User exists
Course exists
Course has lessons
User is not already enrolled
Enrollment is saved only if all checks pass
If any step fails, rollback everything.

Step-by-Step Flow
Step 1: Start Transaction
Step 2: Validate User
Step 3: Validate Course
Step 4: Check Lessons Exist
Step 5: Check Duplicate Enrollment
Step 6: Insert Enrollment
Step 7: Commit Transaction

If any step fails → ROLLBACK


*/

BEGIN TRANSACTION;

BEGIN TRY
    -- step 1:check if user exists
    IF NOT EXISTS(SELECT 1 FROM lms.Users WHERE user_id=2)
        THROW 50001,'User does not exist',1;

   --step 2:check if course exists
    IF NOT EXISTS(SELECT 1 FROM lms.Courses WHERE course_id='C101')
        THROW 50002,'Course does not exist',1;

    --step 3:check if course has lessons
    IF NOT EXISTS(SELECT 1 FROM lms.Lessons WHERE course_id='C101')
        THROW 50003,'Course has no lessons',1;

    --step 4:check if user already enrolled
    IF EXISTS(SELECT 1 FROM lms.Enrollments WHERE user_id=2 AND course_id='C101')
        THROW 50004,'User already enrolled in the course',1;

    --step 5:insert enrollment
    INSERT INTO lms.Enrollments(enrollment_id,enrollment_date,user_id,course_id)
    VALUES(1001,GETDATE(),2,'C101');

    --step 6:commit if everything is fine
    COMMIT TRANSACTION; 
END TRY
BEGIN CATCH
    --rollback in case of error
    ROLLBACK TRANSACTION;

    --Re-throw error
    THROW;
END CATCH;

--32. Explain how to handle concurrent assessment submissions safely. 

/*
 The Problem (Why Concurrency Matters)

When multiple users submit assessments at the same time, problems can occur:
Duplicate submissions
Overwriting marks
Dirty reads / lost updates
Inconsistent scores

Safe Strategy (High Level)
To handle concurrent assessment submissions safely, we must use:
Transactions
Proper isolation level
Constraints
Locks (implicitly via SQL Server)
Error handling


Safe Transaction Flow 
Step-by-step Logic
Start a transaction
Check if submission already exists
Insert submission
Validate marks
Commit
Rollback on error


*/

BEGIN TRY
    BEGIN TRANSACTION;

    -- Prevent dirty & lost updates
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

    -- Check for existing submission
    IF EXISTS (
        SELECT 1
        FROM lms.Assessment_Submissions WITH (UPDLOCK, HOLDLOCK)
        WHERE assessment_id = @assessment_id
          AND user_id = @user_id
    )
    BEGIN
        THROW 50010, 'Assessment already submitted by this user.', 1;
    END

    -- Insert submission
    INSERT INTO lms.Assessment_Submissions
    (
        assessment_id,
        user_id,
        marks_scored,
        submitted_date,
        status
    )
    VALUES
    (
        @assessment_id,
        @user_id,
        @marks_scored,
        SYSDATETIME(),
        'SUBMITTED'
    );

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;


--33. Describe how partial failures should be handled during assessment submission. 

/*
Use a database transaction
All steps of assessment submission (validation, duplicate check, insert) are executed inside a single transaction.

Apply proper isolation level
Use a strict isolation level (such as SERIALIZABLE) to avoid concurrent conflicts and race conditions.

Validate before inserting data
Check whether the user has already submitted the assessment and whether the marks are valid.

Use TRY–CATCH error handling
Any runtime error (constraint violation, trigger error, or system failure) is caught immediately.

Rollback on failure
If any step fails, the transaction is rolled back so no partial or inconsistent data is saved.

Commit only on success
The transaction is committed only when all steps complete successfully.

*/

--34. Recommend suitable transaction isolation levels for enrollments and submissions.

/*
DIfferent operations require different isolation levels based on risk and performance.

Enrollments:
Recommended Isolation Level: READ COMMITTED
   -prevents dirty reads
   -allows good performance
   -enrollment is less sensitive then submissions
   -user can enroll concurrently

Submissions:
Recommended Isolation Level: SERIALIZABLE
    -prevennts duplicate submissions
    -avois race conditions
    -ensure only one submission per user per assessment
    */

--35. Explain how phantom reads could affect analytics queries and how to prevent them. 

/*
A phantom read happens when:
    A transaction runs the same query twice
    New rows appear or disappear between the two runs
    Even though no existing rows were changed

Analytics queries usually:
    Count rows
    Aggregate data (COUNT, SUM, AVG)
    Scan ranges of rows

How it affects analytics:
    -we are counting total number of enrollments in a course in one transcation
    -another transaction adds new enrollments 
    -then we have re-run the first query
    -the count changes due to new rows(phantom reads)

How to prevent phantom reads:
Use SERIALIZABLE isolation level
    -This level locks the range of rows 
    -Prevents other transactions from inserting new rows in that range
   
US=se SNAPSHOT isolation level
    -Provides a consistent view of the data as of the start of the transaction
    -Prevents phantom reads without locking
/*