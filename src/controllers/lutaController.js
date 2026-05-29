var lutaModel = require("../models/lutaModel");

function buscarUltimaLuta(req, res) {
    var idLutador = req.params.idLutador;
    
    lutaModel.buscarUltimaLuta(idLutador)
    .then(function(resultado) {
            res.json(resultado);
        })
        .catch(function(erro) {

            console.log(erro);
            res.status(500).json(erro);

        });
}

function buscarProximaLuta(req, res) {

    var idLutador = req.params.idLutador;

    lutaModel.buscarProximaLuta(idLutador)
        .then(function(resultado) {

            res.json(resultado);

        })
        .catch(function(erro) {

            console.log(erro);
            res.status(500).json(erro);

        });
}

module.exports = {
    buscarUltimaLuta,
    buscarProximaLuta
}