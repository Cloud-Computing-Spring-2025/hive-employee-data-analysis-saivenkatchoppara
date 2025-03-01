INSERT OVERWRITE DIRECTORY '/user/hive/output/Query1'
SELECT * FROM temp_employees WHERE year(join_date) > 2015

INSERT OVERWRITE DIRECTORY '/user/hive/output/Query2'
SELECT department, AVG(salary) AS avg_salary 
FROM temp_employees 
GROUP BY department;

INSERT OVERWRITE DIRECTORY '/user/hive/output/Query3' SELECT * FROM temp_employees WHERE project = 'Alpha'; 

INSERT OVERWRITE DIRECTORY '/user/hive/output/Query4' SELECT job_role, COUNT(*) AS count  FROM temp_employees  GROUP BY job_role;

INSERT OVERWRITE DIRECTORY '/user/hive/output/Query5' ROW FORMAT DELIMITED  FIELDS TERMINATED BY ','  SELECT e.*  FROM temp_employees e  JOIN (SELECT department, AVG(salary) AS avg_salary  FROM temp_employees  GROUP BY department) d  ON e.department = d.department  WHERE e.salary > d.avg_salary; 

INSERT OVERWRITE DIRECTORY '/user/hive/output/Query6' SELECT department, COUNT(*) AS num_employees  FROM temp_employees  GROUP BY department  ORDER BY num_employees DESC  LIMIT 1;

INSERT OVERWRITE DIRECTORY '/user/hive/output/Query7' SELECT * FROM temp_employees  WHERE emp_id IS NOT NULL  AND name IS NOT NULL  AND age IS NOT NULL  AND job_role IS NOT NULL  AND salary IS NOT NULL  AND project IS NOT NULL  AND join_date IS NOT NULL  AND department IS NOT NULL;

INSERT OVERWRITE DIRECTORY '/user/hive/output/Query8' SELECT e.*, d.location  FROM temp_employees e  JOIN departments d  ON e.department = d.department_name; 

INSERT OVERWRITE DIRECTORY '/user/hive/output/Query9' SELECT emp_id, name, department, salary,  RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank FROM temp_employees; 

INSERT OVERWRITE DIRECTORY '/user/hive/output/Query10' SELECT * FROM ( SELECT emp_id, name, department, salary,  RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank FROM temp_employees ) ranked_employees WHERE salary_rank <= 3;
