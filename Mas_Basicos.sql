##### FUNCTIONS #####

# Visualicemos el número de filas de una columna en específico. Si existe un valor
# NULL en esta columna no se considerará en el conteo

SELECT COUNT(emp_id)
FROM employee; 

# Visualicemos el número de empleadas mujeres nacidas despues del 1970

SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND birth_day > '1970-01-01';
               
# Visualicemos la media de los salarios de los empleados hombres

SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

# Visualicemos la suma de los salarios de todos los empleados

SELECT SUM(salary)
FROM employee;

# Visualicemos cuantos hombres y cuantas mujeres existen en la empresa

SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

# Visualicemos las ventas totales de cada vendedor

SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

##### WILDCARDS #####

# Visualizar cualquier cliente que sea un LLC

SELECT *
FROM client
WHERE client_name LIKE '%LLC'; # El % significa que antes de LLC puede ir cualquier
							   # numero de caracteres, pero debe terminar en LLC

# Visualizar todos los empleado nacido en febrero

SELECT *
FROM employee
WHERE birth_day LIKE '____-02%'; # El _ significa que habrá un carácter antes,
								  # en este caso como el año tienen cuatro carácteres
								  # podemos cuatro _

# Visualizar todos los clientes que sean escuelas

SELECT *
FROM client
WHERE client_name LIKE '%school%';

##### UNION #####

# Visualizar un alista de los nombres de empleados, sucursales y clientes

SELECT first_name AS Company_Names
FROM employee
UNION
SELECT branch_name
FROM branch
UNION
SELECT client_name
FROM client;

# Visualizar todos los nombres y branch id de los clientes y sucursales 

SELECT client_name, client.branch_id
FROM client
UNION
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier;

# Notemos que lo anterior lo podemos hacer ya que ambas tablas poseen una
# columna para branch id. Aqui usamos lo de anteponer el nombre de la tabla
# ya que ambos se llaman branch_id

# Visualizar todo el dinero gastado o ganado por la empresa

SELECT salary
FROM employee
UNION
SELECT total_sales
FROM works_with;

##### JOINS #####

INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);

# Visualizar todas las sucursales y los nombres de sus gerentes

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch # JOIN hace que las dos tablas se unan para así buscar el nombre del gerente
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
LEFT JOIN branch # LEFT JOIN incluye a todos dentro de la variables de la izquierda (employee)
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
RIGHT JOIN branch # RIGHT JOIN incluye a todos dentro de la variables de la derecha (branch)
ON employee.emp_id = branch.mgr_id;

























