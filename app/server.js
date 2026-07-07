const express = require('express');
const config = require('./config');

const app = express();
const PORT = process.env.PORT || 3000;

// Intentionally planted problem 1: Missing required environment variable
if (!config.databaseUrl) {
    console.error('Error: DATABASE_URL is undefined');
    process.exit(1);
}

// Problem 2 effect: Mismatched log level
if (config.logLevel === 'error' && !process.env.LOG_LEVEL) {
    console.warn('Warning: Application falling back to error state due to missing LOG_LEVEL');
} else {
    console.log(`Starting app with log level: ${config.logLevel}`);
}

app.get('/health', (req, res) => {
    res.json({ status: 'ok' });
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
