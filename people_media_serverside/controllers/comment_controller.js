const { Msg, CommentService } = require('../utils/facade');

const getCommentByPostId = async (req, res, next) => {
    let role = req.user.role;
    let postId = req.params.id;
    let comments = await CommentService.get(role, postId);
    Msg(res, "All Comment", comments);
}

const add = async (req, res, next) => {
    let comObj = {
        postId: req.body.postId,
        user: req.userId,
        content: req.body.content,
        image: req.body.image,
        status: "ACCEPT"
    }
    let saveComment = await CommentService.add(comObj);
    Msg(res, "Commnet Saved", saveComment);
}
const addPlain = async (req, res, next) => {
    let comObj = {
        postId: req.body.postId,
        user: req.userId,
        content: req.body.content,
        image: "",
        status: "ACCEPT"
    }
    let saveComment = await CommentService.add(comObj);
    Msg(res, "Commnet Saved", saveComment);
}

const updateStatus = async (req, res, next) => {
    let commentId = req.params.id;
    let status = req.body.status;

    let updatedComment = await CommentService.modify(commentId, { status });

    Msg(res, "Comment Status Updated", updatedComment);

}

const dropComment = async (req, res, next) => {
    let commentId = req.params.id;
    await CommentService.drop(commentId);
    Msg(res, "Comment Dropped", {});
}

module.exports = {
    getCommentByPostId,
    add,
    updateStatus,
    dropComment,
    addPlain
}