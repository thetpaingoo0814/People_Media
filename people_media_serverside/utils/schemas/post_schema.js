const Joi = require('joi');

const postSchema = {
    add: Joi.object({
        title: Joi.string()
            .min(5)
            .max(20)
            .required(),
        content: Joi.string()
            .required(),
        category: Joi.string()
            .required(),
        tag: Joi.string()
            .required()
    })
}

module.exports = {
    postSchema
}