// This code is create by M23W7502_ThetPaingOo
const { Mongo, Schema } = require('./db');

const CategorySchema = new Schema({
    name: { type: String, unique: true, required: true },
    image: { type: String, required: true },
    desc: { type: String, required: true }
})

const Category = Mongo.model("categories", CategorySchema);

module.exports = Category;


