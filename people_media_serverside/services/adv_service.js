const model = require('../models/adv_model');

const add = async (obj) => await new model(obj).save();
const all = async (obj) => await model.find();
const allActives = async (obj) => await model.find({ status: "ACTIVE" });
const drop = async (advId) => await model.findByIdAndDelete(advId);
const get = async (id) => await model.findById(id);
const modify = async (id, obj) => await model.findByIdAndUpdate(id, obj, { new: true });

module.exports = {
    add,
    all,
    allActives,
    drop,
    get,
    modify
}