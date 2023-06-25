const express = require("express");
const auth = require("../middleware/auth.js")
let router = express.Router();

const fuelTypeController = require("../controller/fuelType.controller.js");

router.get('/', auth, fuelTypeController.getAll);

router.get('/:fuelID', auth, fuelTypeController.getFuelTypeById)

router.post('/', auth, fuelTypeController.createFuelType);

router.delete('/:fuelID', auth, fuelTypeController.deleteFuelTypeById)

router.put('/', auth, fuelTypeController.updateFuelType)
  
module.exports = router;  