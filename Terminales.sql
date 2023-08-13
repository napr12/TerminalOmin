if not exists(select * from master.sys.databases where name='Terminal')
	create database Terminal
go

create table compania(
	nombre nchar (20)primary key,
	telefono nchar(14) not null,
	direccion nchar(50) not null
)
go

create table empleado(
	nombreUsuario nchar(8) primary key,
	nombre nchar(20) not null,
	apellido nchar(20) not null
)
go

create table viajes(
	codigoInterno int identity(1,1) primary key,
	salida datetime not null,
	llegada datetime not null,
	pasajeros int check(pasajeros<=50) not null,
	anden integer check (anden<=35) not null,
	boleto money not null,
	nombreUsuario nchar(8) not null,
	nombre nchar (20)not null,
	foreign key (nombreUsuario) references empleado(nombreUsuario),
	foreign key (nombre) references compania (nombre)
)
go

create table terminal(
	codigoTerminal nchar(6) check(codigoTerminal LIKE'[A-Za-z][A-Za-z][A-Za-z][A-Za-z][A-Za-z][A-Za-z]') primary key,
	ciudad nchar(20)not null
)
go

create table internacional(
	codigoTerminal nchar(6) check(codigoTerminal LIKE'[A-Za-z][A-Za-z][A-Za-z][A-Za-z][A-Za-z][A-Za-z]') primary key,
	pais nchar(20) not null,
	foreign key (codigoTerminal) references terminal(codigoTerminal)
)
go

create table nacional(
	codigoTerminal nchar(6) check(codigoTerminal LIKE'[A-Za-z][A-Za-z][A-Za-z][A-Za-z][A-Za-z][A-Za-z]') primary key,
	pais ncahr(20) not null,
	foreign key (codigoTerminal) references terminal (codigoTerminal)
)
go

create table pasa(
	codigoTerminal nchar(6) check(codigoTerminal LIKE'[A-Za-z][A-Za-z][A-Za-z][A-Za-z][A-Za-z][A-Za-z]'),
	codigoInterno int,
	parada int,
	foreign key (codigoTerminal) references terminal(codigoTerminal),
	foreign key (codigoTerminal) references terminal(codigoTerminal),
	primary key (codigoTerminal, codigoInterno, parada)
)
go
/*
create table empleado(
	nombreUsuario nchar(8) primary key,
	nombre nchar(20) not null,
	apellido nchar(20) not null
)
go
*/
create proc altaEmpleado @nombreUsuario nchar(8), @nombre nchar(20), @apellido nchar(20), @contraseña nchar(6)
as
begin
	if(PATINDEX('%[A-Za-z]%%[0-9]%{3}', @contraseña)!= 0)
		return -1 --La contraseña no contiene 3 caracteres y 3 numeros
end