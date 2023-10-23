/* 1) Criar as tabelas abaixo, com todas as restrições de chave primária e estrangeira. 
*/

create table departamento(
	codigo integer not null primary key,
	nome varchar(100) not null 
); 

create table cidade(
	codigo integer not null primary key,
	nome varchar (100) not null
);

create table cargo(
	codigo integer not null primary key,
	nome varchar(100) not null,
	salario_base numeric(10,2)
); 

create table funcionario (
	codigo integer not null primary key,
	nome varchar (100) not null,
	telefone integer not null,
	cod_depto integer not null,
	salario numeric(10,2),
	cod_cidade integer not null,
	cod_cargo integer not null,
	constraint fk_cod_depto foreign key (cod_depto) references departamento (codigo),
	constraint fk_cod_cidade foreign key(cod_cidade) references cidade (codigo),
	constraint fk_cod_cargo foreign key (cod_cargo) references cargo (codigo)
);

/* 2) Inserir no mínimo 5 tuplas em cada tabela. Observe as consultas que serão
realizadas para inserir dados compatíveis com as mesmas.  */

select * from departamento

insert into departamento values (1,'compra');
insert into departamento values (2,'venda');
insert into departamento values (3,'loja');
insert into departamento values (4,'recebimento');
insert into departamento values (5,'estoque');

select * from cidade

insert into cidade values (1,'poá');
insert into cidade values(2,'mogi');
insert into cidade values(3,'ferraz');
insert into cidade values(4,'sao paulo');
insert into cidade values(5,'poá');

select * from cargo

insert into cargo values (1,'comprador',3000);
insert into cargo values (2,'vendedor',2500);
insert into cargo values (3,'loja',3000);
insert into cargo values (4,'recebimento',4200);
insert into cargo values (5,'estoque',1000);

select * from funcionario

insert into funcionario values (1,'maria',119582190,1,null,2,1);
insert into funcionario values (2,'boberto',119582191,2,5000,5,4);
insert into funcionario values (3,'isa',119582192,3,1000,4,2);
insert into funcionario values (4,'joao',119582193,4,8000,3,3);
insert into funcionario values (5,'ricardo',119582194,5,10000,1,5);

/* 3) Atualizar salário dos funcionários para 10% de aumento */

update funcionario
set salario = salario * 1.10;

select * from funcionario where salario = salario order by salario

/* 4) Mostrar os funcionários que ganham mais que 1000. */

select nome, salario
from funcionario
where salario >= 1000;

/* 5) Mostrar o número de funcionários que possuem salário menor que 500 */

select count (*)
from funcionario
where salario < 500;

/* 6) Mostrar a média dos salários de todos funcionários. */

select avg(salario)
from funcionario;

/*7) Mostrar a média dos salários dos funcionários que ganham menos que 1000. */

select avg(salario)
from funcionario
where salario <1000;

/* 8) Retornar o salário máximo dos funcionários. */

select max(salario)
from funcionario;

/* 9) Retornar o salário mínimo dos funcionários.  */

select min(salario)
from funcionario;

/* 10) Contar o número de funcionários. */

select count(*)
from funcionario

/* 11) Mostrar a soma de todos os salários.  */

select sum(salario)
from funcionario

/* 12) Mostrar a soma de todos os salários agrupados por departamento. */

select d.nome, sum(f.salario)
from departamento d, funcionario f
where f.cod_depto = d.codigo
group by d.nome;

/* 13) Listar os funcionários em ordem alfabética A/Z.*/

select nome
from funcionario
order by nome

/* 14) Listar os funcionários em ordem alfabética Z/A.*/

select nome
from funcionario
order by nome desc

/* 15) Listar o total de todos funcionários que possuem salário maior que 200. */

select count(*)
from funcionario
where salario > 200

/* 16) Contar todos os funcionários que possuem salário maior que 200 que pertencem ao
departamento 1. */

select count (*)
from funcionario
where salario > 200 and cod_depto = 1

/* 17) Mostrar o nome e o salário dos funcionários que ganham mais que a média de
todos os salários. */

select nome, salario
from funcionario
where salario > (select avg(salario)
from funcionario);