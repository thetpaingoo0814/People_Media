//This code is created by M23W7502_ThetPaingOo
const { Msg, PostService, deleteImageByLink } = require('../utils/facade');

const get = async (req, res, next) => {
    let pageIndex = req.params.index;
    let posts = await PostService.get(pageIndex);
    Msg(res, "Paginated Posts", posts);
}
const getById = async (req, res, next) => {
    let postId = req.params.id;
    let post = await PostService.getById(postId);
    Msg(res, "Single Post", post);
}
const addPostLike = async (req, res, next) => {
    let postId = req.params.id;
    await PostService.addLike(postId);
    Msg(res, "Post like added", {});
}
const postsByTag = async (req, res, next) => {
    let index = req.params.index;
    let tagId = req.params.id;

    let posts = await PostService.getByTag(index, tagId);

    Msg(res, "Posts by tag", posts);
}

const postsByCat = async (req, res, next) => {
    let index = req.params.index;
    let catId = req.params.id;


    let posts = await PostService.getByCat(index, catId);

    Msg(res, "Posts by Category Id", posts);
}

const postsByAuthor = async (req, res, next) => {
    let index = req.params.index;
    let authId = req.params.id;

    let posts = await PostService.getByAuthor(index, authId);

    Msg(res, "Posts by Author id", posts);
}

const add = async (req, res, next) => {
    let author = req.userId;
    req.body["author"] = req.userId;
    let result = await PostService.add(req.body);
    Msg(res, "Success", result);
}

const update = async (req, res, next) => {
    let id = req.params.id;

    let updateData = req.body;

    let dbPost = await PostService.getById(id);

    if (dbPost) {
        if (Object.keys(updateData).includes("images")) {
            dbPost.images.forEach((image) => deleteImageByLink(image));
        }
        let result = await PostService.update(dbPost._id, req.body);
        Msg(res, "Post Updated", result);
    } else {
        next(new Error("No Post with that id!"));
    }
}

const drop = async (req, res, next) => {
    let id = req.params.id;
    let dbPost = await PostService.getById(id);
    if (dbPost) {
        if (dbPost.images.length > 0) {
            dbPost.images.forEach(image => deleteImageByLink(image));
        }
        let result = await PostService.drop(dbPost._id);
        Msg(res, "Post Deleted", result);
    } else {
        next(new Error("No Post with that id!"));
    }
}
module.exports = {
    get,
    postsByTag,
    postsByCat,
    postsByAuthor,
    add,
    update,
    drop,
    getById,
    addPostLike
}
