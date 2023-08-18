# Greenhouse Monitoring System

A Final Year Project (FYP) in Universiti Teknologi Malaysia. A system that monitor the Greenhouse environment, which is: Temperature, Humidity, and Soil Moisture. Additionally, it produces dual output controls, namely: a Misting Nozzle and Drip Irrigation.

This project use **Flutter** for mobile application monitoring, **Arduino IDE** for sensors, and **Firebase** for database.

### The Plant Monitoring Mobile Application

A mobile application which can remotely monitor environment inside a greenhouse that is equipped with Internet of Things (IoT). The variables that is monitored through the *Android* mobile application include: temperature, humidity of the room, and soil moisture.

### The Greenhouse Control System

A microcontroller (ESP32) serves as the command and control hub for the sensors that are included into the automated greenhouse. The processing of the sensor readings that determine the 3 parameters (temperature, soil moisture, and humidity) in the greenhouse. By utilizing Arduino IDE, which later work the IoT module automatically in order to maintain two output control which are misting nozzle, and drip irrigation pump.

## Documentation
