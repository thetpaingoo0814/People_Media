const { Mongo, Schema } = require('./db');

const UserSchema = new Schema({
    name: { type: String, unique: true, required: true },
    phone: { type: String, unique: true, required: true },
    password: { type: String, required: true },
    displayName: { type: String, required: true },
    role: { type: Number, default: 2 }, // 0 => Owner/Dev , 1 => Author , 2 => Reader/User 
    profile: { type: String, required: true },
    created: { type: Date, default: Date.now }
})

UserSchema.index({ name: 1 });
 
const User = Mongo.model("users", UserSchema);

module.exports = User;