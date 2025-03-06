import db from "../DB/dbCon.js"

async function addDevice(owner, aditionalInfo) {
    return await db.collection('devices').insertOne({
        "owner": owner,
        "location": "Unknown",
        "device_name":"Unnamed",
        "aditionalInfo": aditionalInfo
    })
}

async function getDeviceById(dev_id) {
    return await db.collection('devices').findOne({
        "_id": dev_id
    })
}

async function getDeviceByOwner(owner) {
    return await db.collection('devices').find({
        "owner": owner
    }).toArray()
}

async function updateDevice(dev_id, newInfo) {
    return db.collection('devices').updateOne({
        "_id": dev_id
    }, {
        $set: newInfo
    })
}

async function deleteDevice(dev_id) {
    return await db.collection('devices').deleteOne({
        "_id": dev_id
    })
}