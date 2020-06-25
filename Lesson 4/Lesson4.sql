/* 1. Создать VIEW на основе запросов, которые вы сделали в ДЗ к уроку 3.*/
USE geodata;

-- все данные о городе – регион, страна.
CREATE VIEW view_about_cities
AS SELECT
  c.title as city_name,
  r.title as region_name,
  co.title as country_name
FROM _cities c
  JOIN _regions r ON c.region_id = r.id
JOIN _countries co ON c.country_id = co.id
LIMIT 10;
SELECT * FROM view_about_cities;

SHOW COLUMNS FROM `_regions`;
-- все города из Московской области.
CREATE VIEW view_region_moscow
AS SELECT r.title as region_name, c.title as city_name
FROM _regions r
JOIN _cities c ON r.id = c.region_id
WHERE r.title = 'Московская область'
LIMIT 5;
SELECT * FROM view_region_moscow;

SHOW COLUMNS FROM `_countries`;



USE employees;
-- средняя зарплату по отделам.
CREATE VIEW view_avg_salary_dept
AS SELECT
  dp.dept_name as dept_name,
  AVG(s.salary) as avg_salary
FROM departments dp
  JOIN dept_emp de ON dp.dept_no = de.dept_no
  JOIN salaries s ON de.emp_no = s.emp_no
GROUP BY dp.dept_name;
SELECT * FROM view_avg_salary_dept;

-- Максимальная зарплата у одного сотрудника
CREATE VIEW view_max_salary_emp
AS SELECT
  e.emp_no,
  CONCAT(e.first_name, ' ', e.last_name) as name,
  MAX(s.salary) as max_salary
FROM employees e
  JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no
ORDER BY max_salary DESC
LIMIT 1;
SELECT * FROM view_max_salary_emp;

-- количество сотрудников во всех отделах.
CREATE VIEW view_count_emp_dept
AS SELECT
  dp.dept_name,
  COUNT(de.emp_no) as count
FROM departments dp
  JOIN dept_emp de
    ON de.dept_no = dp.dept_no
    AND de.to_date > NOW()
GROUP BY dp.dept_name;
SELECT * FROM view_count_emp_dept;

-- количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.
CREATE VIEW view_count_emp_salary_dept
AS SELECT
  dp.dept_name,
  COUNT(de.emp_no) as count,
  SUM(s.salary) as sum_salary
FROM departments dp
  JOIN dept_emp de
    ON de.dept_no = dp.dept_no
    AND de.to_date > NOW()
  JOIN salaries s
    ON de.emp_no = s.emp_no
    AND s.to_date > NOW()
GROUP BY dp.dept_name;
SELECT * FROM view_count_emp_salary_dept;
/* 2. Создать функцию, которая найдет менеджера по имени и фамилии.*/
-- Найдем менеджера работающего по настоящее время (таблица dept_manager)

DELIMITER //
CREATE FUNCTION func_find_manager (first_name VARCHAR(60), last_name VARCHAR(60))
  RETURNS INT DETERMINISTIC
  BEGIN
    DECLARE emp_no INT;
    SELECT e.emp_no INTO emp_no
    FROM employees e
      JOIN dept_manager dm ON e.emp_no = dm.emp_no AND dm.to_date >= NOW()
    WHERE e.first_name = first_name AND e.last_name = last_name
    LIMIT 1;
    RETURN emp_no;
  END //
DELIMITER ;
SELECT func_find_manager('Vishwani', 'Minakawa') as emp_no_manager;

-- 3. Создать триггер, который при добавлении нового сотрудника будет выплачивать ему вступительный бонус в таблицу salary.
DELIMITER //
CREATE TRIGGER `insert_employees`
  AFTER INSERT
  ON employees
  FOR EACH ROW
  BEGIN
    INSERT INTO salaries
    SET emp_no = NEW.emp_no, salary = 10000, from_date = NOW(), to_date = '9999-01-01';
  END //
DELIMITER ;
INSERT INTO employees (emp_no, first_name, last_name, gender, birth_date, hire_date) VALUES ('80000','Diana', 'Zueva', 'F', '1990-02-10', '2019-02-22');