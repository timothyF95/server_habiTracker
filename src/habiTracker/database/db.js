const Pool = require("pg").Pool;

const pool = new Pool({
    host: process.env.PGHOST,
    port: process.env.PGPORT,

    database: process.env.PGDATABASE_habitracker,
    password: process.env.PGPASSWORD_habitracker,
    user: process.env.PGUSER_habitracker,

});

module.exports = pool;