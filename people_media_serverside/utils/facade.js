const { saveSingleFile, saveMultipleFile, deleteImageByName, deleteImageByLink } = require('./gallery');
const { RDB, ENCODER, TOKEN, Msg, makeRandom } = require('./util');
const { validateToken, validateRole, validateStaff, validateBody } = require('./validator');

const UserService = require('../services/user_service');
const CategoryService = require("../services/category_service");
const TagService = require('../services/tag_service');
const PostService = require('../services/post_service');
const CommentService = require('../services/comment_service');
const AdvService = require('../services/adv_service');

const { userSchema } = require('./schemas/user_schema');
const { tagSchema } = require('./schemas/tag_schema');
const { postSchema } = require('./schemas/post_schema');

module.exports = {
    saveSingleFile,
    saveMultipleFile,
    deleteImageByName,
    deleteImageByLink,

    RDB,
    ENCODER,
    TOKEN,
    Msg,
    makeRandom,

    userSchema,
    tagSchema,
    postSchema,

    validateToken,
    validateRole,
    validateStaff,
    validateBody,

    UserService,
    CategoryService,
    TagService,
    PostService,
    CommentService,
    AdvService

}