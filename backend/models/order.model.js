const { query } = require('express');
const sql = require('./sql');

let connection = sql.connection;



exports.getAll = (cb) => {
    connection.query("SELECT * FROM CARBNB.ORDER", (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.getOwnerOrder = (userId, cb) => {
    connection.query("select * from carbnb.order o left join carbnb.all_cars a on o.carid =a.carid left join carbnb.insurance i on i.insuranceid=o.insuranceid where ownerid= ?", [userId], (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.getPendingOrder = (userId, cb) => {
    connection.query("select * from carbnb.order o left join carbnb.all_cars a on o.carid =a.carid left join carbnb.insurance i on i.insuranceid=o.insuranceid where ownerid= ? and o.statusID=2", [userId], (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.getUserOrder = (userId, cb) => {
    connection.query("select * from carbnb.order o left join carbnb.all_cars a on o.carid =a.carid left join carbnb.insurance i on i.insuranceid=o.insuranceid where o.userid= ? order by orderID desc", [userId], (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}
exports.createOrder = (order, cb) => {
    connection.query("INSERT INTO CARBNB.ORDER SET ?", [order], function (err, rows) {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}


exports.updateOrder = (order, cb) => {
    connection.query("UPDATE CARBNB.ORDER o SET ? WHERE o.orderID = ?", [order, order.orderID], (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}