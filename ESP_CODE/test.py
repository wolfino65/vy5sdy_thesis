import machine
import neopixel
def set_to_red():
    n=neopixel.NeoPixel(machine.Pin(38),1)
    n[0]=(255,0,0)
    n.write()