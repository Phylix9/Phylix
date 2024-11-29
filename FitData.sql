Drop database if exists FitData;

Create database FitData;
use FitData;

-- Normalizada:

Create Table Usuario(
id_usuario int primary key auto_increment,
nombre_usuario varchar(30),
correo_usuario varchar(60),
contrasena_usuario varchar(20),
edad_usuario int,
sexo_usuario varchar (15)
);
Create Table Cuestionario(
id_cuestionario int primary key auto_increment,
nombre_completo varchar(60),
condicion_usuario varchar(60),
medicamento_usuario varchar(60),
frecuencia_usuario varchar(60),
objetivo_usuario varchar(60),
alergias_usuario varchar(60),
restriccion_usuario varchar(60),
estres_usuario varchar(60),
sueno_usuario varchar(60),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

Create Table Rutina(
id_rutina int primary key auto_increment,
rutina_usuario varchar(20),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

Create Table Dieta(
id_dieta int primary key auto_increment,
dieta_usuario varchar(100),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

Create Table Progreso(
id_progreso int primary key auto_increment,
progreso_usuario varchar(60),
id_usuario int,
id_dieta int,
id_rutina int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
FOREIGN KEY (id_dieta) REFERENCES Dieta(id_dieta),
FOREIGN KEY (id_rutina) REFERENCES Rutina(id_rutina)
);


Create Table IMC(
id_imc int primary key auto_increment,
imc_usuario double,
peso_usuario double,
altura_usuario double,
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

Create Table Alimentos(
id_alim int primary key auto_increment,
nombre_alim varchar(100),
porcion_alim double,
categoria varchar(25)
);

-- Insert into Usuario values
-- (null, 'Atorrest10', 'abrahamtorrest10@gmail.com', 'Abraham123-', 'Masculino', 18);

select * from Usuario;
select * from Cuestionario;
-- SELECT * FROM Usuario WHERE correo_usuario = 'abrahamtorrest10@gmail.com' AND contrasena_usuario = 'Abraham123-';

INSERT INTO Alimentos (id_alim, nombre_alim, porcion_alim, categoria) VALUES
(NULL, 'Arroz', 10.00, 'Carbohidrato'),
(NULL, 'Pollo', 10.00, 'Proteína'),
(NULL, 'Aguacate', 30.00, 'Grasa'),
(NULL, 'Brócoli', 50.00, 'Vitamina'),
(NULL, 'Pasta', 10.00, 'Carbohidrato'),
(NULL, 'Carne', 10.00, 'Proteína'),
(NULL, 'Aceite de oliva', 10.00, 'Grasa'),
(NULL, 'Zanahoria', 50.00, 'Vitamina');

select * from Alimentos;
select * from Imc;


Create Table Comidas(
id_comida int primary key auto_increment,
proteina varchar(100),
porcion_proteina int,
carbohidrato varchar(100),
porcion_carbohidrato int,
vitamina varchar(100),
porcion_vitamina int,
grasa varchar(100),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

Create Table DietapersoCreadas(
id_dietaperso int primary key auto_increment,
id_comida int,
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
FOREIGN KEY (id_comida) REFERENCES Comidas(id_comida)
);


Create Table Rutinasper(
id_rut int primary key auto_increment,
ejercicio1 varchar(100),
ejercicio2 varchar(100),
ejercicio3 varchar(100),
ejercicio4 varchar(100),
ejercicio5 varchar(100),
ejercicio6 varchar(100),
ejercicio7 varchar(100),
ejercicio8 varchar(100),
reps1 int,
reps2 int,
reps3 int,
reps4 int,
reps5 int,
reps6 int,
reps7 int,
reps8 int,
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

Create Table RutinapersoCreadas(
id_dietaperso int primary key auto_increment,
id_rut int,
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
FOREIGN KEY (id_rut) REFERENCES Rutinasper(id_rut)
);

create table RutPrest(
id_plan varchar(10) primary key,
rutina_prest varchar(400),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

INSERT INTO RutPrest (id_plan, rutina_prest, id_usuario) VALUES
('plan1', 'Rutina de Pecho 1 - Fuerza\n\nEjercicio 1: Press de banca con barra: 4 series de 6-8 repeticiones\nEjercicio 2: Press inclinado con mancuernas: 4 series de 8-10 repeticiones\nEjercicio 3: Press declinado con barra o mancuernas: 3 series de 10 repeticiones\nEjercicio 4: Fondos en paralelas: 3 series al fallo', NULL),

('plan2', 'Rutina de Pecho 2 - Hipertrofia\n\nEjercicio 1: Press de banca plano con mancuernas: 4 series de 10-12 repeticiones\nEjercicio 2: Aperturas en banco inclinado: 4 series de 12-15 repeticiones\nEjercicio 3: Press en máquina Smith: 3 series de 12 repeticiones\nEjercicio 4: Cruce de poleas: 4 series de 15 repeticiones', NULL),

('plan3', 'Rutina de Espalda 1 - Ancho\n\nEjercicio 1: Dominadas con agarre amplio: 4 series al fallo\nEjercicio 2: Jalón en polea con agarre supino: 4 series de 10-12 repeticiones\nEjercicio 3: Remo con barra: 3 series de 8-10 repeticiones\nEjercicio 4: Pullover en polea alta: 3 series de 12-15 repeticiones', NULL),

('plan4', 'Rutina de Espalda 2 - Grosor\n\nEjercicio 1: Remo en barra T: 4 series de 8-10 repeticiones\nEjercicio 2: Remo en polea baja: 4 series de 10-12 repeticiones\nEjercicio 3: Peso muerto convencional: 3 series de 6-8 repeticiones\nEjercicio 4: Hiperextensiones: 3 series de 15 repeticiones', NULL),

('plan5', 'Rutina de Cuádriceps 1 - Volumen\n\nEjercicio 1: Sentadilla con barra: 4 series de 8-10 repeticiones\nEjercicio 2: Prensa de piernas en máquina: 4 series de 10-12 repeticiones\nEjercicio 3: Extensiones de piernas en máquina: 3 series de 12-15 repeticiones\nEjercicio 4: Sentadillas búlgaras: 3 series de 12 repeticiones por pierna', NULL),

('plan6', 'Rutina de Cuádriceps 2 - Definición\n\nEjercicio 1: Sentadilla frontal con barra: 4 series de 8-10 repeticiones\nEjercicio 2: Zancadas en máquina Smith: 4 series de 12 repeticiones\nEjercicio 3: Prensa de piernas en ángulo cerrado: 4 series de 10-12 repeticiones\nEjercicio 4: Sissy Squat: 3 series de 15 repeticiones', NULL),

('plan7', 'Rutina de Femoral 1 - Gluteo\n\nEjercicio 1: Peso muerto rumano: 4 series de 10-12 repeticiones\nEjercicio 2: Curl de piernas acostado: 4 series de 10-12 repeticiones\nEjercicio 3: Hip Thrust: 3 series de 12 repeticiones\nEjercicio 4: Patada de glúteos en máquina: 3 series de 15 repeticiones', NULL),

('plan8', 'Rutina de Femoral 2 - Desarrollo Femoral\n\nEjercicio 1: Peso muerto rumano con barra: 4 series de 8-10 repeticiones\nEjercicio 2: Curl de piernas acostado en máquina: 4 series de 12 repeticiones\nEjercicio 3: Sentadilla sumo con mancuernas o barra: 3 series de 10-12 repeticiones\nEjercicio 4: Desplante invertido: 3 series de 10-12 repeticiones por pierna', NULL),

('plan9', 'Rutina de Cuerpo Completo\n\nEjercicio 1: Sentadilla con barra: 4 series de 6-8 repeticiones\nEjercicio 2: Peso muerto convencional: 4 series de 6-8 repeticiones\nEjercicio 3: Press de banca con barra: 4 series de 8-10 repeticiones\nEjercicio 4: Remo con barra: 4 series de 10 repeticiones\nEjercicio 5: Press militar con barra: 3 series de 10 repeticiones', NULL);


select * from DietapersoCreadas;
select * from Comidas;


select * from Rutinasper;
 select * from Rutina;
-- select * from RutinapersoCreadas;

select * from RutPrest;
-- select * from DietPrest;

create table ImagenesPerfil(
id_perfil int primary key,
imagen blob,
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

Drop table ImagenesPerfil;

SELECT imagen FROM ImagenesPerfil where id_usuario = 3;

desc ImagenesPerfil;

insert into ImagenesPerfil (id_perfil, id_usuario) VALUES (3,3);