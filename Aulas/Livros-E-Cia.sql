-- Criação do banco de dados
CREATE DATABASE LivrosECia;
 
-- Conecte-se manualmente ao banco 'LivrosECia' depois de criá-lo
 
-- Tabela Cliente (sem coluna gerada para Idade)
CREATE TABLE Clientes (
    ID_Cliente SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Rua VARCHAR(100) NOT NULL,
    Cidade VARCHAR(50) NOT NULL,
    CEP VARCHAR(10) NOT NULL,
    Data_Nascimento DATE NOT NULL,
    Idade INT  -- Coluna normal (não gerada)
);
 
-- Tabela Livro
CREATE TABLE Livros (
    ID_Livro SERIAL PRIMARY KEY,
    Título VARCHAR(100) NOT NULL,
    Autor VARCHAR(100) NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL,
    Categoria VARCHAR(50) NOT NULL
);
 
-- Tabela Pedido
CREATE TABLE Pedidos (
    ID_Pedido SERIAL PRIMARY KEY,
    Data_Pedido DATE NOT NULL,
    Valor_Total DECIMAL(10, 2) NOT NULL,
    ID_Cliente INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);
 
-- Tabela Item_Pedido
CREATE TABLE Itens_Pedido (
    ID_Item SERIAL PRIMARY KEY,
    Quantidade INT NOT NULL,
    Preco_Unitario DECIMAL(10, 2) NOT NULL,
    ID_Pedido INT,
    ID_Livro INT,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID_Pedido),
    FOREIGN KEY (ID_Livro) REFERENCES Livros(ID_Livro)
);

INSERT INTO Clientes (Nome, Rua, Cidade, CEP, Data_Nascimento) VALUES
('Ana Silva', 'Rua das Flores, 123', 'São Paulo', '01001-000', '1985-05-15'),
('Carlos Pereira', 'Avenida Paulista, 456', 'São Paulo', '0130-000', '1990-08-22'),
('Mariana Costa', 'Rua dos pinheiros, 789', 'Rio de Janeiro', '20040-000', '1978-11-30');

INSERT INTO Livros (Título, Autor, Preco, Categoria) VALUES
('O Senhor dos Anéis', 'J.R.R. Tolkien', 59.90, 'Fantasia'),
('1984', 'George Orwell', 39.90, 'Ficção Científica'),
('Dom Casmurro', 'Machado de Assis', 29.90, 'Romance'); 

INSERT INTO Pedidos (Data_Pedido, Valor_Total, ID_Cliente) VALUES
('2025-02-01', 99.80, 1),
('2025-02-05', 29.90, 2),
('2025-02-10', 59.99, 3);

INSERT INTO Itens_Pedido (Quantidade, Preco_Unitario, ID_Pedido, ID_Livro) VALUES
(1, 59.90, 1, 1),
(1, 39.90, 1, 2),
(1, 29.90, 2, 3), 
(2, 29.95, 3, 1);
  

drop table clientes, livros, pedidos, itens_pedido;