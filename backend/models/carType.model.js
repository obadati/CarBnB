const sql = require('./sql');

let connection = sql.connection;

exports.createCarType = (carType, cb) => {
    connection.query("INSERT INTO CARTYPE SET ?", [carType], function (err, rows) {
        if (err)
            cb(err);
        else
            cb(undefined, rows);
    });
}

exports.getAll = (cb) => {
    connection.query("SELECT * FROM CARTYPE", (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.getCarTypeById = (carTypeId, cb) => {
    connection.query("SELECT * FROM CARTYPE c WHERE c.carTypeID = ?", [carTypeId], (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.deleteCarTypeById = (carTypeId, cb) => {
    connection.query("DELETE FROM CARTYPE c WHERE c.carTypeID = ?", [carTypeId], (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.updateCarType = (carType, cb) => {
    connection.query("UPDATE CARTYPE c SET ? WHERE c.carTypeID = ?", [carType, carType.carTypeID], (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}
