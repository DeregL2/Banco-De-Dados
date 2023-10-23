/*1) Criar uma tabela para armazenar os dados dos alunos conforme o desenho.*/

create table aluno(
	rgm_aluno integer primary key not null,
	nome_alu varchar(100) not null,
	endereco_alu varchar(100) not null,
	telefone_alu varchar(100)
);

/*2) Crie uma tabela para armazenar os dados das disciplinas*/

create table disciplinas(
	codigo integer primary key not null,
	nome_disc varchar(100) not null
);

/*3) Criar uma tabela para armazenar as notas dos alunos para cada disciplina.  */

create table notas(
	codigo_nota integer primary key not null,
	p1 numeric(3,1),
	p2 numeric(3,1),
	media numeric(3,1)
);

