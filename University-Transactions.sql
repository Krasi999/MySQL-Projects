-- Disable foreign key checks to prevent constraint errors
SET FOREIGN_KEY_CHECKS = 0;

-- Truncate all tables (faster than DELETE)
TRUNCATE TABLE University.students;
TRUNCATE TABLE University.courses;
TRUNCATE TABLE University.enrollments;
TRUNCATE TABLE University.professors;

-- Enable foreign key checks again
SET FOREIGN_KEY_CHECKS = 1;

insert into students(id, name, email)
values (1, 'Krasimir', 'krasuska@gmail.com'), (2, 'Ivan', 'vankooo@gmail.com'), (3, 'Dimo', 'dimchoo123@gmail.com');

insert into professors(id, name, phone)
values (1, 'Petar Petrov', '0893595055'), (2, 'Ivanka Georgieva', '0887683456'), (3,'Stilian Rangeleov', '0875431298');

insert into courses(id, course_name, professor_id)
values (1, 'Informatika', 1), (2, 'Matematika', 2), (3, 'Fizika', 3);

insert into enrollments(student_id, course_id, grade)
values (1, 3, 4), (2, 1, 6), (3, 2, 5);

begin;

insert into students(id, name, email) 
values(4, 'Pencho', 'penata1@gmail.com');

insert into enrollments(student_id, course_id, grade)
values(4, 1, 6);

commit;

begin;

select * from enrollments where student_id = 1 for update;

update enrollments
set grade = 4
where student_id = 1;

commit;




