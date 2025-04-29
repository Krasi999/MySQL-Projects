-- Disable foreign key checks to prevent constraint errors
SET FOREIGN_KEY_CHECKS = 0;

-- Truncate all tables (faster than DELETE)
TRUNCATE TABLE uni.students;
TRUNCATE TABLE uni.grups;
TRUNCATE TABLE uni.teachers;
TRUNCATE TABLE uni.courses;

-- Enable foreign key checks again
SET FOREIGN_KEY_CHECKS = 1;

insert into uni.courses(credits, subject)
values (10, 'Programming'), (8, 'English');

insert into uni.teachers(id, name, subject)
values (1, 'Hristo', 'Programming'), (2, 'Georgi', 'English');

insert into uni.grups(id, days, hour, course_id, teacher_id)
values (1, 'Mon', '08:30:00', 1, 1), (2, 'Wed', '10:45:00', 2, 2);

insert into uni.students(id, name, fnum, grups_id, email)
values (1, 'Ivan', '121223007', 1, 'ivanchooo@abv.bg'), (2, 'Krasimir', '121223008', 2, 'krasuska@gmail.com');

update uni.students
set email = 'newemail@gmail.com'
where id = '1';

update uni.grups
set hour = '09:30:00'
where id = '2';

delete from uni.students where id = 2;
delete from uni.grups where id = 2;

-- select * from uni.students;
-- select name, email from uni.students; 
-- select * from uni.courses where subject = 'Programming';
-- select * from uni.grups where days = 'Wed';

-- select * from uni.students;
-- select * from uni.teachers;
-- select * from uni.grups;
-- select * from uni.courses;


