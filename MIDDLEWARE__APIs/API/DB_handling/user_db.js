import db from "../DB/dbCon.js"
import  {ObjectId}  from "mongodb"

async function registerUser(username, password, email) {
    return await db.collection('users').insertOne({
        "username": username,
        "password": password,
        "email": email
    })
}

async function login(email, password) {
    return await db.collection('users').findOne({
        "email": email,
        "password": password
    })
}

async function getUserById(user_id) {
    const oid= new ObjectId(user_id);
    return await db.collection('users').findOne({
        "_id": oid
    })
}

async function getUserByEmail(email) {
    return await db.collection('users').findOne({
        "email": email
    })
}

async function updateUser(user_id, newInfo) {
    const oid= new ObjectId(user_id);
    return await db.collection('users').updateOne({
        "_id": oid
    }, {
        $set: newInfo
    })
}
async function deleteUser(user_id) {
    const oid= new ObjectId(user_id);
    return await db.collection('users').deleteOne({
        "_id": oid
    })
}
export { registerUser, login, getUserById, getUserByEmail, updateUser, deleteUser }