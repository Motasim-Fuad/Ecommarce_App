const mongoose = require("mongoose");
const dotenv = require('dotenv');
dotenv.config();

const URL = process.env.MONGO_URL;
mongoose.connect(URL);
const connection = mongoose.connection;
connection.on('error', (error) => console.error(error));
connection.once('open', () => console.log('Connected to Database'));


module.exports = connection;