const sql = require('./sql');

let connection = sql.connection;

exports.saveCarImages = (carId, filePaths, cb) => {
    let sqlStatement = "";
    for (let i = 0; i < filePaths.length; i++) {
        sqlStatement = sqlStatement + "INSERT INTO media (carID, mediaLink) VALUES (" + connection.escape(carId) + ", " + connection.escape(filePaths[i]) + ");"
    }
    connection.query(sqlStatement, (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.getMediaByCarId = (carId, cb) => {
    connection.query("SELECT * FROM media WHERE carID = ?", [carId], (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}