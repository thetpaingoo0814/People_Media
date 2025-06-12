const router = require('express').Router();
const Controller = require('../controllers/tag_controller');
const { validateBody, validateToken, validateRole, tagSchema } = require("../utils/facade");

// router.post('/', validateBody(tagSchema.add), validateToken, validateRole(0), Controller.create);
// router.get('/single/:id', validateToken, validateRole(0), Controller.get);
// router.patch('/:id', validateBody(tagSchema.patch), validateToken, validateRole(0), Controller.update);
// router.delete('/:id', validateToken, validateRole(0), Controller.drop);

router.post('/', validateToken, Controller.create);
router.get('/single/:id', validateToken, Controller.get);
router.patch('/:id', validateToken, Controller.update);
router.delete('/:id', validateToken, Controller.drop);

module.exports = router;