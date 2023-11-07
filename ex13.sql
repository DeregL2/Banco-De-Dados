-- 1) Crie as tabelas referentes ao MER apresentado abaixo: 

create table cliente(
	id integer primary key not null,
	nome varchar(100)
);

create table tipo_filme(
	id integer primary key not null,
	descricao varchar(100),
	qtd_dias_locacao integer,
	vlr_multa_dia numeric(4,2)
);

create table filme (
	id integer primary key not null,
	titulo varchar(100),
	id_tipo integer,
	constraint fk_id_tipo foreign key (id_tipo) references tipo_filme (id)
);

create table locacao (
	id integer primary key not null,
	id_cli integer not null,
	id_filme integer not null,
	data_locacao date,
	data_prev_devolucao date,
	data_devolucao date,
	multa numeric (4,2),
	status varchar(100),
	constraint fk_id_cli foreign key (id_cli) references cliente (id),
	constraint fk_id_filme foreign key (id_filme) references filme(id)
);

-- 2) Crie as sequences necessárias. 

create sequence seq_cli;
create sequence seq_tipo;
create sequence seq_filme;
create sequence seq_loca;


/* 3) Inclua pelo menos 5 registros nas tabelas cliente, filme e tipo_filme de forma a
garantir que todos os registros sejam inseridos, ou em caso de erro, nenhum registro
seja inserido (utilize sequence e insert com query quando necessário). 
*/

begin work;
insert into cliente values (nextval('seq_cli'),'Dereg'),
						   (nextval('seq_cli'),'Boberto'),
						   (nextval('seq_cli'),'Rosa'),
						   (nextval('seq_cli'),'Isa'),
						   (nextval('seq_cli'),'Melissa');
--rollback work;
commit work;

select * from cliente

begin;
insert into tipo_filme values (nextval('seq_tipo'),'Filme Bom',null,10),
							  (nextval('seq_tipo'),'Filme Ruim',null,90),
							  (nextval('seq_tipo'),'Filme Mais ou menos',null,90),
							  (nextval('seq_tipo'),'Filme Delicia',null,90),
							  (nextval('seq_tipo'),'Filme Ruinzao',null,90);
--rollback;
commit work;


select * from tipo_filme

begin;
insert into filme values (nextval('seq_filme'),'Batman',(select id from tipo_filme where descricao ilike 'Filme Bom' )),
						 (nextval('seq_filme'),'Harry Potter',(select id from tipo_filme where descricao ilike 'Filme Ruim' )),
						 (nextval('seq_filme'),'Fada do dente',(select id from tipo_filme where descricao ilike 'Filme Ruinzao' )),
						 (nextval('seq_filme'),'Alvin e os esquilos',(select id from tipo_filme where descricao ilike 'Filme Delicia' )),
						 (nextval('seq_filme'),'A morte',(select id from tipo_filme where descricao ilike 'Filme Mais ou menos'));
--rollback;
commit;

select * from filme

/* 4) Suponha que um determinado cliente queria locar 3 filmes de sua preferência.
Escreva os comandos necessários para registrar esta locação. Se ocorrer algum
erro durante este registro, nenhuma locação deverá ser registrada. */

begin;
insert into locacao values (nextval('seq_loca'),(select id from cliente where nome ilike 'Dereg'),
							(select id from filme where titulo ilike 'Batman'),'2023-11-07','2023-11-17',null,40,'locado'),
							(nextval('seq_loca'),(select id from cliente where nome ilike 'Dereg'),
							(select id from filme where titulo ilike 'Harry Potter'),'2023-11-07','2023-11-20',null,60,'locado'),
							(nextval('seq_loca'),(select id from cliente where nome ilike 'Dereg'),
							(select id from filme where titulo ilike 'A morte'),'2023-11-07','2023-11-20',null,10,'locado');
--rollback;
commit;

select * from locacao

/* 5) No dia seguinte o mesmo cliente retorna para fazer a devolução dos filmes. Escreva
os comandos necessários para registrar esta devolução. Se ocorrer algum erro
durante este registro, nenhuma devolução deverá ser registrada. */

begin;
update locacao
set data_devolucao = '2023-11-08', status = 'devolucao' 
where id_cli = 1;
--rollback;
commit;


select * from locacao

/* Simule a inclusão de 2 novos filmes, porém utilize o comando ROLLBACK para
ilustrar o funcionamento de um SAVEPOINT. */

begin;
savepoint meu_savepoint;
insert into filme values (nextval('seq_filme'),'Meu malvado favorito 3',
				   (select id from tipo_filme where descricao ilike 'Filme Delicia'));
--rollback to meu_savepoint;
commit;
select * from filme