##### ON DELETE #####

# Lo que veremos aqui es ver la manera de eliminar una final de una tabla de
# datos sin que sus variables externas afecten a otras tablas

# Al fin veremos que es lo que significa colocar ON DELETE SET NULL y ON DELETE
# CASCADE. ON DELETE SET NULL lo que hará es que le dará valor NULL a las variables
# externas (presentes en la fila que queremos eliminar) en las tablas que esten.
# ON DELETE CASCADE lo que hará es eliminar la fila entera donde en las tablas donde
# esten presentes las variables externas de la fila que eliminamos

CREATE TABLE branch(
	branch_id INT PRIMARY KEY,
	branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

# Aqui, por ejemplo, le estamos diciendo que si emp_id en employee es eliminada entonces
# le de valor NULL al mgr_id en branch

# Veamos que ocurre si eliminamos a Michael Scott

DELETE FROM employee
WHERE emp_id = 102;

# Veamos si en branch se estableció el valor NULL para el mgr_id

SELECT * FROM employee; # Notemos que cuando creamos employee tambien le dimos una variable
						# externa asociada a emp_id que sería super_id
SELECT * FROM branch;

CREATE TABLE branch_supplier(
	branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY(branch_id, supplier_name),
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

# En este caso, le estamos diciendo que si branch_id es elimnada de branch
# entonces eliminaremos toda su fila en branch_supplier

# Veamos que ocurre si eliminamos la sucursal con branch_id 2

DELETE FROM branch
WHERE branch_id = 2;

SELECT * FROM branch_supplier;

# Como podemos notar, todas las filas que tenian asignadas la sucursal 2 
# fueron eliminadas completas

# En este caso, la utilizacion de SET NULL o de CASCADE depende del tipo de 
# variable externa que estamos eliminando. En el primero lo seteamos como NULL
# ya que esta variable solamente forma parte de la fila y no afecta a las demas
# columnas. Pero en el otro caso, la variable que eliminamos forma parte de las
# variables primarias de branch_supplier, por lo que es conveniente eliminar la fila







