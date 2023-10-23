/* 1. Crie as tabelas e os relacionamentos referentes ao Modelo Relacional abaixo (utilize
constraint para a criação das chaves primárias e estrangeiras): */

create table aluno(
	rgm integer not null,
	nome varchar (100)not null,
	idade integer not null,
	situacao varchar(100),
	constraint pk_rgm primary key(rgm)
);

create table disciplina (
	codigo integer not null,
	nome varchar(100) not null,
	media numeric(3,1) check (media >= 5) not null,
	constraint pk_codigo primary key (codigo),
	constraint uk_nome unique (nome)
);

create table notas(
	codigo_n integer not null,
	cod_aluno integer not null,
	cod_disc integer not null,
	p1 numeric(3,1),
	p2 numeric(3,1),
	media numeric(3,1),
	faltas integer,
	constraint pk_codigo_n primary key (cod_aluno,cod_disc),
	constraint fk_cod_aluno foreign key (cod_aluno) references aluno (rgm),
	constraint fk_cod_disc foreign key (cod_disc) references disciplina (codigo)
);

/* 2. Insira pelo menos 5 registros em cada tabela. Informe valores para TODOS os
campos. Antes da inserção, veja quais consultas/atualizações/deleções deverão ser
feitas para que os dados inseridos sejam compatíveis com as mesmas. */

select * from aluno

insert into aluno values (123,'Derick',20,null);
insert into aluno values (456,'Felipe',24,'Aprovado');
insert into aluno values (789,'Rayssa',19,'Reprovado');
insert into aluno values (101,'Bianca',17,'Reprovado');
insert into aluno values (102,'Rodrigo',30,null);
insert into aluno values (103,'Ana',15,'Aprovada');


select * from disciplina

insert into disciplina values (1,'Matemática',5);
insert into disciplina values (2,'Ed.Física',5);
insert into disciplina values (3,'Biologia',5);
insert into disciplina values (4,'Inglês',5);
insert into disciplina values (5,'Português',5);

select * from notas

insert into notas values (1,123,1,5,8,null,2);
insert into notas values (2,123,2,10,10,null,0);
insert into notas values (3,456,5,9.5,8.1,null,20);
insert into notas values (4,789,4,5,7.2,null,15);
insert into notas values (5,101,3,2.1,4.5,null,8);
insert into notas values (5,103,3,2.1,4.5,null,8);


/* 3. Atualizar o campo situacao, da tabela Alunos,para o texto “Aluno começado com
Ana” somente para os alunos cujo nome começam com Ana. Fazer uma consulta
para listar os registros atualizados. */

update aluno
set situacao = 'Alunos começando com Ana'
where nome ilike 'ana%'

/* 4. Atualizar todas as faltas dos alunos (na tabela Notas) para uma falta a mais em cada
(faltas + 1). Fazer uma consulta para listar os registros atualizados. */

update notas
set faltas = faltas + 1;

select * from notas;

/* 5. Atualizar o número de faltas (na Tabela Notas) para 9 somente dos alunos que
possuem media maior que 6 e faltas menor que 10. Fazer uma consulta para listar
os registros atualizados. */

update notas
set faltas = 9
where media >= 6 and faltas < 10;

select * from notas;

/* 6. Atualizar a situação dos alunos que possuem idade entre 18 e 25 para “Aluno
potencial”. Fazer uma consulta para listar os registros atualizados. */

update aluno
set situacao = 'Aluno potencial'
where idade between 18 and 25;

select * from aluno;

/* 7. Atualizar a situação do Aluno para “em avaliação” caso ele tenha idade 23, 28, 54
ou 55. Fazer uma consulta para listar os registros atualizados. */

update aluno
set situacao = 'Em avaliação'
where idade = 23 or idade = 28 or idade = 54 or idade = 55;

select * from aluno;

/* 8. Atualizar a situação dos alunos para “tem as letras AI no nome” caso ele possua no
nome as letras “ai” seguidas (não importa em que parte do nome). Fazer uma
consulta para listar os registros atualizados. */

update aluno
set situacao = 'Tem as letras IA no nome'
where nome ilike '%ia%';

select * from aluno where nome ilike '%ia%'

/* 9. Atualizar a situação dos alunos para “idade Ideal” caso o aluno tenha 23 ou 26. Fazer
uma consulta para listar os registros atualizados. */


update aluno
set situacao = 'Idade Ideal'
where idade between 23 and 26;

select * from aluno where idade between 23 and 26;