
-- Data Engineering 

-- create employees table
CREATE table employees (
    emp_no INT NOT NULL,
    birth_date  DATE NOT NULL,
    first_name  VARCHAR(35) NOT NULL,
    last_name   VARCHAR(35) NOT NULL,
    gender      VARCHAR(35) NOT NULL,    
    hire_date   DATE NOT NULL,
    PRIMARY KEY (emp_no)
);

SELECT * FROM employees

-- create departments table
CREATE table departments (
    dept_no     CHAR(4) NOT NULL,
    dept_name   VARCHAR(35) NOT NULL,
    PRIMARY KEY (dept_no)
    
);

SELECT * FROM departments;

-- create dept_manager table
CREATE table dept_manager (
   dept_no CHAR(4) NOT NULL,
   emp_no INT NOT NULL,
   from_date DATE NOT NULL,
   to_date DATE NOT NULL,
   PRIMARY KEY (emp_no,dept_no)
); 

drop table dept_manager

select * from dept_manager

-- create dept_emp table
CREATE table dept_emp (
    emp_no INT NOT NULL,
    dept_no CHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    PRIMARY KEY (emp_no,dept_no)
);
drop table dept_emp;

SELECT * FROM dept_emp;

-- create titles table
CREATE table titles (
    emp_no      INT NOT NULL,
    title       VARCHAR(35) NOT NULL,
    from_date   DATE NOT NULL,
    to_date     DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no,title, from_date)
); 

SELECT * FROM titles;

-- create salaries table
CREATE table salaries (
    emp_no      INT  NOT NULL,
    salary      INT  NOT NULL,
    from_date   DATE NOT NULL,
    to_date     DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no, from_date)
) ;

SELECT * FROM salaries;

-- Query * FROM Each Table Confirming Data
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

-- Data Analysis --

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no;

-- 2. List employees who were hired in 1986.

SELECT first_name, last_name, hire_date 
FROM employees WHERE hire_date BETWEEN '01-01-1986' AND '12-31-1986';


-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';

-- 
8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;