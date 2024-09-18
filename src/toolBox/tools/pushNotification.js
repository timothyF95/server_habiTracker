const webpush = require("web-push");
const dotenv = require("dotenv");
const pool = require("../database/db");

dotenv.config();

webpush.setVapidDetails(
  process.env.EMAIL,
  process.env.VAPID_PUBLIC,
  process.env.VAPID_PRIVATE
);

const pushOneUser = async (pushObj) => {
  try {
    const getSubscriptions = await pool.query(
      "SELECT subscriptionObj FROM Hsubscription WHERE activeyn = '1' AND huserid = $1;",
      [pushObj.huserid]
    );

    if (getSubscriptions.rows) {
      for (let sub of getSubscriptions.rows) {
        const payload = JSON.stringify({
          title: pushObj.title,
          body: pushObj.body,
          image: pushObj.image,
        });

        webpush
          .sendNotification(JSON.parse(sub.subscriptionobj), payload)
          .catch((err) => console.error(err));
      }
      return "Subscription Recorded";
    }
    return "Subscription doesn't exist";
  } catch (error) {
    console.log("Error sending push notification: ", error);
  }
};

const pushAllUsers = async ({ title, body, image }) => {
  try {
    const getSubscriptions = await pool.query(
      "SELECT subscriptionObj FROM Hsubscription WHERE activeYN = '1';"
    );

    for (let sub of getSubscriptions.rows) {
      const payload = JSON.stringify({
        title,
        body,
        image,
      });

      webpush
        .sendNotification(JSON.parse(sub.subscriptionobj), payload)
        .catch((err) => console.error(err));
    }

    return "Subscription Recorded";
  } catch (error) {
    console.log("Error sending push notification: ", error);
  }
};

module.exports = {
  pushOneUser,
  pushAllUsers,
};
