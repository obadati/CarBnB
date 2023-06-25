const express = require("express");
const auth = require("../middleware/auth.js")
let router = express.Router();

const brandController = require("../controller/brand.controller.js");

router.get('/', auth, brandController.getAll);

router.get('/:brandID', auth, brandController.getBrandById)

router.post('/', auth, brandController.createBrand);

router.delete('/:brandID', auth, brandController.deleteBrandById)

router.put('/', auth, brandController.updateBrand)
  
module.exports = router;  