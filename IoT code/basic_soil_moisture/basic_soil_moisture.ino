int moistPin[3] = {33, 34, 35};
float moistAdc[3] = {0, 0, 0};

void setup() {
  Serial.begin(115200);

  // set all moisture sensor pin to input
  for (int i = 0; i < 3; i++) {
    pinMode(moistPin[i], INPUT);
  }
}

void loop() {

  // loop each sensor and read
  for (int i = 0; i < 3; i++) {
    // read sensor
    moistAdc[i] = analogRead(moistPin[i]);
    
    // show serial monitor
    Serial.print(" | Moist" + String(i) + ": " + String(moistAdc[i]));
  }

  Serial.println("");
}