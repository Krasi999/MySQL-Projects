Drop database if exists Company;

Create database Company;
Use Company;

Create table employees(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50),
	salary DECIMAL(10,2),
	position VARCHAR(50),
	created_at DATETIME 
);

Create table work_hours(
	id INT PRIMARY KEY AUTO_INCREMENT,
	employee_id INT,
	hours_worked INT,
	work_date DATE,
    Constraint foreign key (employee_id) references employees(id)
);

Create table salary_log(
	id INT PRIMARY KEY AUTO_INCREMENT,
	employee_id INT,
	old_salary DECIMAL(10,2),
	new_salary DECIMAL(10,2),
	changed_at DATETIME
);
