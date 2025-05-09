##### CREATING COMPANY DATABASE #####

# Crearemos una base de datos mas compleja, que se asemeja a una obtenida por
# una empresa, para a su vez realizar actividades mas complejas

CREATE TABLE employee(
	emp_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_day DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);

# Para crear las variables externas tenemos que crear primero las tablas de
# donde vienen estas. Esto lo haremos con FOREIGN KEY le asignamos la variable
# que será externa, con REFERENCES le decimos de donde se obtiene. 

CREATE TABLE branch(
	branch_id INT PRIMARY KEY,
	branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

# Ahora como ya tenemos creada la tabla branch, vamos a modificar la tabla
# employee para agregar las variables externas. Usamos ALTER TABLE para modificarla,
# ADD FOREIGN KEY para asignar la variables que será externa, REFERENCES para decirle
# de donde sacar la información y ON DELETE SET NULL para al eliminar asignar a todo
# NULL

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client(
	client_id INT PRIMARY KEY,
    client_name VARCHAR(40),
    branch_id INT,
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

# En la siguiente tabla veremos como hacer que dos variables sean primary. Esto lo
# hacemos debido a que puede ocurrir que una columna no tenga valores unicos, por
# lo que usamos dos para solucionarlo

CREATE TABLE works_with(
	emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id, client_id),
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier(
	branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY(branch_id, supplier_name),
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

# Ahora procederemos a agregar la información a todas las tablas