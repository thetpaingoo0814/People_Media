const { Mongo, Schema } = require('./db');

const AdvSchema = new Schema({
    image: { type: String, required: true },
    content: { type: String, default: "" },
    status: { type: String, enum: ["PROCESSING", "ACTIVE", "IDEL"], default: "PROCESSING" },
    created: { type: Date, default: Date.now }
})

const Adv = Mongo.model("advs", AdvSchema);

module.exports = Adv;