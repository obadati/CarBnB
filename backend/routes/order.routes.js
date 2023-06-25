const express = require("express");
const auth = require("../middleware/auth.js")
let router = express.Router();

const orderController = require("../controller/order.controller.js");

router.get('/', auth, orderController.getAll);

router.get('/:orderId', auth, orderController.getOrderById)

router.post('/', auth, orderController.createOrder);

router.delete('/:orderId', auth, orderController.deleteOrderById)

router.put('/', auth, orderController.updateOrder)

router.get('/ownerOrder/:userId', auth, orderController.getOwnerOrder)

router.get('/pendingOrder/:userId', auth, orderController.getPendingOrder)

router.get('/userOrder/:userId', auth, orderController.getUserOrder)

module.exports = router;  