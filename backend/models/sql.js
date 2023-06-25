const mysql = require('mysql');

const connection = mysql.createConnection({
    host     : 'localhost',
    port     : 3306,
    user     : 'root',
    password : '12345678',
    database : 'carbnb',
    multipleStatements: true
});

function connectDB(cb) {
    connection.connect(function (err) {
        cb(err)
    });
}

module.exports = {
    connectDB: connectDB,
    connection: connection
}
