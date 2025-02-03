import network
from microdot import Microdot
print("hi from main")
app= Microdot()

@app.route("/")
def start(request):
    return "access"

w=network.WLAN(network.WLAN.IF_AP)
w.config(ssid="test")
w.active(True )
print(w.ifconfig())
app.run(port=60)
