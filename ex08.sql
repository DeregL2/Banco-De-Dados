create table cliente(
 numero integer,
 nome varchar(100) not null,
 endereco varchar(200) not null,
 constraint pk_cli primary key (numero)
);

create table carro (
 registro integer,
 marca varchar(50) not null,
 modelo varchar(50) not null,
 cor varchar(50) not null,
 constraint pk_carro primary key (registro)
);

create table apolice (
 numero integer,
 valor numeric(10,2) not null check (valor > 0),
 dt_inicio date not null,
 dt_fim date not null,
 num_cliente integer not null,
 reg_carro integer not null,
 constraint pk_apolice primary key (numero),
 constraint fk_apolice_cli foreign key (num_cliente)
 references cliente(numero),
 constraint fk_apolice_car foreign key (reg_carro)
 references carro(registro)
);

create table acidente (
 codigo integer,
 data date not null,
 hora time not null,
 local varchar(200) not null,
 constraint pk_acidente primary key (codigo)
);

create table apolice_acidente(
 num_apolice integer,
 cod_acidente integer,
 constraint pk_ap_ac primary key (num_apolice,cod_acidente),
 constraint pk_ac_apolice foreign key (num_apolice)
 references apolice(numero),
 constraint pk_ac_acidente foreign key (cod_acidente)
 references acidente(codigo)
);

insert into cliente values (1,'Maria','Rua A');
insert into cliente values (2,'Ricardo','Rua B');
insert into cliente values (3,'Lucas','Rua C');
insert into cliente values (4,'Vanessa','Rua D');
insert into cliente values (5,'Aline','Rua E'); 

insert into carro values (10,'Fiat','Uno','Vermelho');
insert into carro values (20,'Fiat','Strada','Prata');
insert into carro values (30,'Honda','Civic','Cinza');
insert into carro values (40,'Honda','Fit','Branco');
insert into carro values (50,'Hyundai','HB20','Grafite');

insert into apolice
 values (1,5000.00,'2023-01-10','2024-01-09',1,50);
insert into apolice
 values (2,2500.00,'2023-04-10','2024-04-09',2,20);
insert into apolice
 values (3,8750.00,'2023-02-21','2024-02-20',2,30);
insert into apolice
 values (4,15789.00,'2023-03-18','2024-03-17',4,10);
insert into apolice
 values (5,4580.00,'2023-04-23','2024-04-22',3,50);
 
insert into acidente
 values (100,'2023-05-01','10:32:00','Rua Azul');
insert into acidente
 values (200,'2023-04-20','08:30:00','Rua Branca');
insert into acidente
 values (300,'2023-04-11','11:12:00','Rua Rosa');
insert into acidente
 values (400,'2023-05-17','15:00:00','Rua Verde');
insert into acidente
 values (500,'2023-04-25','10:02:00','Rua Amarela');
 
insert into apolice_acidente values (1,100);
insert into apolice_acidente values (5,100);
insert into apolice_acidente values (2,500);
insert into apolice_acidente values (3,300);
insert into apolice_acidente values (4,200);
insert into apolice_acidente values (5,400);

/* 1. Escreva o comando SQL que exiba marca e modelo de todos os carros de cor
vermelho cadastrados. A lista deve estar ordenada em ordem alfabética pela marca e modelo.*/

select c.marca, c.modelo , c.cor
from carro c
where c.cor ilike 'vermelho'
order by c.marca,c.modelo;

/* 2. Escreva o comando SQl que exiba o local de todos os acidentes ocorridos no mês de
maio de 2023.*/

select local, data
from acidente 
where data between '2023-05-01' and '2023-05-31';

/*3. Escreva o comando SQl que exiba o número de cada apólice juntamente com o nome
do cliente que a possui e o valor da mesma. Apresentar as apólices mais caras primeiro. */

select a.numero,cli.nome,a.valor
from apolice a, cliente cli
where a.num_cliente = cli.numero
order by a.valor desc

/* 4. Escreva o comando SQL que exiba o número de cada apólice, o nome do cliente e a
marca do veículo segurado, das apólices com início no mês de abril de 2023. O resultado deve
estar ordenado em ordem crescente pelo nome do cliente.*/

select a.numero, cli.nome, c.marca, a.dt_inicio
from apolice a, cliente cli, carro c
where 	a.num_cliente = cli.numero and 
		a.reg_carro = c.registro and
		a.dt_inicio between '2023-04-01' and '2023-04-30'
order by cli.nome

/* 5. Escreva o comando SQL que exiba data, horário e local, dos acidentes envolvendo o
HB20 grafite. A lista deverá estar ordenada pela data e horário do acidente. */

select a.data, a.hora, a.local
from acidente a, apolice_acidente aa,apolice ap, carro c
where a.codigo = aa.cod_acidente
	and aa.num_apolice = ap.numero
	and ap.reg_carro = c.registro
	and c.marca = 'Hyundai'
	and c.modelo = 'HB20'
	and c.cor = 'Grafite'
Order by a.data,a.hora

/*6. Escreva o comando SQL que exiba a marca do veículo, o nome do cliente e o número
das apólices de todos os acidentes ocorridos no mês de maio de 2023. */

select c.marca, cli.nome, a.numero 
from carro c, cliente cli, apolice a, acidente aci, apolice_acidente aa
where aci.codigo = aa.cod_acidente and
	aa.num_apolice = a.numero and
	a.reg_carro = c.registro and
	a.num_cliente = cli.numero
	and aci.data between '2023-05-01' and '2023-05-31'
