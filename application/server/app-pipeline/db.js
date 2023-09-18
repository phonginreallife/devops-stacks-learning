const Pool = require("pg").Pool;

const pool = new Pool({
    user: process.env.SECRET_USERNAME,
    password: process.env.SECRET_PASSWORD,
    database: process.env.SECRET_NAME,
    host: process.env.SECRET_HOST,
    port: parseInt(process.env.SECRET_PORT)
});

module.exports = pool;