import network
from microdot import Microdot
app= Microdot()
@app.route("/")
def start (request):
    return """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WiFi Configuration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 50px;
        }
        form {
            max-width: 300px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    <h2>WiFi Configuration</h2>
    <form action="http://192.168.0.5:60" method="POST">
        <label for="ssid">SSID:</label>
        <input type="text" id="ssid" name="ssid" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>

        <input type="submit" value="Submit">
    </form>

</body>
</html>""",200, {'Content-Type': 'text/html'}
@app.post("/")
def conf(request):
    print(request.form.get('ssid'))
    print(request.form.get('password'))
    f=open("conf.txt","w")
    f.write(request.form.get('ssid')+"\n")
    f.write(request.form.get('password'))
    f.close()
    app.shutdown()

w=network.WLAN(network.WLAN.IF_AP)
w.config(ssid="test")
w.active(True )
w.ifconfig(('192.168.0.5','255.255.255.0','192.168.0.1','8.8.8.8'))
print(w.ifconfig())
app.run(port=60)
#runs after microdot server shuts down
print('continues')
w.active(False)
w=network.WLAN(network.STA_IF)
conf = open("conf.txt","r")
ssid= conf.readline().strip()
password= conf.readline().strip()
conf.close()
w.active(True )
w.connect(ssid,password)
print("connecting",end="")
while not w.isconnected():
    print('.',end="")
print('\nsuccesfull connection')

