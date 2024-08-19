const app = require('./app');
const asyncHandler = require('express-async-handler');
const db = require('./config/db');
const dotenv = require('dotenv');
dotenv.config();


// Example route using asyncHandler directly in app.js
app.get('/', asyncHandler(async (req, res) => {
    res.json({ success: true, message: 'API working successfully', data: null });
}));

// Global error handler
app.use((error, req, res, next) => {
    res.status(500).json({ success: false, message: error.message, data: null });
});


app.listen(process.env.PORT, () => {
    console.log(`Server running http://localhost:${process.env.PORT}`);
});