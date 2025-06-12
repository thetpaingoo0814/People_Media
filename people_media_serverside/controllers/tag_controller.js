const { Msg, TagService } = require('../utils/facade');

const all = async (req, res, next) => {
    let tags = await TagService.getAll();
    if (tags) {
        Msg(res, "All Tags", tags);
    } else {
        next(new Error("Something wrong! Contact Developer!"));
    }
}

const get = async (req, res, next) => {
    let tag = await TagService.getById(req.params.id);
    if (tag) {
        Msg(res, "Single Tag", tag);
    } else {
        next(new Error("No Tag with that id!"));
    }
}

const create = async (req, res, next) => {

    let name = req.body.name.toLowerCase();

    let dbTag = await TagService.getByName(name);
    if (dbTag) {
        next(new Error("Tag name is already in use!"));
    } else {
        let result = await TagService.add(name);
        Msg(res, "Tag Created!", result);
    }
}

const update = async (req, res, next) => {

    let id = req.params.id;
    let tag = await TagService.getById(id);
    if (tag) {
        let result = await TagService.modify(tag._id, req.body);
        Msg(res, "Tag Updated", result);
    } else {
        next(new Error("No tag with that id!"));
    }
    
}

const drop = async (req, res, next) => {
    let id = req.params.id;
    let tag = await TagService.getById(id);

    if (tag) {
        let result = await TagService.remove(tag._id);
        Msg(res, "Tag Dropped", result);
    } else {
        next(new Error("No tag with that id!"));
    }
}

module.exports = {
    all,
    create,
    get,
    update,
    drop
}