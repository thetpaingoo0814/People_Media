const { Msg, UserService, ENCODER, TOKEN } = require('../utils/facade');

const register = async (req, res, next) => {
    let name = req.body.name.toLowerCase();
    let phone = req.body.phone;
    let password = req.body.password;
    let displayName = req.body.displayName;

    const namedUser = await UserService.getByName(name);

    if (namedUser) {
        next(new Error("Username is already in use!"));
        return;
    }

    let phonedUser = await UserService.getByPhone(phone);

    if (phonedUser) {
        next(new Error("Phone is already in use!"));
        return;
    }

    password = ENCODER.encode(password);

    let result = await UserService.add(name, displayName, phone, password);
    Msg(res, "Register Success", result);

}

const login = async (req, res, next) => {
    let name = req.body.name.toLowerCase();
    let password = req.body.password;

    let namedUser = await UserService.getByName(name);

    if (!namedUser) {
        next(new Error("Creditial Error"));
        return;
    }

    if (!ENCODER.compare(password, namedUser.password)) {
        next(new Error("Creditial Error"));
        return;
    }

    await UserService.setCacheUser(namedUser._id.toString());
    let token = TOKEN.makeToken(namedUser._id.toString());

    Msg(res, "Login Success", token);

}

const getMe = async (req, res, next) => {
    let userId = req.userId;
    let user = req.user;
    Msg(res, "User Detail", user);
}

const getUsers = async (req, res, next) => {
    let pageIndex = req.params.index;
    let users = await UserService.getUsers(pageIndex);
    Msg(res, `Page Index ${pageIndex}'s users`, users);
}

const getSingleUser = async (req, res, next) => {
    let userId = req.params.id;
    let user = await UserService.getById(userId);
    Msg(res, "Single User", user);
}

const changeRole = async (req, res, next) => {
    let userId = req.body.userId;
    let role = req.body.role;
    let user = await UserService.getById(userId);
    if (user) {
        await UserService.changeRole(user._id, role);
        Msg(res, "User Role Changed!", {});
    } else {
        next(new Error("No User with that id"));
    }
}

const changeName = async (req, res, next) => {
    let user = req.user;
    let name = req.body.name;
    await UserService.modify(user._id, { name });
    await UserService.setCacheUser(user._id.toString());
    Msg(res, "Name Change Success", {});
}

const changePassword = async (req, res, next) => {
    let user = req.user;
    let password = ENCODER.encode(req.body.password);
    await UserService.modify(user._id, { password });
    await UserService.setCacheUser(user._id.toString());
    Msg(res, "Password Change Success", {});
}
const changeProfile = async (req, res, next) => {
    let user = req.user;
    let profile = req.body.image;
    await UserService.modify(user._id, { profile });
    await UserService.setCacheUser(user._id.toString());
    Msg(res, "Password Change Success", {});
}

module.exports = {
    register,
    login,
    getMe,
    getUsers,
    getSingleUser,
    changeRole,
    changeName,
    changePassword,
    changeProfile
}