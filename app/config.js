const config = {
    databaseUrl: process.env.DATABASE_URL,
    logLevel: process.env.LOG_LEVEL || 'error',
    apiKey: process.env.API_KEY
};

module.exports = config;
