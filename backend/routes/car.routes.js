const express = require("express");
const auth = require("../middleware/auth.js")
const multer = require("multer");
const upload = multer({ dest: __dirname + '/../public/images/' });
let router = express.Router();

const carController = require("../controller/car.controller.js");

// Car routes
router.get('/', auth, carController.getAll);

router.post('/filter', auth, carController.getfilter);

router.get('/color', auth, carController.getAllCarColors)

router.get('/city', auth, carController.getAllCity)

router.get('/filterdata', auth, carController.getAllFilterData)

router.get('/:carId', auth, carController.getCarById)

router.get('/user/:userId', auth, carController.getCarByUserId)

router.get('/media/:carId', auth, carController.getMediaByCar)

router.post('/', auth, upload.array("images"), carController.createCar);

router.delete('/:carId', auth, carController.deleteCarById)

router.put('/', auth, carController.updateCarById)

router.put('/carstatus', auth, carController.updateCarStatus)

module.exports = router;  