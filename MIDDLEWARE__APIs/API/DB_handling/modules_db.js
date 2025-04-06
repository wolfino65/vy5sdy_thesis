import db from "../DB/dbCon.js"
import { ObjectId } from "mongodb"

async function addModule(device_file_id, frontend_file_id, aditionalInfo,name) {
    return await db.collection('modules').insertOne({
        "py_id": device_file_id,
        "front_id": frontend_file_id,
        "name":name,
        "aditionalInfo": aditionalInfo
    })
}

async function getModuleById(module_id) {
    const oid = new ObjectId(module_id)
    return await db.collection('modules').findOne({
        "_id": oid
    })
}

async function updateModule(module_id, newInfo) {
    const oid = new ObjectId(module_id)
    return await db.collection('modules').updateOne({
        "_id": oid
    }, {
        $set: newInfo
    })
}

async function deleteModule(module_id) {
    const oid = new ObjectId(module_id)
    return await db.collection('modules').deleteOne({
        "_id": oid
    })
}

async function getModules() {
    return await db.collection('modules').find().toArray();
}

export { getModuleById, addModule, updateModule, deleteModule,getModules }