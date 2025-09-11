
      

CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL,
    estado BOOLEAN DEFAULT TRUE,
    fecha_ing TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modif TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE usuario (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    rol_id INT REFERENCES roles(id) ON DELETE SET NULL,
    estado BOOLEAN DEFAULT TRUE,
    fecha_ing TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modif TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE persona (
    id SERIAL PRIMARY KEY,
    primer_nombre VARCHAR(50) NOT NULL,
    segundo_nombre VARCHAR(50),
    apellido_pat VARCHAR(50) NOT NULL,
    apellido_mat VARCHAR(50),
    rut VARCHAR(12) UNIQUE NOT NULL,
    direccion TEXT,
    edad INT CHECK (edad >= 0),
    id_usuario INT REFERENCES usuario(id) ON DELETE CASCADE,
    estado BOOLEAN DEFAULT TRUE,
    fecha_ing TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modif TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);


select * from usuario



INSERT INTO roles (nombre_rol) VALUES 
('Administrador'),
('Editor'),
('Invitado');


INSERT INTO usuario (username, password, rol_id) VALUES 
('admin_user', 'admin_pass', 1),
('editor_user', 'editor_pass', 2),
('guest_user', 'guest_pass', 3);



INSERT INTO persona (
    primer_nombre, segundo_nombre, apellido_pat, apellido_mat, rut, direccion, edad, id_usuario
) VALUES 
('Miguel', 'Ángel', 'Zamora', 'Montecinos', '12.345.678-9', 'Puente Alto, Santiago', 35, 1),
('Laura', NULL, 'González', 'Rivas', '20.456.789-0', 'Ñuñoa, Santiago', 28, 2),
('Carlos', 'Eduardo', 'Pérez', NULL, '18.123.456-7', 'Maipú, Santiago', 42, 3);



