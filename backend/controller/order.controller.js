//const { toNamespacedPath } = require("path/posix");
const OrderModel = require("../models/order.model.js");

exports.getAll = (req, res) => {
    OrderModel.getAll((err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No orders found' });
        } else {
            res.status(200).json(rows);
        }
    })
};

exports.getOrderById = (req, res) => {

};

exports.createOrder = (req, res) => {
    let order = {
        CarID: req.body.carID,
        ownerID: req.body.ownerID,
        UserID: req.body.userID,
        InsuranceID: 1,
        StatusID: 2,
        FromTime: req.body.fromTime,
        ToTime: req.body.toTime,
        Total: req.body.total,
        Delivery: 0
    }

    OrderModel.createOrder(order, function (err, result) {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return
        }
        res.status(200).json({ status: 'Success', message: 'Order added succesfully' });
    });
};

exports.deleteOrderById = (req, res) => {

};

exports.updateOrder = (req, res) => {
    if (!(req.body.OrderID && req.body.StatusID)) {
        res.status(400).json({ message: 'orderID, new status can not be null' });
        return
    }

    let order = {
        orderID: req.body.OrderID,
        statusID: req.body.StatusID
    }

    OrderModel.updateOrder(order, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.affectedRows == 0) {
            res.status(404).json({ status: 'Failed', message: 'No Order found with ID ' + order.orderID });
        } else {
            res.status(200).json(rows);
        }
    })
};


exports.getUserOrder = (req, res) => {
    let userId = req.params.userId;

    OrderModel.getUserOrder(userId, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No orders found for userId ' + userId });
        } else {
            res.status(200).json(rows);
        }
    })
};

exports.getOwnerOrder = (req, res) => {
    let userId = req.params.userId;

    OrderModel.getOwnerOrder(userId, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No orders found for userId ' + userId });
        } else {
            res.status(200).json(rows);
        }
    })
};

exports.getPendingOrder = (req, res) => {
    let userId = req.params.userId;

    OrderModel.getPendingOrder(userId, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No orders found for userId ' + userId });
        } else {
            res.status(200).json(rows);
        }
    })
};
