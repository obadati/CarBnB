const CarTypeModel = require("../models/carType.model.js");

exports.getAll = (req, res) => {
    CarTypeModel.getAll((err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No car types found' });
        } else {
            res.status(200).json(rows);
        }
    })
};

exports.getCarTypeById = (req, res) => {
    let carTypeID = req.params.carTypeID;
    CarTypeModel.getCarTypeById(carTypeID, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No car type found with ID ' + carTypeID });
        } else {
            res.status(200).json(rows[0]);
        }
    })
};

exports.createCarType = function (req, res) {
    let carType = {
        Type: req.body.type
    }

    CarTypeModel.createCarType(carType, function(err, result) {
        if (err) {
            res.status(500).json( {status: 'Failed', message: err.message} );
            return
        }
        res.status(200).json( {status: 'Success', message: 'Car type added succesfully'} );
    });
};

exports.deleteCarTypeById = (req, res) => {
    let carTypeID = req.params.carTypeID;
    CarTypeModel.deleteCarTypeById(carTypeID, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.affectedRows == 0) {
            res.status(404).json({ status: 'Failed', message: 'No car type found with ID ' + carTypeID });
        } else {
            res.status(200).json(rows);
        }
    })
};

exports.updateCarType = (req, res) => {
    if (!(req.body.carTypeID && req.body.type)) {
        res.status(400).json({message: "carTypeID and type cannot be null."});
        return
    }

    let carType = {
        carTypeID: req.body.carTypeID,
        Type: req.body.type
    }

    CarTypeModel.updateCarType(carType, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.affectedRows == 0) {
            res.status(404).json({ status: 'Failed', message: 'Car type not found with ID ' + carType.carTypeID });
        } else {
            res.status(200).json(rows);
        }
    })
};
