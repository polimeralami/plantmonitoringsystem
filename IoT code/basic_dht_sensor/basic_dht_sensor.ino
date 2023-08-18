#include "DHT.h"

#define DHTPIN 32
#define DHTTYPE DHT11   // DHT 11

DHT dht(DHTPIN, DHTTYPE);

float h = 0;
float t = 0;

void setup() {
  Serial.begin(115200);
  Serial.println(F("DHTxx test!"));
 
  dht.begin();
}

void loop() {
  float h = dht.readHumidity();
  float t = dht.readTemperature();

  if (isnan(h) || isnan(t)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    h = 0;
    t = 0;
  }

  Serial.print("Humid:" + String(h));
  Serial.print(" | Temp:" + String(t));
  Serial.println("");
 
}