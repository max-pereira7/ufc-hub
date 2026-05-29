var database = require("../database/config");

function buscarUltimaLuta(idLutador) {
    var instrucaoSql = `
    
    SELECT 

    l1.nome AS lutador1,
    l1.perfil AS perfil1,

    l2.nome AS lutador2,
    l2.perfil AS perfil2,
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
    AND p.fk_lutador != p2.fk_lutador

JOIN lutador l2
    ON p2.fk_lutador = l2.id_lutador

WHERE p.fk_lutador = ${idLutador}
    AND e.dt_evento < CURDATE()

ORDER BY e.dt_evento DESC

LIMIT 1;

    `;

    return database.executar(instrucaoSql);
}

function buscarProximaLuta(idLutador) {

    var instrucaoSql = `
    
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
    AND p.fk_lutador != p2.fk_lutador

JOIN lutador l2
    ON p2.fk_lutador = l2.id_lutador

WHERE p.fk_lutador = ${idLutador}
    AND e.dt_evento >= CURDATE()

ORDER BY e.dt_evento ASC

LIMIT 1;

    `;

    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimaLuta,
    buscarProximaLuta
}