-- Disable foreign key checks to prevent constraint errors
SET FOREIGN_KEY_CHECKS = 0;

-- Truncate all tables (faster than DELETE)
TRUNCATE TABLE SalaryControl.salary_payments;
TRUNCATE TABLE SalaryControl.coaches;

-- Enable foreign key checks again
SET FOREIGN_KEY_CHECKS = 1;

-- Вмъкване на примерни данни
INSERT INTO coaches (id, name) 
VALUES (1, 'Иван Петров'), (2, 'Георги Димитров'), (3, 'Мария Николова');

INSERT INTO salary_payments (id, coach_id, month, year, salaryAmount) 
VALUES (1, 1, 1, 2024, 2500.00), (2, 2, 1, 2024, 2800.50), (3, 3, 2, 2024, 3000.75);

-- Създаване на процедура
DROP PROCEDURE IF EXISTS PaySalary;

DELIMITER //

CREATE PROCEDURE PaySalary(
    IN IN_coach_id INT,
    IN IN_payment_month INT,
    IN IN_payment_year INT,
    IN IN_amount DECIMAL(10,2)
)
BEGIN
    DECLARE coach_exists INT;
    DECLARE payment_exists INT;

    -- Проверка дали треньорът съществува
    SELECT COUNT(*) INTO coach_exists 
    FROM coaches 
    WHERE id = IN_coach_id;

    IF coach_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The coach is not found!';
    END IF;

    -- Проверка дали вече има заплата за този период
    SELECT COUNT(*) INTO payment_exists 
    FROM salary_payments 
    WHERE coach_id = IN_coach_id AND month = IN_payment_month AND year = IN_payment_year;

    IF payment_exists = 0 THEN
        INSERT INTO salary_payments (coach_id, month, year, salaryAmount) 
        VALUES (IN_coach_id, IN_payment_month, IN_payment_year, IN_amount);
    ELSE
        UPDATE salary_payments 
        SET salaryAmount = IN_amount 
        WHERE coach_id = IN_coach_id AND month = IN_payment_month AND year = IN_payment_year;
    END IF;
END //

DELIMITER ;

CALL PaySalary(1, 3, 2025, 3200.00);

SELECT * FROM salary_payments;



DROP PROCEDURE IF EXISTS raiseSalaries;

DELIMITER //

CREATE PROCEDURE raiseSalaries()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE emp_id INT;
    DECLARE emp_name VARCHAR(100);
    DECLARE emp_salary DECIMAL(10,2);

    DECLARE employeesForRaise CURSOR FOR
        SELECT id, name, salary FROM temp_employees WHERE salary < 50000;
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    DROP TEMPORARY TABLE IF EXISTS temp_employees;

    CREATE TEMPORARY TABLE temp_employees (
        id INT PRIMARY KEY,
        name VARCHAR(100),
        salary DECIMAL(10, 2)
    );

    INSERT INTO temp_employees (id, name, salary)
    VALUES 
        (1, 'John Doe', 50000),
        (2, 'Jane Smith', 60000),
        (3, 'Sam Brown', 45000);

    OPEN employeesForRaise;

    FETCH employeesForRaise INTO emp_id, emp_name, emp_salary;

    WHILE done = 0 DO
        UPDATE temp_employees
        SET salary = emp_salary * 1.10
        WHERE id = emp_id;

        FETCH employeesForRaise INTO emp_id, emp_name, emp_salary;
    END WHILE;

    CLOSE employeesForRaise;

    SELECT * FROM temp_employees;
END //

DELIMITER ;

CALL raiseSalaries();
