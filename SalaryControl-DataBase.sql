Drop database if exists SalaryControl;

Create database SalaryControl;
Use SalaryControl;

CREATE TABLE coaches (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE salary_payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    coach_id INT,
    month INT CHECK (month BETWEEN 1 AND 12),
    year INT,
    salaryAmount DECIMAL(10,2),
    UNIQUE (coach_id, month, year),
    FOREIGN KEY (coach_id) REFERENCES coaches(id) ON DELETE CASCADE
);



