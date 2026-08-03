# 1. Nos en conectamos a la base que vamos a utlizar con el comando USE.
USE sakila;

# 2. Con el comando SELECT llamamos la tabla que queremos consultar y las columnas que queremos visualizar como nombre y apellido.
# En la primera linea nos muestra toda la tabla y en la segunda ya nos muestra los campos especificos.

SELECT * FROM customer;
SELECT customer_id,first_name, last_name FROM customer;

# 2. Consultamos como SELECT una segunda tabla de film para que con el comando WHERE nos muestre todas las peliculas con una duración mayor a 120 minutos.

SELECT * FROM film
WHERE length > 120;

# 3. Realizaremos la consulta en la tabla de customer y la orderamos por apellido de forma ascendente.

SELECT * FROM customer
ORDER BY  last_name ASC;

# 4. Realizaremos la consulta en la tabla de film para conocer las 5 peliculas mas largas, para ello consultamos la tabla film.
# organizamos con order by la columna de length de forma descendente y limitamos la consulta para que nos muestre los 5 peliculas que mas duran.	

SELECT * FROM film
ORDER BY  length DESC
LIMIT 5;

# 5. Utilizamos JOin para conectar dos tablas y con select indicamos que columnas queremos de cada tabla, de la tabla customer tomamos dos columans del nombre y apellido del cliente.
# de Payment tomamos la cantidad y la fecha del pago.

SELECT payment.amount, payment.payment_date, customer.first_name,customer.last_name FROM payment
JOIN customer ON customer.customer_id = payment.customer_id;

# 6. Peliculas alquiladas, para ello tomamos como tabla principal la de rental y con select traemos el nombre de la pelicula, la fecha en la que fue rentada y el inventario.
# utilizamos dos join para cruzar las tablas de acuerdo a las llaves de cada tabla.

SELECT * FROM rental
SELECT * FROM inventory
SELECT * FROM film

SELECT film.title, rental.rental_date, inventory.inventory_id FROM rental
JOIN inventory on rental.inventory_id = inventory.inventory_id
JOIN film on film.film_id = inventory.film_id

# solo se muestra las peliculas que han sido rentadas.

SELECT film.title FROM rental
JOIN inventory on rental.inventory_id = inventory.inventory_id
JOIN film on film.film_id = inventory.film_id
GROUP BY film.title

# 7. LEFT JOIN, realizaremos la consulta para que me muestre nombre y apellido de los clientes sin pago, primero utilizamos un select con las columnas que de nombre y apellido 
# de la tabla de customer y luego la relacionamos con la tabla de payment, filtramos en la tabla where en la columna de payment los valores que son nulos.

SELECT * FROM payment

SELECT customer.first_name, customer.last_name FROM customer
LEFT JOIN payment on customer.customer_id = payment.customer_id
WHERE payment.payment_id  IS NULL;

# 8 Listar los nombres de las peliculas y su duracion de aquellos titulos que no tienen actores, utilizamos un left join y traemos las columnas de titulo y duraciòn, hacemos un filtro 
# buscando los valores nulos.

SELECT * FROM film_actor
SELECT * FROM film

SELECT film.title, film.length FROM film
LEFT JOIN film_actor ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id  IS NULL;

# Parte 5 – INSERT, UPDATE, DELETE (Data Definition Language.
# primero consultamos la tabla de actor, donde evidenciamos 200 registros, despues le damos el comando INSERT INTO y llamamos la tabla, ponemos entre parentesis el nombre de las columnas.
# ponemos el comando VALUES y ponemos los datos entre comillas y parentesis.

SELECT * FROM actor
INSERT INTO actor (first_name, last_name)
VALUES ('ALEXANDRA','JIMENEZ')

# para actualizar el registro que acabamos de introduccir utilizamos UPDATE de la tabla actor, con SET asignamos los nuevos registros que queremos actualizar y con where especificamos el 
# campo que exactamente cumpla con el registro 201.

UPDATE actor
SET 
first_name = 'CAMILA',
last_name = 'LOPEZ'
WHERE actor_id = '201';

# con el comando DELETE borramos el registro que acabamos de actualizar, estableciendo con WHERE como el unico que cumpla la condición de ser el numero 201.

DELETE FROM actor
WHERE actor_id = 201;

# Parte 6 - Consultas Avanzadas
# Top 5 clientes con mayor cantidad de dinero pagado al servicio de rentas.

SELECT customer.customer_id,customer.first_name,customer.last_name, SUM(payment.amount) AS pagado  FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id,customer.first_name,customer.last_name
ORDER BY  pagado DESC
LIMIT 5;

# Top 5 Películas más alquiladas (JOIN entre Rental - Inventory - Film) --> Agrupar los datos con conteo y tomar las mejores 5

SELECT film.title,count( rental.rental_id) AS alquiler FROM rental
JOIN inventory on rental.inventory_id = inventory.inventory_id
JOIN film on film.film_id = inventory.film_id
GROUP BY film.title
ORDER BY alquiler DESC
LIMIT 5;
