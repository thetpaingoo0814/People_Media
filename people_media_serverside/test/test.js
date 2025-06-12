require('dotenv').config({path:"../.env"});

const mongoose = require('mongoose');
mongoose.connect(process.env.DB_URL);

const UserMigration = require('./migration/user_migration');

const test = async() => {
    await UserMigration.migrate();
}

test();