const { Mongo, Schema } = require('./db');

const CommentSchema = new Schema({
    postId: { type: Schema.Types.ObjectId, ref: "posts" },
    user: { type: Schema.Types.ObjectId, ref: "users" },
    content: { type: String, required: true },
    image: { type: String, default: "" },
    status: { type: String, enum: ["PROCESSING", "ACCEPT", "DENY"], default: "PROCESSING" },
    created: { type: Date, default: Date.now }
})

const Comment = Mongo.model("comments", CommentSchema);

module.exports = Comment;
 