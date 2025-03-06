import express from 'express';
import bodyParser from 'body-parser';

import userRouter from './Routing/user_endpoints.js';
import deviceRouter from './Routing/device_endpoints.js';
import moduleRouter from './Routing/module_endpoints.js';
import taskRouter from './Routing/task_endpoints.js';

var app = express();
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.use('/user', userRouter);
app.use('/device', deviceRouter);
app.use('/module', moduleRouter);
app.use('/task', taskRouter);

app.listen(4500, () => {
    console.log("server started.")
}
)