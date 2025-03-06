import db from "../DB/dbCon.js"
import { ObjectId } from "mongodb"

async function addDevice(owner, aditionalInfo) {
    return await db.collection('devices').insertOne({
        "owner": owner,
        "location": "Unknown",
        "device_name":"Unnamed",
        "aditionalInfo": aditionalInfo
    })
}

async function getDeviceById(dev_id) {
    const oid= new ObjectId(dev_id)
    return await db.collection('devices').findOne({
        "_id": oid
    })
}

async function getDeviceByOwner(owner) {
    return await db.collection('devices').find({
        "owner": owner
    }).toArray()
}

async function updateDevice(dev_id, newInfo) {
    const oid= new ObjectId(dev_id)
    return db.collection('devices').updateOne({
        "_id": oid
    }, {
        $set: newInfo
    })
}

async function deleteDevice(dev_id) {
    const oid= new ObjectId(dev_id)
    return await db.collection('devices').deleteOne({
        "_id": oid
    })
}

export { getDeviceById, getDeviceByOwner, addDevice, updateDevice, deleteDevice }