const router = require('express').Router();
const Controller = require('../controllers/adv_controller');
const { validateToken, validateRole, saveSingleFile } = require('../utils/facade');

const checkFileExist = (req, res, next) => {
    if (req.files) {
        if (req.files.file) {
            saveSingleFile(req, res, next);
        } else next(new Error("No File"));
    } else next();
}

router.get('/', validateToken, validateRole(0), Controller.all);
router.post('/', validateToken, validateRole(0), saveSingleFile, Controller.add);
router.delete('/:id', validateToken, validateRole(0), Controller.drop);
router.post("/:id", validateToken, validateRole(0), checkFileExist, Controller.update)

module.exports = router;