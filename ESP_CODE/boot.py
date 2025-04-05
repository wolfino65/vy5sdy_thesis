import network
import os
from microdot import Microdot
import neopixel,machine,time
import urequests
import ujson

npxl = neopixel.NeoPixel(machine.Pin(38),1)
    
def configuration():
    npxl[0]=(0,0,255)
    npxl.write()
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
        with open('owner.txt','w') as f:
            f.write("owner") #will be replaced with data form request
        app.shutdown()
        w.active(False)
    
    w=network.WLAN(network.WLAN.IF_AP)
    w.config(ssid="test")
    w.active(True )
    w.ifconfig(('192.168.0.5','255.255.255.0','192.168.0.1','8.8.8.8'))
    print(w.ifconfig())
    app.run(port=60)

def init_net():
    w=network.WLAN(network.STA_IF)
    conf = open("conf.txt","r")
    ssid= conf.readline().strip()
    password= conf.readline().strip()
    conf.close()
    w.active(True)
    w.connect(ssid,password)
    print("connecting",end="")
    led_index=0
    led_index_flag=True
    connection_start_time= time.time()
    while not w.isconnected():
        if time.time() - connection_start_time >20:
            os.remove("conf.txt")
            w.disconnect()
            w.active(False)
            machine.reset()  
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
    return True 
serverip="192.168.1.82"
def getIdent():
    js=ujson.dumps({'owner':'testOwner','aditionalInfo':{'connected':['Unused','Unused','Unused','Unused']}})
    resp=urequests.post("http://"+serverip+":4500/device/addDevice",data=js,headers = {'content-type': 'application/json'}).json()
    with open("ident.txt","w") as f:
        f.write(resp['insertedId'])

dev_cont=os.listdir()
if 'conf.txt' not in dev_cont:
    configuration()
init_net()
if 'ident.txt' not in dev_cont:
    getIdent()