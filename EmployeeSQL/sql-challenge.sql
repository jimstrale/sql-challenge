CREATE TABLE "titles" (
  "title_id" VARCHAR,
  "title" VARCHAR,
  PRIMARY KEY ("title_id")
);

CREATE TABLE "employees" (
  "emp_no" INT,
  "emp_title_id" VARCHAR,
  "birth_date" DATE,
  "first_name" VARCHAR,
  "last_name" VARCHAR,
  "sex" VARCHAR,
  "hire_date" DATE,
  PRIMARY KEY ("emp_no"),
  CONSTRAINT "FK_employees.emp_title_id"
    FOREIGN KEY ("emp_title_id")
      REFERENCES "titles"("title_id")
);

CREATE TABLE "salary" (
  "emp_no" INT,
  "salary" INT
);

CREATE TABLE "departments" (
  "dept_no" VARCHAR,
  "dept_name" VARCHAR,
  PRIMARY KEY ("dept_no", "dept_name")
);

CREATE TABLE "dept_manager" (
  "dept_no" VARCHAR,
  "emp_no" INT,
  CONSTRAINT "FK_dept_manager.dept_no"
    FOREIGN KEY ("dept_no")
      REFERENCES "departments"("dept_no")
);

CREATE TABLE "dept_emp" (
  "emp_no" INT,
  "dept_no" VARCHAR,
  CONSTRAINT "FK_dept_emp.emp_no"
    FOREIGN KEY ("emp_no")
      REFERENCES "employees"("emp_no"),
  CONSTRAINT "FK_dept_emp.dept_no"
    FOREIGN KEY ("dept_no")
      REFERENCES "departments"("dept_no")
);

--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salary.salary
FROM employees
INNER JOIN salary ON
employees.emp_no = salary.emp_no;

--2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE employees.hire_date >= '1986-01-01' AND employees.hire_date < '1987-01-01';

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no;

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT employees.first_name, employees.last_name
FROM employees
WHERE employees.first_name = 'Hercules' AND employees.last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development'; 

--8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
SELECT employees.last_name, COUNT(employees.last_name) AS "freq_count"
FROM employees
GROUP BY employees.last_name
ORDER BY "freq_count" DESC;