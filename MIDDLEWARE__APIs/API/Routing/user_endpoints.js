import express from 'express';
import { registerUser, login, getUserById, getUserByEmail, updateUser, deleteUser } from '../DB_handling/user_db.js';

var userRouter = express.Router();

userRouter.post('/register', async (req, res) => {
    let { username, password, email } = req.body;
    let result = await registerUser(username, password, email);
    res.send(result);
})

userRouter.post('/login', async (req, res) => {
    let { email, password } = req.body;
    console.log(password);
    let result = await login(email, password);
    console.log(result);
    res.send(result);
})

userRouter.get('/getUserById', async (req, res) => {
    let { user_id } = req.headers;
    let result = await getUserById(user_id);
    res.send(result);
})

userRouter.get('/getUserByEmail', async (req, res) => {
    let { email } = req.headers;
    let result = await getUserByEmail(email);
    res.send(result);
})
userRouter.put('/updateUser', async (req, res) => {
    let { user_id, newInfo } = req.body;
    let result = await updateUser(user_id, newInfo);
    res.send(result);
})
userRouter.delete('/deleteUser', async (req, res) => {
    let { user_id } = req.headers;
    let result = await deleteUser(user_id);
    res.send(result);
})
export default userRouter;