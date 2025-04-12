var responses = []
var currentExecution = []
taskRouter.post('/addTask', async (req, res) => {
    let { dev_id, module_id, user_id, params, aditionalInfo } = req.body;
    let result = await addTask(dev_id, module_id, user_id, params, aditionalInfo);
    executeByIndex(checkForData(dev_id))
    res.send(result);
})

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