import network
import os
from microdot import Microdot
import neopixel,machine,time
import urequests
import ujson
import _thread

npxl = neopixel.NeoPixel(machine.Pin(38),1)
    
def configuration():
    npxl[0]=(0,0,255)
    npxl.write()
    app= Microdot()
    @app.post("/")
    def conf(request):
        req=request.json
        f=open("conf.txt","w")
        f.write(req["ssid"]+"\n")
        f.write(req['password'])
        f.close()
        with open('owner.txt','w') as f:
            f.write(req["owner"]) 
        response = {'status': 'success'}
        def shutdown():
            time.sleep(1)
            app.shutdown()
            machine.reset() 
        
        _thread.start_new_thread(shutdown, ())
        return  response
        
    
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
serverip="158.180.52.252"
def getIdent():
    owner=""
    with open("owner.txt","r") as f:
        owner = f.readline().strip()
    js=ujson.dumps({'owner':owner,'aditionalInfo':{'connected':['Unused','Unused','Unused','Unused']}})
    resp=urequests.post("http://"+serverip+":4500/device/addDevice",data=js,headers = {'content-type': 'application/json'}).json()
    with open("ident.txt","w") as f:
        f.write(resp['insertedId'])

dev_cont=os.listdir()
if 'conf.txt' not in dev_cont:
    configuration()
init_net()
if 'ident.txt' not in dev_cont:
    getIdent()