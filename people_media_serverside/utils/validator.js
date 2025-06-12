const JWT = require('jsonwebtoken');
const UserService = require('../services/user_service');

module.exports = {
    validateToken: async (req, res, next) => {
        if (!req.headers.authorization) {
            next(new Error("Authorization Error"));
        } else {
            let token = req.headers.authorization.split(" ")[1];
            JWT.verify(token, process.env.SECRET_KEY, async (err, decoded) => {
                if (err) {
                    if (err.message == "jwt expired") {
                        next(new Error("Session ပျက်သွားလို့ Login ပြန်ဝင်ပါ"));
                    } else {
                        next(new Error("Authorization Error"));
                    }
                } else {
                    let userId = decoded.id;
                    let user = await UserService.getCacheUser(userId);
                    if (!user) {
                        next(new Error("Authoziration Error"));
                        return;
                    }
                    req.userId = userId;
                    req.user = user;
                    next();
                }
            });
        }
    },
    validateRole: (Role) => {
        return async (req, res, next) => {
            if (req.user.role === Role) {
                next();
            } else {
                next(new Error("You are not permitted to use this route!"));
            }
        }
    },
    validateStaff: (req, res, next) => {
        if (req.user.role <= 1) {
            next();
        } else {
            next(new Error("You are not permitted to use this route!"));
        }
    },
    validateBody: (schema) => {
        return (req, res, next) => {
            const result = schema.validate(req.body);
            if (result.error) {
                next(new Error(result.error.details[0].message));
            } else {
                next();
            }
        }
    }
}