Drop database if exists FitData;

Create database FitData;
use FitData;

-- Sin normalizar:

Create Table Usuario(
id_usuario int primary key auto_increment,
nombre_usuario varchar(30),
correo_usuario varchar(60),
contrasena_usuario varchar(20),
sexo_usuario varchar (15),
edad_usuario int
);
Create Table Cuestionario(
id_cuestionario int primary key auto_increment,
alergias_usuario varchar(60),
enfermedades_usuario varchar(60),
id_usuario int,
id_dieta int ,
id_rutina int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
FOREIGN KEY (id_dieta) REFERENCES Dieta(id_dieta),
FOREIGN KEY (id_rutina) REFERENCES Rutina(id_rutina)
);

Create Table Progreso(
id_cuestionario int primary key auto_increment,
progreso_usuario varchar(60),
id_usuario int,
id_dieta int,
id_rutina int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
FOREIGN KEY (id_dieta) REFERENCES Dieta(id_dieta),
FOREIGN KEY (id_rutina) REFERENCES Rutina(id_rutina)
);

Create Table Rutina(
id_dieta int ,
rutina_usuario varchar(100),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

Create Table Dieta(
id_dieta int,
dieta_usuario varchar(100),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);


Create Table IMC(
id_imc int primary key auto_increment,
imc_usuario decimal(3,2),
peso_usuario decimal(3,2),
altura_usuario decimal(3,2),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Normalizada:

Create Table Usuario(
id_usuario int primary key auto_increment,
nombre_usuario varchar(30),
correo_usuario varchar(60),
contrasena_usuario varchar(20),
sexo_usuario varchar (15),
edad_usuario int
);
Create Table Cuestionario(
id_cuestionario int primary key auto_increment,
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

Create Table Alergias_Usuario(
id_alergia int primary key auto_increment,
alergias_usuario varchar(60),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);
Create Table Enfermedades_Usuario(
id_enfermedad int primary key auto_increment,
enfermedades_usuario varchar(60),
id_cuestionario int,
FOREIGN KEY (id_cuestionario) REFERENCES Cuestionario(id_cuestionario)
);

Create Table Progreso(
id_cuestionario int primary key auto_increment,
progreso_usuario varchar(60),
id_usuario int,
id_dieta int,
id_rutina int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
FOREIGN KEY (id_dieta) REFERENCES Dieta(id_dieta),
FOREIGN KEY (id_rutina) REFERENCES Rutina(id_rutina)
);

Create Table Rutina(
id_dieta int ,
rutina_usuario varchar(100),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

Create Table Dieta(
id_dieta int,
dieta_usuario varchar(100),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);


Create Table IMC(
id_imc int primary key auto_increment,
imc_usuario decimal(3,2),
peso_usuario decimal(3,2),
altura_usuario decimal(3,2),
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);