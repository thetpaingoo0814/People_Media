const model = require('../models/category_model');

const getById = async (id) => {
    let category = await model.findById(id);
    return category;
}

const getByName = async (name) => {
    let category = await model.findOne({ name });
    return category;
}

const getAll = async () => {
    let categories = await model.find();
    return categories;
}

const add = async (name, image, desc) => {
    let obj = { name, image, desc };
    let result = await new model(obj).save();
    return result;
}

const modify = async (id, obj) => {
    let result = await model.findByIdAndUpdate(id, obj);
    return result;
}

const remove = async (id) => {
    let result = await model.findByIdAndDelete(id);
    return result;
}

module.exports = {
    getById,
    getAll,
    add,
    modify,
    remove,
    getByName
}

