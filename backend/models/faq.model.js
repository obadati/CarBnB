const sql = require('./sql');

let connection = sql.connection;

exports.createFaq = (faq, cb) => {
    connection.query("INSERT INTO FAQ SET ?", [faq], function (err, rows) {
        if (err)
            cb(err);
        else
            cb(undefined, rows);
    });
}

exports.getAll = (cb) => {
    connection.query("SELECT * FROM FAQ", (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.getFaqById = (faqId, cb) => {
    connection.query("SELECT * FROM FAQ f WHERE f.faqID = ?", [faqId], (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.deleteFaqById = (faqId, cb) => {
    connection.query("DELETE FROM FAQ f WHERE f.faqID = ?", [faqId], (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}

exports.updateFaq = (faq, cb) => {
    connection.query("UPDATE FAQ f SET ? WHERE f.faqID = ?", [faq, faq.faqID], (err, rows) => {
        if(err) 
            cb(err)
        else
            cb(undefined, rows);
    });
}
