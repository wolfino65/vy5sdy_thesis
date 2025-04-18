import db from "../DB/dbCon.js"
import { ObjectId } from "mongodb"

async function addTask(dev_id, module_id, user_id, params,aditionalInfo) {
    return await db.collection('tasks').insertOne({
        "device_id": dev_id,
        "module_id": module_id,
        "user_id": user_id,
        "module_params": params,
        "aditionalInfo": aditionalInfo,
    })
}

async function getTasksByDeviceId(dev_id) {
    return await db.collection('tasks').find({
        "device_id": dev_id
    }).toArray()
}

async function  deleteTask(task_id) {
    const oid = new ObjectId(task_id)
    return await db.collection('tasks').deleteOne({
        "_id": oid
    })
}

export { addTask, getTasksByDeviceId, deleteTask }