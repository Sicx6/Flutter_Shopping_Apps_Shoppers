console.log('hello world');
//import from pckg
const express = require('express');
const mongoose = require('mongoose');
const db = "mongodb+srv://sicx:17Mei1995.@cluster0.lgklrhr.mongodb.net/?retryWrites=true&w=majority";
const port = 3000;

const app = express();
const authRouter = require('./routes/auth');
const adminRouter = require("./routes/admin");
const productRouter = require('./routes/product');
const userRouter =  require('./routes/user');

//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);


//connection
mongoose.connect(db).then(() => {
    console.log('connection successful');
}).catch((e) => {
    console.log(e);
});

//create api

app.listen(port, "0.0.0.0", () => {
    console.log(`connected at port ${port}`);
});