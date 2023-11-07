-- 1) Com base no MER abaixo, crie o modelo relacional e as tabelas.

create table categoria(
	codigo integer primary key not null,
	nome varchar(100)
);

create table editora(
	codigo integer not null primary key,
	nome varchar(100),
	telefone numeric(11)
);

create table livro (
	codigo integer primary key not null,
	cod_cate integer not null,
	cod_edit integer not null,
	titulo varchar(100),
	resumo varchar(100),
	ano date not null,
	constraint fk_cod_cate foreign key (cod_cate) references categoria (codigo),
	constraint fk_cod_edit foreign key (cod_edit) references editora (codigo)
);

/* 2) Crie uma sequence para cada uma das tabelas criadas no exercício 2 e faça a
inserção de dados utilizando o comando nextval. Quando possível, utilize query. No mínimo 6
inserções para cada tabela. */

create sequence seq_cate;
create sequence seq_edit;
create sequence seq_livro;

insert into categoria values (nextval('seq_cate'),'Romance'),
							(nextval('seq_cate'),'Ação'),
							(nextval('seq_cate'),'Suspense'),
							(nextval('seq_cate'),'Terror'),
							(nextval('seq_cate'),'Drama');;
							
select * from livro

insert into editora values (nextval('seq_edit'),'aaaaaaaa',11957085767),
							(nextval('seq_edit'),'bbbbbbbbbbb',11957085768),
							(nextval('seq_edit'),'ccccccccccc',11957085769),
							(nextval('seq_edit'),'dddddddddddddd',11957085761),
							(nextval('seq_edit'),'eeeeeeeee',11957085760),
							(nextval('seq_edit'),'fffffff',11957085762);

insert into livro values (nextval('seq_livro'),(select codigo from categoria where codigo = 6),
						 (select codigo from editora where codigo = 1),null,null,'2023-01-01');
						 
insert into livro values (nextval('seq_livro'),(select codigo from categoria where nome ilike 'suspense'),
						 (select codigo from editora where nome ilike 'ccccccccccc'),null,null,'2022-03-09');
						 
insert into livro values (nextval('seq_livro'),(select codigo from categoria where nome ilike 'Terror'),
						 (select codigo from editora where nome ilike 'fffffff'),null,null,'2022-03-09');
						 
insert into livro values (nextval('seq_livro'),(select codigo from categoria where nome ilike 'Drama'),
						 (select codigo from editora where nome ilike 'eeeeeeeee'),null,null,'2022-03-09');
						 
insert into livro values (nextval('seq_livro'),(select codigo from categoria where nome ilike 'Ação'),
						 (select codigo from editora where nome ilike 'dddddddddddddd'),null,null,'2022-03-09');
						 
insert into livro values (nextval('seq_livro'),(select codigo from categoria where nome ilike 'aventura'),
						 (select codigo from editora where nome ilike 'bbbbbbbbbbb'),null,null,'2022-03-09');
						 
