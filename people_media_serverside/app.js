require('dotenv').config();
const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const fileUpload = require('express-fileupload');

const mongoose = require('mongoose');
mongoose.connect(process.env.DB_URL);

app.use(express.static('public'));
app.use(express.json({ limit: '10mb' }));
app.use(fileUpload());

const userRouter = require('./routes/user_route');
const categoryRouter = require('./routes/category_route');
const tagRouter = require('./routes/tag_route');
const postRouter = require('./routes/post_route');
const commentRouter = require('./routes/comment_route');
const advRouter = require('./routes/adv_route');
const apiRouter = require('./routes/api_route');

app.use('/users', userRouter);
app.use('/cats', categoryRouter);
app.use('/tags', tagRouter);
app.use('/posts', postRouter);
app.use('/comments', commentRouter);
app.use('/advs', advRouter);
app.use('/apis', apiRouter);


app.use((error, req, res, next) => {
    error.status = error.status || 400;
    res.status(error.status).json({ con: false, msg: error.message });
})

server.listen(process.env.PORT, () => {
    console.clear();
    console.log("Server is Runnint at port ", process.env.PORT);
})
