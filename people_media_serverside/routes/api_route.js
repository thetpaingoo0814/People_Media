const router = require('express').Router();
const AdvController = require('../controllers/adv_controller');
const CatController = require('../controllers/category_controller');
const TagController = require('../controllers/tag_controller');
const CommentController = require('../controllers/comment_controller');
const PostController = require('../controllers/post_controller');
const UserController = require('../controllers/user_controller');
const { validateToken, validateRole, validateBody, saveSingleFile, userSchema } = require("../utils/facade");

router.get('/advs', AdvController.allActives);
router.get('/cats', CatController.all);
router.get('/tags', TagController.all);

// Comments 
router.get('/cmmt/:id', validateToken, CommentController.getCommentByPostId);
router.post('/cmmt/plain', validateToken, CommentController.addPlain);
router.post('/cmmt', validateToken,  saveSingleFile, CommentController.add);

// Posts 
router.get('/post/:index', PostController.get);
router.get('/post/tag/:id/:index', PostController.postsByTag);
router.get('/post/cat/:id/:index', PostController.postsByCat);
router.get('/post/auth/:id/:index', PostController.postsByAuthor);
router.get('/post/byid/:id',PostController.getById);
router.get('/post/like/:id',PostController.addPostLike);

// Users
router.post('/register', validateBody(userSchema.register), UserController.register);
// router.post('/login', validateBody(userSchema.login), UserController.login);
router.post('/login', UserController.login);
router.get('/me', validateToken, UserController.getMe);
router.get("/version/:version", (req, res) => {
    let localVersion = req.params.version;
    if (localVersion == "1.0.1") {
        res.status(200).json({ con: true });
    } else {
        res.status(200).json({ con: false, msg: "http://brightermyanmar.org/peoplemedia.apk" });
    }

});

module.exports = router; 
