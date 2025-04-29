-- Disable foreign key checks to prevent constraint errors
SET FOREIGN_KEY_CHECKS = 0;

-- Truncate all tables (faster than DELETE)
TRUNCATE TABLE ServerApplication.users;
TRUNCATE TABLE ServerApplication.servers;
TRUNCATE TABLE ServerApplication.services;
TRUNCATE TABLE ServerApplication.failures;
TRUNCATE TABLE ServerApplication.notifications;
TRUNCATE TABLE ServerApplication.users_services;
TRUNCATE TABLE ServerApplication.servers_services;

-- Enable foreign key checks again
SET FOREIGN_KEY_CHECKS = 1;

-- Вмъкване на данни в таблицата users
INSERT INTO users (user_id, name, email, salary, role) VALUES
(1, 'Ivan Petrov', 'ivan.petrov@example.com', 4200.00, 'Admin'),
(2, 'Maria Ivanova', 'maria.ivanova@example.com',3780.00, 'Admin'),
(3, 'Georgi Georgiev', 'georgi.georgiev@example.com', 3912.00, 'Admin'),
(4, 'Elena Stoyanova', 'elena.stoyanova@example.com', 3160.00, 'Technician'),
(5, 'Petar Dimitrov', 'petar.dimitrov@example.com', 2950.00, 'Technician'),
(6, 'Stoyan Kostov', 'stoyan.kostov@example.com', 3004.00, 'Technician'),
(7, 'Kristina Hristova', 'kristina.hristova@example.com', 0.00, 'User'),
(8, 'Dimitar Nikolov', 'dimitar.nikolov@example.com', 0.00, 'User'),
(9, 'Nikolay Kolev', 'nikolay.kolev@example.com', 0.00,  'User'),
(10, 'Viktor Andreev', 'viktor.andreev@example.com', 0.00, 'User');

-- Вмъкване на данни в таблицата servers
-- Само потребители с роля "Admin" или "Technician" могат да отговарят за сърварите
INSERT INTO servers (server_id, hostname, ip_address, location, status, responsible_person_id) VALUES
(1, 'server1', '192.168.1.1', 'Sofia', 'Active', 1),
(2, 'server2', '192.168.1.2', 'Plovdiv', 'Inactive', 2),
(3, 'server3', '192.168.1.3', 'Varna', 'Active', 3),
(4, 'server4', '192.168.1.4', 'Burgas', 'Active', 4),
(5, 'server5', '192.168.1.5', 'Ruse', 'Inactive', 5),
(6, 'server6', '192.168.1.6', 'Stara Zagora', 'Active', 6);

-- Вмъкване на данни в таблицата services
INSERT INTO services (service_id, name, status, port) VALUES
(1, 'Web Server', 'Running', '80'),
(2, 'Database Server', 'Running', '3306'),
(3, 'Email Server', 'Down', '25'),
(4, 'VPN Service', 'Running', '1194'),
(5, 'File Server', 'Running', '21'),
(6, 'Monitoring Service', 'Down', '8080'),
(7, 'DNS Server', 'Running', '53'),
(8, 'Firewall', 'Running', '443'),
(9, 'SSH Service', 'Running', '22'),
(10, 'Backup Service', 'Down', '9090');

-- Вмъкване на данни в таблицата failures
-- Само потребители с роля "User" могат да докладват за откази на системата
INSERT INTO failures (failure_id, downtime, reason, status, service_id, reported_by) VALUES
(1, '00:30:00', 'Network Issue', 'Resolved', 3, 9),
(2, '01:15:00', 'Hardware Failure', 'Unresolved', 6, 7),
(3, '00:45:00', 'Software Bug', 'Resolved', 10, 10),
(4, '02:00:00', 'Power Outage', 'Unresolved', 3, 8),
(5, '00:20:00', 'DDoS Attack', 'Resolved', 8, 7),
(6, '01:10:00', 'Overload', 'Unresolved', 2, 8),
(7, '00:50:00', 'Configuration Error', 'Unresolved', 4, 10),
(8, '01:30:00', 'Security Breach', 'Resolved', 7, 9),
(9, '02:45:00', 'Network Congestion', 'Resolved', 5, 7),
(10, '00:55:00', 'Storage Failure', 'Unresolved', 1, 10);

-- Вмъкване на данни в таблицата notifications
-- Известие за проблем в системата могат да получат само потребители с роля "Admin" или "Technician"
INSERT INTO notifications (notification_id, sent_time, status, sent_to, failure_id) VALUES
(1, '00:31:00', 'Sent', 3, 1),
(2, '01:16:00', 'Sent', 6, 2),
(3, '00:46:00', 'Sent', 4, 3),
(4, '02:01:00', 'Failed', 3, 4),
(5, '00:21:00', 'Sent', 2, 5),
(6, '01:11:00', 'Sent', 2, 6),
(7, '00:51:00', 'Failed', 4, 7),
(8, '01:31:00', 'Sent', 1, 8),
(9, '02:46:00', 'Sent', 5, 9),
(10, '00:56:00', 'Failed', 1, 10);

-- Вмъкване на данни в таблицата users_services
INSERT INTO users_services (user_id, service_id) VALUES
(1, 3), (2, 7), (3, 1), (4, 9), (5, 6),
(9, 6), (7, 7), (1, 8), (7, 9), (3, 10),
(10, 3), (3, 9), (8, 1), (4, 10), (2, 5),
(1, 6), (6, 7), (8, 8), (6, 9), (10, 7);

-- Вмъкване на данни в таблицата servers_services
INSERT INTO servers_services (server_id, service_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (1, 7), (2, 8), (3, 9), (4, 10);

SELECT * FROM users
WHERE role like '%Admin%';

SELECT role as Roles, min(salary) as MinimumSalaryForEachRole
FROM users
GROUP BY role;

SELECT servers.server_id, servers.hostname, servers.location, 
services.service_id, services.name, services.status
FROM servers_services
JOIN servers ON servers_services.server_id = servers.server_id
JOIN services ON servers_services.service_id = services.service_id;

SELECT failures.failure_id, failures.reason as failureReason, failures.status as failureStatus,
notifications.notification_id, notifications.status as notificationStatus
FROM failures
RIGHT OUTER JOIN notifications ON failures.failure_id = notifications.failure_id;

SELECT users.user_id, users.name, users.role, services.name
FROM users
JOIN services 
ON users.user_id IN (
	SELECT user_id
    FROM users_services
    WHERE users_services.service_id = services.service_id
    );
    
SELECT avg(users.salary) as AvarageSalaryByEachRole, users.role as UsersRole,
group_concat(servers.hostname) as ServersNames, group_concat(servers.location) as ServersLocations
FROM users
JOIN servers ON users.user_id = servers.responsible_person_id
GROUP BY role;

DROP TRIGGER IF EXISTS users_salary_limit;

DELIMITER //

CREATE TRIGGER users_salary_limit
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF NEW.role = 'User' AND NEW.salary <> 0 THEN SET NEW.salary = 0;
    END IF;
END //

DELIMITER ;

INSERT INTO users(user_id, name, email, salary, role) VALUES 
(11, "Gergana Atanasova", "gergana.atanasova@example.com", 2840.00, "Technician"),
(12, "Kristian Kirov", "kristian.kirov@example.com", 940.00, "User"),
(13, "Svetlin Grigororv", "svetlin.grigorov@example.com", 3878.00, "Admin"),
(14, "Lili Hristova", "lili.hristova@example.com", 1430.00, "User");

SELECT * FROM users;

DROP TABLE IF EXISTS technician_reports;

CREATE TABLE technician_reports (
    technician_id INT,
    technician_name VARCHAR(50),
    salary DECIMAL(10, 2),
    salary_category VARCHAR(20),
    report_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP PROCEDURE IF EXISTS list_technicians_salaries;

DELIMITER //

CREATE PROCEDURE list_technicians_salaries()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE tech_name VARCHAR(50);
    DECLARE tech_salary DECIMAL(10,2);
    DECLARE tech_id INT;
    DECLARE salary_category VARCHAR(20);

    DECLARE tech_cursor CURSOR FOR
        SELECT user_id, name, salary FROM users WHERE role = 'Technician';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN tech_cursor;

    read_loop: LOOP
        FETCH tech_cursor INTO tech_id, tech_name, tech_salary;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF tech_salary < 2900 THEN
            SET salary_category = 'Low';
        ELSEIF tech_salary BETWEEN 2900 AND 3100 THEN
            SET salary_category = 'Medium';
        ELSE
            SET salary_category = 'High';
        END IF;

        INSERT INTO technician_reports (technician_id, technician_name, salary, salary_category)
        VALUES (tech_id, tech_name, tech_salary, salary_category);

    END LOOP;

    CLOSE tech_cursor;
END //

DELIMITER ;

CALL list_technicians_salaries();

SELECT * FROM  technician_reports;
		
-- Тригер към изтриване на записи от таблицата services, който автоматично да изтрива свързаните записи към останалите свързани таблици failures, users_services, servers_services.

-- Select * From services;

-- delete from services where name = 'Firewall';

-- Select * From failures;

-- Delimiter //
-- 	Create trigger delete_triger after delete on services for each row
--     Begin
-- 		if services.service_id = failures.service_id on delete cascade;
--         elseif services.service_id = users_services.service_id then set users_services.service_id = 0;
--         elseif services.service_id = servers_services.service_id then set servers_services.service_id = 0;
--         end if;
-- 	end//
--     
-- Delimiter ;

-- Select * from failures;

DROP TRIGGER IF EXISTS delete_service_related;

DELIMITER //

CREATE TRIGGER delete_service_related
BEFORE DELETE ON services
FOR EACH ROW
BEGIN
    -- Изтриване на записи от failures, свързани със съответната услуга
    DELETE FROM failures WHERE service_id = OLD.service_id;

    -- Изтриване на записи от users_services
    DELETE FROM users_services WHERE service_id = OLD.service_id;

    -- Изтриване на записи от servers_services
    DELETE FROM servers_services WHERE service_id = OLD.service_id;
END //

DELIMITER ;

-- Пример: изтриване на услуга с ID = 3
DELETE FROM services WHERE service_id = 3;

-- Проверка дали свързаните записи са изтрити
SELECT * FROM failures WHERE service_id = 3;
SELECT * FROM users_services WHERE service_id = 3;
SELECT * FROM servers_services WHERE service_id = 3;


