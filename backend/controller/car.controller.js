const CarModel = require("../models/car.model.js");
const MediaModel = require("../models/media.model");
const path = require("path");
const fs = require("fs");

const Car = function (car) {
    this.userID = car.userID;
    this.brandID = car.brandID;
    this.carTypeID = car.carTypeID;
    this.fuelID = car.fuelID;
    this.gear = car.gear;
    this.color = car.color;
    this.description = car.description;
    this.model = car.model;
    this.plateNumber = car.plateNumber;
    this.hourlyCost = car.hourlyCost;
    this.dailyCost = car.dailyCost;
    this.seats = car.seats;
    this.doors = car.doors;
    this.lat = car.lat;
    this.long = car.long;
    this.city = car.city;
    this.status = 1;
    this.dateCreated = car.dateCreated;
};

exports.getAll = (req, res) => {
    CarModel.getAll((err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No cars found' });
        } else {
            res.status(200).json(rows);
        }
    })
};

exports.getAllCarColors = (req, res) => {
    CarModel.getAllCarColors((err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No cars found' });
        } else {
            res.status(200).json(rows);
        }
    })
};

exports.getAllCity = (req, res) => {
    CarModel.getAllCity((err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No cars found' });
        } else {
            res.status(200).json(rows);
        }
        console.log(rows)

    })
};

exports.getAllFilterData = (req, res) => {
    CarModel.getAllFilterData((err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No cars found' });
        } else {
            console.log(rows)

            let city = [];
            let brand = [];
            let type = [];
            let fuel = [];
            let gear = [];
            let color = [];

            for (let i = 0; i < rows.length; i++) {
                if (rows[i].title == "brand") {
                    brand.push(rows[i].val);
                }
                else if (rows[i].title == "city") {
                    city.push(rows[i].val);
                }
                else if (rows[i].title == "type") {
                    type.push(rows[i].val);
                }
                else if (rows[i].title == "fuel") {
                    fuel.push(rows[i].val);
                }
                else if (rows[i].title == "color") {
                    color.push(rows[i].val);
                }

            }

            let text = {
                brand: brand,
                city: city,
                type: type,
                color: color,
                gear: ["Automatic", "Manual"],
                fuel: fuel
            };
            console.log(text)
            res.status(200).json(text);
        }
    })
};
exports.getCarById = (req, res) => {
    let carId = req.params.carId;
    CarModel.getCarById(carId, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
        } else {
            if (rows.length == 0) {
                res.status(404).json({ status: 'Failed', message: 'No car found with id ' + carId });
            } else {
                res.status(200).json(rows);
            }
        }
    })
};


exports.getfilter = (req, res) => {

    let car = {
        city: req.body.city,
        brand: req.body.brand,
        type: req.body.type,
        fuel: req.body.fuel,
        gear: req.body.gear,
        color: req.body.color,
        seat: req.body.seat,
        door: req.body.door,
        price: req.body.price
    }

    CarModel.getfilter(car, function (err, rows) {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No cars found' });
        } else {
            res.status(200).json(rows);
        }
    })
};


exports.getCarByUserId = (req, res) => {
    let userId = req.params.userId;
    CarModel.getCarByUserId(userId, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
        } else {
            if (rows.length == 0) {
                res.status(404).json({ status: 'Failed', message: 'No car found with id ' + userId });
            } else {
                res.status(200).json(rows);
            }
        }
    })
};

exports.getMediaByCar = (req, res) => {
    let carId = req.params.carId;
    MediaModel.getMediaByCarId(carId, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
        } else {
            if (rows.length == 0) {
                res.status(404).json({ status: 'Failed', message: 'No media found for car with id ' + carId });
            } else {
                res.status(200).json(rows);
            }
        }
    })
};

exports.createCar = (req, res) => {
    let car = new Car({
        userID: req.body.userId,
        brandID: req.body.brandId,
        carTypeID: req.body.carTypeId,
        fuelID: req.body.fuelTypeId,
        gear: req.body.gear,
        color: req.body.color,
        description: req.body.description,
        model: req.body.model,
        plateNumber: req.body.plateNumber,
        hourlyCost: req.body.hourlyCost,
        dailyCost: req.body.dailyCost,
        seats: req.body.seats,
        doors: req.body.doors,
        lat: req.body.lat,
        long: req.body.long,
        city: req.body.city,
        dateCreated: new Date()
    });

    // Images
    let filePaths = [];
    if (req.files) {
        for (let i = 0; i < req.files.length; i++) {
            let extension = path.extname(req.files[i].originalname)
            if (extension == "") extension = ".png";

            let filePath = req.files[i].path;
            fs.renameSync(path.join(filePath), path.join(filePath) + extension)
            filePaths.push("/images/" + path.basename(req.files[i].path) + extension);
        }
    }

    CarModel.createCar(car, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
        } else {
            if (rows.length == 0) {
                res.status(500).json({ status: 'Failed', message: 'No car created' });
            } else {
                // Car saved. Now save image paths in database
                let result = rows;
                if (filePaths.length > 0) {
                    MediaModel.saveCarImages(result.insertId, filePaths, (err, rows) => {
                        if (err) {
                            res.status(500).json({ status: 'Failed', message: err.message });
                            return;
                        }

                        res.status(200).json(result);
                    })
                } else {
                    res.status(200).json(result);
                }
            }
        }
    })
};

exports.deleteCarById = (req, res) => {
    let carId = req.params.carId;
    CarModel.deleteCarById(carId, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.affectedRows == 0) {
            res.status(404).json({ status: 'Failed', message: 'No car found with ID ' + carId });
        } else {
            res.status(200).json(rows);
        }
    })
};


exports.updateCarStatus = (req, res) => {
    if (!(req.body.CarID && req.body.Status >= 0)) {
        res.status(400).json({ message: 'CarID, new status can not be null' });
        return
    }

    let car = {
        carID: req.body.CarID,
        status: req.body.Status
    }

    CarModel.updateCarStatus(car, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.affectedRows == 0) {
            res.status(404).json({ status: 'Failed', message: 'No car found with ID ' + car.carId });
        } else {
            res.status(200).json(rows);
        }
    })
};

exports.updateCarById = (req, res) => {
    if (!(req.body.carId &&
        req.body.userId &&
        req.body.name &&
        req.body.brand &&
        req.body.Type &&
        req.body.gear &&
        req.body.fuel &&
        req.body.color &&
        req.body.description &&
        req.body.model &&
        req.body.plateNumber &&
        req.body.hourlyCost &&
        req.body.dailyCost &&
        req.body.seats &&
        req.body.doors &&
        req.body.lat &&
        req.body.long &&
        req.body.city)) {
        res.status(400).json({ message: "Not all parameters specified" });
        return
    }

    let car = {
        carID: req.body.carId,
        userID: req.body.userId,
        name: req.body.name,
        brand: req.body.brand,
        type: req.body.Type,
        fuel: req.body.fuel,
        gear: req.body.gear,
        color: req.body.color,
        description: req.body.description,
        model: req.body.model,
        plateNumber: req.body.plateNumber,
        hourlyCost: req.body.hourlyCost,
        dailyCost: req.body.dailyCost,
        seats: req.body.seats,
        doors: req.body.doors,
        lat: req.body.lat,
        long: req.body.long,
        city: req.body.city
    }

    CarModel.updateCar(car, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.affectedRows == 0) {
            res.status(404).json({ status: 'Failed', message: 'Car not found with ID ' + car.carID });
        } else {
            res.status(200).json(rows);
        }
    })
};
