const FaqModel = require("../models/faq.model.js");

exports.getAll = function(req, res) {
    FaqModel.getAll((err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No FAQs found' });
        } else {
            res.status(200).json(rows);
        }
    })
};

exports.getFaqById = (req, res) => {
    let faqId = req.params.faqId;
    FaqModel.getFaqById(faqId, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No FAQ found with ID ' + faqId });
        } else {
            res.status(200).json(rows[0]);
        }
    })
};

exports.createFaq = function (req, res) {
    let faq = {
        question: req.body.question,
        answer: req.body.answer
    }

    FaqModel.createFaq(faq, function(err, result) {
        if (err) {
            res.status(500).json( {status: 'Failed', message: err.message} );
            return
        }
        res.status(200).json( {status: 'Success', message: 'FAQ added succesfully'} );
    });
};

exports.deleteFaqById = (req, res) => {
    let faqId = req.params.faqId;
    FaqModel.deleteFaqById(faqId, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.affectedRows == 0) {
            res.status(404).json({ status: 'Failed', message: 'No FAQ found with ID ' + faqId });
        } else {
            res.status(200).json(rows);
        }
    })
};

exports.updateFaq = (req, res) => {
    if (!(req.body.faqID && req.body.question && req.body.answer)) {
        res.status(400).json({message: 'faqID, question and answer cannot be null.'});
        return
    }

    let faq = {
        faqID: req.body.faqID,
        question: req.body.question,
        answer: req.body.answer
    }

    FaqModel.updateFaq(faq, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return;
        }

        if (rows.affectedRows == 0) {
            res.status(404).json({ status: 'Failed', message: 'No FAQ found with ID ' + faq.faqID });
        } else {
            res.status(200).json(rows);
        }
    })
};
