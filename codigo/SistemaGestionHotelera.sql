-- Bases de datos I
-- Sistema de Gestion Hotelera


-- Creacion de la base de datos con la verificacion de que si existe o no la base de datos.
if not exists (select [name] from sys.databases where [name] = N'SistemaGestionHotelera')
begin
	create database SistemaGestionHotelera
end

--Uso de la base de datos
use SistemaGestionHotelera

--Creacion de las tablas catalogo 
--Tabla catalogo Provincia
create table Provincia (
	IdProvincia int identity(1,1) primary key,
	NombreProvincia varchar(50) not null
);

--Tabla catalogo Canton
create table Canton (
	IdCanton int identity(1,1) primary key,
	NombreCanton varchar(50) not null
);

--Tabla catalogo Distrito
create table Distrito (
	IdDistrito int identity(1,1) primary key,
	NombreDistrito varchar(50) not null
);

--Tabla catalogo RedSocial
create table RedSocial (
	IdRedSocial int identity(1,1) primary key,
	NombreRedSocial varchar(50) not null
);

--Tabla catalogo TipoHospedaje
create table TipoHospedaje(
	IdTipoHospedaje int identity(1,1) primary key,
	NombreTipoHospedaje varchar(50) not null
);

--Tabla catalogo Servicio
create table Servicio(
	IdServicio int identity(1,1) primary key,
	NombreServicio varchar(50) not null,
	Descripcion text not null
);

--Tabla catalogo TipoCama
create table TipoCama(
	IdTipoCama int identity(1,1) primary key,
	NombreTipoCama varchar(50) not null, 
	Descripcion text not null
);

--Tabla catalogo Comodidad
create table Comodidad(
	IdComodidad int identity(1,1) primary key,
	NombreComodidad varchar(50) not null
);

--Tabla catalogo TipoIdentidad
create table TipoIdentidad(
	IdTipoIdentidad int identity(1,1) primary key,
	NombreTipoIdentidad varchar(50) not null,
	Descripcion text not null
);

--Tabla Catalogo Pais
create table Pais(
	IdPais int identity(1,1) primary key,
	NombrePais varchar(75) not null,
	CodigoPais varchar(5) not null,
	Abrebiacion varchar(3) not null
);

--Tabla catalogo TipoPago
create table TipoPago(
	IdTipoPago int identity(1,1) primary key,
	NombreTipoPago varchar(50) not null,
);

--Tabla catalogo TipoServicio
create table TipoServicio (
	IdServicio int identity(1,1) primary key, 
	NombreServicio varchar(50) not null,
	descripcion text not null
);

--Tabla catalogo TipoActividad
create table TipoActividad (
	IdActividad int identity(1,1) primary key not null,
	NombreActividad varchar(50) not null,
	descripcion text not null
);






--Creacion de las tablas
--Hospedajes
--Tabla de Hospedaje
create table Hospedaje (
	IdHospedaje int identity(1,1) primary key,
    CedulaJuridica varchar(20) not null check(CedulaJuridica like '[0-9]%' and len(CedulaJuridica) between 10 and 20),
    NombreHospedaje varchar(50) not null,
    TipoHospedaje int not null,
    UrlSitioWeb varchar(255) null check(UrlSitioWeb is null or UrlSitioWeb like 'http%'),
    CorreoElectronico varchar(100) not null unique check(CorreoElectronico like '_%@_%._%'),
    ReferenciasGPS varchar(100) not null,
    constraint FK_TipoHospedaje foreign key (TipoHospedaje) references TipoHospedaje(IdTipoHospedaje)
);

--Tabla de DireccionHospedaje
create table DireccionHospedaje (
    IdDireccion int identity(1,1) primary key,
	IdHospedaje int not null,
	SenasExactas varchar(255) not null,
	Barrio varchar(100)not null,
    Provincia int not null,
    Canton int not null,
    Distrito int not null,
	constraint FK_DireccionHospedaje foreign key (IdHospedaje) references Hospedaje(IdHospedaje),
	constraint FK_ProvinciaHospedaje foreign key (Provincia) references Provincia(IdProvincia),
	constraint FK_CantonHospedaje foreign key (Canton) references Canton(IdCanton),
	constraint FK_DistritoHospedaje foreign key (Distrito) references Distrito(IdDistrito)
);

--Tabla de TelefonoHospedaje
create table TelefonoHospedaje(
	IdTelefonoHospedaje int identity(1,1) primary key,
	NumeroTelefono varchar(20) not null check(NumeroTelefono like '+506' and NumeroTelefono not like '%[^0-9+ -]%'), --permite el ingreso de números y el caracter + y - para el codigo
	IdHospedaje int not null,
	constraint FK_TelefonoHospedaje foreign key (IdHospedaje) references Hospedaje(IdHospedaje)
);

--Tabla de ServicioHospedaje
create table ServicioHospedaje (
	IdServicioHospedaje int identity(1,1) primary key,
	IdHospedaje int not null unique,
	IdServicio int not null unique,
	constraint FK_ServicioHospedaje foreign key (IdHospedaje) references Hospedaje(IdHospedaje),
	constraint FK_Servicio foreign key (IdServicio) references Servicio(IdServicio)
);

--Tabla de RedSocialHospedaje
create table RedSocialHospedaje(
	IdRedSocilaHospedaje int identity(1,1) primary key,
	IdHospedaje int not null unique, --Para que el hospedaje no tenga dos veces la misma red social
	IdRedSocial int not null unique,
	NombreUsuario varchar(50) not null,
	UrlPerfil varchar(255) not null check(UrlPerfil like 'htpp%'),
	constraint FK_RedSocialHospedaje foreign key (IdHospedaje) references Hospedaje(IdHospedaje),
	constraint FK_RedSocial foreign key (IdRedSocial) references RedSocial(IdRedSocial)
);

--Tabla de TipoHabitacion
create table TipoHabitacion(
	IdTipoHabitacion int identity(1,1) primary key,
	NombreTipoHabitacion varchar(50) not null,
	IdTipoCama int not null,
	IdHospedaje int not null,
	Capacidad int not null check(Capacidad > 0),
	Descripcion text not null,
	Precio decimal(10,2) not null check(Precio > 0),
	constraint FK_TipoCamaHabitacion foreign key (IdTipoCama) references TipoCama(IdTipoCama),
	constraint FK_TipoHabitacionHospedaje foreign key (IdHospedaje) references Hospedaje(IdHospedaje)
);

--Tabla de ComodidadHabitacion 
create table ComodidadHabitacion (
	IdComodidadHabitacion int identity(1,1) primary key,
	IdComodidad int not null unique,
	IdTipoHabitacion int not null unique,
	constraint FK_ComodidadHabitacion foreign key (IdComodidad) references Comodidad(IdComodidad),
	constraint FK_TipoHabitacionComodidad foreign key (IdTipoHabitacion) references TipoHabitacion(IdTipoHabitacion)
);

--Tabla de FotoHabitacion
create table FotoHabitacion (
	IdFotoHabitacion int identity(1,1) primary key,
	IdTipoHabitacion int not null,
	Foto image not null,
	constraint FK_FotoTipoHabotacion foreign key (IdTipoHabitacion) references TipoHabitacion(IdTipoHabitacion)
);

--Tabla de Habitacion
create table Habitacion (
	IdHabitacion int identity(1,1) primary key,
	NumeroHabitacion int not null unique check(NumeroHabitacion > 0),
	IdTipoHabitacion int not null unique, --par evitar que en un mismo hospedaje no se tenga el mismo numero de habitaciones repetidas
	IdHospedaje int not null unique,
	CantidadPersonas int not null check(CantidadPersonas > 0),
	constraint FK_TipoHabitacion foreign key (IdTipoHabitacion) references TipoHabitacion(IdTipoHabitacion),
	constraint FK_HabitacionHospedaje foreign key (IdHospedaje) references Hospedaje(IdHospedaje)
);

--Tabla de Cliente
create table Cliente (
	IdCliente int identity(1,1) primary key,
	IdentificacionCliente varchar(20) not null unique,
	PrimerApellido varchar(50) not null,
	SegundoApellido varchar(50) not null,
	Nombre varchar(50) not null,
	CorreoElectronico varchar(100) not null unique check(CorreoElectronico like '%_@_%._%'),
	FechaNacimiento date not null check(FechaNacimiento < getdate()), --para que la fecha de nacimiento no sea futura
	TipoIdentidad int not null,
	PaisResidencia int not null,
	constraint FK_IdTipoIdentidad foreign key (TipoIdentidad) references TipoIdentidad(IdTipoIdentidad),
	constraint FK_PaisResidencia foreign key (PaisResidencia) references Pais(IdPais)

);

--Tabla de TelefonoCliente
create table TelefonoCliente (
	IdTelefonoCliente int identity(1,1) primary key,
	IdCliente int not null,
	NumeroTelefono varchar(20) not null check(NumeroTelefono like '+%' and NumeroTelefono not like '%[^0-9+ -]%'),
	TipoTelefono varchar(20) not null check(TipoTelefono in ('Móvil', 'Casa', 'Trabajo', 'Otro')),
	constraint FK_TelefonoCliente foreign key (IdCliente) references Cliente(IdCliente)
);

--Tabla de DireccionCliente
create table DireccionCliente (
	IdDirreccionCliente int identity(1,1) primary key,
	IdCliente int not null unique, --para que cada cliente solo pueda tener una direccion
	Provincia int null,
	Canton int null,
	Distrito int null,
	constraint FK_DireccionCliente foreign key (IdCliente) references Cliente(IdCliente),
	constraint FK_ProvinciaCliente foreign key (Provincia) references Provincia(IdProvincia),
	constraint FK_CantonCliente foreign key (Canton) references Canton(IdCanton),
	constraint FK_DistritoCliente foreign key (Distrito) references Distrito(IdDistrito),
	constraint CHK_DireccionCostarricense check((Provincia is null and Canton is null and Distrito is null) or (Provincia is not null and Canton is not null and Distrito is not null))
);

--Tabla de Reservacion
create table Reservacion (
	IdReserva int identity(1,1) primary key,
	NumeroReserva varchar(12) not null unique,
	IdHabitacion int not null,
	CantidadPersonas int not null check(CantidadPersonas > 0),
	IdCliente int not null,
	FechaIngreso date not null check(FechaIngreso >= cast(getdate() as date)),--se valida que la fecha de ingreso este en una fecha valida
	FechaSalida  date not null,
	HoraIngreso time not null, 
	HoraSalida time not null check(HoraSalida <= '12:00:00'),--se valida que la hora de salida sea antes o a las 12:00
	PoseeVehiculo Bit not null default 0,
	constraint Ck_validacionFechas check((FechaIngreso <= FechaSalida)), --se valida que la fecha de ingreso sea menor que la de salida
	constraint FK_ReservaHabitacion foreign key (IdHabitacion) references Habitacion(IdHabitacion),
	constraint FK_ReservaCliente foreign key (IdCliente) references Cliente(IdCliente)
);

--Tabla de Facturacion
create table Facturacion (
	IdFactura int identity(1,1) primary key,
	NumeroFacturacion varchar(12),
	IdReserva int not null unique,
	FechaEmision  date not null default cast(getdate() as date),-- que la fecha sea por omision la fecha actual
	CantidadNoches int null,
	ImporteTotal decimal(10,2) null,
	IdTipoPago int not null,
	constraint FK_ReservaFacturada foreign key (IdReserva) references Reservacion(IdReserva),
	constraint FK_MetodoPago foreign key (IdTipoPago) references TipoPago(IdTipoPago)
);

--Empresas Recreativas
--Tabla de EmpresaRecreativa
create table EmpresaRecreativa (
	IdEmpresaRecreativa int identity(1,1) primary key,
	CedulaJuridicaEmpresa varchar(20) not null check(CedulaJuridicaEmpresa like '%[0-9]%' and len(CedulaJuridicaEmpresa) between 10 and 20),
	NombreEmpresas varchar(50) not null,
	CorreoElectronico varchar(100) not null unique check(CorreoElectronico like '%@%.%'),--correo que sea único
	NombrePersonal varchar(150) not null, 
	NumeroTelefono varchar(20) not null check(NumeroTelefono like '+506' and NumeroTelefono not like '%[^0-9+ -]%') --permite el ingreso de números y el caracter + y - para el codigo
);

--Tabla de EmpresaServicio
create table EmpresaServicio(
	IdEmpresaServicio int identity(1,1) primary key,
	CostoAdicional decimal(10,2) null,
	Descripcion text not null,
	IdServicio int not null,
	IdEmpresaRecreativa int not null,
	constraint FK_ServicioEmpresa foreign key (IdServicio) references TipoServicio(IdServicio),
	constraint FK_EmpresaRecreativaServicio foreign key (IdEmpresaRecreativa) references EmpresaRecreativa(IdEmpresaRecreativa)
);

--Tabla de EmpresaActividad
create table EmpresaActividad(
	IdEmpresaActividad int identity(1,1) primary key,
	precio decimal(10,2) not null check(Precio > 0),
	MaximoParticipantes int not null check(MaximoParticipantes > 0),
	MinimoParticipantes int not null check(MinimoParticipantes > 0),
	Duracion int not null check(Duracion > 0),
	Descripcion text null,
	Horarios text null,
	IdActividad int not null,
	IdEmpresaRecreativa int not null,
	constraint FK_actividadEmpresa foreign key (IdActividad) references TipoActividad(IdActividad),
	constraint FK_EmpresaRecreativaActividad foreign key (IdEmpresaRecreativa) references EmpresaRecreativa(IdEmpresaRecreativa),
	constraint CHK_MaxMinParticipantes check(MinimoParticipantes <= MaximoParticipantes)
);

--Tabla de DireccionEmpresa
create table DireccionEmpresa (
    IdDireccionEmpresa int identity(1,1) primary key,
	IdEmpresaRecreativa int not null,
	SenasExactas varchar(255) not null,
    Provincia int not null,
    Canton int not null,
    Distrito int not null,
	constraint FK_DireccionEmpresaRecreativa foreign key (IdEmpresaRecreativa) references EmpresaRecreativa(IdEmpresaRecreativa),
	constraint FK_ProvinciaEmpresa foreign key (Provincia) references Provincia(IdProvincia),
	constraint FK_CantonEmpresa foreign key (Canton) references Canton(IdCanton),
	constraint FK_DistritoEmpresa foreign key (Distrito) references Distrito(IdDistrito)
);