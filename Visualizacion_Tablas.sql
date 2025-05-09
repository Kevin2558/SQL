##### MORE BASIC QUERIES #####

# Lo primero que ahremos es visualizar todos los empleados

SELECT * 
FROM employee;

# Visualicemos todos los clientes

SELECT *
FROM client;

# Visualicemos todo los empleados ordenados por el salario

SELECT *
FROM employee
ORDER BY salary; # Recordar que podemos usar DESC

# Visualicemos todos los empleados ordenados por sexo y luego por nombre

SELECT *
FROM employee
ORDER BY sex, first_name, last_name;

# Visualicemos los primeros 5 empleados en la tabla

SELECT *
FROM employee
LIMIT 5;

# Visualicemos nombre y apellido de todos los empleados

SELECT first_name AS Nombre, last_name AS Apellido # Con AS le asignamos un nombre a la columna
FROM employee;

# Visualicemos los diferentes generos que posee la base de datos

SELECT DISTINCT sex
FROM employee;


















