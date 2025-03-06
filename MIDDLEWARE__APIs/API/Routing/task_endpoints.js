import express from 'express'
import { addTask, getTasksByDeviceId, deleteTask } from '../DB_handling/tasks_db.js'
var taskRouter = express.Router();

taskRouter.post('/addTask', async (req, res) => {
    let { dev_id, module_id, user_id, params, aditionalInfo } = req.body;
    let result = await addTask(dev_id, module_id, user_id, params, aditionalInfo);
    res.send(result);
})

taskRouter.get('/getTasksByDeviceId', async (req, res) => {
    let { dev_id } = req.headers;
    let result = await getTasksByDeviceId(dev_id);
    res.send(result);
})

taskRouter.delete('/deleteTask', async (req, res) => {
    let { task_id } = req.headers;
    let result = await deleteTask(task_id);
    res.send(result);
})

export default taskRouter;