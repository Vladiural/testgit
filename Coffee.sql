--CREATE DATABASE coffee;

CREATE TABLE IF NOT EXISTS post
(
	id serial NOT NULL PRIMARY KEY,
	title varchar(50) NOT NULL,
	salary numeric(10,2) NOT NULL,
	description varchar(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS employee
(
	id serial NOT NULL PRIMARY KEY,
	firstname varchar(20) NOT NULL,
	name varchar(20) NOT NULL,
	patronymic varchar(20) NOT NULL,
	date_birth date NOT NULL,
	telephone varchar(18) NOT NULL,
	post_id integer NOT NULL REFERENCES post(id)
);
	


CREATE TABLE IF NOT EXISTS client
(
	id serial NOT NULL PRIMARY KEY,
	firstname varchar(20) NOT NULL,
	name varchar(20) NOT NULL,
	patronymic varchar(20) NULL,
	date_birth date NOT NULL,
	telephone varchar(18) NOT NULL,
	adress varchar(150) NULL
);


CREATE TABLE IF NOT EXISTS coffee
(
	id serial NOT NULL PRIMARY KEY,
	name varchar(50) NOT NULL,
	price numeric NOT NULL,
	volume integer NOT NULL,
	description varchar(150) NOT NULL
);

CREATE TABLE IF NOT EXISTS topping
(
	id serial NOT NULL PRIMARY KEY,
	name varchar(50) NOT NULL,
	price numeric NOT NULL,
	volume integer NOT NULL,
	description text NOT NULL
);

CREATE TABLE IF NOT EXISTS ingredient
(
	id serial NOT NULL PRIMARY KEY,
	name varchar(50) NOT NULL,
	price numeric NOT NULL,
	volume integer NOT NULL,
	description text NOT NULL
);


CREATE TABLE IF NOT EXISTS orders
(
	id serial NOT NULL PRIMARY KEY,
	registration timestamp NOT NULL,
	numer integer NOT NULL,
	price numeric NOT NULL,
	end_ord timestamp NOT NULL,
	adress varchar(200) NULL,
	delivery Boolean NOT NULL,
	payment varchar(50) NOT NULL,
	fk_employee integer NOT NULL REFERENCES employee(id)
	
);

ALTER TABLE orders
ADD fk_client integer NOT NULL REFERENCES client(id);

CREATE TABLE IF NOT EXISTS position_order
(
	id serial NOT NULL PRIMARY KEY, 
	fk_cof_id integer NOT NULL REFERENCES coffee(id),
	fk_order_id integer NOT NULL REFERENCES orders(id),
	count_cof integer NOT NULL,
	
	UNIQUE(fk_cof_id,fk_order_id)
);

CREATE TABLE IF NOT EXISTS topping_pos_order
(
	id serial NOT NULL PRIMARY KEY, 
	fk_topping_id integer NOT NULL REFERENCES topping(id),
	fk_pos_order_id integer NOT NULL REFERENCES position_order(id),
	
	UNIQUE(fk_topping_id,fk_pos_order_id)
);

CREATE TABLE IF NOT EXISTS ingredient_coffee
(
	id serial NOT NULL PRIMARY KEY,
	fk_ingredient_id integer NOT NULL REFERENCES ingredient(id),
	fk_coffee_id integer NOT NULL REFERENCES coffee(id),
	
	UNIQUE(fk_ingredient_id, fk_coffee_id)
);

INSERT INTO post (id, title, salary, description)
VALUES
(1, 'Директор', 150000.00, 'Руководит всем процессом'),
(2, 'Бариста', 35000.00, 'Варит прекрасный кофе'),
(3, 'Официант', 31000.00, 'Приниамет заказ от клиента'),
(4, 'Курьер', 29000.00, 'Доставляет заказ клиенту');

INSERT INTO employee (id, firstname, name, patronymic, date_birth, telephone, post_id)
VALUES
(1, 'Макаров', 'Владимир', 'Александрович', '01-01-2001', '+7(999)999-99-99',1),
(2, 'Колыванов', 'Колыван', 'Петрович', '11-11-1991', '+7(111)111-12-12',2),
(3, 'Захаров', 'Захар', 'Егорович', '11-11-2011', '+7(999)999-19-19',3),
(4, 'Петров', 'Петр', 'Евстфьевич', '03-03-1993', '+7(333)939-39-93',4);

INSERT INTO client (id, firstname, name,patronymic, date_birth, telephone, adress)
VALUES
(1, 'Иванов', 'Глеб', 'Павлович', '05-11-1921', '+7(343)255-11-20', 'Нью-Йорк'),
(2, 'Глебов', 'Федор', 'Петрович', '15-10-1901', '+7(313)155-01-21', 'Хитроу'),
(3, 'Йовович', 'Мила', 'Ивановна', '25-01-1901', '+7(303)205-00-00', 'Токио');


INSERT INTO ingredient (id, name, price, volume, description) VALUES
(1, 'Арабика', 100, 200.00, 'В арабике много липидов и сахаров, которые делают вкус интенсивным и кислотным. В конкретном сорте арабики из конкретного региона можно почувствовать сладость ягод, кислотность цитрусовых, аромат цветов и орехов.'),
(2, 'Робусто', 120, 200.00, 'В робусте больше кофеина и хлорогеновой кислоты и мало липидов и сахаров. Это делает робусту хорошим энергетиком, но кофеин также придаёт кофе горечь и тяжёлый аромат. Вкус робусты — терпкий и плоский.'),
(3, 'Цикорий', 85, 180.00, 'это корень растения цикория (эндивия), который обжаривают, измельчают и используют в качестве дешевого заменителя растворимого кофе или его ароматизатора.');

INSERT INTO topping (id, name, price, volume, description) VALUES
(1, 'Ваниль', 50, 10, 'Сироп для кофе с ароматом ванили'),
(2, 'Карамель', 55, 10, 'Сироп для кофе с ароматом карамели'),
(3, 'Шоколад', 60, 10, 'Сироп для кофе с ароматом шоколада');

INSERT INTO coffee (id, name, price, volume, description) VALUES
(1, 'Латте', 200, 250, 'Кофе с молоком'),
(2, 'Капучино', 250, 250, 'Кофе с молочной пенкой'),
(3, 'Американо', 150, 150, 'Черный кофе');

INSERT INTO orders (id, registration, number, price, delivery, payment, fk_employee, fk_client) VALUES
(1, '2023-01-27 11:25', 1, 500.00, 'False', 'Оплачен', 3, 1),
(2, '2023-01-26 15:01', 2, 1100.00, 'False', 'Не оплачен', 4, 2),
(3, '2023-01-25 09:25', 3, 300.00, 'False', 'Оплачен', 3, 3);

INSERT INTO ingredient_coffee (id, fk_ingredient_id, fk_coffee_id) VALUES
(1, 2, 3),
(2, 3, 2);

INSERT INTO position_order (id, fk_cof_id, fk_order_id, count_cof) VALUES
(1, 2, 1, 3),
(2, 1, 2, 2),
(3, 3, 3, 1);

INSERT INTO topping_pos_order (id, fk_topping_id, fk_pos_order_id) VALUES
(1, 1, 1),
(2, 2, 3);

SELECT * FROM post;
SELECT * FROM employee;
SELECT * FROM orders;
SELECT * FROM client;
SELECT * FROM ingredient;
SELECT * FROM ingredient_coffee;
SELECT * FROM position_order;
SELECT * FROM topping;
SELECT * FROM topping_pos_order;
SELECT * FROM coffee;

UPDATE client
SET adress = 'Екатеринбург'
WHERE id = 2;

UPDATE ingredient
SET name = 'Цикорий /(пародия на кофе/)'
WHERE name = 'Цикорий';

DELETE FROM topping
WHERE id = '3';

DELETE FROM position_order
WHERE fk_cof_id <2;

SELECT registration, SUM(price) FROM orders
GROUP BY registration;

SELECT COUNT(salary) FROM post;

SELECT AVG(salary) FROM post;

SELECT MIN(date_birth) FROM employee;

SELECT MAX(price) FROM coffee;

SELECT * FROM client
ORDER BY name;

SELECT * FROM coffee
ORDER BY price DESC;

SELECT FROM position_order
WHERE id !=2;

SELECT * FROM coffee OFFSET(2);

SELECT * FROM post
WHERE salary >10000 and salary <40000;

SELECT * FROM post
WHERE id > 1 and (salary != 31000) or salary >100000; 

SELECT * FROM client
WHERE name NOT IN('Мила');

SELECT DISTINCT name FROM client;

SELECT * FROM coffee
WHERE name LIKE '___те';

SELECT * FROM employee
WHERE telephone SIMILAR TO '%2%';

SELECT 
	post.title AS "Навзвание должности", 
	post.salary AS "Уровень зарплаты",
	employee.firstname AS "Фамилия сотрудника", 
	employee.name AS "Имя сотрудника", 
	employee.patronymic AS "Отчетсво сотрудника", 
	employee.date_birth AS "День рождения сотрудника", 
	employee.telephone AS "Телефон сотрудника" 
FROM employee INNER JOIN post 
	ON employee.post_id = post.id;

SELECT name COUNT(price)  FROM coffee;

SELECT SUM(price) AS "Сумма всех напитков" FROM coffee;

UPDATE VIEW ord AS
    SELECT coffee.name, coffee.price, coffee.volume, ingredient_coffee.fk_ingredient_coffee
        FROM coffee, ingredient_coffee
        WHERE coffee.id = fk_coffee_id;

SELECT * FROM ord;

BEGIN;

SELECT * FROM orders
UPDATE orders
	SET price = price + 200
	WHERE id = 3
UPDATE orders 
	SET price = price - 200
	WHERE id = 1
COMMIT;