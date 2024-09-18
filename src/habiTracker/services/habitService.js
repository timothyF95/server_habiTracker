const Habit = require("../database/habit.js");

const getTrackerHabits = async ({ user_id, current_date }) => {
  try {
    const trackerHabits = await Habit.getTrackerHabits({
      user_id,
      current_date,
    });
    return trackerHabits;
  } catch (error) {
    throw error;
  }
};

const insertTrackerRecord = async ({ user_id, habit_id, created_by, active_yn }) => {
  try {
    await Habit.insertTrackerRecord({
      user_id,
      habit_id,
      created_by,
      active_yn,
    });
  } catch (error) {
    throw error;
  }
};

module.exports = {
  getTrackerHabits,
  insertTrackerRecord,
};
