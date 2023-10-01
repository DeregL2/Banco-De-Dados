create table Cargo(
 codigo numeric(5),
 nome varchar(100) not null,
 salario_base numeric(10,2) not null,
 Constraint pk_cargo_cod Primary Key (codigo)
);
create table Cidade(
 codigo numeric(5),
 nome varchar(100) not null,
 Constraint pk_cidade_cod Primary Key (codigo)
);
create table Departamento(
 codigo numeric(5),
 nome varchar(100) not null,
 Constraint pk_depto_cod Primary Key (codigo)
);
create table Funcionario(
 codigo numeric(5),
 nome varchar(100) not null,
 telefone varchar(50) null,
 salario numeric(10,2) not null,
 cod_cargo numeric(5) not null,
 cod_cidade numeric(5) not null,
 cod_depto numeric(5) not null,
 gerente numeric(5),
 Constraint pk_func_cod Primary Key (codigo),
 Constraint fk_func_cargo Foreign Key(cod_cargo)
References Cargo(codigo),
 Constraint fk_func_cidade Foreign Key(cod_cidade)
References Cidade(codigo),
 Constraint fk_func_depto Foreign Key(cod_depto)
References Departamento(codigo),
 Constraint fk_func_gerente Foreign Key(gerente)
References Funcionario(codigo)
);
INSERT INTO cargo (codigo,nome,salario_base)
VALUES (1,'estagiario',800.00);
INSERT INTO cargo (codigo,nome,salario_base)
VALUES (2,'gerente',2000.00);
INSERT INTO cargo (codigo,nome,salario_base)
VALUES (3,'supervisor',1800.00);
INSERT INTO cargo (codigo,nome,salario_base)
VALUES (4,'encarregado',1500.00);
INSERT INTO cargo (codigo,nome,salario_base)
VALUES (5,'auxiliar',1000.00);
INSERT INTO cidade (codigo,nome) VALUES (1,'Mogi das Cruzes');
INSERT INTO cidade (codigo,nome) VALUES (2,'São Paulo');
INSERT INTO cidade (codigo,nome) VALUES (3,'Campinas');
INSERT INTO cidade (codigo,nome) VALUES (4,'São Jose dos Campos'); 
INSERT INTO departamento (codigo,nome) VALUES (1,'vendas');
INSERT INTO departamento (codigo,nome) VALUES (2,'compras');
INSERT INTO departamento (codigo,nome) VALUES (3,'PCP');
INSERT INTO departamento (codigo,nome) VALUES (4,'produção');
INSERT INTO funcionario(codigo, nome, telefone, salario,
cod_cargo, cod_cidade, cod_depto, gerente)
VALUES (1,'Antonio Leite','989 0999',10000.00,2,3,2,NULL);
INSERT INTO funcionario (codigo, nome, telefone, salario,
cod_cargo, cod_cidade, cod_depto, gerente)
VALUES (2,'Lucas Silva','8778 7878',7000.00,2,1,1,1);
INSERT INTO funcionario (codigo, nome, telefone, salario,
cod_cargo, cod_cidade, cod_depto, gerente)
VALUES (3,'Bruna Santos','899 9987', 2000.98, 3, 3, 4, 2);
INSERT INTO funcionario (codigo, nome, telefone, salario,
cod_cargo, cod_cidade, cod_depto, gerente)
VALUES (4,'Camila Rocha','987 554545',4000.98,4,2,1,1);
INSERT INTO funcionario (codigo, nome, telefone, salario,
cod_cargo, cod_cidade, cod_depto, gerente)
VALUES (5,'Dayna Santos','7655 6654',600.00,1,4,3,1);
INSERT INTO funcionario (codigo, nome, telefone, salario,
cod_cargo, cod_cidade, cod_depto, gerente)
VALUES (6,'Emerson Santos','899 99989',6000.98,2,3,4,2); 
/* 1. Mostrar o nome e o salário dos funcionários que recebem entre 6 e 8 mil. O resultado
deve aparecer em ordem crescente de salário. */

select nome, salario
from funcionario
where salario between 6000 and 8000
order by nome;

/* 2. Mostrar o nome o e cargo de todos os funcionários. O resultado deverá aparecer em
ordem crescente pelo nome do funcionário. 
*/

select f.nome,car.nome
from funcionario f, cargo car
where f.cod_cargo = car.codigo
order by f.nome;

/* 3. Mostrar o nome de todos os departamentos e seus respectivos funcionários.O
resultado deve aparecer em ordem alfabética por departamento e funcionário. */

select d.nome , f.nome
from funcionario f, departamento d
where f.cod_depto = d.codigo
order by d.nome;

/* 4. Mostrar o nome e o salário dos funcionários que trabalham no departamento de
compras. */

select f.nome, f.salario,d.nome
from funcionario f, departamento d
where f.cod_depto = d.codigo and d.nome = 'compras';

/* 5. Mostrar o nome do funcionário e o nome da cidade, apenas dos funcionários que
residem em cidades que possuem a palavra São no nome. */

select f.nome , cid.nome
from funcionario f, cidade cid
where f.cod_cidade = cid.codigo and cid.nome ilike '%são%';

/* 6. Qual o nome, salário e o cargo dos funcionários que moram em Campinas? O
resultado deve aparecer em ordem decrescente de salário. */

select f.nome, f.salario , car.nome
from funcionario f, cargo car , cidade cid
where 	f.cod_cargo = car.codigo and 
		f.cod_cidade = cid.codigo and
		cid.nome  ilike 'campinas'
order by f.salario desc;

/* 7.Mostrar o nome, a cidade onde mora, e o departamento onde trabalha dos funcionários
que são estagiários.*/

select f.nome, cid.nome ,dep.nome ,car.nome
from funcionario f , cidade cid, departamento dep, cargo car
where 	f.cod_cidade = cid.codigo and
		f.cod_depto = dep.codigo and
		f.cod_cargo = car.codigo and
		car.nome = 'estagiario';
		
/* 8. Mostrar o nome de todos os funcionários que são subordinados do gerente Antonio
Leite.O resultado deve aparecer em ordem alfabética.*/

select f.nome, f.gerente
from funcionario f
where f.gerente = 1
order by f.nome;

select * from funcionario;