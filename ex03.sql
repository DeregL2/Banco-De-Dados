create table aluno(
	rgm integer not null,
	nome varchar(100) not null,
	idade integer not null,
	situacao varchar(100),
	constraint pk_rgm primary key(rgm)
);

create table disciplina(
	codigo integer not null,
	nome varchar(100) unique not null,
	media numeric(3,1) not null check (media >=5),
	constraint pk_codigo primary key(codigo)
);

create table notas(
	cod_aluno integer not null,
	cod_disc integer not null,
	cod_notas integer not null,
	p1 numeric(3,1) not null,
	p2 numeric(3,1) not null,
	media numeric(3,1),
	faltas integer,
	constraint pk_cod_notas primary key(cod_aluno,cod_disc),
	constraint fk_cod_disc foreign key (cod_disc) references disciplina (codigo),
	constraint fk_cod_aluno foreign key (cod_aluno) references aluno (rgm)
);

select * from aluno;
insert into aluno values (112311,'Derick',20);
insert into aluno values (112312,'Jorge',30);
insert into aluno values (112313,'Samantha',19);
insert into aluno values (112314,'Henrique',18);
insert into aluno values (112316,'Ana',17);

select *
from aluno
where idade between 17 and 30
order by nome;

select * from disciplina;
insert into disciplina values (2010,'Matemática',5);
insert into disciplina values (2011,'Português',5);
insert into disciplina values (2012,'Biologia',5);
insert into disciplina values (2013,'Inglês',5);
insert into disciplina values (2014,'Ed.Fisica',5);

select * from notas;
insert into notas values (112311,2011,123,8,7,7.5,20);
insert into notas values (112312,2011,124,10,7,8.5,40);
insert into notas values (112313,2012,125,8,2,5,17);
insert into notas values (112314,2013,126,8,5,6.5,30);
insert into notas values (112315,2014,127,8,9,8.5,10);

/* 3- Atualizar o campo situacao da tabela Alunos, para o texto "aluno começando com Ana" somente para os
alunos cujo ome começam com Ana. Fazer uma consulta para listar os registros atualizados */

update aluno
set situacao = 'reprovado'
where nome ilike 'd%';

select * from aluno;

select *
from aluno
where situacao = 'reprovado';

/* 4- Atualizar todas as faltas dos alunos (na tabela notas) para uma falta a mais em cada (faltas +1). fazer uma consulta 
para listar os registros atualiados */

update notas
set faltas = faltas +1;

select * from notas;


/* 5- Atualizar o número de faltas ( na tabela Notas) para 9 somente dos alunos que possuem media maior que 6 e faltas menor que 10.
Fazer uma consulta para listar os registros atualiados.
*/

update notas
set faltas = 9
where media > 6 and faltas < 30;

select * from notas where faltas = 9;

/* 6- Atualizar a situacao dos alunos que possuem idade entre 18 e 25 para "Aluno potencial"
fazer uma consulta para listar os registros atualizados
*/

update aluno
set situacao = 'Aluno potencial'
where idade >= 18 and idade <= 25;

select * from aluno where situacao = 'Aluno potencial';