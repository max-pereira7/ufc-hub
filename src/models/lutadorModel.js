var database = require("../database/config");

function buscarDadosLutador(idLutador) {
    var instrucaoSql = `SELECT l.nome, 
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
    c.nome AS categoria
    FROM lutador l 
    JOIN categoria c ON l.fk_categoria = c.id_categoria
    WHERE id_lutador = ${idLutador};`;

    return database.executar(instrucaoSql);
}

function buscarDadosCartel(idLutador) {
    var instrucaoSql = `SELECT vitorias, 
    derrotas, 
    empates, 
    sem_resultado, 
    ko_tko, 
    finalizacao, 
    decisao, 
    vitorias_primeiro_round,
    ROUND(
        (ko_tko * 100) /
        SUM(vitorias + 
        derrotas + 
        empates + 
        sem_resultado
        )
    ,0) AS porcentagem_ko,
    ROUND(
        (finalizacao * 100) /
        SUM(vitorias + 
        derrotas + 
        empates + 
        sem_resultado
        )
    ,0) AS porcentagem_finalizacao,
    ROUND(
        (decisao * 100) /
        SUM(vitorias + 
        derrotas + 
        empates + 
        sem_resultado
        )
    ,0) AS porcentagem_decisao
    FROM cartel 
    WHERE fk_lutador = ${idLutador};`;
    return database.executar(instrucaoSql);
}

function buscarDadosEstatisticas(idLutador) {

    var instrucaoSql = ` SELECT golpes_sig_desferidos_total,
    golpes_sig_conectados_total,
    golpes_sig_conectados_por_min,
    golpes_sig_absorvidos_por_min,
    golpes_sig_defesa_porcentagem,
    media_knockdowns_por_15_min,
    quedas_tentativas,
    quedas_aplicadas,
    media_quedas_por_15_min,
    quedas_defesa_porcentagem,
    media_finalizacoes_por_15_min,
    tempo_medio_luta,
    golpes_sig_cabeca,
    golpes_sig_tronco,
    golpes_sig_perna,
    golpes_sig_em_pe,
    golpes_sig_clinche,
    golpes_sig_solo,
    ROUND(
        golpes_sig_conectados_total * 100.0 /
        golpes_sig_desferidos_total,
        1
    ) AS precisao_golpes,
    ROUND(
        (quedas_aplicadas * 100.0) /
        quedas_tentativas,
        1
    ) AS precisao_quedas,
    ROUND(
        (golpes_sig_em_pe * 100) / 
        SUM(
            golpes_sig_em_pe + 
            golpes_sig_clinche + 
            golpes_sig_solo
            )
    , 0) AS porcentagem_em_pe,
    ROUND(
        (golpes_sig_clinche * 100) / 
        SUM(
            golpes_sig_em_pe + 
            golpes_sig_clinche + 
            golpes_sig_solo
            )
    , 0) AS porcentagem_clinche,
    ROUND(
        (golpes_sig_solo * 100) / 
        SUM(
            golpes_sig_em_pe + 
            golpes_sig_clinche + 
            golpes_sig_solo
            )
    , 0) AS porcentagem_solo
    FROM estatistica 
    WHERE fk_lutador = ${idLutador};
    `;
    return database.executar(instrucaoSql);
}

function buscarLutadores() {
    var instrucaoSql = `SELECT * FROM lutador;`;
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarDadosLutador,
    buscarDadosCartel,
    buscarDadosEstatisticas,
    buscarLutadores
}