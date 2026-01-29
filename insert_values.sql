--INserting Values into User table
INSERT INTO lms.Users VALUES
(1,'Arjun','arjun@engg.com','9000000001'),
(2,'Ravi','ravi@engg.com','9000000002'),
(3,'Suresh','suresh@engg.com','9000000003'),
(4,'Karthik','karthik@engg.com','9000000004'),
(5,'Manoj','manoj@engg.com','9000000005'),
(6,'Anitha','anitha@engg.com','9000000006'),
(7,'Divya','divya@engg.com','9000000007'),
(8,'Priya','priya@engg.com','9000000008'),
(9,'Sneha','sneha@engg.com','9000000009'),
(10,'Meena','meena@engg.com','9000000010'),
(11,'Rahul','rahul@engg.com','9000000011'),
(12,'Vijay','vijay@engg.com','9000000012'),
(13,'Aakash','aakash@engg.com','9000000013'),
(14,'Naveen','naveen@engg.com','9000000014'),
(15,'Santhosh','santhosh@engg.com','9000000015'),
(16,'Deepak','deepak@engg.com','9000000016'),
(17,'Pooja','pooja@engg.com','9000000017'),
(18,'Keerthi','keerthi@engg.com','9000000018'),
(19,'Harish','harish@engg.com','9000000019'),
(20,'Gokul','gokul@engg.com','9000000020');


--Inserting Values into Courses table
INSERT INTO lms.Courses (course_id, course_title, course_duration) VALUES
('CSE101','Data Structures',60),
('CSE102','DBMS',45),
('CSE103','Operating Systems',50),
('CSE104','Computer Networks',45),
('CSE105','Java Programming',70),

('ECE201','Digital Electronics',55),
('ECE202','Signals and Systems',60),
('ECE203','VLSI Design',50),
('ECE204','Microprocessors',45),

('ME301','Engineering Mechanics',40),
('ME302','Thermodynamics',60),
('ME303','Fluid Mechanics',55),

('CE401','Structural Analysis',50),
('CE402','Concrete Technology',45),
('CE403','Geotechnical Engineering',60),

('EEE501','Electrical Machines',60),
('EEE502','Power Systems',50),

('AI601','Machine Learning',70),
('AI602','Deep Learning',80),

('WEB701','Web Technologies',50),
('CSE999','Advanced Algorithms',60),
('CSE988','DATA BASE',30);


--Inserting Values into Lesson Table
INSERT INTO lms.Lessons (lesson_id, lesson_title, course_id) VALUES

(201,'Arrays','CSE101'),
(202,'Linked Lists','CSE101'),
(203,'Stacks and Queues','CSE101'),
(204,'SQL Basics','CSE102'),
(205,'Normalization','CSE102'),
(206,'Indexes','CSE102'),
(207,'Process Management','CSE103'),
(208,'CPU Scheduling','CSE103'),
(209,'Deadlocks','CSE103'),
(210,'OSI Model','CSE104'),
(211,'TCP/IP','CSE104'),
(212,'Java Basics','CSE105'),
(213,'OOP Concepts','CSE105'),
(214,'Boolean Algebra','ECE201'),
(215,'Flip Flops','ECE201'),
(216,'Laplace Transform','ECE202'),
(217,'Z Transform','ECE202'),
(218,'Newton Laws','ME301'),
(219,'Friction','ME301'),
(220,'HTML Basics','WEB701'),
(221,'CSS Basics','WEB701');

--Insert Into Enrollment table
INSERT INTO lms.Enrollments
(enrollment_id, enrollment_date, user_id, course_id)
VALUES
(1001,'2024-01-05',1,'CSE101'),
(1002,'2024-01-06',2,'CSE102'),
(1003,'2024-01-07',3,'CSE103'),
(1004,'2024-01-08',4,'CSE104'),
(1005,'2024-01-09',5,'CSE105'),
(1006,'2024-01-10',6,'ECE201'),
(1007,'2024-01-11',7,'ECE202'),
(1008,'2024-01-12',8,'ECE203'),
(1009,'2024-01-13',9,'ECE204'),
(1010,'2024-01-14',10,'ME301'),
(1011,'2024-01-15',11,'ME302'),
(1012,'2024-01-16',12,'ME303'),
(1013,'2024-01-17',13,'CE401'),
(1014,'2024-01-18',14,'CE402'),
(1015,'2024-01-19',15,'CE403'),
(1016,'2024-01-20',16,'EEE501'),
(1017,'2024-01-21',17,'EEE502'),
(1018,'2024-01-22',18,'AI601'),
(1019,'2024-01-23',19,'AI602'),
(1020,'2024-01-24',20,'WEB701'),
(2001,'2024-02-01',1,'CSE102'),
(2002,'2024-02-02',1,'CSE103'),
(2003,'2024-02-03',1,'CSE104'),
(2004,'2024-02-01',2,'CSE101'),
(2005,'2024-02-02',2,'CSE103'),
(2006,'2024-02-03',2,'CSE104');


--Insert into Asssessment table
INSERT INTO lms.Assessments
(assessment_id, assessment_title, max_score, lesson_id)
VALUES
(3001,'Arrays Quiz',100,201),
(3002,'Linked Lists Test',100,202),
(3003,'Stacks & Queues Quiz',100,203),
(3004,'SQL Basics Test',100,204),
(3005,'Normalization Quiz',100,205),
(3006,'Indexing Test',100,206),
(3007,'Process Mgmt Quiz',100,207),
(3008,'CPU Scheduling Test',100,208),
(3009,'Deadlocks Quiz',100,209),
(3010,'OSI Model Test',100,210),
(3011,'TCP/IP Quiz',100,211),
(3012,'Java Basics Quiz',100,212),
(3013,'OOP Concepts Test',100,213),
(3014,'Boolean Algebra Quiz',100,214),
(3015,'Flip Flops Test',100,215),
(3016,'Laplace Transform Quiz',100,216),
(3017,'Z Transform Test',100,217),
(3018,'Newton Laws Quiz',100,218),
(3019,'Friction Test',100,219),
(3020,'HTML Basics Quiz',100,220),
(3021,'CSS Basics Test',100,221);

--Insert into Usert_Activity
INSERT INTO lms.User_Activity
(user_id, lesson_id, activity_timestamp)
VALUES
(1,201,'2024-03-01 09:00:00'),
(2,202,'2024-03-01 09:30:00'),
(3,203,'2024-03-01 10:00:00'),
(4,204,'2024-03-01 10:30:00'),
(5,205,'2024-03-01 11:00:00'),
(6,206,'2024-03-02 09:00:00'),
(7,207,'2024-03-02 09:30:00'),
(8,208,'2024-03-02 10:00:00'),
(9,209,'2024-03-02 10:30:00'),
(10,210,'2024-03-02 11:00:00'),
(11,211,'2024-03-03 09:00:00'),
(12,212,'2024-03-03 09:30:00'),
(13,213,'2024-03-03 10:00:00'),
(14,214,'2024-03-03 10:30:00'),
(15,215,'2024-03-03 11:00:00'),
(16,216,'2024-03-04 09:00:00'),
(17,217,'2024-03-04 09:30:00'),
(18,218,'2024-03-04 10:00:00'),
(19,219,'2024-03-04 10:30:00'),
(20,220,'2024-03-04 11:00:00');

--Insert into Assessment Submissions
INSERT INTO lms.Assessment_Submissions
(assessment_id, user_id, marks_scored, submitted_date, status)
VALUES
(3001,1,78,'2024-03-10 10:00','submitted'),
(3002,1,85,'2024-03-11 11:00','submitted'),
(3003,2,67,'2024-03-10 09:30','submitted'),
(3004,2,72,'2024-03-12 10:30','submitted'),
(3005,3,88,'2024-03-13 11:00','submitted'),
(3006,3,91,'2024-03-14 12:00','submitted'),
(3007,4,65,'2024-03-15 10:00','submitted'),
(3008,4,70,'2024-03-16 11:00','submitted'),
(3009,5,82,'2024-03-17 09:45','submitted'),
(3010,5,76,'2024-03-18 10:15','submitted'),
(3011,6,69,'2024-03-19 11:30','submitted'),
(3012,6,74,'2024-03-20 12:00','submitted'),
(3013,7,80,'2024-03-21 09:00','submitted'),
(3014,8,85,'2024-03-21 10:30','submitted'),
(3015,9,90,'2024-03-22 11:15','submitted'),
(3016,10,73,'2024-03-22 12:45','submitted'),
(3017,11,68,'2024-03-23 10:00','submitted'),
(3018,12,88,'2024-03-23 11:30','submitted'),
(3019,13,92,'2024-03-24 09:00','submitted'),
(3020,14,77,'2024-03-24 10:30','submitted'),
(3020, 5, 40, '2024-03-25 10:00', 'submitted'),
(3019, 6, 30, '2024-03-25 11:00', 'submitted');
