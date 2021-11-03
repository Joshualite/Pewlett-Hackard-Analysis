SELECT first_name, last_name FROM employees 
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';


-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_data BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_data BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name ,last_name 
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_data BETWEEN '1985-01-01' AND '1988-12-31');

-- 7.3.2

DROP TABLE retirement_info;

SELECT emp_no, first_name , last_name
INTO retirement_info
FROM employees 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_data BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

--7.3.3

SELECT departments.dept_name, dept_manager.emp_no , dept_manager.from_date, dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON  departments.dept_no  = dept_manager.dept_no;

SELECT retirement_info.emp_no, retirement_info.first_name , retirement_info.last_name,dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

SELECT ri.emp_no, ri.first_name , ri.last_name , de.to_date
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no;

SELECT d.dept_name, dm.emp_no , dm.from_date , dm.to_date
FROM departments AS d
INNER JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no;

SELECT ri.emp_no,
      ri.first_name, 
	  ri.last_name,
	  de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
on ri.emp_no = de.emp_no
WHERE de.to_date = ('999-01-01');

-- Employee count by department number
SELECT COUNT (ce.emp_no), de.dept_no
FROM current_emp  AS ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no

SELECT COUNT (ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT COUNT(ce.emp_no), de.dept_no
INTO retirement_by_department
FROM current_emp AS ce
LEFT JOIN dept_emp AS de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no

SELECT emp_no,
       first_name,
	   last_name, 
	   gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_data BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE emp_info;

SELECT e.emp_no,
       e.first_name,
	   e.last_name,
	   e.gender,
	   s.salary,
	   de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON e.emp_no = s.emp_no
INNER JOIN dept_emp as de
on e.emp_no = de.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_data BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');


SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);



SELECT * FROM dept_info;

SELECT ri.emp_no,
       ri.first_name,
	   ri.last_name,
	   di.dept_name
INTO sales_info	   
FROM retirement_info as ri
INNER JOIN dept_info as di
ON ri.emp_no = di.emp_no
WHERE dept_name  = 'Sales';        