const sql = require('./sql');

let connection = sql.connection;

exports.registerUser = (user, cb) => {
    connection.query("INSERT INTO USER SET ?", [user], function (err, rows) {
        if (err) cb(err);
        else cb(undefined, rows);
    });
}

exports.getUser = (email, cb) => {
    connection.query("SELECT * FROM USER u WHERE u.email = ?", [email], function (err, rows) {
        if (err) cb(err);
        else cb(undefined, rows);
    });
}

exports.getUserById = (userId, cb) => {
    connection.query("SELECT userID,firstName,LastName,birthdate,email,phoneNumber,profilePic,dateCreated FROM USER WHERE userID = ?", [userId], (err, rows) => {
        if (err)
            cb(err)
        else
            cb(undefined, rows);
    });
}
exports.getAllUser = (cb) => {
    connection.query("SELECT * FROM User", (err, rows) => {
        if (err) cb(err)
        else cb(undefined, rows);
    })
}

