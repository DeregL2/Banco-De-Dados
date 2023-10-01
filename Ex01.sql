create table cliente(
	numero integer not null,
	nome	varchar(50) not null,
	endereco	varchar(100),
	constraint Pk_numero_cliente Primary Key(numero)
);

create table carro(
	registro	integer not null,
	marca	varchar(100) not null,
	modelo	varchar(100) not null,
	cor	varchar(50) not null,
	constraint Pk_registro_carro Primary Key(registro)
);

create table acidente(
	codigo	integer not null,
	data	date not null,
	hora	time,
	local	varchar(100) not null,
	constraint Pk_codigo_acidente Primary Key(codigo)
);

create table apolice(
	numero_apo	integer not null,
	valor	decimal(10,2) not null,
	dt_ini	date not null,
	dt_fim	date not null,
	numero	integer not null,
	registro integer not null,
	constraint Pk_numero_apolice Primary Key(numero_apo),
	constraint Fk_numero_client foreign Key(numero)references cliente(numero),
	constraint Fk_numero_registro foreign Key(registro)references carro (registro)
);

create table cobre(
	numero_apo	integer not null,
	codigo	integer not null,
	constraint Pk_cobre primary key (numero_apo,codigo),
	constraint Fk_numero_apo foreign Key(numero_apo) references apolice(numero_apo),
	constraint Fk_codigo_acidente foreign Key(codigo) references acidente(codigo)
);