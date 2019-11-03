CREATE TABLE departments (
	dept_no VARCHAR (4) NOT NULL,
	dept_name VARCHAR (30) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);

SELECT * FROM departments;

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR (4) NOT NULL,
	from_date VARCHAR (10) NOT NULL,
	to_date VARCHAR (10) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM dept_emp;

CREATE TABLE dept_manager (
	dept_no VARCHAR (4) NOT NULL,
	emp_no INT NOT NULL,
	from_date VARCHAR (10) NOT NULL,
	to_date VARCHAR (10) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (dept_no, emp_no)
);

SELECT * FROM dept_manager;

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date VARCHAR (10) NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR,
	hire_date VARCHAR (10),
	PRIMARY KEY (emp_no)
);

SELECT * FROM employees;

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT,
	from_date VARCHAR (10),
	to_date VARCHAR (10),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, from_date)
);

SELECT * FROM salaries;

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date VARCHAR (10),
	to_date VARCHAR (10),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);

SELECT * FROM titles;

--List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM salaries
INNER JOIN employees ON
employees.emp_no=salaries.emp_no;

--List employees who were hired in 1986. This code is not working - I think I incorrectly set the hire_date as VARCHAR instead of DATE. It is too late to fix it now as I have used the table in many queries.
--SELECT *
--FROM employees
--WHERE
	--hire_date >= 1/1/1986
	--AND hire_date < 1/1/1987;

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
FROM dept_manager
INNER JOIN employees ON
employees.emp_no=dept_manager.emp_no
INNER JOIN departments ON
dept_manager.dept_no=departments.dept_no

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
FROM employees
INNER JOIN dept_emp ON
dept_emp.emp_no=employees.emp_no
INNER JOIN departments ON
dept_emp.dept_no=departments.dept_no

--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name = 'Hercules' 
AND last_name
LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
FROM employees
INNER JOIN dept_emp 
ON (dept_emp.emp_no=employees.emp_no)
INNER JOIN departments 
ON (dept_emp.dept_no=departments.dept_no)
WHERE departments.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
FROM employees
INNER JOIN dept_emp 
ON (dept_emp.emp_no=employees.emp_no)
INNER JOIN departments 
ON (dept_emp.dept_no=departments.dept_no)
WHERE departments.dept_name = 'Sales'
OR departments.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY last_name DESC;
