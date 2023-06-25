//const { toNamespacedPath } = require("path/posix");
const insuranceModel = require("../models/insurance.model.js");

exports.getAll = (req, res) => {
    insuranceModel.getAll((err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No insurance found' });
        } else {
            res.status(200).json(rows);
        }
    })
};
