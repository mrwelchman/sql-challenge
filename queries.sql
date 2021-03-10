create table titles (
	title_id varchar primary key,
	title varchar);

create table departments (
	dept_no varchar primary key,
	dept_name varchar);
	
create table employees (
	emp_no int primary key,
	emp_title_id varchar,
	birth_date varchar,
	first_name varchar,
	last_name varchar,
	sex varchar,
	hire_date varchar,
	foreign key (emp_title_id) references titles(title_id));
	
create table salaries (
	emp_no int primary key,
	salary int,
	foreign key (emp_no) references employees(emp_no));
	
create table dept_emp (
	emp_no int, 
	dept_no varchar,
	primary key (emp_no, dept_no),
	foreign key (emp_no) references employees(emp_no),
	foreign key (dept_no) references departments(dept_no));
	
create table dept_manager (
	dept_no varchar,
	emp_no int,
	primary key (dept_no, emp_no),
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references employees(emp_no));
	
-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
from employees
join salaries on employees.emp_no=salaries.emp_no;

--2. List first name, last name, and hire date for employees who were hired in 1986.
select first_name, last_name, hire_date
from employees
where hire_date like '%1986';

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
select dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
from dept_manager
join departments on dept_manager.dept_no=departments.dept_no
join employees on dept_manager.emp_no=employees.emp_no;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
join dept_emp on employees.emp_no=dept_emp.emp_no
join departments on dept_emp.dept_no=departments.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name, sex
from employees
where first_name='Hercules' and last_name like 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
select * from departments;
	-- sales dept_no is d007
select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
join dept_emp on employees.emp_no=dept_emp.emp_no
join departments on dept_emp.dept_no=departments.dept_no
where departments.dept_no='d007';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select * from departments;
	-- sales dept_no is d007, development dept_no is d005
select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
join dept_emp on employees.emp_no=dept_emp.emp_no
join departments on dept_emp.dept_no=departments.dept_no
where departments.dept_no='d005' or departments.dept_no='d007';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count(last_name) as "Frequency"
from employees
group by last_name
order by "Frequency" desc;

