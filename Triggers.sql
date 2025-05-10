##### TRIGGERS #####

# Veremos una especie de activadores los cuales al asignarle cierta tarea
# responderán agregando un valor dentro de una tabla ya creada. Viendo el ejemplo
# es más ilustrativo que es lo que ocurre

CREATE TABLE trigger_test(
	message VARCHAR(100)
);

# Lo siguiente se tiene que agregar linea por linea en la consola. Primero se le dice
# cual es la database que vamos a utilizar (en esta caso rawr) y luego escribimos el condigo

DELIMITER $$
CREATE
	TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
		INSERT INTO trigger_test VALUES('Se agregó un nuevo empleado');
	END$$
DELIMITER ;

# Una vez creado, ahora cada vez que ingresamos un empleado a la tabla employee
# en la tabla trigger_test se agregará un mensaje avisando que se agregó un nuevo
# empleado

# Veamos como funcionaría

INSERT INTO employee
VALUES(109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);

SELECT * FROM trigger_test;

# Si queremos eliminar el trigger anterior (en el caso de querer que se agregue
# otra frase al añadir un empleado) haremos lo siguiente

# Primero miraremos los triggers para cerciorarse de que el trigger existe

SHOW TRIGGERS;

# Luego, procederemos a eliminarlo con el comando

DROP TRIGGER IF EXISTS my_trigger; # Con el if nos aseguramos de que no haya un error

# Veamos otro ejemplo. Recordar que el siguiente bloque de codigo se hace en la consola

DELIMITER $$
CREATE
	TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
		INSERT INTO trigger_test VALUES(CONCAT('Se agregó el nuevo empleado ', NEW.first_name));
	END$$
DELIMITER ;

# NEW se refiere a la nueva fila que se está agregando, asi nos entregará el nombre de esta fila.
# Podemos agregar al CONCAT ' ', NEW.last_name así tambien veremos el apellido del empleado

INSERT INTO employee
VALUES(110, 'Ignacio', 'Alvarez', '1997-05-17', 'M', 73000, 106, 3);

SELECT * FROM trigger_test;

# Veamos otro ejemplo.

DELIMITER $$
CREATE
	TRIGGER my_trigger2 BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
		IF NEW.sex = 'M' THEN
			INSERT INTO trigger_test VALUES('Se añadió un empleado hombre');
		ELSEIF NEW.sex = 'F' THEN
			INSERT INTO trigger_test VALUES('Se añadió una empleada mujer');
		ELSE
			INSERT INTO trigger_test VALUES('Se añadió otro empleado');
		END IF;
	END$$
DELIMITER ;

INSERT INTO employee
VALUES(111, 'Pam', 'Beesly', '1988-02-19', 'F', 69000, 106, 3);

SELECT * FROM trigger_test;

# Notemos que como este ultimo trigger se efectúa cuando agregamos un empleado
# tambien se activa el trigger que definimos anteriormente

# Podemos utilizar AFETER/BEFORE y tambien INSERT/UPDATE/DELETE asi le decimos
# al trigger despues o antes de que accion queremos que se efectue


















