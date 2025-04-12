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