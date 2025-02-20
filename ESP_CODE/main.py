import network
import os

from microdot import Microdot
import neopixel,machine,time
npxl = neopixel.NeoPixel(machine.Pin(38),1)
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
dev_cont=os.listdir()
if 'conf.txt' not in dev_cont:
    npxl[0]=(0,0,255)
    npxl.write()
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
led_index=0
led_index_flag=True  
while not w.isconnected():
    if led_index >= 240 or led_index <=0:
        led_index_flag = not led_index_flag
    npxl[0]=(0,led_index,0)
    npxl.write()
    time.sleep_ms(50)
    if led_index_flag == False :
        led_index += 20
    else:
        led_index -= 20
    print('.',end="")
print('\nsuccesfull connection')
print(w.ifconfig())
npxl[0]=(0,32,0)
npxl.write()
#--------------------------------------
import urequests
FILE_ID = "1F5GJ0k45eJiRC3-XUQ_f74drGBJRwOTh"
API_KEY = "AIzaSyCof7aLYawxMevJrPAwpgYt9fUxYXMrdZE"
def download_file_from_google_drive(file_id, api_key):
    url = f"https://www.googleapis.com/drive/v3/files/{file_id}?alt=media&key={api_key}"
    response = urequests.get(url)
    
    if response.status_code == 200:
        with open("asd"+".py", "wb") as f:
            f.write(response.content)
        print("File downloaded successfully")
    else:
        print("Failed to download file")
        print("Status Code:", response.status_code)
        print("Response:", response.text)
    response.close()
download_file_from_google_drive(FILE_ID,API_KEY)

import asd as a
a.set_to_red()
