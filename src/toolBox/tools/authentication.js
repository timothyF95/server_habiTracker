const dotenv = require("dotenv");
const jwt = require('jsonwebtoken')

dotenv.config();
const jwtSecret = process.env.JWTSECRET || ''; 


const authenticate = (req, res, next) => {

    if (req.method === 'OPTIONS') {
        return res.status(200).json({ message: "Pre-flight is an arsehole" });
    }

    const authHeader = req.headers.authorization;
  
    if (authHeader && authHeader.startsWith('Bearer ')) {
      const token = authHeader.slice(7);
  
      jwt.verify(token, jwtSecret, (err, decodedToken) => {
        if (err) {
          return res.status(403).json({ message: "Not authorized" });
        } else {
          req.user = decodedToken;
          next();
        }
      });
    } else {
      return res.status(401).json({ message: "Not authorized, token not available" });
    }
};

module.exports = {
    authenticate,
};