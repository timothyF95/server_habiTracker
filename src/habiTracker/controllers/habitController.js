const habitService = require("../services/habitService");
const dotenv = require("dotenv");
dotenv.config();

const getTrackerHabits = async (req, res) => {
  const { user_id, current_date } = req.body;

  try {
    if (!user_id || !current_date) {
      throw {
        status: 400,
        message: "Invalid Request: user_id and current_date are required.",
      };
    }

    const trackerHabits = await habitService.getTrackerHabits({ user_id, current_date });

    res.status(200).send({ status: "OK", data: trackerHabits });
  } catch (error) {
    res
      .status(error?.status || 500)
      .send({
        status: "FAILED",
        data: { error: error?.message || "An error occurred while fetching tracker habits." },
      });
  }
};

const insertTrackerRecord = async (req, res) => {
  const { user_id, habit_id, created_by, active_yn } = req.body;

  try {
    if (!user_id || !habit_id || !created_by || active_yn === undefined) {
      throw {
        status: 400,
        message: "Invalid Request: All fields (user_id, habit_id, created_by, active_yn) are required.",
      };
    }

    await habitService.insertTrackerRecord({
      user_id,
      habit_id,
      created_by,
      active_yn,
    });

    res.status(201).send({ status: "OK", message: "Tracker record inserted successfully" });
  } catch (error) {
    res
      .status(error?.status || 500)
      .send({
        status: "FAILED",
        data: { error: error?.message || "An error occurred while inserting the tracker record." },
      });
  }
};

module.exports = {
  getTrackerHabits,
  insertTrackerRecord,
};
