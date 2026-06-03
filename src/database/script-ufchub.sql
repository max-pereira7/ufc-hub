CREATE DATABASE db_ufchub;
USE db_ufchub;

/*
   TABELAS
*/

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(100)
);

CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    limite_peso DECIMAL(4,1)
);

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
    perfil VARCHAR(120),
    fk_categoria INT,

    FOREIGN KEY (fk_categoria) REFERENCES categoria(id_categoria),

    CONSTRAINT ch_base_luta CHECK (base_luta IN ('Destro', 'Canhoto', 'Ambidestro'))
);

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

    FOREIGN KEY (fk_lutador) REFERENCES lutador(id_lutador)
);

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

    FOREIGN KEY (fk_lutador) REFERENCES lutador(id_lutador)
);

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
    fk_evento INT,

    FOREIGN KEY (fk_evento) REFERENCES evento(id_evento),

    CONSTRAINT ch_metodo_fim
        CHECK (metodo_fim IN (
                'KO/TKO',
                'Finalização',
                'Decisão',
                'Sem Resultado')),

    CONSTRAINT ch_round_fim CHECK (round_fim BETWEEN 1 AND 5)
);

CREATE TABLE participacao (
    fk_lutador INT,
    fk_luta INT,
    resultado VARCHAR(25),

    PRIMARY KEY (fk_lutador, fk_luta),

    FOREIGN KEY (fk_lutador) REFERENCES lutador(id_lutador),

    FOREIGN KEY (fk_luta) REFERENCES luta(id_luta),

    CONSTRAINT ch_resultado CHECK (resultado IN ('Vitória','Derrota', 'Empate', 'Sem Resultado'))
);


/*
   INSERTS
*/

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

INSERT INTO lutador VALUES
(DEFAULT, 'Ilia Topuria', 'El Matador', 'Espanha',
'1997-01-21', 1.70, 70, 1.75, 'Destro',
'../assets/atletas/foto-topuria.avif',
1, TRUE,
'../assets/atletas/perfil-topuria.avif',
5),

(DEFAULT, 'Islam Makhachev', NULL, 'Rússia',
'1991-10-27', 1.78, 77, 1.79, 'Canhoto',
'../assets/atletas/foto-makhachev.avif',
1, TRUE,
'../assets/atletas/perfil-makhachev.avif',
6),

(DEFAULT, 'Charles Oliveira', 'Do Bronxs', 'Brasil',
'1989-10-17', 1.78, 70, 1.90, 'Destro',
'../assets/atletas/foto-charles.avif',
3, FALSE,
'../assets/atletas/perfil-charles.avif',
5),

(DEFAULT, 'Max Holloway', 'Blessed', 'Estados Unidos',
'1991-12-04', 1.80, 70, 1.75, 'Destro',
'../assets/atletas/foto-max.avif',
4, FALSE,
'../assets/atletas/perfil-max.avif',
5),

(DEFAULT, 'Justin Gaethje', 'The Highlight', 'Estados Unidos',
'1988-11-14', 1.80, 70, 1.78, 'Destro',
'../assets/atletas/foto-justin.avif',
2, FALSE,
'../assets/atletas/perfil-justin.avif',
5);

INSERT INTO cartel VALUES
(DEFAULT, 17, 0, 0, 0, 7, 8, 2, 11, 1),
(DEFAULT, 28, 1, 0, 0, 5, 13, 10, 11, 2),
(DEFAULT, 37, 11, 0, 0, 10, 22, 5, 16, 3),
(DEFAULT, 27, 5, 0, 0, 20, 1, 6, 9, 4),
(DEFAULT, 27, 9, 0, 0, 12, 2, 13, 3, 5);

INSERT INTO estatistica VALUES
(DEFAULT, 840, 405, 4.81, 3.81, 64, 1.25, 18, 11, 1.96, 94, '09:22', 288, 69, 48, 319, 12, 74, 1, 1.07),
(DEFAULT, 830, 485, 2.45, 1.45, 62, 0.30, 73, 41, 3.10, 91, '11:01', 344, 114, 27, 278, 89, 118, 2, 0.98),
(DEFAULT, 1715, 954, 3.23, 3.05, 49, 0.41, 113, 45, 2.29, 55, '07:58', 565, 246, 143, 560, 173, 221, 3, 2.59),
(DEFAULT, 2016, 1180, 6.48, 7.05, 51, 0.74, 10, 4, 0.33, 74, '12:09', 762, 131, 287, 992, 147, 41, 4, 0.00),
(DEFAULT, 7647, 3681, 6.91, 4.61, 59, 0.34, 15, 8, 0.23, 81, '16:39', 2381, 899, 401, 3247, 246, 188, 5, 0.28);

INSERT INTO evento VALUES
(DEFAULT, 'UFC 317', 'Las Vegas, EUA', '2025-06-28'),
(DEFAULT, 'UFC 328', 'Washington, EUA', '2026-06-14');

INSERT INTO luta VALUES
(DEFAULT, 'KO/TKO', 1, '00:02:27', TRUE, TRUE, 1),
(DEFAULT, NULL, NULL, NULL, TRUE, TRUE, 2);

INSERT INTO participacao VALUES
(1,1,'Vitória'),
(3,1,'Derrota');

INSERT INTO participacao VALUES
(1,2,NULL),
(4,2,NULL);


/*
   SELECTS GERAIS
*/

SELECT * FROM usuario;
SELECT * FROM categoria;
SELECT * FROM lutador;
SELECT * FROM cartel;
SELECT * FROM estatistica;
SELECT * FROM evento;
SELECT * FROM luta;
SELECT * FROM participacao;

/*
	SELECTS
*/


/*
Busca informações completas de um lutador
com o nome da categoria.
*/

SELECT
    l.nome,
    l.apelido,
    l.nacionalidade,
    l.dt_nascimento,
    l.altura,
    l.peso,
    l.alcance,
    l.base_luta,
    l.imagem,
    l.posicao_ranking,
    l.campeao,
    c.nome
FROM lutador l
JOIN categoria c
    ON l.fk_categoria = c.id_categoria
WHERE id_lutador = 2;


/*
Calcula porcentagem de vitórias por método.
*/

SELECT ROUND((ko_tko * 100) / vitorias, 0) AS porcentagem_ko
FROM cartel
WHERE fk_lutador = 1;

SELECT ROUND((finalizacao * 100) / vitorias, 0) AS porcentagem_finalizacao
FROM cartel
WHERE fk_lutador = 1;

SELECT ROUND((decisao * 100) / vitorias, 0) AS porcentagem_decisao
FROM cartel
WHERE fk_lutador = 1;


/*
Distribuição dos golpes significativos por posição de combate.
*/

SELECT
    golpes_sig_em_pe,
    golpes_sig_clinche,
    golpes_sig_solo,
    
    ROUND(
        (golpes_sig_em_pe * 100)
        /
        (golpes_sig_em_pe + golpes_sig_clinche + golpes_sig_solo),
        0
    ) AS porcentagem_em_pe,
    
    ROUND(
        (golpes_sig_clinche * 100)
        /
        (golpes_sig_em_pe + golpes_sig_clinche + golpes_sig_solo),
        0
    ) AS porcentagem_clinche,
    
    ROUND(
        (golpes_sig_solo * 100)
        /
        (golpes_sig_em_pe + golpes_sig_clinche + golpes_sig_solo),
        0
    ) AS porcentagem_solo

FROM estatistica
WHERE fk_lutador = 1;


/*
Histórico completo de lutas.

- nome do lutador
- resultado
- método da vitória
- evento
- data
- round
*/

SELECT
    l.nome AS nome_lutador,
    p.resultado,
    lt.metodo_fim AS metodo,
    e.nome,
    e.dt_evento,
    lt.round_fim
FROM lutador l
JOIN participacao p
    ON l.id_lutador = p.fk_lutador
JOIN luta lt
    ON p.fk_luta = lt.id_luta
JOIN evento e
    ON lt.fk_evento = e.id_evento;


/*
Última ou próxima luta de um atleta.

Faz um auto JOIN na tabela participacao
para encontrar o adversário da mesma luta.
*/

SELECT
    l1.nome AS lutador1,
    l1.perfil AS perfil1,
    l2.nome AS lutador2,
    l2.perfil AS perfil2,
    p.resultado,
    e.nome AS evento,
    e.dt_evento
FROM participacao p

JOIN luta lt
    ON p.fk_luta = lt.id_luta
JOIN evento e
    ON lt.fk_evento = e.id_evento
JOIN lutador l1
    ON p.fk_lutador = l1.id_lutador
JOIN participacao p2
    ON p.fk_luta = p2.fk_luta
    AND p.fk_lutador <> p2.fk_lutador
JOIN lutador l2
    ON p2.fk_lutador = l2.id_lutador
WHERE p.fk_lutador = l1.id_lutador

ORDER BY e.dt_evento DESC

LIMIT 1;