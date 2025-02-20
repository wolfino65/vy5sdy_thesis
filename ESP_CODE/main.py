print("switch to main")
#----------------------
populated=[False,False,False,False] #module connections
#----------------------
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
