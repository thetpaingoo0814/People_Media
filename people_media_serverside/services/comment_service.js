const model = require('../models/comment_model');

const add = async (obj) => {
    let addedComment = await new model(obj).save();
    return addedComment;
}

const get = async (role, postId) => {
    let comments = [];
    switch (role) {
        case 0: comments = await model.find({ postId }).populate('user', 'name'); break;
        default: comments = await model.find({ postId, status: "ACCEPT" }).populate('user', 'name'); break;
    }
    return comments;
}

const modify = async (commentId, obj) => {
    let modi = await model.findByIdAndUpdate(commentId, obj, { new: true });
    return modi;
}

const drop = async (commentId) => {
    await model.findByIdAndDelete(commentId);
    return;
}

module.exports = {
    add,
    get,
    modify,
    drop
}
