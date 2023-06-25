const express = require("express");
const auth = require("../middleware/auth.js")
let router = express.Router();

const carTypeController = require("../controller/carType.controller.js");

router.get('/', auth, carTypeController.getAll);

router.get('/:carTypeID', auth, carTypeController.getCarTypeById)

router.post('/', auth, carTypeController.createCarType);

router.delete('/:carTypeID', auth, carTypeController.deleteCarTypeById)

router.put('/', auth, carTypeController.updateCarType)
  
module.exports = router;  