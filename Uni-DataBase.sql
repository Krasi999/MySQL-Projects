CREATE DATABASE Uni;
USE Uni;

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    credits INT,
    subject VARCHAR(20)
);

CREATE TABLE teachers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    subject VARCHAR(20)
);

CREATE TABLE grups (
    id INT PRIMARY KEY AUTO_INCREMENT,
    days ENUM('Mon', 'Tue', 'Wed', 'Thu', 'Fri'),
    hour TIME,
    course_id INT NOT NULL,
    teacher_id INT UNIQUE,
    CONSTRAINT FOREIGN KEY (course_id) REFERENCES courses(id),
    CONSTRAINT FOREIGN KEY (teacher_id) REFERENCES teachers(id) ON DELETE CASCADE
);

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    fnum VARCHAR(10),
    grups_id int not null,
    constraint foreign key (grups_id) references grups(id)
);

CREATE TABLE participate_in (
    grups_id INT NOT NULL,
    student_id INT NOT NULL,
    PRIMARY KEY (grups_id, student_id),
    CONSTRAINT FOREIGN KEY (grups_id) REFERENCES grups(id),
    CONSTRAINT FOREIGN KEY (student_id) REFERENCES students(id)
);

alter table students
add email varchar(20);


