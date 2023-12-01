-- Tabela Cliente
CREATE TABLE Cliente (
    cpf NUMERIC PRIMARY KEY,
    nome VARCHAR(100),
    endereco VARCHAR(200),
    telefone NUMERIC(11)
);

-- Tabela Peca
CREATE TABLE Peca (
    id INTEGER PRIMARY KEY,
    descricao VARCHAR(200),
    custo NUMERIC
);

-- Tabela Servico
CREATE TABLE Servico (
    id INTEGER PRIMARY KEY,
    descricao VARCHAR(200),
    custo NUMERIC,
    tempo INTEGER
);

-- Tabela Veiculo
CREATE TABLE Veiculo (
    renavan NUMERIC PRIMARY KEY,
    chassi VARCHAR(20) NOT NULL,
    placa VARCHAR(10) NOT NULL,
    modelo VARCHAR(50),
    cor VARCHAR(20),
    situacao VARCHAR(20),
    cliente_cpf NUMERIC NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY (cliente_cpf) REFERENCES Cliente(cpf)
);

-- Tabela RelatoCliente
CREATE TABLE RelatoCliente (
    id INTEGER PRIMARY KEY,
    problema VARCHAR(2000),
    data DATE,
    veiculo_renavan NUMERIC,
    CONSTRAINT fk_vaiculo_renavan FOREIGN KEY (veiculo_renavan) REFERENCES Veiculo(renavan)
);
	
-- Tabela Orcamento
CREATE TABLE Orcamento (
    id INTEGER PRIMARY KEY,
    valor NUMERIC,
    data DATE,
    situacao VARCHAR(20),
    mecanico VARCHAR(100),
    totalHoras INTEGER,
    previsaoEnt DATE,
    formaPag VARCHAR(50),
    veiculo_renavan NUMERIC,
    CONSTRAINT fk_veiculo_renavan FOREIGN KEY (veiculo_renavan) REFERENCES Veiculo(renavan)
);

-- Tabela ItemServico
CREATE TABLE ItemServico (
    orcamento INTEGER,
    servico INTEGER,
    situacao VARCHAR(20),
    PRIMARY KEY (orcamento, servico),
    CONSTRAINT fk_orcamento FOREIGN KEY (orcamento) REFERENCES Orcamento(id),
    CONSTRAINT fk_servico FOREIGN KEY (servico) REFERENCES Servico(id)
);

-- Tabela ItemPeca
CREATE TABLE ItemPeca (
    orcamento INTEGER,
    peca INTEGER,
    quantidade INTEGER,
    custoTotalPeca NUMERIC,
    situacao VARCHAR(20),
    PRIMARY KEY (orcamento, peca),
    FOREIGN KEY (orcamento) REFERENCES Orcamento(id),
    FOREIGN KEY (peca) REFERENCES Peca(id)
);


--1. Crie as tabelas apresentadas no Modelo Relacional. Utilize constraint para a
--indicação das chaves primárias e estrangeiras.

--2. Crie todas as sequences necessárias. 
create sequence seq_cliente;
create sequence seq_peca;
create sequence seq_veiculo;
create sequence seq_item_servico;
create sequence seq_relato;
create sequence seq_orcamento;
create sequence seq_servico;
create sequence seq_item_peca;

-- 3. Insira 3 registros em cada tabela. Preencha valores para todos os campos da tabela.
--Utilize as sequences criadas e insert com query quando necessário. 

select * from ItemPeca

insert into cliente values (11238901746,'Dereg','Rua Flores',11957082367);
insert into cliente values (11238931746,'Maria','Rua Garcia',11957085747);
insert into cliente values (11236901746,'Roma','Rua dolores',11957085767);

insert into Peca values (nextval('seq_peca'),'aaaaaaaaaa',20);
insert into Peca values (nextval('seq_peca'),'bbbbbbbbbb',40);
insert into Peca values (nextval('seq_peca'),'cccccccccc',10);

insert into Servico values (nextval('seq_servico'),'ahhaah',25,3);
insert into Servico values (nextval('seq_servico'),'aksjd',200,12);
insert into Servico values (nextval('seq_servico'),'mdsai9',100,20);

insert into Veiculo values (90218328671,'jsdj60','1102u','hb20','rosa','quebrado',(select cpf from Cliente where cpf =11238901746 ));
insert into Veiculo values (93728928671,'9012o','jdsa89','fox','azul','quebrado',(select cpf from Cliente where cpf =11238931746 ));
insert into Veiculo values (72893321012,'djnhbsa','21jjda','ruiz','preto','quebrado',(select cpf from Cliente where cpf =11238931746 ));

insert into RelatoCliente values (nextval('seq_relato'),'ndsaojdhiuhondjkbnidsahgdiusahduosa',
								 '2023-10-28',(select renavan from Veiculo where renavan =90218328671 ));
insert into RelatoCliente values (nextval('seq_relato'),'idjsaoiudhsiabdicsnb8',
								 '2023-10-01',(select renavan from Veiculo where renavan =93728928671 ));
insert into RelatoCliente values (nextval('seq_relato'),'dsaijhgdiuhsnaijkdhsaiubgv cdishdksanhiu',
								 '2023-10-30',(select renavan from Veiculo where renavan =72893321012 ));
insert into RelatoCliente values (nextval('seq_relato'),'CAIU DO BARRANCO',
								 '2023-10-30',(select renavan from Veiculo where renavan =90218328671 ));

insert into Orcamento values (nextval('seq_orcamento'),200,'2023-10-01','Vendido','Hoarez',90,'2023-10-10','Pix',
							  (select renavan from Veiculo where renavan = 90218328671));
insert into Orcamento values (nextval('seq_orcamento'),400,'2023-10-20','Vendido','Hoarez',120,'2023-11-01','Pix',
							  (select renavan from Veiculo where renavan = 90218328671));
insert into Orcamento values (nextval('seq_orcamento'),150,'2023-10-30','Vendido','Hoarez',20,'2023-11-22','Pix',
							  (select renavan from Veiculo where renavan = 90218328671));

insert into ItemServico values ((select id from Orcamento where id = 1),(select id from Servico where id = 1),'dhsauji');
insert into ItemServico values ((select id from Orcamento where id = 2),(select id from Servico where id = 2),'dhsauji');
insert into ItemServico values ((select id from Orcamento where id = 3),(select id from Servico where id = 3),'dhsauji');

insert into ItemPeca values ((select id from Orcamento where id = 1), (select id from Peca where id = 1), 20,450,'FDJIHFDSJI');
insert into ItemPeca values ((select id from Orcamento where id = 2), (select id from Peca where id = 2), 22,500,'FDJIHFDSJI');
insert into ItemPeca values ((select id from Orcamento where id = 3), (select id from Peca where id = 3), 5,120,'FDJIHFDSJI');

--4. Crie uma função que devolva um histórico dos problemas de um determinado
--veículo, em ordem cronológica, passando o renavan.

/* CRIANDO A FUNÇÃO */
create function devolver (numeric)
returns setof varchar as
'
	select r.problema
	from RelatoCliente r, Veiculo v
	where r.veiculo_renavan = v.renavan and v.renavan = $1
	order by v.renavan;
'
language 'sql';

/* UTILIZANDO A FUNÇÃO */
select devolver (90218328671)


--5. Crie uma função que devolva todos os veículos de um determinado cliente,
--passando o nome do cliente como parâmetro. 
	
create function consulta(varchar)
returns setof varchar as
'
	select v.modelo
	from Cliente c , Veiculo v
	where v.cliente_cpf = c.cpf and c.nome ilike $1
'
language 'sql';

select consulta('maria')

--6. Crie uma função que devolva todas as peças utilizadas em um determinado
--orçamento, ordenadas alfabeticamente, passando o código do orçamento como
--parâmetro. 

create function review (integer)
returns setof (varchar,integer) as
'
	select i.descricao,p.quantidade
	from ItemPeca p , Orcamento o , Peca i
	where p.orcamento = o.id and 
	p.peca = i.id and
	o.id = $1
	order by i.descricao;
'
language 'sql'; 

/* JEITO DO GPT */
create function review (integer)
returns table (descricao VARCHAR(200), quantidade INTEGER)
as
'
    select i.descricao, p.quantidade
    from ItemPeca p, Orcamento o, Peca i
    where p.orcamento = o.id and 
    p.peca = i.id and
    o.id = $1
    order by i.descricao;
'
language 'sql';

select review(2)