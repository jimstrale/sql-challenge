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

