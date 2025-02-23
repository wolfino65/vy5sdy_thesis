print("switch to main")
import a
import b
import c
import d
import machine
import urequests
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
            if i == 1 and populated[i] == False : #p.value()
                populated[i]=True
                file_ids[i]=fid
                download_file_from_google_drive(fid,API_KEY,module_controlfile_names[i])
                write_state(populated)
                return 
def read_state():
    temp=[]
    with open("state.txt","r") as f:
            line=f.readline().strip()
            for i in line.split(','):
                temp.append(True if i=="True" else False)
    return temp
def write_state(populated_in):
    with open("state.txt","w") as f:
            for i in range(0,len(populated_in)):
                if i == len(populated_in)-1:
                    f.write("True" if populated_in[i] else "False")
                else:
                    f.write("True" if populated_in[i] else "False")
                    f.write(",")
#----------------------
populated=read_state()#module connections
#write_state(populated)
con_check_pins=[1,2,3,4]
file_ids=[None,None,None,None]
module_controlfile_names = ["a.py","b.py","c.py","d.py"]
#----------------------
#connect_new_module(FILE_ID)
b.set_to_red()