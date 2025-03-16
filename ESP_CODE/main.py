print("switch to main")
import a
import b
import c
import d
import machine
import urequests
import os

FILE_ID = "1F5GJ0k45eJiRC3-XUQ_f74drGBJRwOTh"
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
#download_file_from_google_drive(FILE_ID,API_KEY)

def connect_new_module(fid):
    if False not in populated:
        return 
    while True:
        for i in range(0,len(con_check_pins)):
            p= machine.Pin(con_check_pins[i],machine.Pin.IN)
            if p.value() == 1 and populated[i] == False : #p.value()
                populated[i]=True
                file_ids[i]=fid
                download_file_from_google_drive(fid,API_KEY,module_controlfile_names[i])
                write_state(populated,file_ids)
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
def write_state(populated_in, ids_in):
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
                return

def reset_state():
    with open('state.txt','w') as f:
        f.write('False,False,False,False\n,,,')

#----------------------
populated=read_state()#module connections
ID=read_identification()
con_check_pins=[1,2,42,41]       #*testrig    config
circuit_controller_pins=[4,5,6,7]#*        v2 
file_ids=read_fids()
module_controlfile_names = ["a.py","b.py","c.py","d.py"]
#----------------------
#connect_new_module(FILE_ID)
#b.set_to_red()
serverip="192.168.1.82"
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
            connect_new_module(module_resp['py_id'])
            new_file_flag=True
        elif resp["aditionalInfo"]["method"] == "remove":
                disconnect_module()
        elif resp["aditionalInfo"]["method"] == "disown":
            os.remove('ident.txt')
            os.remove('conf.txt')
            reset_state()
        elif resp["aditionalInfo"]["method"] == "network_reset":
            os.remove('conf.txt')
        elif resp["aditionalInfo"]["method"] == "module_reset":
            D("in module_reset")
            reset_state()
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
    response.close()
    if new_file_flag == True:
        machine.reset()
