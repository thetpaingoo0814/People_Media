const UserModel = require("../../models/user_model");
const { ENCODER } = require('../../utils/util');
const migrateDev = async () => {
    let ownerObj = {
        name: "owner",
        phone: "09100100100",
        password: ENCODER.encode("123123"),
        displayName: "Spiderman",
        role: 0,
        profile: process.env.IMAGE_PATH + "/1.png"
    }
    let result = await new UserModel(ownerObj).save();
    console.log("Owner Migrated!", result);
}

const migrate = async () => {
    await migrateDev();
}

module.exports = {
    migrate
}