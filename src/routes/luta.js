var express = require("express");
var router = express.Router();

var lutaController = require("../controllers/lutaController");

router.get("/ultima/:idLutador", function (req, res) {
    lutaController.buscarUltimaLuta(req, res);
});

router.get("/proxima/:idLutador", function (req, res) {
    lutaController.buscarProximaLuta(req, res);
});

router.get("/historico/:idLutador", function (req, res) {
    lutaController.buscarHistorico(req, res);
});

module.exports = router;