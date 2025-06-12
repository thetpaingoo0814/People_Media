const model = require('../models/tag_model');

const getAll = async () => {
    let tags = null;
    try {
        tags = await model.find();
    } catch (error) {
        console.log("Error at Tag getAll in TagService!");
    } finally {
        return tags;
    }
}

const getByName = async (name) => {
    let tag = null;
    try {
        tag = await model.findOne({ name });
    } catch (error) {
        console.log("Error at getByName in TagService");
    } finally {
        return tag;
    }
}

const getById = async (id) => {
    let tag = null;
    try {
        tag = await model.findById(id);
    } catch (error) {
        console.log("Here We Go");
    } finally {
        return tag;
    }
}

const add = async (name) => {
    let result = null;
    try {
        result = await new model({ name }).save();
    } catch (error) {
        console.log("Error at Add in TagService");
    } finally {
        return result;
    }
}

const modify = async (id, obj) => {
    let result = null;
    try {
        result = await model.findByIdAndUpdate(id, obj, { new: true });
    } catch (error) {
        console.log("Error at Modify in TagService");
    } finally {
        return result;
    }
}

const remove = async (id) => {

    let result = null;
    try {
        result = await model.findByIdAndDelete(id);
    } catch (e) {
        console.log("Error at Remove in TagService");
    } finally {
        return result;
    }

}

module.exports = {
    getAll,
    getByName,
    getById,
    add,
    modify,
    remove
}