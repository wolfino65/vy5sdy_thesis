import machine
import neopixel
import time
def run(params):
    n=neopixel.NeoPixel(machine.Pin(38),1)
    n[0]=(255,0,0)
    n.write()
    time.sleep(2)
    print(params)