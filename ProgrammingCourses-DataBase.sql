create database ProgrammingCourses;
use ProgrammingCourses;

create table students(
	id int primary key auto_increment,
    name varchar(50),
    class int not null,
    instructors_id int not null,
    constraint foreign key (instructors_id) references instructors(id)
);

create table instructors(
	id int primary key auto_increment,
    name varchar(50),
    courses_name varchar(50)
);

create table courses(
	id int primary key auto_increment,
    courses_name varchar(50)
);

create table coursesGroups(
	id int primary key auto_increment,
    courses_name varchar(50),
    members_count int,
    courses_id int not null,
    constraint foreign key (courses_id) references courses(id)
);

create table coursesSchedule(
	id int primary key auto_increment,
    hour time,
    days enum('Mon', 'Thu', 'Wed', 'Thr', 'Fri'),
    coursesGroups_id int unique,
    constraint foreign key (coursesGroups_id) references coursesGroups(id)
);

create table studentGroups(
	student_id int not null,
    coursesGroups_id int not null,
    primary key(student_id, coursesGroups_id),
    constraint foreign key (student_id) references students(id),
    constraint foreign key (coursesGroups_id) references coursesGroups(id)
);

alter table students
add tax int;
