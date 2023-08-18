#include <Arduino.h>
#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"
#include "DHT.h"
#include "time.h"

#define WIFI_SSID "realme 3 Pro"
#define WIFI_PASSWORD "b5c032a461bf"
#define API_KEY "AIzaSyB753OlmLIV-ZwxzfXcJj1-OdN59nakaao"
#define DATABASE_URL "https://test-bf718-default-rtdb.asia-southeast1.firebasedatabase.app/" 
#define DHTPIN 32
#define DHTTYPE DHT11   // DHT 11
#define relayPinMoist 27
#define relayPinTemp 26

//Define Firebase Data object
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
DHT dht(DHTPIN, DHTTYPE);

// NTP server to request epoch time
const char* ntpServer = "pool.ntp.org";

// Variable to save current epoch time
unsigned long epochTime; 

int moistPin[3] = {33, 34, 35};
float maxMoist[3] = {2867.00, 2389.00, 2048.0}; // value need to be adjust here
float moistAdc[3] = {0.0, 0.0, 0.0};
float moistAverage = 0;
unsigned long sendDataPrevMillis = 0;
int count = 0;
bool signupOK = false;
float h = 0;
float t = 0;
String dateLog = "";
int nozzleStatus = 0;
int dripperStatus = 0;

void setup(){
  Serial.begin(115200);
  
  dht.begin();

  pinMode(relayPinMoist, OUTPUT); // set output for relay
  pinMode(relayPinTemp, OUTPUT);
  
  digitalWrite(relayPinMoist, LOW); // then set it initially low
  digitalWrite(relayPinTemp, LOW); // then set it initially low

  // set all moisture sensor pin to input
  for (int i = 0; i < 3; i++) {
    pinMode(moistPin[i], INPUT);
  }
  
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED){
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  configTime(0, 0, ntpServer);

  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;

  if (Firebase.signUp(&config, &auth, "", "")){
    Serial.println("ok");
    signupOK = true;
  }
  else{
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }

  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
  
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}

void loop(){ 
  readSensor();
  
  sendData();

  if (t >= 40) {
    digitalWrite(relayPinTemp, HIGH); // turn on relay
    nozzleStatus = 1;
  } else if (t <= 38) {
    digitalWrite(relayPinTemp, LOW); // turn off relay
    nozzleStatus = 0;
  }

  if (moistAverage <= 50) {
    digitalWrite(relayPinMoist, HIGH); // turn on relay
    dripperStatus = 1;
  } else if (moistAverage > 60) {
    digitalWrite(relayPinMoist, LOW); // turn on relay
    dripperStatus = 0;
  }

  // show at serial monitor
  // Serial.print("Epoch Time: " + String(epochTime));
  printLocalTime();
  Serial.print(" | moistAverage: " + String(moistAverage));
  Serial.print(" | Humid: " + String(h));
  Serial.print(" | Temp: " + String(t));
  Serial.print(" | nozzle: " + String(nozzleStatus));
  Serial.print(" | dripper: " + String(dripperStatus));
  Serial.println("");
}

void readSensor() {
  moistAverage = 0;
  for (int i = 0; i < 3; i++) {
    // read sensor
    moistAdc[i] = analogRead(moistPin[i]);
    moistAdc[i] = map(moistAdc[i], maxMoist[i], 4095.0, 100.0, 0.0);

    // add limiter
    if (moistAdc[i] > 100) {
      moistAdc[i] = 100;
    } if (moistAdc[i] < 0) {
      moistAdc[i] = 0;
    }
    
    // show serial monitor
    // Serial.print(" | Moist" + String(i) + ": " + String(moistAdc[i]));

    moistAverage = moistAverage + moistAdc[i];
  }

  moistAverage = moistAverage / 3.0;

  // read DHT
  h = dht.readHumidity();
  t = dht.readTemperature();

  if (isnan(h) || isnan(t)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    h = 0;
    t = 0;
  }

  epochTime = getTime();
}

void sendData () {
  if (Firebase.ready() && signupOK && (millis() - sendDataPrevMillis > 60000 || sendDataPrevMillis == 0)){
    sendDataPrevMillis = millis();
  
    if (Firebase.RTDB.setFloat(&fbdo, "realtime/humidity", h)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
    
    if (Firebase.RTDB.setFloat(&fbdo, "realtime/temp", t)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    if (Firebase.RTDB.setFloat(&fbdo, "realtime/moisture/plant1", moistAdc[0])){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    if (Firebase.RTDB.setFloat(&fbdo, "realtime/moisture/plant2", moistAdc[1])){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    if (Firebase.RTDB.setFloat(&fbdo, "realtime/moisture/plant3", moistAdc[2])){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    // ---------------------------
    // logger section
    // ---------------------------

    if (Firebase.RTDB.setFloat(&fbdo, "history/" + dateLog + "/humidity", h)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
    
    if (Firebase.RTDB.setFloat(&fbdo, "history/" + dateLog + "/temp", t)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    if (Firebase.RTDB.setFloat(&fbdo, "history/" + dateLog + "/moisture/plant1", moistAdc[0])){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    if (Firebase.RTDB.setFloat(&fbdo, "history/" + dateLog + "/moisture/plant2", moistAdc[1])){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    if (Firebase.RTDB.setFloat(&fbdo, "history/" + dateLog + "/moisture/plant3", moistAdc[2])){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
  }
}

// Function that gets current epoch time
unsigned long getTime() {
  time_t now;
  struct tm timeinfo;
  if (!getLocalTime(&timeinfo)) {
    //Serial.println("Failed to obtain time");
    return(0);
  }
  time(&now);
  return now;
}

void printLocalTime(){
  struct tm timeinfo;
  if(!getLocalTime(&timeinfo)){
    // Serial.println("Failed to obtain time");
    return;
  }

  char dateBuffer[20];
  strftime(dateBuffer,20, "%Y-%m-%d", &timeinfo);
  
  dateLog = dateBuffer;
  Serial.print(dateBuffer);
}