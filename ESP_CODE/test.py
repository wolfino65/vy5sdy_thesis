import machine
import neopixel
def run(params):
    n=neopixel.NeoPixel(machine.Pin(38),1)
    n[0]=(255,0,0)
    n.write()
    print(params)