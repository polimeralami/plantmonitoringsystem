#define relayPin 27
#define relayPin 26

void setup() {
  Serial.begin(115200);
  pinMode(relayPin, OUTPUT);
}

void loop() {
  digitalWrite(relayPin, HIGH);
  delay(1000);
  digitalWrite(relayPin, LOW);
  delay(1000);
}