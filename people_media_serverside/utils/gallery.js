const fs = require('fs'),
    path = require('path');

// const getFilePath = (filename) => path.join(__dirname,"../public/images/"+filename);
const getFilePath = (filename) => path.join(__dirname, `../public/images/${filename}`);
const getImageLink = (filename) => `${process.env.IMAGE_PATH}/${filename}`;
const genFileName = (filename) => new Date().valueOf() + "_" + filename.replace(/\s/g, '');

const shareSave = (file) => {
    let fileName = genFileName(file.name);
    file.mv(getFilePath(fileName));
    return getImageLink(fileName);
}

const saveSingleFile = (req, res, next) => {
    if (req.files) {
        if (req.files.file) {
            req.body['image'] = shareSave(req.files.file);
            next();
        } else next(new Error("No File"));
    } else next(new Error("No File"));
}

const saveMultipleFile = (req, res, next) => {
    let imgPaths = [];
    if (req.files) {
        if (req.files.files) {
            for (let file of req.files.files) {
                let imagePath = shareSave(file);
                imgPaths.push(imagePath);
            }
            req.body['images'] = imgPaths;
            next();
        } else next(new Error("No Files"));
    } else next(new Error("No Files"));
}

const deleteImageByName = (name) => {
    let filePath = getFilePath(name);
    if (fs.existsSync(filePath)) {
        fs.unlinkSync(filePath);
    }
}

const deleteImageByLink = (link) => {
    // http://127.0.0.1:3000/images/shirt.png
    let pathAry = link.split("/");
    let name = pathAry[pathAry.length - 1];
    deleteImageByName(name);
}

module.exports = {
    saveSingleFile,
    saveMultipleFile,
    deleteImageByName,
    deleteImageByLink
}

