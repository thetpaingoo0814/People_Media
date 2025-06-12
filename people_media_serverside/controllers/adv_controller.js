const { Msg, AdvService, deleteImageByLink } = require("../utils/facade");

const all = async (req, res, next) => {
    let advs = await AdvService.all();
    Msg(res, "All Advertisements", advs);
}

const allActives = async (req, res, next) => {
    let advs = await AdvService.allActives();
    Msg(res, "All Active Advs", advs);
}

const add = async (req, res, next) => {
    let obj = {
        image: req.body.image,
        content: req.body.content
    }
    let adv = await AdvService.add(obj);
    Msg(res, "Advertisement Created!", adv)
}

const drop = async (req, res, next) => {
    let advId = req.params.id;
    let dbAdv = await AdvService.get(advId);
    if (dbAdv) {
        deleteImageByLink(dbAdv.image);
        await AdvService.drop(advId);
        Msg(res, "Advertisement Dropped!", {});
    } else {
        next(new Error("No Adv with that id!"));
    }
}

const update = async (req, res, next) => {
    let id = req.params.id;
    let obj = {};

    if (req.body.image) obj["image"] = req.body.image;
    if (req.body.content) obj["content"] = req.body.content;
    if (req.body.status) obj["status"] = req.body.status;

    let updateAdv = await AdvService.modify(id, obj);
    Msg(res, "Adv Updated", updateAdv);
}


module.exports = {
    add,
    all,
    drop,
    update,
    allActives
}