import express from 'express';
import bodyParser from 'body-parser';
import userRouter from './Routing/user_endpoints.js';

var app = express();
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use('/user', userRouter);


app.listen(4500, () => {
    console.log("server started.")
    }
)