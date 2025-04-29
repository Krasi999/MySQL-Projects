create database Films;
use Films;

create table movies(
	movie_id int primary key auto_increment,
    title varchar(50),
    release_year int,
    duration int,
    studio_id int not null,
    producer_id int not null,
    budget int,
    constraint foreign key (studio_id) references studios(studio_id),
    constraint foreign key (producer_id) references producers(producer_id)
);

create table actors(
	actor_id int primary key auto_increment,
    name varchar(50),
    address varchar(50),
    gender enum('M', 'F'),
    birthdate date
);

create table studios(
	studio_id int primary key auto_increment,
    name varchar(50),
    address varchar(50),
    bulstat varchar(50)
);

create table producers(
	producer_id int primary key auto_increment,
    name varchar(50),
    address varchar(50),
    bulstat varchar(50)
);

create table movies_actors(
	movie_id int not null,
    actor_id int not null,
    primary key(movie_id, actor_id),
	constraint foreign key (movie_id) references movies(movie_id),
    constraint foreign key (actor_id) references actors(actor_id)
);
