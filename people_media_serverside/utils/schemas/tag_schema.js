const Joi = require('joi');

const tagSchema = {
    add : Joi.object({
        name:Joi.string() 
            .min(3)
            .max(20)
            .required()
    }),
    patch:Joi.object({
        name:Joi.string()
        .min(3)
        .max(20)
    })
}

module.exports = {
    tagSchema
}