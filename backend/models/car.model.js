const sql = require('./sql');

let connection = sql.connection;

exports.getAll = (cb) => {
    connection.query("SELECT * FROM all_active_cars", (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.getAllCarColors = (cb) => {
    connection.query("SELECT Distinct(color) FROM all_active_cars", (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.getAllCity = (cb) => {
    connection.query("SELECT Distinct(city) FROM all_active_cars", (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}
exports.getCarById = (carId, cb) => {
    connection.query("SELECT * FROM all_cars WHERE carID = ?", [carId], (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}
exports.updateCarStatus = (car, cb) => {
    connection.query("UPDATE CARBNB.CAR c SET ? WHERE c.carID = ?", [car, car.carID], (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}
exports.getfilter = (car, cb) => {
    let dbQuery = "SELECT * FROM all_active_cars where carID > 0 "
    if (car.city != undefined && car.city != '') {
        dbQuery += ("and `city` = \'" + car.city + "\' ");
    }
    if (car.brand != undefined && car.brand != '') {
        dbQuery += ("and `brand` = \'" + car.brand + "\' ");
    }
    if (car.type != undefined && car.type != '') {
        dbQuery += ("and `type` = \'" + car.type + "\' ");
    }
    if (car.fuel != undefined && car.fuel != '') {
        dbQuery += ("and `fuel` = \'" + car.fuel + "\' ");
    }
    if (car.gear != undefined && car.gear != '') {
        dbQuery += ("and `gear` COLLATE utf8mb4_general_ci = \'" + car.gear + "\' ");
    }
    if (car.color != undefined && car.color != '') {
        dbQuery += ("and `color` = \'" + car.color + "\' ");
    }
    if (car.seat != undefined && car.seat != 0) {
        dbQuery += ("and `seats` = " + car.seat + " ");
    }
    if (car.door != undefined && car.door != 0) {
        dbQuery += ("and `doors` = " + car.door + " ");
    }
    if (car.price != undefined && car.price != 0) {
        dbQuery += ("and `dailycost` <= " + car.price + " ");
    }
    console.log(dbQuery);
    connection.query(dbQuery, (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.getCarByUserId = (userId, cb) => {
    connection.query("SELECT * FROM all_cars WHERE userID = ?", [userId], (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.createCar = (car, cb) => {
    connection.query("INSERT INTO CAR SET ?", [car], (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.deleteCarById = (carId, cb) => {
    connection.query("DELETE FROM CAR c WHERE c.carID = ?", [carId], (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.updateCar = (car, cb) => {
    connection.query("UPDATE CAR c SET ? WHERE c.carID = ?", [car, car.carID], (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}


exports.getAll = (cb) => {
    connection.query("SELECT * FROM all_active_cars", (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.getAllFilterData = (cb) => {
    connection.query("select 'color' title ,a.*  from (select distinct(color) val from carbnb.all_active_cars) a union all select 'city' title ,a.*  from (select distinct(city) val from carbnb.all_active_cars) a union all  select 'brand' title ,a.*  from (SELECT brand val FROM carbnb.brand) a  union all     select 'fuel'  title,a.*  from (SELECT type val FROM carbnb.fueltype) a  union all  select 'type' title,a.*  from (SELECT type val FROM carbnb.cartype) a ", (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}
