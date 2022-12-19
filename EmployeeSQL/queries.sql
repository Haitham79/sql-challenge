CREATE TABLE Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
Country varchar (100) 
);

CREATE TABLE Dept
(
dept_name varchar (100), 
dept_no varchar (100) 
);
CREATE TABLE Dept_emp
(
emp_no varchar (100),
dept_no varchar (100)
);

CREATE TABLE Dept_manager
(
dept_no varchar (100),	
emp_no varchar (100)
);

CREATE TABLE employees
(
emp_no varchar (100),
emp_title_id varchar (100),
birth_date varchar (100),
first_name varchar (100),
last_name varchar (100),
sex varchar (100),
hire_date varchar (100)
);

CREATE TABLE salaries
(	
emp_no varchar (100),
salary varchar (100)
);

CREATE TABLE titles
(
title_id varchar (100),
title varchar (100)
 );
 
 
 -- List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
	FROM employees
	INNER JOIN salaries ON employees.emp_no = salaries.emp_no;
	ORDER by employees.emp_no

-- List the first name, last name, and hire date for the employees who were hired in 1986.
select first_name, last_name, hire_date 
	FROM employees
	WHERE hire_date >= '1986-01-01' and hire_date <= '1986-12-31';
	ORDER by hire_date

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, 
	FROM dept_manager
	INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
	INNER JOIN employees ON employees.emp_no = dept_manager.emp_no;
	ORDER by dept_manager.dept_no

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
	FROM employees
	INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
	INNER JOIN departments ON departments.dept_no = dept_emp.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
	SELECT emp_no, first_name, last_name, sex 
	FROM employees
	WHERE first_name = 'Hercules' AND last_name LIKE 'B%';
	ORDER by emp_no 

-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
	FROM employees
	INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
	INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
	WHERE departments.dept_name = 'Sales';
	ORDER by employees.emp_no


-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.first_name, employees.last_name
	FROM employees
	INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
	INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
	WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';
	ORDER by departments.dept_name, employees.emp_no 

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS "Last Name Count"
	FROM employees
	GROUP BY last_name
	ORDER BY "Last_Name



CREATE TABLE employees (
    emp_no int   NOT NULL,
    emp_title_id varchar   NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar   NOT NULL,
    last_name varchar   NOT NULL,
    sex varchar   NOT NULL,
    hire_date date   NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE salaries (
    emp_no int   NOT NULL,
    salary int   NOT NULL,
    CONSTRAINT pk_salaries PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE titles (
    title_id varchar   NOT NULL,
    title varchar   NOT NULL,
    CONSTRAINT pk_titles PRIMARY KEY (
        title_id
     )
);

CREATE TABLE departments (
    dept_no varchar   NOT NULL,
    dept_name varchar   NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE dept_emp (
    emp_no int   NOT NULL,
    dept_no varchar   NOT NULL,
    CONSTRAINT pk_dept_emp PRIMARY KEY (
        emp_no,dept_no
     )
);

CREATE TABLE dept_manager (
    dept_no varchar   NOT NULL,
    emp_no int   NOT NULL,
    CONSTRAINT pk_dept_manager PRIMARY KEY (
        dept_no,emp_no
     )
);

ALTER TABLE employees ADD CONSTRAINT fk_employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES titles (title_id);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);
