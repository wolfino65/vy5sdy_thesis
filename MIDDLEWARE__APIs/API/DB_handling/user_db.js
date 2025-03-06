import db from "../DB/dbCon.js"

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
    return await db.collection('users').findOne({
        "_id": user_id
    })
}

async function getUserByEmail(email) {
    return await db.collection('users').findOne({
        "email": email
    })
}

async function updateUser(user_id, newInfo) {
    return await db.collection('users').updateOne({
        "_id": user_id
    }, {
        $set: newInfo
    })
}