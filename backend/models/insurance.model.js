const { query } = require('express');
const sql = require('./sql');

let connection = sql.connection;

exports.getAll = (cb) => {
    connection.query("SELECT * FROM CARBNB.insurance", (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}