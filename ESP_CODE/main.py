print("switch to main")
import machine
#----------------------
populated=[False,False,False,False] #module connections
con_check_pins=[1,2,3,4]
module_controlfile_names = ["a.py","b.py","c.py","d.py"]
#----------------------
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

def connect_new_module(fid)
    while True:
        for i in range(0,len(con_check_pins)-1):
            p= machine.Pin(con_check_pins[i],machine.Pin.IN)
            if p.value() == 1 and populated[i] == False :
                populated[i]=True
                download_file_from_google_drive(fid,API_KEY,module_controlfile_names[i])