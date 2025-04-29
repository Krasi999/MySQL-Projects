-- Disable foreign key checks to prevent constraint errors
SET FOREIGN_KEY_CHECKS = 0;

-- Truncate all tables (faster than DELETE)
TRUNCATE TABLE SchoolSports.students;
TRUNCATE TABLE SchoolSports.coaches;
TRUNCATE TABLE SchoolSports.sports;
TRUNCATE TABLE SchoolSports.trainingGroups;
TRUNCATE TABLE SchoolSports.trainingSchedule;
TRUNCATE TABLE SchoolSports.studentGroups;


-- Enable foreign key checks again
SET FOREIGN_KEY_CHECKS = 1;

insert into SchoolSports.coaches(id, name, sport)
values (1, 'Georgi Krustev Ivanov', 'Swimming'), (2, 'Krasimir Georgiev Gushmakov', 'Tennis'), (3, 'Ivan Todorov Petrov', 'Football');

insert into SchoolSports.students(id, name, coaches_id, class, tax)
values (1, 'Alex', 1, 8, 30), (2, 'Cvetan', 2, 12, 45), (3, 'Peter', 3, 10, 60), (4, 'Luka', 1, 10, 30);

insert into SchoolSports.sports(id, name)
values (1, 'Swimming'), (2, 'Tennis'), (3, 'Football');

insert into SchoolSports.trainingGroups(id, sport)
values (1, 'Swimming'), (2, 'Tennis'), (3, 'Football');

insert into SchoolSports.trainingSchedule(id, hour, days)
values (1, '18:30:00', 'Wed'), (2, '20:00:00', 'Fri'), (3, '08:00:00', 'Mon');

insert into SchoolSports.studentGroups(student_id, trainingGroups_id)
values (1, 1), (2, 2), (3, 3), (4, 1);

-- select SchoolSports.students.name, SchoolSports.students.class, SchoolSports.trainingGroups.id
-- from SchoolSports.students
-- inner join SchoolSports.studentGroups on students.id = student_id
-- inner join SchoolSports.trainingGroups on trainingGroups_id = trainingGroups.id
-- inner join SchoolSports.trainingSchedule on trainingGroups.id = trainingSchedule.id
-- inner join SchoolSports.coaches on students.coaches_id = coaches.id
-- where SchoolSports.trainingSchedule.hour = '08:00:00'
-- and SchoolSports.trainingSchedule.days = 'Mon'
-- and SchoolSports.coaches.name = 'Ivan Todorov Petrov';

-- select SchoolSports.coaches.name, SchoolSports.sports.name
-- from SchoolSports.coaches
-- cross join SchoolSports.sports;

-- select s1.id, s1.name, s1.coaches_id, s2.name
-- from SchoolSports.students as s1, SchoolSports.students s2
-- where s1.coaches_id = s2.coaches_id
-- and s1.id <> s2.id;

-- select name, 'students' as role from SchoolSports.students
-- union
-- select name, 'coaches' as role from SchoolSports.coaches;

-- select SchoolSports.students.name, SchoolSports.sports.name
-- from SchoolSports.students
-- cross join SchoolSports.sports; 

-- select min(tax) from SchoolSports.students;
-- select max(tax) from SchoolSports.students;
-- select count(name) from SchoolSports.students;
-- select sum(tax) from SchoolSports.students;
-- select avg(tax) from SchoolSports.students;

-- select SchoolSports.students.name, SchoolSports.students.tax
-- from SchoolSports.students
-- group by SchoolSports.students.tax, SchoolSports.students.name
-- having tax > 35;


