DROP DATABASE IF EXISTS projeto_aula;
CREATE DATABASE projeto_aula;
USE projeto_aula;

CREATE TABLE produtora(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(150) NOT NULL UNIQUE
,descrição TEXT NOT NULL
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,CONSTRAINT pk_produtora PRIMARY KEY (id)
);

CREATE TABLE distribuidora(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(150) NOT NULL
,descrição TEXT NOT NULL 
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,CONSTRAINT pk_distribuidora PRIMARY KEY (id)
);

CREATE TABLE jogo(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(255) NOT NULL
,produtora_id INT NOT NULL
,distribuidora_id INT NOT NULL
,ano_publicacao CHAR(4) NOT NULL
,descricao TEXT
,genero VARCHAR(45) NOT NULL
,plataforma VARCHAR(45) NOT NULL
,media_notas DOUBLE
,media_tempo DOUBLE
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,CONSTRAINT pk_jogo PRIMARY KEY (id)
,CONSTRAINT fk_jogo_produtora FOREIGN KEY (produtora_id) REFERENCES produtora (id)
,CONSTRAINT fk_jogo_distribuidora FOREIGN KEY (distribuidora_id) REFERENCES distribuidora (id)
,CONSTRAINT jogo_unico UNIQUE(nome, ano_publicacao, produtora_id, distribuidora_id)
);

CREATE TABLE plano(
id INT NOT NULL AUTO_INCREMENT
,tipo VARCHAR(15) NOT NULL
,beneficios VARCHAR(200) NOT NULL
,CONSTRAINT pk_plano PRIMARY KEY (id)
);

CREATE TABLE usuario(
id INT NOT NULL AUTO_INCREMENT
,nick VARCHAR(20) NOT NULL UNIQUE
,nome VARCHAR(100) NOT NULL
,email VARCHAR(100) NOT NULL UNIQUE
,senha VARCHAR(40) NOT NULL
,descricao TEXT
,adminstrador ENUM('S','N') NOT NULL DEFAULT 'N'
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,plano_id INT NOT NULL
,CONSTRAINT pk_usuario PRIMARY KEY (id)
,CONSTRAINT fk_usario_plano FOREIGN KEY (plano_id) REFERENCES plano (id)
);

CREATE TABLE fpagamento(
id INT NOT NULL AUTO_INCREMENT
,descricao VARCHAR (100) NOT NULL
,duracao_plano VARCHAR(50) NOT NULL
,entrada ENUM('S','N') NOT NULL DEFAULT 'N'
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_fpagamento PRIMARY KEY (id)
);

CREATE TABLE venda(
id INT NOT NULL AUTO_INCREMENT
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,usuario_id INT NOT NULL
,fpagamento_id INT NOT NULL
,total_decimal DECIMAL(12,2)
,CONSTRAINT pk_venda PRIMARY KEY (id)
,CONSTRAINT fk_venda_usuario FOREIGN KEY (usuario_id) REFERENCES usuario (id)
,CONSTRAINT fk_venda_fpagamento FOREIGN KEY (fpagamento_id) REFERENCES fpagamento (id)
);

CREATE TABLE analise(
id INT NOT NULL AUTO_INCREMENT
,usuario_id INT NOT NULL
,jogo_id INT NOT NULL
,review TEXT
,tempo_jogo TIME NOT NULL DEFAULT '00:00:00'
,nota INT NOT NULL
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_analise PRIMARY KEY (id)
,CONSTRAINT fk_analise_usuario FOREIGN KEY (usuario_id) REFERENCES usuario (id)
,CONSTRAINT fk_analise_jogo FOREIGN KEY (jogo_id) REFERENCES jogo (id)
,CONSTRAINT nota_valida CHECK(nota<=10 AND nota>=0)
);

CREATE TABLE lista_de_preferencia(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(100) NOT NULL
,usuario_id INT NOT NULL
,jogo_id INT NOT NULL
,descrição TEXT
,comentario_item TEXT
,CONSTRAINT pk_lista PRIMARY KEY (id)
,CONSTRAINT fk_lista_usuario FOREIGN KEY (usuario_id) REFERENCES usuario (id)
,CONSTRAINT fk_lista_jogo FOREIGN KEY (jogo_id) REFERENCES jogo (id)
);

-- INSERINDO PRODUTORAS
INSERT INTO produtora(nome,descrição,ativo)
VALUES	('Gearbox Software', 'Gearbox Software, L.L.C. é uma empresa norte-americana de desenvolvimento de jogos, localizada em Plano, no Texas','S'); 
INSERT INTO produtora(nome,descrição,ativo)
VALUES	('Insomniac Games', 'A Insomniac Games, Inc. é uma desenvolvedora norte-americana de jogos eletrônicos sediada em Burbank, Califórnia.','S');
INSERT INTO produtora(nome,descrição,ativo)
VALUES	('Playground Games', 'Playground Games é uma desenvolvedora de jogos eletrônicos britânica localizada em Leamington Spa, no Reino Unido.','S'); 

-- INSERINDO DISTRIBUIDORAS
INSERT INTO distribuidora(nome,descrição,ativo) 
VALUES	('Sony Interactive Entertainment', 'A Sony Interactive Entertainment é uma desenvolvedora e publicadora multinacional de jogos eletrônicos e consoles','S'); 
INSERT INTO distribuidora(nome,descrição,ativo) 
VALUES	('Xbox Game Studios', 'Xbox Game Studios é uma divisão multinacional da Microsoft responsável por produzir e distribuir jogos eletrônicos para consoles e computadores','S');
INSERT INTO distribuidora(nome,descrição,ativo) 
VALUES	('2K', '2K é uma publicadora de jogos eletrônicos estadunidense baseada em Novato, Califórnia. A 2K foi fundada pela Take-Two Interactive em Janeiro de 2005 por meio das empresas 2K Games e 2K Sports, seguindo a aquisição pela Take-Two de uma empresa chamada Visual Concepts naquele mesmo mês.','S');

-- INSERINDO JOGOS
INSERT INTO jogo(nome,produtora_id,distribuidora_id,ano_publicacao,descricao,genero,plataforma,media_notas,media_tempo) 
VALUES	('Spider-Man', 2, 1,'2018','Spider-Man é um jogo eletrônico de ação-aventura desenvolvido pela Insomniac Games e publicado pela Sony Interactive Entertainment.','Aventura','PS5','4.5','18.00'); 
INSERT INTO jogo(nome,produtora_id,distribuidora_id,ano_publicacao,descricao,genero,plataforma,media_notas,media_tempo) 
VALUES	('Borderlands 3', 1, 3,'2019','Borderlands 3 é um jogo eletrônico de RPG de ação desenvolvido pela Gearbox Software e publicado pela 2K Games. É a sequência de Borderlands 2 e o quarto título principal da série Borderlands','Ação','PC','4.3','60.30');
INSERT INTO jogo(nome,produtora_id,distribuidora_id,ano_publicacao,descricao,genero,plataforma,media_notas,media_tempo) 
VALUES	('Forza Horizon 5', 3, 2,'2021','Forza Horizon 5 é um jogo eletrônico de corrida desenvolvido pela Playground Games e publicado pela Xbox Game Studios. É o quinto jogo da série Forza Horizon e o décimo segundo título principal da franquia Forza. O jogo se passa em uma representação ficcional do México.','Corrida','Xbox Series X','4.8','30.00');

-- INSERINDO PLANO
INSERT INTO plano(tipo,beneficios)
VALUES ('Normal','Nenhum');
INSERT INTO plano(tipo,beneficios)
VALUES ('Pro','Sem anuncios e estatisticas personalizadas');
INSERT INTO plano(tipo,beneficios)
VALUES ('VIP','Sem anuncios, estatisticas personalizadas, acessao a noticias, imagem de fundo do perfil personalidade e mais');

-- INSERINDO USUÁRIOS
INSERT INTO usuario(nick,nome,email,senha,descricao,plano_id)
VALUES('aortaluis','Luís','veda_cremin@yahoo.com','1yH31@',NULL,1);
INSERT INTO usuario(nick,nome,email,senha,descricao,plano_id)
VALUES('jourgelio','Mateus','maximus.nikolaus@yahoo.com','W53w5M^39$3','Olá, estou usando este aplicativo!',3);
INSERT INTO usuario(nick,nome,email,senha,descricao,adminstrador,plano_id) -- INSERINDO UM ADMINSTRADOR
VALUES('tsaslalom','Diana','alycia_smith@yahoo.com','WX&35r$5e4uCc1Yx','Always trust computer games.','S',2);

-- INSERINDO FORMAS DE PAGAMENTOS
INSERT INTO fpagamento(descricao,duracao_plano)
VALUES('Cartão de credito','1 mês');
INSERT INTO fpagamento(descricao,duracao_plano)
VALUES('Cartão de credito','3 meses');
INSERT INTO fpagamento(descricao,duracao_plano)
VALUES('Cartão de credito','1 ano');
INSERT INTO fpagamento(descricao,duracao_plano)
VALUES('PIX','1 meses');
INSERT INTO fpagamento(descricao,duracao_plano)
VALUES('PIX','3 meses');
INSERT INTO fpagamento(descricao,duracao_plano)
VALUES('PIX','1 Ano');

-- INSERINDO VENDAS
INSERT INTO venda(usuario_id,fpagamento_id,total_decimal)
VALUES (2,3,180.00);
INSERT INTO venda(usuario_id,fpagamento_id,total_decimal)
VALUES (3,4,60.00);


-- INSERINDO ANÁLISE
INSERT INTO analise(usuario_id,jogo_id,review,tempo_jogo,nota,data_cadastro)
VALUES (1, 3,'Vrum Vrum','65:30:00',10,'2019-09-10');
INSERT INTO analise(usuario_id,jogo_id,review,tempo_jogo,nota,data_cadastro)
VALUES (2, 2,'Loot shooter perdido no tempo','36:10:10',7,'2021-12-14');
INSERT INTO analise(usuario_id,jogo_id,review,tempo_jogo,nota,data_cadastro)
VALUES (3, 1,'O amigão da vizinhança brilhou','19:26:01',9,'2022-08-09');

-- INSERINDO LISTAS
INSERT INTO lista_de_preferencia(nome,usuario_id,jogo_id,descrição,comentario_item)
VALUES ('Melhores jogos 2020',1,1,NULL,NULL);
INSERT INTO lista_de_preferencia(nome,usuario_id,jogo_id,descrição,comentario_item)
VALUES ('Melhores jogos 2020',1,2,NULL,NULL);
INSERT INTO lista_de_preferencia(nome,usuario_id,jogo_id,descrição,comentario_item)
VALUES ('Melhores jogos 2020',1,3,NULL,NULL);

-- Consulta Produtoras
SELECT
	p.nome 'Nome'
	,p.descrição 'Descrição'
    ,j.nome 'Jogos Produzidos'
    ,j.ano_publicacao 'Ano de Lançamento'
FROM 
	produtora p, jogo j
WHERE j.produtora_id = p.id;

-- Consulta Distribuidoras
SELECT
	d.nome 'Nome'
	,d.descrição 'Descrição'
    ,j.nome 'Jogos Distribuidos'
    ,j.ano_publicacao 'Ano de Lançamento'
	,p.nome 'Desenvolvido por'
FROM 
	distribuidora d, jogo j, produtora p
WHERE j.distribuidora_id = d.id
AND p.id = j.produtora_id;

-- Consulta Jogos
SELECT
	j.nome 'Nome do Jogo'
    ,j.ano_publicacao 'Ano de Publicação'
    ,p.nome 'Nome da Produtora'
    ,d.nome 'Nome da Distribuidora'
FROM jogo j, produtora p, distribuidora d
WHERE p.id = j.produtora_id
AND d.id = j.distribuidora_id;

-- Consulta Planos
SELECT
	*
FROM 
	plano;

-- Consulta Usuários
SELECT
	*
FROM 
	usuario;

-- Consulta Formas de Pagamentos
SELECT
	*
FROM 
	fpagamento;

-- Consulta Vendas
SELECT
	*
FROM 
	venda;

-- Consulta Análises
SELECT
	u.nome 'Usuario'
	,j.nome 'Jogo'
    ,j.ano_publicacao 'Ano de Publicação'
    ,a.review 'Considerações'
    ,a.tempo_jogo 'Tempo de Jogo'
	,a.nota 'Nota'
	,a.data_cadastro 'Data término'
FROM usuario u, analise a, jogo j
WHERE u.id = a.usuario_id
AND j.id = a.jogo_id;

-- Consulta Listas
SELECT
	u.nome 'Criador da Lista'
    ,l.nome 'Nome da Lista'
    ,j.nome 'Nome do Jogo'
FROM 
	lista_de_preferencia l, usuario u, jogo j
WHERE u.id = l.usuario_id
AND j.id = l.jogo_id;
