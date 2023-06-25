const jwt = require("jsonwebtoken");
const config = require("../config.js")

const verifyToken = (req, res, next) => {
  let token = req.body.access_token || req.headers.authorization;

  if (!token) {
    return res.status(403).send("A token is required for authentication");
  }

  if(token.startsWith("Bearer ")) token = token.substring(7);

  // just for testing, remove when app is finished
  if(token == "test_token") return next();

  try {
    const decoded = jwt.verify(token, config.jwtSecret);

    req.user = decoded;
  } catch (err) {
    return res.status(401).send("Invalid Token");
  }

  return next();
};

module.exports = verifyToken;