-- Bases de datos I
-- Sistema de Gestion Hotelera

use SistemaGestionHotelera

--Creacion de los inserts
--Tabla catalogo Provincia
insert into Provincia(NombreProvincia) 
values
	('San José'),
	('Alajuela'),
	('Cartago'),
	('Heredia'),
	('Guanacaste'),
	('Puntarenas'),
	('Limón');

--Inserts TipoHospedaje
insert into TipoHospedaje(NombreTipoHospedaje) 
values
    ('Hotel'),
    ('Hostal'),
    ('Casa'),
    ('Departamento'),
    ('Cuarto compartido'),
    ('Cabaña');


-- Inserts RedSocial
insert into RedSocial(NombreRedSocial)
values 
    ('Facebook'),
    ('Instagram'),
    ('Twitter'),
    ('TikTok');

--Tabla catalogo Servicio
insert into Servicio(NombreServicio, Descripcion)
values
	('Piscina', 'Piscina disponible para huéspedes'),
    ('WiFi', 'Acceso a internet inalámbrico'),
    ('Parqueo', 'Estacionamiento disponible'),
    ('Restaurante', 'Restaurante en el establecimiento'),
    ('Bar', 'Bar disponible en el establecimiento'),
    ('Ranch', 'Áreas de rancho para actividades'),
    ('Aire acondicionado', 'Habitaciones con aire acondicionado'),
    ('Desayuno incluido', 'Desayuno incluido en la estadía'),
    ('Servicio a la habitación', 'Room service disponible'),
    ('Gimnasio', 'Área de ejercicio disponible');

--Inserts TipoCama
insert into TipoCama(NombreTipoCama, Descripcion)
values
	('Individual', 'Cama individual (90-100 cm)'),
    ('Matrimonial', 'Cama doble estándar (135-150 cm)'),
    ('Queen', 'Cama queen size (160 cm)'),
    ('King', 'Cama king size (180-200 cm)'),
    ('Super King', 'Cama extra grande (200 cm+)'),
    ('Litera', 'Camas apiladas'),
    ('Sofá cama', 'Sofá que se convierte en cama');

--Insert Comodidad
insert into Comodidad(NombreComodidad)
values
	('WiFi en habitación'),
    ('Aire acondicionado'),
    ('Ventilador'),
    ('Agua caliente'),
    ('TV pantalla plana'),
    ('Minibar'),
    ('Caja fuerte'),
    ('Teléfono'),
    ('Escritorio'),
    ('Tetera/Cafetera'),
    ('Secador de pelo'),
    ('Plancha'),
    ('Baño privado'),
    ('Jacuzzi'),
    ('Balcón');

--Inserts TipoIdentidad
insert into TipoIdentidad(NombreTipoIdentidad, Descripcion) 
values
	('Cédula nacional', 'Documento de identidad nacional para ciudadanos costarricenses'),
	('DIMEX', 'Documento de Identidad Migratorio para Extranjeros residentes en Costa Rica'),
	('Cédula jurídica', 'Documento de identidad para empresas y organizaciones legalmente constituidas en Costa Rica'),
	('Pasaporte', 'Documento de identidad internacional para extranjeros'),
	('Cédula de residencia', 'Documento para extranjeros con estatus de residentes permanentes');

--Inserts País
insert into Pais(NombrePais, CodigoPais, Abrebiacion)
values 
	('Costa Rica', '506', 'CR'),
	('Estados Unidos', '1', 'USA'),
	('Canadá', '1', 'CAN'),
	('México', '52', 'MEX'),
	('Panamá', '507', 'PAN'),
	('Nicaragua', '505', 'NIC'),
	('El Salvador', '503', 'SLV'),
	('Honduras', '504', 'HND'),
	('Guatemala', '502', 'GTM'),
	('República Dominicana', '1', 'DOM'),
	('Cuba', '53', 'CUB'),
	('Jamaica', '1', 'JAM'),
	('España', '34', 'ESP'),
	('Francia', '33', 'FRA'),
	('Alemania', '49', 'DEU'),
	('Reino Unido', '44', 'GBR'),
	('Italia', '39', 'ITA'),
	('Países Bajos', '31', 'NLD'),
	('Suiza', '41', 'CHE'),
	('Bélgica', '32', 'BEL'),
	('Suecia', '46', 'SWE'),
	('Portugal', '351', 'PRT'),
	('Austria', '43', 'AUT'),
	('Irlanda', '353', 'IRL'),
	('Brasil', '55', 'BRA'),
	('Argentina', '54', 'ARG'),
	('Colombia', '57', 'COL'),
	('Chile', '56', 'CHL'),
	('Perú', '51', 'PER'),
	('Ecuador', '593', 'ECU'),
	('Venezuela', '58', 'VEN'),
	('Uruguay', '598', 'URY'),
	('China', '86', 'CHN'),
	('Japón', '81', 'JPN'),
	('Corea del Sur', '82', 'KOR'),
	('Australia', '61', 'AUS'),
	('Nueva Zelanda', '64', 'NZL'),
	('India', '91', 'IND'),
	('Israel', '972', 'ISR'),
	('Emiratos Árabes Unidos', '971', 'ARE');

--Inserts TipoPago
insert into TipoPago(NombreTipoPago)
values
	('Efectivo'),
    ('Tarjeta crédito');

--Inserts TipoServicio
insert into TipoServicio(NombreServicio, Descripcion)
values
	('Transporte', 'Servicio de transporte incluido'),
    ('Comida', 'Servicio de alimentación incluido'),
    ('Guía', 'Servicio de guía turístico'),
    ('Equipo', 'Alquiler de equipo especializado'),
    ('Fotografía', 'Servicio fotográfico profesional'),
    ('Seguro', 'Seguro de viaje incluido'),
    ('Bebidas', 'Bebidas incluidas'),
    ('Hotel', 'Incluye estadía en hotel'),
    ('Entradas', 'Incluye entradas a atracciones');

--Inserts TipoActividad
insert into TipoActividad(NombreActividad, Descripcion)
values 
	('Tour en bote', 'Paseos recreativos en bote'),
    ('Tour en lancha', 'Paseos en lancha rápida'),
    ('Tour en catamarán', 'Paseos en catamarán'),
    ('Kayak', 'Alquiler o tours en kayak'),
    ('Snorkeling', 'Tour de snorkeling'),
    ('Buceo', 'Tour de buceo'),
    ('Senderismo', 'Tours de senderismo guiados'),
    ('Cabalgata', 'Paseos a caballo'),
    ('Rappel', 'Actividades de rappel'),
    ('Canopy', 'Tours de canopy'),
    ('Observación de aves', 'Tours de observación de aves'),
    ('Tour cultural', 'Visitas culturales guiadas');


--Tablas principales
--Tabla Hospedaje
insert into Hospedaje (CedulaJuridica, NombreHospedaje, TipoHospedaje, UrlSitioWeb, CorreoElectronico, ReferenciasGPS) 
values
	('3-101-123456', 'Hotel Buenavista', 1, 'http://www.hotelbuenavista.com', 'reservaciones@hotelbuenavista.com', '9.9281, -84.0907'),
	('3-102-654321', 'Hotel Playa Hermosa', 1, 'http://www.hotelplayahermosa.com', 'info@hotelplayahermosa.com', '10.5667, -85.6833'),
	('3-103-789123', 'Hotel Monteverde', 1, 'http://www.hotelmonteverde.com', 'contacto@hotelmonteverde.com', '10.2705, -84.8248'),
	('3-201-456789', 'Hostel Pura Vida', 2, 'http://www.hostelpuravida.com', 'bookings@hostelpuravida.com', '9.9355, -84.0791'),
	('3-202-987654', 'Hostel Caribe', 2, NULL, 'reservas@hostelarenal.com', '10.4631, -84.7033'),
	('3-301-112233', 'Casa Tropical', 3, 'http://www.casatropical.com', 'info@casatropical.com', '9.9123, -84.0567'),
	('3-401-445566', 'Cabañas del Bosque', 6, NULL, 'cabanas@delbosque.com', '10.3012, -84.8123');

--Tabla DireccionesHospedaje
insert into DireccionHospedaje (IdHospedaje, SenasExactas, Barrio, Provincia, Canton, Distrito) 
values
	(1, '200 metros norte del Banco Nacional Cahuita', 'Barrio Escalante', 1, 'Limon', 'Carmen'),
	(2, 'Frente a la playa principal', 'Playa Hermosa', 6, 'Limón', 'Playa Hermosa'),
	(3, '500 metros este de la reserva', 'Santa Elena', 5, 'Monteverde', 'Santa Elena'),
	(4, 'Calle 15, entre avenidas 8 y 10', 'La California', 1, 'San José', 'Uruca'),
	(5, '1 km al este del volcán', 'La Fortuna', 2, 'San Carlos', 'La Fortuna'),
	(6, 'Casa color amarillo con portón negro', 'Rohrmoser', 1, 'San José', 'Pavas'),
	(7, 'Entrada principal del bosque, segunda cabaña', 'Monteverde', 5, 'Monteverde', 'Santa Elena');

--Tabla TelefonoHospedaje
insert into TelefonoHospedaje (NumeroTelefono, IdHospedaje)
values
	('+506 2222-3333', 1),
	('+506 2222-4444', 1),
	('+506 2654-1234', 2),
	('+506 2645-7890', 3),
	('+506 2233-4455', 4),
	('+506 2479-8080', 5),
	('+506 8877-6655', 6),
	('+506 8345-6789', 7);

--Tabla ServiciosHospedaje
insert into	ServicioHospedaje (IdHospedaje, IdServicio) 
values
	(1, 1), 
	(1, 2), 
	(1, 3), 
	(1, 4), 
	(1, 6), 
	(2, 1), 
	(2, 2), 
	(2, 3), 
	(2, 7), 
	(4, 2), 
	(4, 3),
	(7, 2);

--Tabla RedesSocialesHospedaje
insert into RedSocialHospedaje (IdHospedaje, IdRedSocial, NombreUsuario, UrlPerfil)
values 
	(1, 1, 'HotelBuenavistaCR', 'http://www.facebook.com/HotelBuenavistaCR'),
	(1, 2, '@HotelBuenavista', 'http://www.instagram.com/HotelBuenavista'),
	(2, 1, 'PlayaHermosaHotel', 'http://www.facebook.com/PlayaHermosaHotel'),
	(2, 3, '@PHHotelCR', 'http://www.twitter.com/PHHotelCR'),
	(4, 1, 'HostelPuraVida', 'http://www.facebook.com/HostelPuraVida'),
	(4, 2, '@PuraVidaHostel', 'http://www.instagram.com/PuraVidaHostel'),
	(4, 4, '@Reserva', 'http://wa.me/50683456789'),
	(7, 2, '@CabanasDelBosque', 'http://www.instagram.com/CabanasDelBosque');

--Tabla TipoHabitacion
insert into TipoHabitacion (NombreTipoHabitacion, IdTipoCama, IdHospedaje, Capacidad, Descripcion, Precio) 
values
	('Habitación Estándar', 1, 1, 2, 'Habitación cómoda con cama individual, ideal para viajeros solos', 75.00),
	('Habitación Doble', 2, 1, 2, 'Habitación con cama matrimonial, perfecta para parejas', 95.00),
	('Suite Ejecutiva', 4, 1, 3, 'Amplia suite con cama king, sala de estar y amenities de lujo', 150.00),
	('Bungalow Vista Mar', 3, 2, 2, 'Encantador bungalow con cama queen y vista directa al mar', 120.00),
	('Suite Familiar', 5, 2, 4, 'Suite con dos camas individuales, ideal para familias', 180.00),
	('Dormitorio Compartido', 6, 4, 6, 'Amplio dormitorio con literas para 6 personas', 25.00),
	('Habitación Privada', 1, 4, 1, 'Habitación privada con cama individual', 40.00),
	('Cabaña Romántica', 3, 7, 2, 'Acogedora cabaña con cama queen y chimenea', 110.00),
	('Cabaña Familiar', 2, 7, 4, 'Amplia cabaña con cama matrimonial y litera', 160.00);

--Tabla ComodidadHabitacion
insert into ComodidadHabitacion (IdComodidad, IdTipoHabitacion) 
values
	(2, 1), 
	(6, 1), 
	(7, 1),
	(1, 2), 
	(3, 2), 
	(6, 2), 
	(7, 2),
	(1, 3), 
	(3, 3), 
	(4, 3), 
	(5, 3), 
	(6, 3), 
	(7, 3), 
	(9, 3), 
	(1, 4), 
	(3, 4), 
	(6, 4), 
	(7, 4),
	(10, 4),
	(2, 6), 
	(6, 6), 
	(7, 6),
	(2, 8), 
	(6, 8), 
	(7, 8);

--FotoHabitacion
insert into FotoHabitacion (IdTipoHabitacion, Foto) 
values
	(1, 0x1234567890ABCDEF),
	(1, 0xFEDCBA0987654321),
	(2, 0xABCDEF1234567890),
	(2, 0x0987654321FEDCBA),
	(2, 0x1122334455667788),
	(3, 0x3344556677889900),
	(3, 0xAABBCCDDEEFF0011),
	(3, 0x556677889900AABB),
	(4, 0x6677889900AABBCC),
	(4, 0xDDEEFF0011223344),
	(6, 0x77889900AABBCCDD),
	(8, 0xEEFF001122334455),
	(8, 0x9900AABBCCDDEEFF),
	(8, 0x0011223344556677);

--Tabla de Habitacion
insert into Habitacion (NumeroHabitacion, IdTipoHabitacion, IdHospedaje, CantidadPersonas) 
values 
	(101, 1, 1, 1),  
	(102, 1, 1, 1),
	(201, 2, 1, 2),  
	(202, 2, 1, 2),
	(301, 3, 1, 3), 
	(10, 4, 2, 2),  
	(11, 4, 2, 2),
	(20, 5, 2, 4),
	(1, 6, 4, 6),   
	(2, 6, 4, 6),
	(3, 7, 4, 1),
	(1, 8, 7, 2),   
	(2, 9, 7, 4);

--Tabla de Cliente
insert into Cliente (IdentificacionCliente, PrimerApellido, SegundoApellido, Nombre, CorreoElectronico, FechaNacimiento, TipoIdentidad, PaisResidencia) 
values
	('1-1234-5678', 'González', 'Pérez', 'María', 'maria.gonzalez@email.com', '1985-06-15', 1, 1),
	('1-2345-6789', 'Rodríguez', 'Hernández', 'Juan', 'juan.rodriguez@email.com', '1990-11-22', 1, 1),
	('1-3456-7890', 'Martínez', 'López', 'Ana', 'ana.martinez@email.com', '1978-03-10', 1, 1),
	('AB123456', 'Smith', 'Johnson', 'John', 'john.smith@email.com', '1982-09-05', 3, 2),
	('CD789012', 'García', 'Fernández', 'Carlos', 'carlos.garcia@email.com', '1995-07-30', 3, 3),
	('EF345678', 'Brown', 'Vasques', 'Emily', 'emily.brown@email.com', '1992-12-18', 3, 4);

--Tabla de TelefonoCliente
insert into TelefonoCliente (IdCliente, NumeroTelefono, TipoTelefono) 
values
	(7, '+506 8888-9999', 'Móvil'),
	(7, '+506 2222-3333', 'Casa'),
	(8, '+506 7777-6666', 'Móvil'),
	(9, '+506 6666-5555', 'Móvil'),
	(10, '+1 213-555-1234', 'Móvil'),
	(11, '+34 91 555 12 34', 'Trabajo'),
	(12, '+52 55 1234 5678', 'Móvil');

--Tabla de DireccionCliente
insert into DireccionCliente (IdCliente, Provincia, Canton, Distrito) 
values
	(7, 1, 'San José', 'Carmen'),
	(8, 1, 'Escazú', 'San Rafael'),
	(9, 2, 'Alajuela', 'Alajuela Centro'),
	(10, NULL, NULL, NULL),
	(11, NULL, NULL, NULL),
	(12, NULL, NULL, NULL);

--Tabla de Reservacion
insert into Reservacion (NumeroReserva, IdHabitacion, CantidadPersonas, IdCliente, FechaIngreso, FechaSalida, HoraIngreso, HoraSalida, PoseeVehiculo)
values 
	('RES250115001', 1, 1, 1,'2025-04-29', '2025-05-02', '15:00:00', '11:00:00', 0),
	('RES250119002', 3, 2, 2, '2025-05-19', '2025-05-23', '14:00:00', '10:30:00', 1),
	('RES250208003', 5, 3, 3, '2025-05-01', '2025-05-08', '16:00:00', '12:00:00', 1),
	('RES250205004', 6, 2, 4, '2025-05-05', '2025-05-11', '13:00:00', '11:45:00', 0),
	('RES250318005', 7, 4, 5, '2025-05-12', '2025-05-18', '12:00:00', '10:00:00', 0);

insert into Facturacion (NumeroFacturacion,IdReserva,CantidadNoches, ImporteTotal, IdTipoPago)
values 
	('FAC250115001',6, datediff(day, '2025-01-15', '2025-01-19'), 4 * 75.00, 2),
	('FAC250119002',2, datediff(day, '2025-01-19', '2025-01-23'), 4 * 95.00, 1),
	('FAC250208003',3, datediff(day, '2025-02-01', '2025-02-08'), 7 * 150.00, 1),
	('FAC250205004',4, datediff(day, '2025-02-05', '2025-02-11'), 6 * 120.00, 2),
	('FAC250318005',5, datediff(day, '2025-03-12', '2025-03-18'), 6 * 25.00, 2);

--Tabla EmpresaRecreativa
insert into EmpresaRecreativa (CedulaJuridicaEmpresa, NombreEmpresas, CorreoElectronico, NombrePersonal, NumeroTelefono)
values
	('3-101-234567', 'Caribe Aventura', 'info@caribeaventura.com', 'Roberto Méndez', '+506 2758-1234'),
	('3-102-345678', 'EcoTours Cahuita', 'reservas@ecotourscahuita.com', 'María Fernández', '+506 2755-5678'),
	('3-103-456789', 'Dive Limón', 'contact@divelimon.com', 'Carlos Rodríguez', '+506 2750-9012'),
	('3-104-567890', 'Canopy del Caribe', 'aventuras@canopycaribe.com', 'Ana Vargas', '+506 2756-3456');

--Tabla de EmpresaServicio
insert into EmpresaServicio (CostoAdicional, Descripcion, IdServicio, IdEmpresaRecreativa)
values 
	(15.00, 'Transporte desde hoteles en Limón centro', 1, 1),
	(25.00, 'Almuerzo típico caribeño incluido', 2, 1),
	(10.00, 'Guía bilingüe (español/inglés)', 3, 1),
	(0.00, 'Equipo de snorkeling incluido', 4, 2),
	(20.00, 'Fotógrafo profesional durante el tour', 5, 2),
	(0.00, 'Todo el equipo de buceo incluido', 4, 3),
	(15.00, 'Seguro de viaje para actividades acuáticas', 6, 3),
	(10.00, 'Bebidas refrescantes después del tour', 7, 3),
	(0.00, 'Equipo de seguridad profesional incluido', 4, 4),
	(12.00, 'Transporte desde Puerto Viejo', 1, 4);

--Tabla de EmpresaActividad
insert into EmpresaActividad (precio, MaximoParticipantes, MinimoParticipantes, Duracion, Descripcion, Horarios, IdActividad, IdEmpresaRecreativa)
values 
	(65.00, 12, 4, 120, 'Tour en bote por los canales de Tortuguero con avistamiento de vida silvestre', 'Lunes a Sábado: 8:00 am y 1:00 pm', 1, 1),
	(85.00, 8, 2, 180, 'Tour en lancha rápida hacia Punta Uva con parada para snorkeling', 'Todos los días: 9:00 am', 2, 1),
	(45.00, 15, 1, 90, 'Tour de snorkeling en el arrecife de Cahuita', 'Martes a Domingo: 8:00 am y 2:00 pm', 5, 2),
	(30.00, 20, 1, 120, 'Senderismo guiado por el Parque Nacional Cahuita', 'Todos los días: 7:00 am y 3:00 pm', 7, 2),
	(120.00, 6, 2, 240, 'Tour de buceo en el arrecife de Manzanillo', 'Lunes, Miércoles, Viernes: 7:30 am', 6, 3),
	(75.00, 10, 1, 180, 'Curso de snorkeling para principiantes', 'Todos los días: 10:00 am', 5, 3),
	(55.00, 8, 2, 150, 'Tour de canopy por la selva con 12 plataformas', 'Todos los días: 8:00 am, 11:00 am, 2:00 pm', 10, 4),
	(40.00, 12, 4, 90, 'Tour de observación de aves en la reserva privada', 'Martes a Domingo: 6:00 am y 4:00 pm', 11, 4);

--Tabla de DireccionEmpresa
insert into DireccionEmpresa (IdEmpresaRecreativa, SenasExactas, Provincia, Canton, Distrito)
values 
	(1, '200 metros oeste del muelle principal', 7, 'Limón', 'Limón'),
	(2, 'Frente a la entrada principal del Parque Nacional Cahuita', 7, 'Talamanca', 'Cahuita'),
	(3, '50 metros norte del Supermercado Puerto Viejo', 7, 'Talamanca', 'Puerto Viejo'),
	(4, '3 km al sur de la entrada a Veragua Rainforest', 7, 'Limón', 'Matama');
