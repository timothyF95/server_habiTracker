const express = require("express");
const { authenticate } = require("../toolBox/tools/authentication");
const { userPassLogin } = require("../toolBox/tools/userPassLogin");

const v1HabitRouter = require("./v1/routes/habitRoutes");

const router = express.Router();

router.use("/api/v1/auth", userPassLogin);
// router.use("/api/v1/habits", authenticate, v1HabitRouter);
router.use("/api/v1/habits", v1HabitRouter);


module.exports = router;
