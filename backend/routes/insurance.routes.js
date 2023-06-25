const express = require("express");
const auth = require("../middleware/auth.js")
let router = express.Router();

const insuranceController = require("../controller/insurance.controller.js");

router.get('/', auth, insuranceController.getAll);

module.exports = router;  