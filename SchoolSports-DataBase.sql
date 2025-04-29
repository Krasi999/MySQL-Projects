Create database SchoolSports;
Use SchoolSports;

Create table students(
	id int primary key auto_increment,
    name varchar(50),
    coaches_id int not null,
    constraint foreign key (coaches_id) references coaches(id)
);

Create table coaches(
	id int primary key auto_increment,
    name varchar(50),
    sport varchar(30)
);

Create table sports(
	id int primary key auto_increment,
    name varchar(30)
);

Create table trainingGroups(
	id int primary key auto_increment,
    hour time,
    sport varchar(30)
);

Create table trainingSchedule(
	id int primary key auto_increment,
    hour time,
    days enum('Mon', 'Thu', 'Wed', 'Thr', 'Fri')
);

Create table studentGroups(
	student_id int not null,
    trainingGroups_id int not null,
    primary key(student_id, trainingGroups_id),
    constraint foreign key (student_id) references students(id),
    constraint foreign key (trainingGroups_id) references trainingGroups(id)
);

alter table students
add class int;

alter table trainingGroups
drop hour;

alter table SchoolSports.students
add tax int not null;
