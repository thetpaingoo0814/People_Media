const model = require('../models/user_model');
const { RDB } = require('../utils/util');

const getById = async (id) => {
    let user = await model.findById(id).select('-password');
    return user;
}

const getByName = async (name) => {
    let user = await model.findOne({ name });
    return user;
}

const getByPhone = async (phone) => {
    let user = await model.findOne({ phone });
    return user;
}

const add = async (name, displayName, phone, password) => {
    let profile = process.env.IMAGE_PATH + "/1.png"
    let result = await new model({ name, displayName, phone, password, profile }).save();
    return result;
}

const setCacheUser = async (key) => {
    let user = await getById(key);
    await RDB.set(key, user);
}

const getCacheUser = async (key) => {
    let user = await RDB.get(key);
    return user;
}

const changeRole = async (id, role) => {
    await model.findByIdAndUpdate(id, { role });
}

const getUsers = async (index) => {
    let userCount = 3;
    let users = await model.find({
        $or: [
            { role: 1 },
            { role: 2 }
        ]
    }).skip(index * userCount).sort({ 'created': -1 }).limit(userCount);
    return users;
}

const modify = async (id, obj) => {
    await model.findByIdAndUpdate(id, obj);
}

module.exports = {
    getById,
    getByName,
    getByPhone,
    add,
    setCacheUser,
    getCacheUser,
    changeRole,
    getUsers,
    modify
}