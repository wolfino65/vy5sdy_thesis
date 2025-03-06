import express from 'express';
import { registerUser, login, getUserById, getUserByEmail, updateUser } from '../DB_handling/user_db.js';

var userRouter = express.Router();

userRouter.post('/register', async (req, res) => {
    let { username, password, email } = req.body;
    let result = await registerUser(username, password, email);
    res.send(result);
    console.log(result);
})




export default userRouter;