const sql = require('./sql');

let connection = sql.connection;

exports.createFuelType = (fuelType, cb) => {
    connection.query("INSERT INTO FUELTYPE SET ?", [fuelType], function (err, rows) {
        if (err)
            cb(err);
        else
            cb(undefined, rows);
    });
}

exports.getAll = (cb) => {
    connection.query("SELECT * FROM FUELTYPE", (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.getFuelTypeById = (fuelTypeId, cb) => {
    connection.query("SELECT * FROM FUELTYPE f WHERE f.fuelID = ?", [fuelTypeId], (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.deleteFuelTypeById = (fuelTypeId, cb) => {
    connection.query("DELETE FROM FUELTYPE f WHERE f.fuelID = ?", [fuelTypeId], (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.updateFuelType = (fuelType, cb) => {
    connection.query("UPDATE FUELTYPE f SET ? WHERE f.fuelID = ?", [fuelType, fuelType.fuelID], (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}
