const express = require("express");
const dotenv = require("dotenv");
const cookieParser = require("cookie-parser");

// Divisions
const habiTrackerDivision = require("./habiTracker/routeMap");
dotenv.config();

const PORT = process.env.PORT || 3000;
const app = express();

app.use(express.json({ limit: '20mb' }));
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

app.use((req, res, next) => {

  const allowedOrigins = [
    "http://localhost:3000",
  ];

  const origin = req.headers.origin;
  if (allowedOrigins.includes(origin)) {
    res.header("Access-Control-Allow-Origin", origin);
  }
  res.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
  res.header("Access-Control-Allow-Headers", "Content-Type, Authorization");
  next();
});

app.use("/habiTracker", habiTrackerDivision);


app.listen(PORT, () => {
  console.log(`API is listening on port ${PORT}`);
});

module.exports = app;
