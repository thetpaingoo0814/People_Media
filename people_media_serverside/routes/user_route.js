const router = require('express').Router();
const Controller = require('../controllers/user_controller');
const { validateBody, validateToken, validateRole, saveSingleFile } = require('../utils/facade');

router.get('/pagi/:index', validateToken, validateRole(0), Controller.getUsers);
router.get('/single/:id', validateToken, validateRole(0), Controller.getSingleUser);
router.post('/changerole', validateToken, validateRole(0), Controller.changeRole);
router.post('/changeName', validateToken, Controller.changeName);
router.post('/changePassword', validateToken, Controller.changePassword);
router.post('/changeProfile', validateToken, saveSingleFile, Controller.changeProfile);

module.exports = router;