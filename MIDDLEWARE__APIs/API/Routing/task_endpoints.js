import express from 'express'
import { addTask, getTasksByDeviceId, deleteTask } from '../DB_handling/tasks_db.js'
var taskRouter = express.Router();
var responses = []
taskRouter.post('/addTask', async (req, res) => {
    let { dev_id, module_id, user_id, params, aditionalInfo } = req.body;
    let result = await addTask(dev_id, module_id, user_id, params, aditionalInfo);
    executeByIndex(checkForData(dev_id))
    res.send(result);
})
var currentExecution = []
taskRouter.get('/getTasksByDeviceId', async (req, res) => {
    let { dev_id } = req.headers;
    var i = checkForData(dev_id)
    if (i > -1) {
        executeByIndex(i)
    }
    else {
        let result = await getTasksByDeviceId(dev_id);

        if (JSON.stringify(result) === '[]' || getExec(dev_id) > -1) {
            responses.push({
                "dev_id": dev_id,
                "res": res
            })
        }
        else {
            res.send(result);
        }
    }
})

taskRouter.delete('/deleteTask', async (req, res) => {
    let { task_id } = req.headers;
    let result = await deleteTask(task_id);
    res.send(result);
})

async function executeByIndex(i) {
    if (i > -1) {
        var element = responses[i]
        currentExecution.push(element['dev_id'])
        var resp = element['res']
        let result = await getTasksByDeviceId(element['dev_id']);
        resp.send(result)
        remove(currentExecution, element['dev_id'])
        remove(responses, element['dev_id'], true, 'dev_id')
    }
}

function checkForData(dev_id) {
    return responses.findIndex((el) => el['dev_id'] == dev_id)
}

function remove(arr, data, isJSON = false, JSONIdentifier) {
    if (isJSON) {
        arr.splice(arr.findIndex((el) => el[JSONIdentifier] == data), 1)
    }
    else {
        arr.splice(arr.findIndex((el) => el == data), 1)
    }
}
function getExec(JSONIdentifier) {
    return currentExecution.findIndex((el) => el == JSONIdentifier)
}
export default taskRouter;