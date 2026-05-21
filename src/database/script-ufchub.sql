CREATE DATABASE db_ufchub;
USE db_ufchub;

CREATE TABLE usuario (
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(100)
);

SELECT * FROM usuario;

CREATE TABLE lutador (
	id_lutador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    apelido VARCHAR(100),
    nacionalidade VARCHAR(50),
    dt_nascimento DATE,
    altura DECIMAL(3,2),
    peso DECIMAL(4,1),
    alcance DECIMAL(3,2),
    base_luta VARCHAR(15),
    imagem VARCHAR(255),
    posicao_ranking INT,
    campeao BOOLEAN,
    fk_categoria INT,
	FOREIGN KEY (fk_categoria) REFERENCES categoria (id_categoria),
    CONSTRAINT ch_base_luta CHECK (base_luta IN ('Destro', 'Canhoto', 'Ambidestro'))
);

SELECT l.nome, l.apelido, l.nacionalidade, l.dt_nascimento, l.altura, l.peso, 
l.alcance, l.base_luta, l.imagem, l.posicao_ranking, l.campeao, c.nome 
FROM lutador l JOIN categoria c ON l.fk_categoria = c.id_categoria
WHERE id_lutador = 1;

INSERT INTO lutador VALUES 
(DEFAULT, 'Ilia Topuria', 'El Matador', 'Espanha', '1997-01-21', 1.70, 70, 1.75, 'Destro', 
'../assets/atletas/foto-topuria.avif', 1, TRUE, 5),
(DEFAULT, 'Islam Makhachev', '', 'Rússia', '1991-10-27', 1.78, 77, 1.79, 'Canhoto', 
'../assets/atletas/foto-.avif', 1, TRUE, 5);


SELECT * FROM lutador;

CREATE TABLE cartel (
	id_cartel INT PRIMARY KEY AUTO_INCREMENT,
    vitorias INT,
    derrotas INT,
    empates INT,
    sem_resultado INT,
    ko_tko INT,
    finalizacao INT,
    decisao INT,
    vitorias_primeiro_round INT,
    
    fk_lutador INT UNIQUE,
    FOREIGN KEY (fk_lutador) REFERENCES lutador (id_lutador)
);

SELECT ROUND((ko_tko * 100) / vitorias, 0) FROM cartel AS porcentagem_ko WHERE fk_lutador = 1;
SELECT ROUND((finalizacao * 100) / vitorias, 0) FROM cartel AS porcentagem_finalizacao WHERE fk_lutador = 1;
SELECT ROUND((decisao * 100) / vitorias, 0) FROM cartel AS porcentagem_decisao WHERE fk_lutador = 1;

SELECT vitorias, derrotas, empates, sem_resultado, ko_tko, finalizacao, decisao, vitorias_primeiro_round 
FROM cartel 
WHERE fk_lutador = 1;

INSERT INTO cartel VALUES 
(DEFAULT, 17, 0, 0, 0, 7, 8, 2, 11, 1);

SELECT golpes_sig_desferidos_total, golpes_sig_conectados_total, golpes_sig_conectados_por_min,
golpes_sig_absorvidos_por_min, golpes_sig_defesa_porcentagem, media_knockdowns_por_15_min,
quedas_tentativas, quedas_aplicadas, media_quedas_por_15_min, quedas_defesa_porcentagem,
tempo_medio_luta FROM estatistica WHERE fk_lutador = 1;

UPDATE estatistica SET golpes_sig_defesa_porcentagem = 64 WHERE id_estatistica = 1;

CREATE TABLE estatistica (
	id_estatistica INT PRIMARY KEY AUTO_INCREMENT,
    
    golpes_sig_desferidos_total INT,
    golpes_sig_conectados_total INT,
    golpes_sig_conectados_por_min DECIMAL(4,2),
    golpes_sig_absorvidos_por_min DECIMAL(4,2),
    golpes_sig_defesa_porcentagem INT,
    media_knockdowns_por_15_min DECIMAL(4,2),
    
    quedas_tentativas INT,
    quedas_aplicadas INT,
    media_quedas_por_15_min DECIMAL(4,2),
    quedas_defesa_porcentagem INT,
    media_finalizacoes_por_15_min DECIMAL(4,2),
    tempo_medio_luta TIME,
    
    golpes_sig_cabeca INT,
    golpes_sig_tronco INT,
    golpes_sig_perna INT,
    
    golpes_sig_em_pe INT,
    golpes_sig_clinche INT,
    golpes_sig_solo INT,
    
    fk_lutador INT UNIQUE,
    FOREIGN KEY (fk_lutador) REFERENCES lutador (id_lutador)
);

SELECT golpes_sig_desferidos_total, golpes_sig_conectados_total, golpes_sig_conectados_por_min,
golpes_sig_absorvidos_por_min, golpes_sig_defesa_porcentagem, media_knockdowns_por_15_min,
quedas_tentativas, quedas_aplicadas, media_quedas_por_15_min, quedas_defesa_porcentagem,
tempo_medio_luta, golpes_sig_cabeca, golpes_sig_tronco, golpes_sig_perna, golpes_sig_em_pe, golpes_sig_clinche,
    golpes_sig_solo, media_finalizacoes_por_15_min FROM estatistica WHERE fk_lutador = 1;
    
INSERT INTO estatistica VALUES 
(DEFAULT, 840, 405, 4.81, 3.81, 94, 1.25, 18, 5, 1.96, 94, '09:22', 288, 69, 48, 319, 12, 74, 1, 1.07);

SELECT golpes_sig_em_pe, golpes_sig_clinche, golpes_sig_solo,
ROUND((golpes_sig_em_pe * 100) / SUM(golpes_sig_em_pe + golpes_sig_clinche + golpes_sig_solo), 0) AS porcentagem_em_pe,
ROUND((golpes_sig_clinche * 100) / SUM(golpes_sig_em_pe + golpes_sig_clinche + golpes_sig_solo), 0) AS porcentagem_clinche,
ROUND((golpes_sig_solo * 100) / SUM(golpes_sig_em_pe + golpes_sig_clinche + golpes_sig_solo), 0) AS porcentagem_solo
FROM estatistica WHERE fk_lutador = 1;


CREATE TABLE evento (
	id_evento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(65),
    localizacao VARCHAR(40),
    dt_evento DATE
);

CREATE TABLE luta (
	id_luta INT PRIMARY KEY AUTO_INCREMENT,
    metodo_fim VARCHAR(45),
    round_fim INT,
    tempo_fim TIME,
    disputa_cinturao BOOLEAN,
    luta_principal BOOLEAN,
    CONSTRAINT ch_metodo_fim CHECK (metodo_fim IN ('KO/TKO', 'Finalização', 'Decisão', 'Sem Resultado')),
    CONSTRAINT ch_round_fim CHECK (round_fim BETWEEN 1 AND 5),
    fk_evento INT,
    FOREIGN KEY (fk_evento) REFERENCES evento (id_evento)
);

CREATE TABLE participacao (
	fk_lutador INT,
    fk_luta INT,
    resultado VARCHAR(25),
    
    PRIMARY KEY (fk_lutador, fk_luta),
    CONSTRAINT ch_resultado CHECK (resultado IN ('Vitória', 'Derrota', 'Empate', 'Sem Resultado')),
    FOREIGN KEY (fk_lutador) REFERENCES lutador (id_lutador),
    FOREIGN KEY (fk_luta) REFERENCES luta (id_luta)
);

CREATE TABLE categoria (
	id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    limite_peso DECIMAL(4,1)
);

INSERT INTO categoria VALUES 
(DEFAULT, 'Ranking Geral Masculino', NULL),
(DEFAULT, 'Peso-Mosca Masculino', 56.7),
(DEFAULT, 'Peso-Galo Masculino', 61.2),
(DEFAULT, 'Peso-Pena Masculino', 65.7),
(DEFAULT, 'Peso-Leve', 70.3),
(DEFAULT, 'Peso Meio-Médio', 77.1),
(DEFAULT, 'Peso-Médio', 83.9),
(DEFAULT, 'Peso Meio-Pesado', 92.9),
(DEFAULT, 'Peso-Pesado', 120.2),
(DEFAULT, 'Ranking Geral Feminino', NULL),
(DEFAULT, 'Peso-Palha Feminino', 52.2),
(DEFAULT, 'Peso-Mosca Feminino', 56.7),
(DEFAULT, 'Peso-Galo Feminino', 61.2);