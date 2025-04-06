import express from 'express'
import { getModuleById, addModule, updateModule, deleteModule,getModules } from '../DB_handling/modules_db.js'
var moduleRouter = express.Router();

moduleRouter.post('/addModule', async (req, res) => {
    let { device_file_id, frontend_file_id, aditionalInfo ,name } = req.body;
    let result = await addModule(device_file_id, frontend_file_id, aditionalInfo, name);
    res.send(result);
})

moduleRouter.get('/getModuleById', async (req, res) => {
    let { module_id } = req.headers;
    let result = await getModuleById(module_id);
    res.send(result);
})

moduleRouter.put('/updateModule', async (req, res) => {
    let { module_id, newInfo } = req.body;
    let result = await updateModule(module_id, newInfo);
    res.send(result);
})

moduleRouter.delete('/deleteModule', async (req, res) => {
    let { module_id } = req.headers;
    let result = await deleteModule(module_id);
    res.send(result);
})

moduleRouter.get("/allModules",async (req,res)=>{
    let result=await getModules();
    res.send(result);
})

export default moduleRouter;