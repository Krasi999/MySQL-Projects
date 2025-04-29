drop database if exists serverapplication;
create database ServerApplication;
use ServerApplication;

create table users(
	user_id int primary key auto_increment,
    name varchar(50),
    email varchar(50),
    salary decimal(10,2),
    role varchar(50)
);

create table servers(
	server_id int primary key auto_increment,
    hostname varchar(50),
    ip_address varchar(20),
    location varchar(50),
    status varchar(20),
    responsible_person_id int,
    constraint foreign key (responsible_person_id) references users(user_id) on delete cascade on update cascade
);

create table services(
	service_id int primary key auto_increment,
    name varchar(50),
    status varchar(20),
    port varchar(20)
);

create table failures(
	failure_id int primary key auto_increment,
    downtime time,
    reason varchar(50),
    status varchar(20),
    service_id int,
    reported_by int,
    constraint foreign key (service_id) references services(service_id) on delete cascade on update cascade,
    constraint foreign key (reported_by) references users(user_id) on delete cascade on update cascade
);

create table notifications(
	notification_id int primary key auto_increment,
    sent_time time,
    status varchar(20),
    sent_to int,
    failure_id int unique,
	constraint foreign key (sent_to) references users(user_id) on delete cascade on update cascade,
    constraint foreign key (failure_id) references failures(failure_id) on delete cascade on update cascade
);

create table users_services(
	user_id int,
    service_id int,
    primary key(user_id, service_id),
    constraint foreign key (user_id) references users(user_id) on delete cascade on update cascade,
    constraint foreign key (service_id) references services(service_id) on delete cascade on update cascade
);

create table servers_services(
	server_id int,
    service_id int,
    primary key(server_id, service_id),
	constraint foreign key (server_id) references servers(server_id) on delete cascade on update cascade,
    constraint foreign key (service_id) references services(service_id) on delete cascade on update cascade
);
