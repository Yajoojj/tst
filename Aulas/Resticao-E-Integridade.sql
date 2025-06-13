create database bd_restricao_integridade;
use bd_restricao_integridade;

create table Clientes
(
cliente_id int auto_increment primary key,
cpf varchar (11) unique not null, # garante que o atributo seja unico
nome varchar (100) not null, # garante que o atributo seja obrigatório
email varchar(100) unique not null
);

create table pedidos
(
pedido_id int auto_increment primary key,
cliente_id int not null,
data_pedido datetime default current_timestamp, # insere data e hora atual
constraint fk_idCliente_pedidos foreign key (cliente_id) references Clientes(cliente_id)
on delete cascade # permite a exclusão do pedido sempre que o cliente for excluido,on update
);

create table produtos 
(
produto_id int auto_increment primary key,
nomeProd varchar (50) not null,
preco double (10,2) not null,
estoque int(3) not null
);

CREATE TABLE Item_Pedidos (
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade >0),
    PRIMARY KEY (pedido_id, produto_id),  
    CONSTRAINT fk_pedido_item FOREIGN KEY (pedido_id) 	REFERENCES Pedidos(pedido_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_produto_item FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id) ON DELETE RESTRICT ON UPDATE CASCADE
    );


/* Alteração na estrutura da tabela */
ALTER TABLE produtos
ADD CONSTRAINT chk_preco CHECK (preco > 0),
ADD CONSTRAINT chk_estoque CHECK (estoque > 0),
ADD COLUMN categoria ENUM('Eletronico', 'Vestuário', 'Alimento') NOT NULL DEFAULT 'Eletronico';

ALTER TABLE Clientes
ADD COLUMN data_nascimento DATE NOT NULL,
ADD CONSTRAINT chk_dtNasc_valida CHECK (data_nascimento BETWEEN '1900-01-01' AND CURDATE()),
ADD CONSTRAINT chk_formato_email CHECK (email LIKE '%_@__%.__%');


#NAO PODE DELETAR OS PEDIDOS NEM OS PRODUTOS
#TEM QUE VERIFICAR A QUANTIDADE +0

