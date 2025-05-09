##### NESTED QUERIES #####

# Visualizar los nombres de todos los empleados que hayan vendido
# más de 30.000 a un solo cliente

SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
	SELECT works_with.emp_id
	FROM works_with
	WHERE works_with.total_sales > 30000
);

# La interpretacion de lo anterior es que: entregará nombre y apellidos extraidos de
# la tabla de empleados y la condición en el WHERE es que el empleado cumpla con
# haber vendido mas de 30000 a un cliente

# Lo anterior es lo que llamamos consulta anidada, para terminar la primera consulta
# necesita ejecutar la segunda consulta

# Visualizar todos los clientes que son atendidos por la sucursal que administra 
# Michael Scott

SELECT client.client_name
FROM client
WHERE client.branch_id = (
	SELECT branch.branch_id
	FROM branch
	WHERE branch.mgr_id = 102 # Aqui asumimos conocer el id de Michael Scott
    LIMIT 1 # Le agregamos esto ya que Michael podria administrar mas sucursales
);

# La interpretacion de lo anterior es: Buscar primero el id de la sucursal
# donde administra Michael Scott y luego buscar el nombre de los clientes
# a los que le ha vendido esa sucursal
























