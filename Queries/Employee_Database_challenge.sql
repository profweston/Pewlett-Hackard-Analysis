
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC

--Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title 
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--Retiring totals by Titles
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;


--Editing retiree list to include hire date

SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles_edited
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
ORDER BY emp_no ASC

SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title 
INTO unique_titles_edited
FROM retirement_titles_edited
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT COUNT(title), title
INTO retiring_titles_edited
FROM unique_titles_edited
GROUP BY title
ORDER BY count DESC;



--Mentorship Eligibility
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
     de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no=de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE de.to_date = '9999-01-01' 
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')

SELECT * COUNT(title), title
INTO mentorship_titles
FROM mentorship_eligibility
GROUP BY title


--Finding department name for all employees
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, dept_name
INTO dept_info_unique
FROM dept_info
ORDER BY emp_no DESC;


SELECT u.emp_no, u.first_name, u.last_name, u.title, di.dept_name
INTO unique_titles_by_dept
FROM unique_titles_edited as u
LEFT JOIN dept_info as i
ON (u.emp_no = di.emp_no)
ORDER BY emp_no ASC;

SELECT COUNT(title), title
INTO retiring_titles_edited
FROM unique_titles_edited
GROUP BY title
ORDER BY count DESC;

SELECT DISTINCT ON (emp_no) emp_no, dept_no, from_date, to_date
INTO dept_info_unique
FROM dept_emp
WHERE to_date = '9999-01-01'
ORDER BY emp_no DESC;

SELECT u.emp_no, u.first_name, u.last_name, u.title, d.dept_no
INTO unique_titles_by_dept
FROM unique_titles_edited as u
LEFT JOIN dept_info_unique as d
ON (u.emp_no = d.emp_no)
ORDER BY emp_no ASC

SELECT u.emp_no, u.first_name, u.last_name, u.title, d.dept_no, d.dept_name
INTO unique_titles_by_dept_name
FROM unique_titles_by_dept as u
LEFT JOIN departments as d
ON (u.dept_no = d.dept_no)
ORDER BY emp_no ASC;

SELECT COUNT(dept_name), dept_name, title
INTO unique_titles_by_dept_name_totals
FROM unique_titles_by_dept_name
GROUP BY dept_name, title
ORDER BY dept_name

SELECT u.emp_no, u.first_name, u.last_name, u.title, di.dept_name
INTO unique_titles_by_dept
FROM unique_titles_edited as u
RIGHT JOIN dept_info as di
ON (u.emp_no = di.emp_no)
ORDER BY emp_no ASC

SELECT * FROM unique_titles_by_dept

SELECT COUNT(emp_no)FROM dept_info

SELECT DISTINCT ON (emp_no) emp_no, dept_no, from_date, to_date
INTO dept_info_unique
FROM dept_emp
WHERE to_date = '9999-01-01'
ORDER BY emp_no DESC;


SELECT u.emp_no, u.first_name, u.last_name, u.title, d.dept_no
INTO unique_titles_by_dept
FROM unique_titles_edited as u
LEFT JOIN dept_info_unique as d
ON (u.emp_no = d.emp_no)
ORDER BY emp_no ASC


SELECT u.emp_no, u.first_name, u.last_name, u.title, d.dept_no, d.dept_name
INTO unique_titles_by_dept_name
FROM unique_titles_by_dept as u
LEFT JOIN departments as d
ON (u.dept_no = d.dept_no)
ORDER BY emp_no ASC;

SELECT COUNT(dept_name), dept_name, title
INTO unique_titles_by_dept_name_totals
FROM unique_titles_by_dept_name
GROUP BY dept_name, title
ORDER BY dept_name


SELECT COUNT(title), title
INTO mentorship_titles
FROM mentorship_eligibility
GROUP BY title


--Determining mentorship availability by dept.

SELECT m.emp_no, m.first_name, m.last_name, m.birth_date, m.from_date, m. to_date, m.title, d.dept_no
INTO mentorship_dept
FROM mentorship_eligibility as m
LEFT JOIN dept_info_unique as d
ON m.emp_no = d.emp_no
;

SELECT m.emp_no, m.first_name, m.last_name, m.birth_date, m.from_date, m. to_date, m.title, d.dept_name
INTO mentorship_dept_name
FROM mentorship_dept as m
LEFT JOIN departments as d
ON m.dept_no = d.dept_no
;

SELECT m.emp_no, m.first_name, m.last_name, m.birth_date, m.from_date, m. to_date, m.title, d.dept_name
INTO mentorship_dept_name
FROM mentorship_dept as m
LEFT JOIN departments as d
ON m.dept_no = d.dept_no
;

SELECT COUNT(dept_name), dept_name, title
INTO mentorship_dept_totals
FROM mentorship_dept_name
GROUP BY dept_name, title
ORDER BY dept_name DESC;
