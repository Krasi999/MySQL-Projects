create database University;
use University;

create table students(
	id int primary key auto_increment,
    name varchar(50),
    email varchar(50)
);

create table courses(
	id int primary key auto_increment,
    course_name varchar(50),
    teacher varchar(50)
);

create table enrollments(
	student_id int,
    course_id int,
    grade int,
    primary key (student_id, course_id),
    constraint foreign key (student_id) references students(id) on delete cascade on update cascade,
    constraint foreign key (course_id) references courses(id) on delete cascade on update cascade
);

create table professors(
	id int primary key auto_increment,
    name varchar(50),
    phone varchar(20)
);

drop table enrollments;
drop table courses;

create table courses(
	id int primary key auto_increment,
    course_name varchar(50),
    professor_id int,
    constraint foreign key(professor_id) references professors(id) on delete cascade on update cascade
);
