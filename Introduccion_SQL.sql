##### CREATE DATABASE #####

-- Active: 1746740885902@@localhost@3306@rawr
CREATE DATABASE rawr;

##### CREATE TABLES #####

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

##### INSERTING DATA #####

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
# El agregar DEFAULT provocará que al no agregar un valor en esa columna se agregue
# un valor predeterminado
# La columna que le asignemos PRIMMARY será tanto NOT NULL como UNIQUE

CREATE TABLE student (
	student_id INT PRIMARY KEY,
    student_name VARCHAR(20),
    major VARCHAR(20) DEFAULT 'Undecided'
);

INSERT INTO student VALUES(1,'Jack','Biology');
INSERT INTO student(student_id,student_name) VALUES(2,'Kate');

SELECT * FROM student;

# Ahora, haremos que los valores para student_id se vayan agregando automaticamente
# cada vez que vayamos agregando una fila

DROP TABLE student;

CREATE TABLE student (
	student_id INT AUTO_INCREMENT,
    student_name VARCHAR(20),
    major VARCHAR(20) DEFAULT 'Undecided',
    PRIMARY KEY(student_id)
);

INSERT INTO student (student_name,major) VALUES('Jack','Biology');
INSERT INTO student(student_name) VALUES('Kate');

SELECT * FROM student;

##### UPDATE AND DELETE #####

# Vamos a ver como modificar/eliminar filas de la tabla de datos

CREATE TABLE student (
	student_id INT AUTO_INCREMENT,
    student_name VARCHAR(20),
    major VARCHAR(20) DEFAULT 'Undecided',
    PRIMARY KEY(student_id)
);

INSERT INTO student (student_name,major) VALUES('Jack','Biology');
INSERT INTO student (student_name,major) VALUES('Kate','Sociology');
INSERT INTO student (student_name,major) VALUES('Claire','Chemistry');
INSERT INTO student (student_name,major) VALUES('Jack','Biology');
INSERT INTO student (student_name,major) VALUES('Mike','Computer Science');

SELECT * FROM student;

# El siguiente fragmento de codigo lo que hace es buscar las filas donde se encuentre el valor que le
# asignamos en WHERE y cambiara su valor por el que le asignamos en SET. Con este comando tambien podemos ocupar <> (desigual),
# < , > , <= , >= (estas nos ayudarán cuando trabajemos con variables numericas por si el cambio
# va a ser en un rango en especifico, por ejemplo si queremos dar categorias)

UPDATE student
SET major = 'Bio'
WHERE major = 'Biology'; 

UPDATE student
SET major = 'Comp Sci'
WHERE major = 'Computer Science';

UPDATE student
SET major = 'Comp Sci'
WHERE student_id =4;

# Tambien podemos utilizar identificadores lógicos para actualizar

UPDATE student
SET major = 'Biochemistry'
WHERE major = 'Bio' OR major = 'Chemistry';

# Ahora, veamos como actualizar una fila con nueva información

UPDATE student
SET student_name = 'Tom', major = 'Undecided'
WHERE student_id = 1;

# Si no ocupamos WHERE, entonces la instuccion que le demos la efectuará en todas las filas

UPDATE student
SET major = 'Undecided';

SELECT * FROM student;

# Observacion: Aqui salia un error ya que el programa en Edit/Preferences/SQL Editor tenia activada
# el ticket de safe updates, una vez desactivado y reiniciado el programa se soluciona

# Ahora pasemos a ver como se eliminan las filas a través del comando DELETE

DELETE FROM student; # Esto eliminará todas las filas

DELETE FROM student
WHERE student_id = 5; # Nuevamente con WHERE le entregamos donde queremos que haga la instrucción.

DELETE FROM student
WHERE student_name = 'Name' AND major = 'Undecided';

##### BASIC QUERIES #####

# Ahora veremos los comandos para obtener información de la base de datos

# SELECT nos sirve para decirle al sistema que queremos obtener información. El asterisco
# significa que queremos obtener toda la información. FROM nos señala de donde queremos
# obtener la informacion.

# En vez de asterisco, podemos especificar cual es la informacion que queremos obtener

SELECT * FROM student; 
SELECT student_name FROM student;
SELECT student_name, major FROM student;

# Tambien podemos especificar de donde queremos obtener major agregando student. antes.
# Esto será útil una vez el código sea más complejo.

SELECT student.major FROM student;

# Tambien podemos ordenar la informacion que nos entrega a través de ORDER BY

SELECT student.student_name, student.major 
FROM student
ORDER BY student_name; # Ordena los nombres en orden alfabético

SELECT student.student_name, student.major
FROM student
ORDER BY student_name DESC; # Ahora los ordena descendentemente

SELECT * 
FROM student
ORDER BY student_id DESC; # Aqui no aparece la columna de los id pero si la usamos para ordenar

SELECT * 
FROM student
ORDER BY major, student_id; # Esto lo que hará es ordenarlos primero segun major (alfabeto)
							# y luego si hay algunos que tengan el mismo major ordenará
							# según su id

# Observacion: Podemos poner por separado si alguna variable queremos que la use para ordenar
# pero de manera descendente, poniendo DESC luego de la variable especifica

SELECT *
FROM student
ORDER BY student_id DESC
LIMIT 2; # Solo nos entregará las primeras dos filas

# Ahora veremos como filtrar información de las bases de datos a través de WHERE

SELECT student_name, major
FROM student
WHERE major = 'Chemistry' OR student_name='Kate';

SELECT student_name, major
FROM student
WHERE major <> 'Chemistry'; # Esto nos daria las filas que en major no sean Chemistry

SELECT *
FROM student
WHERE student_id <3;

SELECT *
FROM student
WHERE student_name IN ('Claire','Kate','Mike') AND student_id > 2; 












