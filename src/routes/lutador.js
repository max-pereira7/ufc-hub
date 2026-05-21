var express = require("express");
var router = express.Router();

var lutadorController = require("../controllers/lutadorController");

router.get("/dados/:idLutador", function (req, res) {
    lutadorController.buscarDadosLutador(req, res);
});

router.get("/cartel/:idLutador", function (req, res) {
    lutadorController.buscarDadosCartel(req, res);
});

router.get("/estatisticas/:idLutador", function (req, res) {
    lutadorController.buscarDadosEstatisticas(req, res);
});

module.exports = router;