import express from 'express'
import { addTask, getTasksByDeviceId, deleteTask } from '../DB_handling/tasks_db.js'
var taskRouter = express.Router();
var responses = []
taskRouter.post('/addTask', async (req, res) => {
    let { dev_id, module_id, user_id, params, aditionalInfo } = req.body;
    let result = await addTask(dev_id, module_id, user_id, params, aditionalInfo);
    checkForData(dev_id)
    res.send(result);
})

taskRouter.get('/getTasksByDeviceId', async (req, res) => {
    let { dev_id } = req.headers;
    let result = await getTasksByDeviceId(dev_id);

    if (JSON.stringify(result)==='[]') {
        responses.push({
            "dev_id": dev_id,
            "res": res
        })
    }
    else {
        res.send(result);
    }
})

taskRouter.delete('/deleteTask', async (req, res) => {
    let { task_id } = req.headers;
    let result = await deleteTask(task_id);
    res.send(result);
})

async function checkForData(requesting_dev_id) {
    for (const element of responses) {
        if (element['dev_id'] === requesting_dev_id) {
            var resp = element['res']
            let result = await getTasksByDeviceId(element['dev_id']);
            resp.send(result)
        }
    }
}

export default taskRouter;