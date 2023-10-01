create table gravadora(
	grav_cod integer not null,
	grav_nome varchar(50) not null,
	grav_end varchar(100),
	constraint Pk_grav_cod primary key (grav_cod)
);

create table CD(
	cd_cod integer not null,
	cd_grav_cod integer not null,
	cd_nome varchar(50),
	cd_valor numeric not null,
	cd_data_lanc date,
	constraint Pk_cd_cod primary key(cd_cod),
	constraint Fk_cd_grav_cod foreign key(cd_grav_cod) references gravadora(grav_cod)
);

create table musica(
	musc_cod integer not null,
	musc_nome varchar(50) not null,
	musc_duracao interval,
	musc_faixa integer,
	constraint Pk_musc_cod primary key(musc_cod)
);

create table autor(
	aut_cod integer not null,
	aut_nome varchar(50),
	constraint Pk_aut_cod primary key(aut_cod)
);

create table item_cd(
	ite_mus_cod integer not null,
	ite_cd_cod integer not null,
	constraint Pk_item_cod primary key(ite_mus_cod,ite_cd_cod),
	constraint Fk_ite_mus_cod foreign key(ite_mus_cod) references musica (musc_cod),
	constraint Fk_ite_cd_cod foreign key(ite_cd_cod) references cd(cd_cod)
);

create table musica_autor(
	mus_cod integer not null,
	aut_cod integer not null,
	constraint Pk_musc_auto primary key (mus_cod,aut_cod),
	constraint Fk_mus_cod foreign key(mus_cod) references musica (musc_cod),
	constraint Fk_aut_cod foreign key(aut_cod) references autor (aut_cod)
);

insert into autor values (2,'maria');
select * from autor;