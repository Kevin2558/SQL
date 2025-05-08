-- Active: 1746740885902@@localhost@3306@rawr
CREATE DATABASE rawr;

# CRETE TABLES

# Al crear tablas la columna primaria (identificador unico para cada fila) se puede
# poner al final como PRIMARY KEY()

CREATE TABLE student (
	student_id INT PRIMARY KEY,
    student_name VARCHAR(20),
    major VARCHAR(20)
);

# DESCRIBE nos sirve para mostrar las caracteristicas de nuestra tabla, como
# ver el tipo de dato por columna

DESCRIBE student;

# DROP TABLE podemos eliminar la tabla

DROP TABLE student;

# Ahora, agregaremos/eliminaremos una nueva columna con el comando ALTER TABLE

ALTER TABLE student ADD gpa DECIMAL(3,2);
ALTER TABLE student DROP gpa;

# INSERTING DATA

# Usaremos el comando INSERT para añadir filas con informacion al dataset. La informacion
# se agrega en el orden en que ingresamos las columnas de la tabla.

INSERT INTO student VALUES(1,'Jack','Biology');
INSERT INTO student VALUES(2,'Kate','Sociology');

# En el caso de que no poseamos la informacion de una de las columnas se hace lo siguiente.
# Agregará automaticamente el valor NULL en las columnas donde no entreguemos datos.

INSERT INTO student(student_id, student_name) VALUES(3,'Claire');

# Notar que no se pueden ingresar filas con un valor ya agregado en el primmary. Luego
# veremos las formas de modificar una fila, pero cambiarla por una nueva no se puede.

# Con el siguiente comando podremos observar la tabla de datos

SELECT * FROM student;

# Ahora crearemos la tabla con ciertos ajustes para que el insertar y modificar filas ser
# mas facil

DROP TABLE student;

# El agregar NOT NULL provocará que sea obligatorio agregar un valor en esa columna
# El agregar UNIQUE provocará que al agregar valores estos deben ser unicos, es decir,
# una vez agregado un valor no se puede repetir

CREATE TABLE student (
	student_id INT PRIMARY KEY,
    student_name VARCHAR(20) NOT NULL,
    major VARCHAR(20) UNIQUE
);




