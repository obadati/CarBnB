const express = require("express");
const auth = require("../middleware/auth.js")
let router = express.Router();

const userController = require("../controller/user.controller.js");

router.post('/register', userController.register);

router.post('/login', userController.login);

router.get('/all', auth, userController.getAll)

router.get('/:userId', auth, userController.getUserById)

module.exports = router;  