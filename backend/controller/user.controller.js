const UserModel = require("../models/user.model.js");
const bcrypt = require("bcrypt");
const config = require("../config.js");
const jwt = require("jsonwebtoken");

exports.register = async function (req, res) {

    let password = req.body.password;
    let encryptedPassword = await bcrypt.hash(password, 10);

    let user = {
        firstName: req.body.firstName,
        LastName: req.body.lastName,
        birthdate: req.body.birthdate,
        email: req.body.email,
        phoneNumber: req.body.phoneNumber ? req.body.phoneNumber : null,
        password: encryptedPassword,
        profilePic: null,
        dateCreated: new Date()
    }

    UserModel.getUser(user.email, (err, rows) => {
        if (rows && rows.length > 0) {
            res.status(409).json({ status: 'Failed', message: 'Email address is already in use' });
        } else {
            UserModel.registerUser(user, function (err, result) {
                if (err) {
                    res.status(500).json({ status: 'Failed', message: err.message });
                    return
                }

                UserModel.getUser(user.email, function (err, result) {
                    if (err) {
                        res.status(500).json({ status: 'Failed', message: err.message });
                        return
                    }

                    const token = jwt.sign({ user: user.email }, config.jwtSecret, { expiresIn: '1h' });
                    res.status(200).json({ status: 'Success', message: 'User added succesfully', access_token: token, user: result[0] });

                });
            });
        }
    });
}

exports.login = async function (req, res) {

    let email = req.body.email;
    let password = req.body.password;

    if (!(email && password)) {
        res.status(400).json({ message: 'Email and password cannot be null.' });
        return
    }

    UserModel.getUser(email, function (err, result) {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return
        }

        if (result.length == 0) {
            res.status(401).json({ status: 'Failed', message: 'Invalid credentials.' });
        }
        else {
            if (!bcrypt.compareSync(password, result[0].password)) {
                res.status(401).json({ status: 'Failed', message: 'Invalid credentials.' });
                return
            }

            const token = jwt.sign({ user: result[0].email }, config.jwtSecret, { expiresIn: '1h' });
            res.status(200).json({ user: result[0], access_token: token });
        }
    });

}

exports.getAll = function (req, res) {
    UserModel.getAllUser((err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
            return
        }

        if (rows.length == 0) {
            res.status(404).json({ status: 'Failed', message: 'No users found' });
        }
        else {
            res.status(200).json(rows);
        }
    })

}

exports.getUserById = (req, res) => {
    let userId = req.params.userId;
    UserModel.getUserById(userId, (err, rows) => {
        if (err) {
            res.status(500).json({ status: 'Failed', message: err.message });
        } else {
            if (rows.length == 0) {
                res.status(404).json({ status: 'Failed', message: 'No User found with id ' + userId });
            } else {
                res.status(200).json(rows);
            }
        }
    })
};