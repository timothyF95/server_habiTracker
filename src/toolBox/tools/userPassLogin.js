const dotenv = require("dotenv");
const jwt = require("jsonwebtoken");
const pool = require("../database/uddb");
dotenv.config();

const jwtSecret = process.env.JWTSECRET || "";

const userPassLogin = async (req, res) => {
  const { body } = req;
 
  if (req.method === "OPTIONS") {
    return res.status(200).json({ message: "Pre-flight success" });
  }


  if (!body.emailaddress || !body.userpass) {
    return res.status(400).send({
      status: "FAILED",
      data: { 
        error:
          "One of the following keys is missing or is empty in request body: 'emailaddress', 'userpass'",
      },
    });
  }
  const userP = {
    userpass: body.userpass,
    emailaddress: body.emailaddress.toLowerCase(),
  };

  try {
    const getUser = await pool.query(
      "SELECT h_user_id FROM h_user WHERE emailaddress = $1 AND userpass = $2",
      [userP.emailaddress, userP.userpass]
    );

    if (getUser.rowCount === 0) {
      throw {
        status: 404,
        message: `Username or password incorrect`,
      };
    } else if (getUser.rowCount > 1) {
      throw {
        status: 404,
        message: `I diagnose you - schizophrenic`,
      };
    }

    const resUser = getUser.rows;

    const maxAge = 3 * 60 * 60;
    const token = jwt.sign(
      { sub: "1234567890", HuserID: resUser[0].huserid },
      jwtSecret,
      {
        expiresIn: maxAge, // 3hrs in sec
      }
    );

    const resData = {};
    resData.huserid = resUser[0].h_user_id;
    resData.token = token;
    res.cookie("captainWaffles", token, {
      httpOnly: true,
      maxAge: maxAge * 1000, // 3hrs in ms
      // secure: true
    });

    res.status(200).send({ status: "OK", data: resData });
  } catch (error) {
    res
      .status(error?.status || 500)
      .send({ status: "FAILED", data: { error: error?.message || error } });
  }
};

module.exports = {
  userPassLogin,
};
