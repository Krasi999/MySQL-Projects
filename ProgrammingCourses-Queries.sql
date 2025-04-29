-- Disable foreign key checks to prevent constraint errors
SET FOREIGN_KEY_CHECKS = 0;

-- Truncate all tables (faster than DELETE)
TRUNCATE TABLE ProgrammingCourses.students;
TRUNCATE TABLE ProgrammingCourses.instructors;
TRUNCATE TABLE ProgrammingCourses.courses;
TRUNCATE TABLE ProgrammingCourses.coursesGroups;
TRUNCATE TABLE ProgrammingCourses.coursesSchedule;
TRUNCATE TABLE ProgrammingCourses.studentGroups;

-- Enable foreign key checks again
SET FOREIGN_KEY_CHECKS = 1;

insert into ProgrammingCourses.instructors(id, name, courses_name)
values (1, 'Elena Petrova', 'Web development'), (2, 'Krustio Krosnarov', 'Software engennering'), (3, 'Luka Gechev', 'Phyton fundamentals');

insert into ProgrammingCourses.students(id, name, class, instructors_id, tax)
values (1, 'Krasimir Gushmakov', 12, 1, 45), (2, 'Georgi Pashov', 10, 2, 80), (3, 'Ivan Hristov', 6, 3, 120), (4, 'Pencho Penchev', 8, 1, 45);

insert into ProgrammingCourses.courses(id, courses_name)
values (1, 'Web development'), (2, 'Software engennering'), (3, 'Phyton fundamentals');

insert into ProgrammingCourses.coursesGroups(id, courses_name, members_count, courses_id)
values (1, 'Web development', 2, 1), (2, 'Software engennering', 1, 2), (3, 'Phyton fundamentals', 1, 3);

insert into ProgrammingCourses.coursesSchedule(id, hour, days, coursesGroups_id)
values (1, '14:00', 'Fri', 1), (2, '20:00', 'Mon', 2), (3, '17:30', 'Wed', 3);

insert into ProgrammingCourses.studentGroups(student_id, coursesGroups_id)
values (1, 1), (2, 2), (3, 3), (4, 1);

select ProgrammingCourses.students.name, ProgrammingCourses.students.class, ProgrammingCourses.studentGroups.coursesGroups_id
from ProgrammingCourses.students
inner join ProgrammingCourses.studentGroups on studentGroups.student_id = students.id
inner join ProgrammingCourses.coursesGroups on studentGroups.coursesGroups_id = coursesGroups.id
inner join ProgrammingCourses.courses on coursesGroups.courses_id = courses.id
inner join ProgrammingCourses.coursesSchedule on coursesSchedule.coursesGroups_id = coursesGroups.id
inner join ProgrammingCourses.instructors on instructors.id = students.instructors_id
where ProgrammingCourses.coursesSchedule.days = 'Fri'
and ProgrammingCourses.coursesSchedule.hour = '14:00'
and ProgrammingCourses.instructors.name = 'Elena Petrova'
and ProgrammingCourses.courses.courses_name = 'Web development';

select instructors.name, courses.courses_name
from instructors
cross join courses;

select s1.id, s1.name, s2.id, s2.name
from students as s1, students as s2
where s1.instructors_id = s2.instructors_id
and s1.id <> s2.id;

select name, 'student' as role from students
union
select name, 'instructor' as role from instructors;

select students.id, students.name
from students
inner join instructors on instructors.id = students.instructors_id
inner join courses on courses.courses_name = instructors.courses_name
inner join coursesGroups on coursesGroups.courses_id = courses.id
inner join  coursesSchedule on coursesSchedule.coursesGroups_id = coursesGroups.id
where courses.courses_name = 'Web development'
and coursesSchedule.hour = '14:00'
and coursesSchedule.days = 'Fri'
and instructors.name = 'Elena Petrova';

select students.name, courses.courses_name
from students
cross join courses;

select min(tax) as "Minimum tax" from students;
select max(tax) as "Maximum tax" from students;
select avg(tax) as "Average tax" from students;
select sum(tax) as "Sumary tax" from students;
select count(id) as "Number of students" from students;

select students.name, students.tax
from students
group by students.name, students.tax
having tax < 100;
