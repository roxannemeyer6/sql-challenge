--starting with the departments csv, I created a table them imported the 
--information from the csv using a right click-->import data

create table departments (
	dept_no varchar(4) PRIMARY KEY,
	dept_name text
);

Select * from departments;

--now create then import for department employees
create table dept_emp (
	emp_no int PRIMARY KEY,
	dept_no varchar(4)
);

Select * from dept_emp;

--now create then import for department managers
create table dept_manager (
	dept_no varchar(4),
	emp_no int PRIMARY KEY
);

Select * from dept_manager;

--now create then import for employees
create table employees (
	emp_no int PRIMARY KEY,
	emp_title_id varchar(5),
	birth_date date,
	first_name varchar(30),
	last_name varchar (30),
	sex text,
	hire_date date
);

Select * from employees;


--now create then import for salaries
create table salaries (
	emp_no int PRIMARY KEY,
	salary int
);

Select * from salaries

--now create then import for titles. note: I
--found that title_ID in this original table is the
--same as emp_title_ID from the employees table
--so I needed to edit and rename so I can link
create table titles (
	title_id varchar(5) PRIMARY KEY,
	title varchar(20)
);

ALTER TABLE titles
RENAME COLUMN title_id to emp_title_ID;

Select * from titles;

--now that everything has been imported, I need to modify the data
--so that I can create new tables as needed
--I was asked to create the following:
--1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, 
  employees.first_name, 
  employees.last_name,
  employees.sex,
  salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no = salaries.emp_no
--2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT employees.first_name, 
  employees.last_name,
  employees.hire_date
FROM employees
WHERE hire_date > '12/31/1985'
AND hire_date < '1/1/1987'
--3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dept_manager.emp_no, 
  employees.first_name, 
  employees.last_name,
  departments.dept_no,
  departments.dept_name
FROM dept_manager
INNER JOIN employees ON
dept_manager.emp_no = employees.emp_no
INNER JOIN departments ON
dept_manager.dept_no = departments.dept_no

--4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT employees.emp_no, 
  employees.first_name, 
  employees.last_name,
  dept_emp.dept_no,
  departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no
--5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
--note: got help from https://stackoverflow.com/questions/16179802/query-to-retrieve-all-people-with-a-last-name-starting-with-a-specific-letter
SELECT employees.first_name, 
  employees.last_name,
  employees.sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'

--6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT employees.emp_no, 
  employees.first_name, 
  employees.last_name,
  dept_emp.dept_no,
  departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no
WHERE dept_name= 'Sales'
--7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, 
  employees.first_name, 
  employees.last_name,
  dept_emp.dept_no,
  departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no
WHERE dept_name= 'Sales'
	OR dept_name= 'Development'
--8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
--note: received help from https://stackoverflow.com/questions/1217244/select-top-distinct-results-ordered-by-frequency
SELECT(last_name), count(*)
from employees
group by(last_name) 
order by count(*) desc
