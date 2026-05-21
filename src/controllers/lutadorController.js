var lutadorModel = require("../models/lutadorModel");

function buscarDadosLutador(req, res) {

    var idLutador = req.params.idLutador;

    lutadorModel.buscarDadosLutador(idLutador)
        .then(function (resultado) {

            res.json(resultado);

        }).catch(function (erro) {

            console.log(erro);
            res.status(500).json(erro);

        });
}

function buscarDadosCartel(req, res) {

    var idLutador = req.params.idLutador;

    lutadorModel.buscarDadosCartel(idLutador)
        .then(function (resultado) {

            res.json(resultado);

        }).catch(function (erro) {

            console.log(erro);
            res.status(500).json(erro);

        });
}

function buscarDadosEstatisticas(req, res) {

    var idLutador = req.params.idLutador;

    lutadorModel.buscarDadosEstatisticas(idLutador)
        .then(function (resultado) {

            res.json(resultado);

        }).catch(function (erro) {

            console.log(erro);
            res.status(500).json(erro);

        });
}

module.exports = {
    buscarDadosLutador,
    buscarDadosCartel,
    buscarDadosEstatisticas
}