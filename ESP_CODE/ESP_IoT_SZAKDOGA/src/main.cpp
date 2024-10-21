#include <Arduino.h>
#include <WiFi.h>
const char *ssid = "ESP_32_IoT";
void setup()
{
    Serial.begin(9600);
    Serial.println("Configuring access point...");
    WiFi.softAP(ssid);
    IPAddress myIP = WiFi.softAPIP();
    Serial.print("AP IP address: ");
    Serial.println(myIP);
}

void loop()
{
    NULL;
}