const mysql = require('mysql');
const {promisify} = require('util');
const {database } = require('./keys');

const pool = mysql.createPool(database);

pool.getConnection((err, connection) => {
    if(err) {
        if (err.code === 'PROTOCOL_CONNECTION_LOST') {
            console.error('Database connection was closed due to a protocol error.');
        } else if (err.code === 'ER_CON_COUNT_ERROR') {
            console.error('Too many connections, the user has been disconnected from the server.');
        } else if (err.code === 'ECONNREFUSED') {
            console.error('Database connection was refused.');
        }
    }

    if (connection) connection.release();
    console.log('Connected to the database');
    return;
});

pool.query = promisify(pool.query);

module.exports = pool;