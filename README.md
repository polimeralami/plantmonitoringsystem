# Greenhouse Monitoring System

A Final Year Project (FYP) in Universiti Teknologi Malaysia. A system that monitor the Greenhouse environment, which is: Temperature, Humidity, and Soil Moisture. Additionally, it produces dual output controls, namely: a Misting Nozzle and Drip Irrigation.

This project use **Flutter** for mobile application monitoring, **Arduino IDE** for sensors, and **Firebase** for database.

## Features

### The Plant Monitoring Mobile Application

A mobile application which can remotely monitor environment inside a greenhouse that is equipped with Internet of Things (IoT). The variables that is monitored through the *Android* mobile application include: temperature, humidity of the room, and soil moisture.

**Contains:**
- Sign-In, Sign-Up and Log-Out using Email & Password / Biometric.
- Realtime monitor Temperature, Humidity, and Soil moisture.
- History for monitored environment.

### The Greenhouse Control System

A microcontroller (ESP32) serves as the command and control hub for the sensors that are included into the automated greenhouse. The processing of the sensor readings that determine the 3 parameters (temperature, soil moisture, and humidity) in the greenhouse. By utilizing Arduino IDE, which later work the IoT module automatically in order to maintain two output control which are misting nozzle, and drip irrigation pump.

**Contains:**
- Connection to Wi-Fi, and Firebase Account.
- Sensor reading from DHT11, and Soil Moisture Module.
- Upload realtime data and stores in Firebase.

## Documentation

<details>

<summary>IOT CODE INSTALLATION</summary>

## All important code related to IoT is in the **"IoT Code"** folder.

Remember to *separate* and *delete* the "IoT Code" folder from the whole mobile application code because it might cause an error. Run "IoT Code" folder in separate environment and use Arduino IDE for the better.

### All Basic Folder

Inside IoT Code folder, there are several folder named with *basic*, this is for initializing your sensors and checking if everything works properly before continuing to the main code. Please go through every basic code before jumping to the *combine* file, and remember to change necessary details *(all pins according to your board)* according to your cases. Other instruction available at the comments section.

### Combine File.

This *combine* file is the main file for running your Greenhouse IoT system. Change necessary details according to your cases.

</details>
