const express = require("express");
const habitController = require("../../controllers/habitController");

const router = express.Router();

router.post("/getTrackerHabits", habitController.getTrackerHabits);
router.post("/insertTrackerRecord", habitController.insertTrackerRecord);


module.exports = router;
