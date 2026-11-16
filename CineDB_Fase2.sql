-- Creación de la Base de Datos
CREATE DATABASE CineDB;
GO

USE CineDB;
GO

-- 1. Tabla Pelicula
CREATE TABLE Pelicula (
    idPelicula INT IDENTITY(1,1),
    titulo VARCHAR(100) NOT NULL, -- CONSTRAINT NOT NULL implícito/explícito
    duracionMinutos INT NOT NULL,
    clasificacion VARCHAR(10) NOT NULL,
    CONSTRAINT PK_Pelicula PRIMARY KEY (idPelicula),
    CONSTRAINT CK_Pelicula_Duracion CHECK (duracionMinutos > 0) -- CONSTRAINT CHECK
);

-- 2. Tabla Sala
CREATE TABLE Sala (
    idSala INT IDENTITY(1,1),
    nombreSala VARCHAR(50) NOT NULL,
    capacidadTotal INT NOT NULL,
    CONSTRAINT PK_Sala PRIMARY KEY (idSala),
    CONSTRAINT CK_Sala_Capacidad CHECK (capacidadTotal > 0)
);

-- 3. Tabla Asiento
CREATE TABLE Asiento (
    idAsiento INT IDENTITY(1,1),
    idSala INT NOT NULL,
    fila VARCHAR(5) NOT NULL,
    numeroAsiento INT NOT NULL,
    CONSTRAINT PK_Asiento PRIMARY KEY (idAsiento),
    CONSTRAINT FK_Asiento_Sala FOREIGN KEY (idSala) REFERENCES Sala(idSala), -- CONSTRAINT FK
    CONSTRAINT UQ_Asiento_Sala_Fila_Num UNIQUE (idSala, fila, numeroAsiento) -- CONSTRAINT UNIQUE
);

-- 4. Tabla Empleado
CREATE TABLE Empleado (
    idEmpleado INT IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    puesto VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Empleado PRIMARY KEY (idEmpleado),
    CONSTRAINT UQ_Empleado_Correo UNIQUE (correo)
);

-- 5. Tabla Cliente
CREATE TABLE Cliente (
    idCliente INT IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) NULL,
    correo VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Cliente PRIMARY KEY (idCliente),
    CONSTRAINT UQ_Cliente_Correo UNIQUE (correo)
);

-- 6. Tabla Funcion
CREATE TABLE Funcion (
    idFuncion INT IDENTITY(1,1),
    idPelicula INT NOT NULL,
    idSala INT NOT NULL,
    fechaHoraInicio DATETIME NOT NULL,
    precioBoleto DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_Funcion PRIMARY KEY (idFuncion),
    CONSTRAINT FK_Funcion_Pelicula FOREIGN KEY (idPelicula) REFERENCES Pelicula(idPelicula),
    CONSTRAINT FK_Funcion_Sala FOREIGN KEY (idSala) REFERENCES Sala(idSala),
    CONSTRAINT CK_Funcion_Precio CHECK (precioBoleto >= 0)
);

-- 7. Tabla Boleto
CREATE TABLE Boleto (
    idBoleto INT IDENTITY(1,1),
    idFuncion INT NOT NULL,
    idAsiento INT NOT NULL,
    idCliente INT,
    fechaCompra DATETIME NOT NULL, -- CONSTRAINT DEFAULT aplicado abajo
    CONSTRAINT PK_Boleto PRIMARY KEY (idBoleto),
    CONSTRAINT FK_Boleto_Funcion FOREIGN KEY (idFuncion) REFERENCES Funcion(idFuncion),
    CONSTRAINT FK_Boleto_Asiento FOREIGN KEY (idAsiento) REFERENCES Asiento(idAsiento),
    CONSTRAINT FK_Boleto_Cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    CONSTRAINT DF_Boleto_FechaCompra DEFAULT GETDATE() FOR fechaCompra -- CONSTRAINT DEFAULT
);

-- 8. Tabla Producto (Dulcería)
CREATE TABLE Producto (
    idProducto INT IDENTITY(1,1),
    nombreProducto VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    CONSTRAINT PK_Producto PRIMARY KEY (idProducto),
    CONSTRAINT CK_Producto_Precio CHECK (precio >= 0),
    CONSTRAINT CK_Producto_Stock CHECK (stock >= 0)
);

-- 9. Tabla Venta
CREATE TABLE Venta (
    idVenta INT IDENTITY(1,1),
    idEmpleado INT NOT NULL,
    idCliente INT,
    fechaVenta DATETIME NOT NULL,
    CONSTRAINT PK_Venta PRIMARY KEY (idVenta),
    CONSTRAINT FK_Venta_Empleado FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado),
    CONSTRAINT FK_Venta_Cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    CONSTRAINT DF_Venta_Fecha DEFAULT GETDATE() FOR fechaVenta
);

-- 10. Tabla DetalleVenta
CREATE TABLE DetalleVenta (
    idDetalle INT IDENTITY(1,1),
    idVenta INT NOT NULL,
    idProducto INT NOT NULL,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_DetalleVenta PRIMARY KEY (idDetalle),
    CONSTRAINT FK_DetalleVenta_Venta FOREIGN KEY (idVenta) REFERENCES Venta(idVenta),
    CONSTRAINT FK_DetalleVenta_Producto FOREIGN KEY (idProducto) REFERENCES Producto(idProducto),
    CONSTRAINT CK_DetalleVenta_Cantidad CHECK (cantidad > 0)
);

USE CineDB;
GO

-- ============================================================================
-- 1. Agregar una columna 'tipoCliente' (Frecuente / Regular) a la tabla Cliente
-- ============================================================================
ALTER TABLE Cliente ADD tipoCliente VARCHAR(20) CONSTRAINT DF_Cliente_Tipo DEFAULT 'Regular' NOT NULL;
GO

-- CONSULTA DE COMPROBACIÓN 1: Verifica que la columna 'tipoCliente' fue agregada
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE, COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Cliente' AND COLUMN_NAME = 'tipoCliente';
GO


-- ============================================================================
-- 2. Modificar la longitud de la columna 'titulo' en Pelicula a VARCHAR(200)
-- ============================================================================
ALTER TABLE Pelicula ALTER COLUMN titulo VARCHAR(200) NOT NULL;
GO

-- CONSULTA DE COMPROBACIÓN 2: Verifica que el tamaño cambio a 200 caracteres
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Pelicula' AND COLUMN_NAME = 'titulo';
GO


-- ============================================================================
-- 3. Agregar columna 'estatus' y su restricción CHECK en Empleado
-- ============================================================================
ALTER TABLE Empleado ADD estatus VARCHAR(10) NULL;
GO
ALTER TABLE Empleado ADD CONSTRAINT CK_Empleado_Estatus CHECK (estatus IN ('Activo', 'Inactivo'));
GO

-- CONSULTA DE COMPROBACIÓN 3: Muestra la restricción CHECK creada en la tabla Empleado
SELECT name AS NombreConstraint, definition AS ReglaCheck
FROM sys.check_constraints
WHERE parent_object_id = OBJECT_ID('Empleado');
GO


-- ============================================================================
-- 4. Agregar una columna 'observaciones' en la tabla Funcion
-- ============================================================================
ALTER TABLE Funcion ADD observaciones VARCHAR(255) NULL;
GO

-- CONSULTA DE COMPROBACIÓN 4: Confirma la existencia de la columna 'observaciones'
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Funcion' AND COLUMN_NAME = 'observaciones';
GO


-- ============================================================================
-- 5. Eliminar (DROP) la restricción 'CK_Producto_Stock' en Producto
-- ============================================================================
ALTER TABLE Producto DROP CONSTRAINT CK_Producto_Stock;
GO

-- CONSULTA DE COMPROBACIÓN 5: Verifica que la restricción ya NO existe en la tabla Producto
SELECT name AS NombreConstraint
FROM sys.check_constraints
WHERE parent_object_id = OBJECT_ID('Producto') AND name = 'CK_Producto_Stock';
GO