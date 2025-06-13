create database Index_Transaction_ACID;
use Index_Transaction_ACID;
 

create table clientes
(
id int auto_increment primary key,
nome varchar(100),
email varchar(100)
);
 
create table contas
(
id int auto_increment primary key,
cliente_id int,
saldo decimal(10,2),
foreign key (cliente_id) references clientes(id)
);
 
create table transacoes
(
id int auto_increment primary key,
conta_id int,
valor decimal(10,2),
tipo_transacao varchar(10),
data_transacao datetime,
foreign key (conta_id) references contas(id)
);
 
Insert into clientes (nome,email) values
("João Silva", "joao@email.com"),
("Maria Santos", "maira@email.com"),
("Carlos Pereira", "carlos@email.com");
 
insert into contas (cliente_id,saldo) values
(1,1000),
(2,500),
(3, 1200);
 
insert into transacoes (conta_id, valor, tipo_transacao, data_transacao) values
(1, 500,'deposito', '2024-09-18 10:00:00'),
(1, 200,'saque', '2024-09-18 11:00:00'),
(1, 30,'deposito', '2024-09-18 12:00:00');
 
#INDEX
/* Suponha que você faça muitas consultas na base de dados, baseada em nome.
Um indice na coluna nome ira acelerar esses consultas.*/
 
#Consulta sem Index
select * from clientes where nome='João Silva';
 
#Criando Index para coluna nome
Create index idx_cliente_nome on clientes(nome);
 
#Consulta com Index
select * from clientes where nome='João Silva';
 
# Index em colunas para busca complexa
/*Se as consultas frequentemente buscam por combinações de saldo e cliente_id, 
deve criar um indice composto pode melhorar o desempenho.*/
 
#Consulta sem Index
Select * from contas where cliente_id=1 and saldo >500;
 
#Criar o Index
create index idx_cliente_saldo on contas(cliente_id,saldo);
 
#Consulta com Index
Select * from contas where cliente_id=1 and saldo >500;
 
#Index para melhorar o Order By
/* Ao usar a cláusula Order By em uma coluna especifíca, o uso de indice 
pode acelerar o processo de ordenação. */
 
-- Consulta com Order By sem Index
select * from transacoes order by data_transacao DESC;
 
-- Crinado o Index
create index idx_transacoes_data on transacoes(data_transacao);

#Transações (Transaction)
-- EXemplo 1 - Transferência entre contas
select * from contas;

start transaction;
Update contas set saldo = saldo - 100 where id = 1; #Retirada de dinheiro
Update contas set saldo = saldo  + 800 where id = 2; #Depósito de dinheiro 
commit;

#Transação com erro
start transaction;
update contas set saldo = saldo - 100 where id = 1; #Retirada
select * from contas;
rollback;

#Exemplo 3: Inserção de uma nova transação com saldo atualizado.
/*Quando im deposito é, tanto na tabela contas quanto na tabela transações,
precisam ser atualizadas simultaneamente*/

Start transaction;
update contas set saldo=saldo + 200 where id=1;
insert into transacoes(conta_id, valor, tipo_transacao, data_transacao)
values (1, 200, 'deposito', now());
commit;

Select * from contas;
Select * from transacoes;
