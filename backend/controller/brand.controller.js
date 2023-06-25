const BrandModel = require("../models/brand.model.js");

exports.getAll = (req, res) => {
    BrandModel.getAll((err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No brands found' });
        } else {
            res.status(200).json(rows);
        }
    })
};

exports.getBrandById = (req, res) => {
    let brandId = req.params.brandID;
    BrandModel.getBrandById(brandId, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No brand found with ID ' + brandId });
        } else {
            res.status(200).json(rows);
        }
    })
};

exports.createBrand = function (req, res) {
    let brand = {
        brand: req.body.brand
    }

    BrandModel.createBrand(brand, function(err, result) {
        if (err) {
            res.status(500).json( {status: 'Failed', message: err.message} );
            return
        }
        res.status(200).json( {status: 'Success', message: 'Brand added succesfully'} );
    });
};

exports.deleteBrandById = (req, res) => {
    let brandId = req.params.brandID;
    BrandModel.deleteBrandById(brandId, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.affectedRows == 0) {
            res.status(404).json({ status: 'Failed', message: 'No brand found with ID ' + brandId });
        } else {
            res.status(200).json(rows);
        }
    })
};

exports.updateBrand = (req, res) => {
    if (!(req.body.brandID && req.body.brand)) {
        res.status(400).json({message: "Id and brand cannot be null."});
        return
    }

    let brand = {
        brandID: req.body.brandID,
        brand: req.body.brand
    }

    BrandModel.updateBrand(brand, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.affectedRows == 0) {
            res.status(404).json({ status: 'Failed', message: 'Brand not found with ID ' + brand.brandID });
        } else {
            res.status(200).json(rows);
        }
    })
};
