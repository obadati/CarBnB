const FuelTypeModel = require("../models/fuelType.model.js");

exports.getAll = (req, res) => {
    FuelTypeModel.getAll((err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No fuel type found' });
        } else {
            res.status(200).json(rows);
        }
    })
};

exports.getFuelTypeById = (req, res) => {
    let fuelID = req.params.fuelID;
    FuelTypeModel.getFuelTypeById(fuelID, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No fuel type found with ID ' + fuelID });
        } else {
            res.status(200).json(rows[0]);
        }
    })
};

exports.createFuelType = function (req, res) {
    let fuelType = {
        Type: req.body.type
    }

    FuelTypeModel.createFuelType(fuelType, function(err, result) {
        if (err) {
            res.status(500).json( {status: 'Failed', message: err.message} );
            return
        }
        res.status(200).json( {status: 'Success', message: 'Fuel type added succesfully'} );
    });
};

exports.deleteFuelTypeById = (req, res) => {
    let fuelID = req.params.fuelID;
    FuelTypeModel.deleteFuelTypeById(fuelID, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.affectedRows == 0) {
            res.status(404).json({ status: 'Failed', message: 'No fuel type found with ID ' + fuelID });
        } else {
            res.status(200).json(rows);
        }
    })
};

exports.updateFuelType = (req, res) => {
    if (!(req.body.fuelID && req.body.type)) {
        res.status(400).json({message: "fuelID and type cannot be null."});
        return
    }

    let fuelType = {
        fuelID: req.body.fuelID,
        Type: req.body.type
    }

    FuelTypeModel.updateFuelType(fuelType, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.affectedRows == 0) {
            res.status(404).json({ status: 'Failed', message: 'Fuel type not found with ID ' + fuelType.fuelID });
        } else {
            res.status(200).json(rows);
        }
    })
};
