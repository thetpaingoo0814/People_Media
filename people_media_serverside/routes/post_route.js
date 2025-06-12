const router = require('express').Router();
const Controller = require('../controllers/post_controller');
const { validateToken, validateRole, validateBody, validateStaff, saveMultipleFile, postSchema } = require('../utils/facade');

// router.post('/', validateToken, validateRole(1), validateBody(postSchema.add),saveMultipleFile, Controller.add);
// router.patch('/:id', validateToken, validateRole(1), saveMultipleFile, Controller.update)
// router.delete('/:id',validateToken,validateStaff,Controller.drop);

router.post('/', validateToken, saveMultipleFile, Controller.add);
router.patch('/plane/:id', validateToken, Controller.update);
router.patch('/:id', validateToken, saveMultipleFile, Controller.update);
router.delete('/:id', validateToken, Controller.drop);

module.exports = router;




