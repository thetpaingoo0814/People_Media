const { CategoryService, Msg, deleteImageByLink } = require('../utils/facade');

const all = async (req, res, next) => {
    let cats = await CategoryService.getAll();
    Msg(res, "All Categories", cats);
}

const add = async (req, res, next) => {

    let name = req.body.name;
    let image = req.body.image;
    let desc = req.body.desc;

    let category = await CategoryService.getByName(name);
    if (category) {
        next(new Error("Category name is already in use!"));
    } else {
        let result = await CategoryService.add(name, image, desc);
        Msg(res, "New Category Created", result);
    }
    
}

const update = async (req, res, next) => {
    let catId = req.params.id;
    let body = req.body;

    let category = await CategoryService.getById(catId);
    if (category) {
        let result = await CategoryService.modify(catId, body);
        Msg(res, "Category Updated", result);
    } else {
        next(new Error("No Category with that id!"));
    }

}

const drop = async (req, res, next) => {
    let catId = req.params.id;
    let category = await CategoryService.getById(catId);
    if (category) {
        deleteImageByLink(category.image);
        let result = await CategoryService.remove(catId);
        Msg(res, "Category Deleted", result);
    } else {
        next(new Error("No Category with that id!"));
    }
}

module.exports = {
    all,
    add,
    update,
    drop
}