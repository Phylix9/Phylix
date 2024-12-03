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
desc Cuestionario;
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
carbohidrato varchar(100),
vitamina varchar(100),
grasa varchar(100),
porcion_proteina int,
porcion_carbohidrato int,
porcion_vitamina int,
porcion_grasa int,
nombre_dieta varchar(50),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);
select * from Comidas;

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
ejercicio9 varchar(100),
reps1 int,
reps2 int,
reps3 int,
reps4 int,
reps5 int,
reps6 int,
reps7 int,
reps8 int,
reps9 int,
nombre_rutina varchar(40),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

select * from Rutinasper;
drop table Rutinasper;

create table RutPrest(
id_plan varchar(10) primary key,
rutina_prest varchar(400),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

INSERT INTO RutPrest (id_plan, rutina_prest, id_usuario) VALUES
('Plan 1', 'Rutina de Pecho 1 - Fuerza\n\nEjercicio 1: Press de banca con barra: 4 series de 6-8 repeticiones\nEjercicio 2: Press inclinado con mancuernas: 4 series de 8-10 repeticiones\nEjercicio 3: Press declinado con barra o mancuernas: 3 series de 10 repeticiones\nEjercicio 4: Fondos en paralelas: 3 series al fallo', NULL),
('Plan 2', 'Rutina de Pecho 2 - Hipertrofia\n\nEjercicio 1: Press de banca plano con mancuernas: 4 series de 10-12 repeticiones\nEjercicio 2: Aperturas en banco inclinado: 4 series de 12-15 repeticiones\nEjercicio 3: Press en máquina Smith: 3 series de 12 repeticiones\nEjercicio 4: Cruce de poleas: 4 series de 15 repeticiones', NULL),
('Plan 3', 'Rutina de Espalda 1 - Ancho\n\nEjercicio 1: Dominadas con agarre amplio: 4 series al fallo\nEjercicio 2: Jalón en polea con agarre supino: 4 series de 10-12 repeticiones\nEjercicio 3: Remo con barra: 3 series de 8-10 repeticiones\nEjercicio 4: Pullover en polea alta: 3 series de 12-15 repeticiones', NULL),
('Plan 4', 'Rutina de Espalda 2 - Grosor\n\nEjercicio 1: Remo en barra T: 4 series de 8-10 repeticiones\nEjercicio 2: Remo en polea baja: 4 series de 10-12 repeticiones\nEjercicio 3: Peso muerto convencional: 3 series de 6-8 repeticiones\nEjercicio 4: Hiperextensiones: 3 series de 15 repeticiones', NULL),
('Plan 5', 'Rutina de Cuádriceps 1 - Volumen\n\nEjercicio 1: Sentadilla con barra: 4 series de 8-10 repeticiones\nEjercicio 2: Prensa de piernas en máquina: 4 series de 10-12 repeticiones\nEjercicio 3: Extensiones de piernas en máquina: 3 series de 12-15 repeticiones\nEjercicio 4: Sentadillas búlgaras: 3 series de 12 repeticiones por pierna', NULL),
('Plan 6', 'Rutina de Cuádriceps 2 - Definición\n\nEjercicio 1: Sentadilla frontal con barra: 4 series de 8-10 repeticiones\nEjercicio 2: Zancadas en máquina Smith: 4 series de 12 repeticiones\nEjercicio 3: Prensa de piernas en ángulo cerrado: 4 series de 10-12 repeticiones\nEjercicio 4: Sissy Squat: 3 series de 15 repeticiones', NULL),
('Plan 7', 'Rutina de Femoral 1 - Gluteo\n\nEjercicio 1: Peso muerto rumano: 4 series de 10-12 repeticiones\nEjercicio 2: Curl de piernas acostado: 4 series de 10-12 repeticiones\nEjercicio 3: Hip Thrust: 3 series de 12 repeticiones\nEjercicio 4: Patada de glúteos en máquina: 3 series de 15 repeticiones', NULL),
('Plan 8', 'Rutina de Femoral 2 - Desarrollo Femoral\n\nEjercicio 1: Peso muerto rumano con barra: 4 series de 8-10 repeticiones\nEjercicio 2: Curl de piernas acostado en máquina: 4 series de 12 repeticiones\nEjercicio 3: Sentadilla sumo con mancuernas o barra: 3 series de 10-12 repeticiones\nEjercicio 4: Desplante invertido: 3 series de 10-12 repeticiones por pierna', NULL),
('Plan 9', 'Rutina de Cuerpo Completo\n\nEjercicio 1: Sentadilla con barra: 4 series de 6-8 repeticiones\nEjercicio 2: Peso muerto convencional: 4 series de 6-8 repeticiones\nEjercicio 3: Press de banca con barra: 4 series de 8-10 repeticiones\nEjercicio 4: Remo con barra: 4 series de 10 repeticiones\nEjercicio 5: Press militar con barra: 3 series de 10 repeticiones', NULL);

select * from Comidas;


select * from Rutinasper;
 select * from Rutina;
-- select * from RutinapersoCreadas;

select * from RutPrest;
-- select * from DietPrest;

create table ImagenesPerfil(
id_perfil int primary key,
imagen longblob,
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

create table RutPrestUsuarios(
id_planusers int auto_increment primary key,
id_planselected varchar(10),
rutina_prestusers varchar(400),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

SELECT * FROM RutPrestUsuarios;

create table DietaPrest(
id_dieta varchar(10) primary key,
dieta_prest varchar(900),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

create table DietaPrestUsuarios(
id_dietausers int auto_increment primary key,
id_dietaselected varchar(10),
dieta_prestusers varchar(900),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

select * from DietaPrest;

INSERT INTO DietaPrest (id_dieta, dieta_prest, id_usuario) VALUES
('Plan 1', 'Comida 1: 4 huevos revueltos con espinacas y champiñones; 1 taza de avena cocida con un plátano en rodajas; café o té sin azúcar.\nComida 2: 1 sándwich de atún en agua con lechuga, jitomate y pan integral; 1 taza de fresas.\nComida 3: 150 g de pechuga de pollo a la parrilla; ensalada de lechuga, tomate, pepino y zanahoria con aceite de oliva y jugo de limón; ½ taza de arroz hervido; ½ aguacate.\nComida 4: 180 g de res con pimientos y cebolla; 1 taza de espinacas; 3 tortillas de maíz.\nComida 5: Gelatina light, una taza de jícama rallada, té de hierbas sin azúcar.', NULL),
('Plan 2', 'Comida 1: Yogurt griego (145 g) con 1 taza de avena y 2 tazas de papaya; 4 claras de huevo con 2 rebanadas de jamón de pavo.\nComida 2: Bistec en salsa verde (210 g) con 3 tortillas de maíz; ensalada de lechuga y pepino.\nComida 3: Ensalada de pollo con lechuga orejona, zanahoria rallada y jitomate asado; ¾ taza de arroz blanco hervido.\nComida 4: Mazapán sin azúcar, 10 almendras y 1 taza de gelatina de agua; 1 taza de piña picada.\nComida 5: Manzana roja chica con 20 almendras y 1 taza de gelatina de agua.', NULL),
('Plan 3', 'Comida 1: Yogurt griego (145 g) con 1 manzana roja picada y 1 taza de melón; 100 g de pechuga de pollo asada con 2 tortillas de maíz.\nComida 2: Ensalada de res con ajo asado y vegetales (zanahoria, nopales, ejotes); 3 tortillas de maíz.\nComida 3: Salteado de pollo (120 g) con calabacitas, pimiento rojo y verde, y camote en cubos.\nComida 4: Mazapán sin azúcar, 10 almendras y 1 taza de gelatina de agua; 1 taza de piña picada.\nComida 5: Manzana roja chica con 20 almendras y 1 taza de gelatina de agua.', NULL),
('Plan 4', 'Comida 1: Licuado con ½ taza de leche y ½ taza de agua, 1 plátano dominico, ½ taza de avena y 6 nueces enteras.\nComida 2: Yogurt griego (½ taza) con ½ taza de melón y 20 almendras; acompañado de 1 pan tostado.\nComida 3: Ensalada de atún con 1 taza de germen de alfalfa, lechuga, jitomate, 1 lata de atún en agua y 20 g de queso Oaxaca; acompañada con crotones y ⅓ de aguacate y un paquete de tostadas Salma.\nComida 4: Sándwich de dos pisos con 2 claras de huevo, 3 rebanadas de pechuga de pavo y 20 g de queso manchego, lechuga, jitomate y 1 cucharadita de mayonesa; servido en 3 panes blancos.\nComida 5: Omelette con 4 claras de huevo y 40 g de queso Oaxaca, 1 taza de champiñones, acelgas y espinacas; acompañado de 3 tortillas de maíz.', NULL),
('Plan 5', 'Comida 1: Yogurt con frutas: ½ taza de yogurt griego con ½ mango, ¼ taza de amaranto y 20 almendras.\nComida 2: Rice cake: sobre un rice cake, 2 cucharadas de crema de cacahuate, 5 fresas en rodajas y ½ taza de yogurt griego.\nComida 3: Brochetas de pollo: 150 g de pechuga de pollo asada con pimiento y cebolla; servido con ½ aguacate y 1½ taza de arroz integral.\nComida 4: 150 g de cecina asada acompañada de 1 taza de jitomate, acelga y espinaca; servido con ½ aguacate.\nComida 5: Chilaquiles: 1 taza de salsa de tomate (con cebolla y chile al gusto), 3 tostadas Salma como totopos, 2 huevos estrellados y 40 g de queso panela rallado; acompañado de 1 cucharada de crema.', NULL),
('Plan 6', 'Comida 1: Yogurt con ½ taza de avena, 1½ taza de papaya, 1 cucharada de chía y 10 almendras.\nComida 2: Sándwich dulce con 2 panes blancos, 1 cucharada de crema de cacahuate, 1 cucharadita de mermelada, 1 plátano en rodajas y 10 almendras; 1 taza de leche de almendras.\nComida 3: Ensalada de atún con lechuga, jitomate, cebolla morada y 2 huevos hervidos; 3 tostadas horneadas.\nComida 4: Bolitas de pollo con 120 g de pechuga licuada con ⅓ aguacate y 30 g de queso Oaxaca; acompañadas de 1 taza de apio y zanahoria.\nComida 5: Tres rollitos de pechuga de pavo.', NULL);


select * from DietaPrestUsuarios;
