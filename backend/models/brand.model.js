const sql = require('./sql');

let connection = sql.connection;

exports.createBrand = (brand, cb) => {
    connection.query("INSERT INTO BRAND SET ?", [brand], function (err, rows) {
        if (err)
            cb(err);
        else
            cb(undefined, rows);
    });
}

exports.getAll = (cb) => {
    connection.query("SELECT * FROM Brand", (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.getBrandById = (brandId, cb) => {
    connection.query("SELECT * FROM BRAND b WHERE b.brandID = ?", [brandId], (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.deleteBrandById = (brandId, cb) => {
    connection.query("DELETE FROM BRAND b WHERE b.brandID = ?", [brandId], (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.updateBrand = (brand, cb) => {
    connection.query("UPDATE BRAND b SET ? WHERE b.brandID = ?", [brand, brand.brandID], (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}
