-- Join Employee and Salary CSVs to list employee #, last and first names, gender, and salary
SELECT 
	e.emp_no,
	e.last_name,
	e.first_name,
	e.gender,
	s.salary
FROM
	employee e
	INNER JOIN (
		SELECT salary.emp_no, salary.salary
		FROM salary) s 
	ON s.emp_no = e.emp_no;
	
-- List employees hired in the year 1986
SELECT 
	*
FROM 
	employee
WHERE
	hire_date >= '1986-01-01' AND hire_date < '1987-01-01';

-- List of managers in each department
SELECT
	dm.dept_no, -- department #
	d.dept_name, -- department name
	dm.emp_no, -- employee #
	e.last_name, -- last name
	e.first_name, -- first name
	dm.from_date, -- start date
	dm.to_date -- end date
FROM
	dept_manager dm
	JOIN (
		SELECT department.dept_no, department.dept_name
		FROM department) d
	ON d.dept_no = dm.dept_no
	JOIN (
		SELECT employee.emp_no, employee.last_name, employee.first_name
		FROM employee) e
	ON e.emp_no = dm.emp_no;

-- List of employees with respective department names
		--CREATE VIEW for use of view later on
CREATE VIEW emp_dept_name AS (
SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM
	employee e
	-- Join dept_emp with department first to join dept_no and dept_name
	JOIN (
		SELECT dept_emp.dept_no, dept_emp.emp_no
		FROM dept_emp) de
	ON de.emp_no = e.emp_no
	-- Using newly joined dept_no and dept_name, plug into final join
	JOIN (
		SELECT department.dept_no, department.dept_name
		FROM department) d
	ON d.dept_no = de.dept_no
);
SELECT * FROM emp_dept_name;

-- Find all employees with "Hercules" as first name, and last name starting with "B"
SELECT
	e.first_name,
	e.last_name
FROM 
	employee e
WHERE
	first_name ILIKE '%hercules%' AND last_name ILIKE 'b%';

-- *USING CREATE VIEW ABOVE* find all employees within sales department
SELECT *
FROM emp_dept_name
WHERE
	dept_name LIKE 'Sales';

-- *USING CREATE VIEW ABOVE* find all employees within sales or development departments
SELECT *
FROM emp_dept_name
WHERE
	dept_name LIKE 'Sales' OR dept_name LIKE 'Development';
	
-- List frequency of last names
SELECT 
	e.last_name,
	COUNT(*) AS emp_last_name_count
FROM
	employee e
GROUP BY
	e.last_name
-- sort in descending order
ORDER BY emp_last_name_count DESC;