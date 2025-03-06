import db from "../DB/dbCon.js"

async function addModule(device_file_id, frontend_file_id, aditionalInfo)  {
    return await db.collection('modules').insertOne({
        "py_id":device_file_id,
        "front_id":frontend_file_id,
        "aditionalInfo": aditionalInfo
    })
}

async function getModuleById(module_id) {
    return await db.collection('modules').findOne({
        "_id": module_id
    })
}

async function updateModule(module_id, newInfo) {
    return await db.collection('modules').updateOne({
        "_id": module_id
    }, {
        $set: newInfo
    })
}
