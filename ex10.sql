/*1) Crie as tabelas equivalentes ao MER abaixo:*/

create table aluno(
	rgm integer primary key not null,
	nome varchar(100) not null,
	dt_nasc date not null
);

create table disciplina(
	codigo integer primary key not null,
	nome varchar(100) not null,
	numero_creditos integer
); 

create table cursa(
	p1 numeric(3,1),
	p2 numeric(3,1),
	media numeric(3,1),
	faltas integer,
	cod_curso integer,
	cod_disp integer,
	cod_aluno integer,
	constraint pk_cod_curso primary key(cod_disp,cod_aluno),
	constraint fk_cod_disp foreign key (cod_disp) references disciplina (codigo),
	constraint fk_cod_aluno foreign key (cod_aluno) references aluno (rgm)
);

/*2) Insira, pelo menos, 5 tuplas em cada uma das tabelas criadas. Na tabela cursa, deixe
a coluna media vazia.*/

select * from aluno;
insert into aluno values (11231103,'Derick','2002-11-02');
insert into aluno values (11231104,'Jão','2004-11-20');
insert into aluno values (11231105,'Livia','2005-12-13');
insert into aluno values (11231106,'Alyne','2002-09-04');
insert into aluno values (11231107,'Pedro','2010-10-02'); 

select * from disciplina;
insert into disciplina values (1,'matemática',500);
insert into disciplina values (2,'português',1000);
insert into disciplina values (3,'ciência',350);
insert into disciplina values (4,'biologia', 100);
insert into disciplina values (5,'inglês',250); 

select * from cursa;
insert into cursa values (5,5,null,20,1,3,11231103);
insert into cursa values (5,4,null,13,2,2,11231104);
insert into cursa values (10,8,null,19,3,2,11231105);
insert into cursa values (7,6,null,10,4,3,11231106);
insert into cursa values (8,10,null,5,5,5,11231107);

/* 3) Escreva o comando SQL que calcula e atualiza o valor da coluna media. Considere
uma média aritmética. */

update cursa
set media = (p1+p2)/2

/* 4) Faça as alterações necessárias para que a coluna nome, de cada tabela, seja de
preenchimento obrigatório. */

alter table aluno alter nome set not null

alter table disciplina alter nome set not null

/* 5) Escreva o comando que exibe uma listagem contendo: o nome e o número de créditos
de todas as disciplinas cadastradas. Esta listagem deve aparecer em ordem decrescente
pelo número de créditos e em ordem alfabética. */

select nome,numero_creditos
from disciplina
order by numero_creditos desc, nome asc

/* 6) Adicione na tabela Aluno a coluna telefone. Esta coluna deve receber apenas
números. */

alter table aluno add column telefone numeric(11);

/* 7) Para cada aluno inserido, inclua seu número de telefone */

update aluno
set telefone = '11917085767'
where rgm = 11231107

/* 8) Na tabela Aluno, modifique o nome da coluna dt_nasc para nascimento. */

alter table aluno rename dt_nasc to nascimento

/* 9) Na tabela Disciplina, remova a coluna numero_creditos. */

alter table disciplina drop column numero_creditos

/* 10) Crie uma tabela chamada USUARIO. Esta tabela deverá armazenar, além da chave
primária, o código do aluno, o login, a senha e o nível de acesso (nível 1, 2 ou 3). Cada
aluno poderá ter mais de um usuário, porém de níveis de acesso diferentes. */

create table usuario(
	codigo integer primary key not null,
	cod_aluno integer not null,
	login varchar(100) not null,
	senha varchar(150)not null,
	nivel integer check (nivel in (1,2,3)),
	constraint fk_cod_aluno foreign key(cod_aluno) references aluno (rgm),
	constraint uk_nivel unique (cod_aluno,nivel)
);

/* 12) Escreva o comando que exibe uma listagem contendo: o nome e o telefone de todos
os alunos. Esta listagem deve aparecer em ordem alfabética. */

select a.nome, a.telefone
from aluno a
order by a.nome

/* 13) Insira na tabela Usuario uma tupla referente a cada aluno cadastrado. */

insert into usuario values (6,11231103,'21','123',3);
insert into usuario values (7,11231104,'27','124',3);
insert into usuario values (8,11231105,'26','125',3);
insert into usuario values (4,11231106,'25','126',1);
insert into usuario values (5,11231107,'22','127',1);

/* 14) Escreva o comando que exibe o RGM e o login dos alunos com acesso de nível 3.
O resultado deve estar em ordem crescente de RGM */

select a.rgm, u.login
from aluno a, usuario u
where u.cod_aluno = a.rgm and u.nivel = 3
order by a.rgm;

/* 15) Escreva o comando que exibe uma listagem contendo: o nome de cada disciplina e
a quantidade de alunos que a cursa. O resultado deve aparecer em ordem alfabética
pelo nome da disciplina. */

select d.nome, count(*) as qtdalunos
from disciplina d, cursa c
where c.cod_disp = d.codigo
group by d.nome
order by d.nome

/* 16) Escreva o comando que exibe uma listagem contendo: o nome de cada disciplina e
a média obtida pelos alunos que a cursam. O resultado deve aparecer em ordem
alfabética pelo nome da disciplina. */

select d.nome,a.nome,c.media
from disciplina d, cursa c, aluno a
where c.cod_aluno = a.rgm and c.cod_disp = d.codigo
order by d.nome,a.nome asc;

select d.nome, avg(c.media) as mediageral
from disciplina d, cursa c
where c.cod_disp = d.codigo
group by d.nome
order by d.nome;

/* 17) Na tabela Usuario, apague todos os registros dos usuários de acesso nível 1. */

delete from usuario
where nivel = 1

/* 18) Apague todas as tabelas criadas. */
