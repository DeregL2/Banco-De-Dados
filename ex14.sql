create table genero(
 id numeric,
 nome varchar(100),
 constraint genero_pkey primary key (id)
);
create table filme(
 id numeric not null,
 nome varchar(100),
 duracao integer,
 sinopse varchar(2000),
 genero integer,
 data timestamp,
 constraint pk_genero primary key (id),
 constraint fk_genero_filme foreign key (genero)
 references genero (id)
);
insert into genero values (1,'drama');
insert into genero values (2,'comedia');
insert into genero values (3,'terror');
insert into genero values (4,'romance');
insert into genero values (5,'suspense');
insert into filme
 values (1,'os outros','90','aaaaaaaaaaaa',5,'2006-08-15');
insert into filme
 values (2,'duplex','120','aaaaaaaaaaaa',2,'2001-08-15');
insert into filme
 values (3,'click','100','aaaaaaaaaaaa',2,'2005-08-15');
insert into filme
 values (4,'o piano','90','aaaaaaaaaaaa',1,'2005-06-12'); 
 
-- 1. Criar uma função para retornar o número do gênero passando o nome dele. 

create function tipo(varchar)
returns integer as
'
	select id
	from genero
	where nome ilike $1;
'
language 'sql';


--2. Criar uma função para fazer o insert na tabela de gêneros. 

CREATE function inserir(numeric,varchar)
RETURNS void as
'
	insert into genero values ($1,$2);
'
LANGUAGE 'sql';

