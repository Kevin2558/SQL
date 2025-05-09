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

# Ahora procederemos a agregar la información a todas las tablas. Como las tablas
# las creamos de una manera especifica, al momento de agregar información hay que
# tenerlo en cuenta.

## Corporate

# En el ejemplo la ultima variable para David deberia ser 1, pero como esta está
# anidada a branch, tenemos que setearla como NULL y una vez se entregue el valor
# en branch se deberá modificar

INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

## Scranton

INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

## Stamford

INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

# Cargamos la tabla de esta forma debido al ciclo de informacion que hay entre la tabla
# employee y la tabla branch. En branch tenemos la variable mgr_id pero para agregarla
# primero tenemos que agregar a los managers en employee, una vez agregado creamos el
# branch y modificamos el apartado branch del manager ya que como no estaba creado tuvimos
# que asignarle null. Una vez realizado lo anterior podemos agregar a todos los demas
# empleados.

# Ahora continuamos agregando la información de las demás tablas.

# Como ya rellenamos toda la tabla branch, podemos crear branch supplier y client
# las cuales solo dependen de branch

-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

# Una vez creada la tabla client, podemos rellenar work with ya que esta depende
# de employee y de client

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

# Por último visualizamos las tablas para ver si se ejecutó bien

SELECT * FROM employee;
SELECT * FROM works_with;