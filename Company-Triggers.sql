-- Disable foreign key checks to prevent constraint errors
SET FOREIGN_KEY_CHECKS = 0;

-- Truncate all tables (faster than DELETE)
TRUNCATE TABLE Company.employees;
TRUNCATE TABLE Company.work_hours;
TRUNCATE TABLE Company.salary_log;

-- Enable foreign key checks again
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO employees (id, name, salary, position, created_at) VALUES
(1, 'Иван Петров', 3200.00, 'Програмист', NOW()),
(2, 'Мария Иванова', 2800.00, 'HR специалист', NOW()),
(3, 'Георги Димитров', 3500.00, 'Системен администратор', NOW()),
(4, 'Елена Николова', 3000.00, 'Маркетинг мениджър', NOW());

INSERT INTO work_hours (id, employee_id, hours_worked, work_date) VALUES
(1, 1, 120, '2025-04-15'),
(2, 2, 175, '2025-04-15'),
(3, 3, 140, '2025-04-15'),
(4, 4, 180, '2025-04-16');

INSERT INTO salary_log (employee_id, old_salary, new_salary, changed_at) VALUES
(1, 3000.00, 3200.00, '2025-04-01 09:00:00'),
(2, 2600.00, 2800.00, '2025-03-20 10:30:00'),
(3, 3300.00, 3500.00, '2025-04-10 11:00:00'),
(4, 2800.00, 3000.00, '2025-03-28 14:15:00');

DROP TRIGGER IF EXISTS before_insert_employee;
DROP TRIGGER IF EXISTS after_insert_work_hours;
DROP TRIGGER IF EXISTS before_update_salary;
DROP TRIGGER IF EXISTS after_update_salary;
DROP TRIGGER IF EXISTS before_delete_employee;
DROP TRIGGER IF EXISTS after_delete_employee;

DELIMITER //

CREATE TRIGGER before_insert_employee
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
  IF NEW.created_at IS NULL THEN
    SET NEW.created_at = NOW();
  END IF;
END//

DELIMITER ;

INSERT INTO employees (name, salary, position)
VALUES ('Антон Тодоров', 3100.00, 'QA инженер');

SELECT * FROM employees;



DELIMITER //

CREATE TRIGGER after_insert_work_hours
AFTER INSERT ON work_hours
FOR EACH ROW
BEGIN
  DECLARE total_hours INT;
  DECLARE log_count INT;

  SELECT SUM(hours_worked) INTO total_hours
  FROM work_hours
  WHERE employee_id = NEW.employee_id
    AND MONTH(work_date) = MONTH(NEW.work_date)
    AND YEAR(work_date) = YEAR(NEW.work_date);

  SELECT COUNT(*) INTO log_count
  FROM salary_log
  WHERE employee_id = NEW.employee_id
    AND MONTH(changed_at) = MONTH(NEW.work_date)
    AND YEAR(changed_at) = YEAR(NEW.work_date);

  IF total_hours > 160 AND log_count = 0 THEN
    UPDATE employees
    SET salary = salary * 1.10
    WHERE id = NEW.employee_id;
  END IF;
END//

DELIMITER ;

SELECT * FROM salary_log;



DELIMITER //

CREATE TRIGGER before_update_salary
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
  IF OLD.salary != NEW.salary THEN
    SET @old_salary := OLD.salary;
  END IF;
END//

DELIMITER ;



DELIMITER //

CREATE TRIGGER after_update_salary
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
  IF OLD.salary != NEW.salary THEN
    INSERT INTO salary_log (employee_id, old_salary, new_salary, changed_at)
    VALUES (NEW.id, @old_salary, NEW.salary, NOW());
  END IF;
END//

DELIMITER ;



DELIMITER //

CREATE TRIGGER before_delete_employee
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
  DECLARE work_count INT;

  SELECT COUNT(*) INTO work_count
  FROM work_hours
  WHERE employee_id = OLD.id;

  IF work_count > 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Не можете да изтриете служител, който има записи за работни часове.';
  END IF;
END//

DELIMITER ;



DELIMITER //

CREATE TRIGGER after_delete_employee
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
  INSERT INTO log_messages (message)
  VALUES (CONCAT('Служител ', OLD.name, ' (ID: ', OLD.id, ') е изтрит успешно.'));
END//

DELIMITER ;

SHOW TRIGGERS FROM Company;
    


