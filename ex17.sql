CREATE TABLE Cliente (
    id INTEGER PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    telefone VARCHAR(15) NOT NULL
);

CREATE TABLE Genero (
    id INTEGER PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE Tipo (
    id INTEGER PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    valor NUMERIC(10, 2) NOT NULL,
    qtd_dias INTEGER NOT NULL
);

CREATE TABLE Filme (
    id INTEGER PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    duracao INTEGER NOT NULL,
    sinopse TEXT NOT NULL,
    ano_lancamento INTEGER NOT NULL,
    genero INTEGER REFERENCES Genero(id),
    tipo INTEGER REFERENCES Tipo(id)
);

CREATE TABLE Dependente (
    id INTEGER PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    responsavel INTEGER REFERENCES Cliente(id)
);

CREATE TABLE Locacao (
    id INTEGER PRIMARY KEY,
    cliente INTEGER REFERENCES Cliente(id),
    filme INTEGER REFERENCES Filme(id),
    dt_locacao DATE NOT NULL,
    dt_prev_entrega DATE NOT NULL,
    dt_entrega DATE,
    total NUMERIC(10, 2) NOT NULL
);
--2. Crie todas as sequences necessárias.

create sequence seq_cli;
create sequence seq_gen;
create sequence seq_tipo;
create sequence seq_filme;
create sequence seq_depen;
create sequence seq_loc;

/* 3. Insira 3 registros em cada tabela. Preencha valores para todos os campos da tabela.
Utilize as sequences criadas e insert com query quando necessário. */

select * from Locacao
select * from Cliente
select * from Genero
select * from Tipo
select * from Filme
select * from Dependente

insert into Cliente values (nextval('seq_cli'),'Dereg',98274659018,'Rua Pires',957085767);
insert into Cliente values (nextval('seq_cli'),'Maria',82981237827,'Rua ipiranga',902193091);
insert into Cliente values (nextval('seq_cli'),'Jorge',82309138209,'Rua Marive',283490284);

insert into Genero values (nextval('seq_gen'),'Romance');
insert into Genero values (nextval('seq_gen'),'Terror');
insert into Genero values (nextval('seq_gen'),'Gore');

insert into Tipo values (nextval('seq_tipo'),'Livre',20,6);
insert into Tipo values (nextval('seq_tipo'),'+18',27,30);
insert into Tipo values (nextval('seq_tipo'),'+12',30,14);

insert into Filme values (nextval('seq_filme'),'Meu Malvado Fav',120,'Blá blá blá',2024,(select id from Genero where id = 1),
						  (select id from Tipo where id=1));
insert into Filme values (nextval('seq_filme'),'Harry Potter',160,'AHAHAH',2024,(select id from Genero where id = 2),
						 (select id from Tipo where id = 3));
insert into Filme values (nextval('seq_filme'),'Múmia',95,'AKOAKOAKAOAKO',2006,(select id from Genero where id = 3),
						 (select id from Tipo where id = 2));

insert into Dependente values (nextval('seq_depen'),'Jullia',(select id from Cliente where id = 1));
insert into Dependente values (nextval('seq_depen'),'Patricia',(select id from Cliente where id = 2));
insert into Dependente values (nextval('seq_depen'),'Larissa',(select id from CLiente where id = 3));

insert into Locacao values (nextval('seq_loc'),(select id from Cliente where id = 1),(select id from Filme where id = 1),
						   '2023-10-20','2023-10-30','2023-11-01',20);
insert into Locacao values (nextval('seq_loc'),(select id from Cliente where id = 2),(select id from Filme where id = 2),
						   '2023-12-20','2023-01-30','2023-02-20',40);
insert into Locacao values (nextval('seq_loc'),(select id from Cliente where id = 3),(select id from Filme where id = 3),
						   '2023-12-20','2023-01-31','2023-09-02',90);
						   
						   

--4. Crie uma função para inserir um novo filme. Todos os dados do filme devem ser
--passados como parâmetro, acompanhados dos nomes do gênero e tipo. 


select * from tipo
update filme
set tipo = 6
where id = 7

create or replace function inserir_filme(tit varchar, dur integer , sin text, ano_la integer, genero_int integer, tipo_t integer)
returns void as
$$
	insert into Filme values(nextval('seq_filme'),tit,dur,sin,ano_la,genero_int, tipo_t);
	
$$
language 'sql';
drop function inserir_filme

--5. Insira um novo filme utilizando a função criada no exercício 4.
select inserir_filme('Reunião',120,'disjaidjsa',2025,4,4)

--6. Crie uma função que devolva a quantidade de dias que um filme pode ficar com o
--cliente, passando o nome do filme.

create or replace function qtd_de_dias(varchar)
returns integer as
$$
	select t.qtd_dias 
	from Filme f, Tipo t
	where f.tipo = t.id and f.titulo = $1
$$
language 'sql'

select qtd_de_dias ('Múmia')
