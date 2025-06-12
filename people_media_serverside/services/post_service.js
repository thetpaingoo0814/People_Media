const PostModel = require("../models/post_model");

const getById = async (id) => await PostModel.findById(id).populate('author', 'name');

const get = async (pageIndex) => {
    let pageCount = 10;
    let posts = await PostModel.find({}).populate('author', 'name').skip(pageIndex * pageCount).sort({ 'created': -1 })
        .limit(pageCount);
    return posts;
}
const addLike = async (postId) => {
    await PostModel.findByIdAndUpdate(postId, { $inc: { likes: 1 } });
    return;
}

const getByTag = async (pageIndex, tagId) => {
    let pageCount = 10;
    let posts = await PostModel.find({ tag: tagId }).skip(pageIndex * pageCount)
        .sort({ 'created': -1 }).limit(pageCount);
    return posts;
}

const getByCat = async (pageIndex, catId) => {
    let pageCount = 10;
    let posts = await PostModel.find({ category: catId }).populate('author', 'name').skip(pageIndex * pageCount)
        .sort({ 'created': -1 }).limit(pageCount);
    return posts;
}

const getByAuthor = async (pageIndex, authId) => {
    let pageCount = 10;
    let posts = await PostModel.find({ author: authId }).skip(pageIndex * pageCount)
        .sort({ 'created': -1 }).limit(pageCount);
    return posts;
}

const add = async (post) => {
    let result = null;

    try {
        result = await new PostModel(post).save();
    } catch (error) {
        console.log(error);
    } finally {
        return result;
    }
}

const update = async (id, data) => {
    let result = null;

    try {
        result = await PostModel.findByIdAndUpdate(id, data, { new: true });
    } catch (e) {
        console.log(e);
    } finally {
        return result;
    }

}

const drop = async (id) => await PostModel.findByIdAndDelete(id);

module.exports = {
    getById,
    getByTag,
    getByCat,
    getByAuthor,
    get,
    add,
    update,
    drop,
    addLike
}