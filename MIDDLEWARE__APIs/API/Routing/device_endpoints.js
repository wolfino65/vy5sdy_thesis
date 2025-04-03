import express from 'express'
import { getDeviceById, getDeviceByOwner, addDevice, updateDevice, deleteDevice } from '../DB_handling/device_db.js'
var deviceRouter = express.Router();

deviceRouter.post('/addDevice', async (req, res) => {
    let { owner, aditionalInfo } = req.body;
    console.log(owner);
    let result = await addDevice(owner, aditionalInfo);
    console.log(result);
    res.send(result);
})

deviceRouter.get('/getDeviceById', async (req, res) => {
    let { dev_id } = req.headers;
    let result = await getDeviceById(dev_id);
    res.send(result);
})

deviceRouter.get('/getDeviceByOwner', async (req, res) => {
    let { owner } = req.headers;
    let result = await getDeviceByOwner(owner);
    res.send(result);
})

deviceRouter.put('/updateDevice', async (req, res) => {
    let { dev_id, newInfo } = req.body;
    let result = await updateDevice(dev_id, newInfo);
    res.send(result);
})

deviceRouter.delete('/deleteDevice', async (req, res) => {
    let { dev_id } = req.headers;
    let result = await deleteDevice(dev_id);
    res.send(result);
})

export default deviceRouter;