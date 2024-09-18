const pool = require("./db");
const dotenv = require("dotenv");
dotenv.config();

// Fetch tracker habits based on user_id and current_date
const getTrackerHabits = async ({ user_id, current_date }) => {
  try {
    const result = await pool.query(
      "SELECT * FROM get_tracker_habits($1, $2);",
      [user_id, current_date]
    );
    return result.rows;
  } catch (error) {
    throw {
      status: error?.status || 500,
      message: error?.message || "An error occurred while fetching tracker habits.",
    };
  }
};

const insertTrackerRecord = async ({ user_id, habit_id, created_by, active_yn }) => {
  try {
    await pool.query(
      "SELECT insert_tracker_record($1, $2, $3, $4);", 
      [user_id, habit_id, created_by, active_yn]
    );
  } catch (error) {
    throw {
      status: error?.status || 500,
      message: error?.message || "An error occurred while inserting tracker record.",
    };
  }
};

module.exports = {
  getTrackerHabits,
  insertTrackerRecord,
};
