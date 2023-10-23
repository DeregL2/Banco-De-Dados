/* 1- Crie um banco de dados e a tabela definida abaixo:  */

create table teste(
	codigo numeric(6) primary key not null ,
	salario numeric(8,2) not null,
	dia_hoje date ,
	texto varchar(10),
	aprovado boolean
);

/* 2 - Fazer as seguintes alterações na tabela criada no exercício 1 */

/*a) Alterar o nome da tabela para AULABD.
b) Alterar o nome da coluna aprovado para situacao.
c) Adicionar um novo campo na tabela ( RGM numeric(5) ).
d) Adicionar um novo campo na tabela ( novo_campo varchar(100) ).
e) Alterar o campo novo_campo de modo a ser obrigatório (NOT NULL).
f) Apagar o campo salário da tabela.
g) Adicionar uma constraint de Primary Key para o campo RGM. Funcionou? Por quê?
Fazer com que o campo possa ser uma chave primária.
h) Apagar a Tabela. 
*/

alter table teste rename to aulabd ;

alter table aulabd rename aprovado to situacao;

alter table aulabd add column rgm numeric(5);

alter table aulabd add column novo_campo varchar(100);

alter table aulabd alter novo_campo set not null;

alter table aulabd drop salario ;

alter table aulabd drop codigo restrict;

alter table aulabd add constraint pk_rgm primary key (rgm);

drop table aulabd;

/* 3) Crie um novo banco de dados e as tabelas definidas abaixo. */

create table aluno(
	rgm integer not null,
	nome varchar(100),
	endereco varchar(100),
	telefone numeric(11)
);

create table disciplina(
	codigo integer not null,
	nome varchar(100),
	ementa varchar(50)
);

create table aluno_disciplina( 
	cod_aluno integer not null,
	cod_disciplina integer not null,
	nota1 numeric(3,1),
	nota2 numeric(3,1),
	media numeric(3,1),
	faltas integer
);

alter table aluno add constraint pk_rgm primary key (rgm);
alter table disciplina add constraint pk_codigo primary key (codigo);
alter table aluno_disciplina add codigo_a_d integer;
alter table aluno_disciplina add constraint pk_codigo_a_d primary key(cod_aluno,cod_disciplina);
alter table aluno_disciplina add constraint fk_cod_aluno foreign key (cod_aluno) references aluno(rgm);
alter table aluno_disciplina add constraint fk_cod_disciplina foreign key (cod_disciplina) references disciplina (codigo);

/* 4) Fazer as seguintes alterações na tabela criada no exercício 3

a) Adicionar na tabela Aluno um campo para armazenar o RG e outro para CPF.
b) Fazer com que o campo CPF da tabela Aluno seja único e obrigatório.
c) Excluir o campo faltas da tabela Aluno_Disciplina.
d) Alterar o nome da tabela ALUNO_DISCIPLINA para NOTAS.
e) Fazer com que o campo media da tabela NOTAS seja obrigatório.
f) Alterar o nome da tabela Aluno para Alunos. Funcionou? O que aconteceu com as
tabelas que referenciavam essa tabela?
g) Apagar a coluna RGM da tabela Alunos. Funcionou? Por quê?Como faço para apagála?
h) Apagar a tabela Disciplina. Funcionou? Como faço para apagá-la?
i) Apagar todas as tabelas. */

alter table aluno 
	add rg integer;
	
alter table aluno 
	add cpf integer;

alter table aluno 
	add constraint uk_cpf unique (cpf);
	
alter table aluno 
	alter column cpf set not null;

alter table aluno_disciplina
	drop column faltas;

alter table aluno_disciplina
	rename to notas;
	
alter table notas
	alter column media set not null;
	
alter table aluno
	rename to alunos;

alter table alunos
	drop rgm cascade;

drop table disciplina cascade;

drop table notas,alunos;
