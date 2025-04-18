print("switch to main")
import a
import b
import c
import d
import machine
import urequests
import os
import neopixel

API_KEY = "AIzaSyCof7aLYawxMevJrPAwpgYt9fUxYXMrdZE"
def download_file_from_google_drive(file_id, api_key,file):
    url = f"https://www.googleapis.com/drive/v3/files/{file_id}?alt=media&key={api_key}"
    response = urequests.get(url)
    if response.status_code == 200:
        with open(file, "wb") as f:
            f.write(response.content)
        print("File downloaded successfully")
    else:
        print("Failed to download file")
        print("Status Code:", response.status_code)
        print("Response:", response.text)
    response.close()

def connect_new_module(fid,mod_id):
    if False not in populated:
        return 
    while True:
        for i in range(0,len(con_check_pins)):
            p= machine.Pin(con_check_pins[i],machine.Pin.IN)
            if p.value() == 1 and populated[i] == False :
                populated[i]=True
                file_ids[i]=fid
                module_ids[i]=mod_id
                download_file_from_google_drive(fid,API_KEY,module_controlfile_names[i])
                write_state(populated,file_ids,module_ids)
                return 
def read_state():
    temp=[]
    with open("state.txt","r") as f:
        line=f.readline().strip()
        for i in line.split(','):
            temp.append(True if i=="True" else False)
    return temp
def read_fids():
    temp=[]
    with open("state.txt","r") as f:
        line=f.readline()
        line=f.readline().strip()
        for i in line.split(','):
            temp.append(None if i=='' else i)
    return temp 
def write_state(populated_in, ids_in,mod_ids_in):
    with open("state.txt","w") as f:
            for i in range(0,len(populated_in)):
                if i == len(populated_in)-1:
                    f.write("True" if populated_in[i] else "False")
                else:
                    f.write("True" if populated_in[i] else "False")
                    f.write(",")
            f.write("\n")
            for i in range(0,len(ids_in)):
                if i !=0:
                    f.write(',')
                if ids_in[i] == None:
                    f.write('')
                else:
                    f.write(ids_in[i])
            f.write("\n")
            for i in range(0,len(mod_ids_in)):
                if i !=0:
                    f.write(',')
                if mod_ids_in[i] == None:
                    f.write('')
                else:
                    f.write(mod_ids_in[i])

def selector(f):
    def wraper(params,pin):
        machine.Pin(pin,machine.Pin.OUT).value(1)
        f(params,pin)
        machine.Pin(pin,machine.Pin.OUT).value(0)
    return wraper
    
@selector    
def runa (params,pin):
    a.run(params)
@selector
def runb (params,pin):
    b.run(params)
@selector
def runc (params,pin):
    c.run(params)
@selector
def rund (params,pin):
    d.run(params)


def read_identification():
    id=""
    with open('ident.txt','r') as f:
        id=f.readline().strip()
    return id
def disconnect_module():
    while True :
        for i in range(0,len(con_check_pins)):
            p= machine.Pin(con_check_pins[i],machine.Pin.IN)
            if p.value() == 0 and populated[i] == True:
                populated[i] = False
                file_ids[i]= None
                module_ids[i]=None 
                return

def reset_state():
    with open('state.txt','w') as f:
        f.write('False,False,False,False\n,,,\n,,,')
def get_owner():
    with open("owner.txt","r") as f:
        return f.readline().strip()
def report_state():
    stringifyedState=[]
    for i in module_ids:
        if i is None :
            stringifyedState.append("Unused")
        else:
            stringifyedState.append(i)
    json_data = {
    'dev_id': ID,
    'newInfo': {
        'aditionalInfo': {
            'connected': stringifyedState
        }
    }
}
    urequests.put("http://"+serverip+":4500/device/updateDevice",json = json_data)
def get_module_ids():
    temp=[]
    with open("state.txt","r") as f:
        f.readline()
        f.readline()
        mod_ids=f.readline().strip().split(",")
        for i in mod_ids:
            temp.append(None if i=='' else i)
    return temp
npxl = neopixel.NeoPixel(machine.Pin(38),1)
#----------------------
populated=read_state()#module connections
ID=read_identification()
con_check_pins=[1,2,42,41]       #*testrig    config
circuit_controller_pins=[4,5,6,7]#*        v2 
file_ids=read_fids()
module_controlfile_names = ["a.py","b.py","c.py","d.py"]
ownerId=get_owner()
module_ids = get_module_ids()
#----------------------
#connect_new_module(FILE_ID)
#b.set_to_red()
serverip="158.180.52.252"
def D(s):
    print("DEBUG: "+s)
#-------------------------------------------------------------------------
new_file_flag=False
while True :
    D("in while")
    response=urequests.get("http://"+serverip+":4500/task/getTasksByDeviceId",headers={'dev_id':ID}).json()
    for resp in response:
        if resp["aditionalInfo"]["method"] == "add_new":
            module_resp=urequests.get("http://"+serverip+":4500/module/getModuleById",headers={'module_id':resp['module_id']}).json()
            connect_new_module(module_resp['py_id'],module_resp["_id"])
            new_file_flag=True
            report_state()
        elif resp["aditionalInfo"]["method"] == "remove":
            disconnect_module()
            report_state()
        elif resp["aditionalInfo"]["method"] == "disown":
            os.remove('ident.txt')
            os.remove('conf.txt')
            reset_state()
            machine.reset() 
        elif resp["aditionalInfo"]["method"] == "network_reset":
            os.remove('conf.txt')
            machine.reset() 
        elif resp["aditionalInfo"]["method"] == "module_reset":
            D("in module_reset")
            reset_state()
            report_state()
        elif resp["aditionalInfo"]["method"] == "run":
            module_resp=urequests.get("http://"+serverip+":4500/module/getModuleById",headers={'module_id':resp['module_id']}).json()
            D("in run")
            for i in range (0,len(file_ids)):
                if file_ids[i] == module_resp['py_id']:
                    if module_controlfile_names[i]=="a.py":
                        D("in run a")
                        runa(resp['module_params'],circuit_controller_pins[i])
                    elif module_controlfile_names[i]=="b.py":
                        runb(resp['module_params'],circuit_controller_pins[i])
                    elif module_controlfile_names[i]=="c.py":
                        runc(resp['module_params'],circuit_controller_pins[i])
                    elif module_controlfile_names[i]=="d.py":
                        rund(resp['module_params'],circuit_controller_pins[i])
        D("before del")
        urequests.delete("http://"+serverip+":4500/task/deleteTask",headers={'task_id':resp['_id']})
        D("after del")
        
    npxl[0]=(0,32,0)
    npxl.write()
    if new_file_flag == True:
        machine.reset()
