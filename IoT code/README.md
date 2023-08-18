## Instruction for each folder:

**1. Basic DHT Sensor:** Run this code to check if your DHT11 sensor working properly.

**2. Basic Relay:** Run this code to check if your relay sensor working properly.

**3. Basic Soil Moisture:** Run this code to check if your soil moisture sensor working properly and to collect data sample to change value for "combine.ino" file later.
    
- remember to take the *average* readings from each sensors, in their *"wet"* or *"too much water"* state (to show the "100%"), for data sample that will be used in the main file.

**4. Basic Firebase:** Run this code to check if your Wi-Fi connection and firebase connection working properly.

**5. Combine:** Run this code after finish running every order code inside the "IoT Code" folder.
    - At maxMoist variable, the value need to be adjusted according to the data sample which is obtained from the *Basic Soil Moisture* file. This is intended to present sensor data in percentage format for user visibility.

       float maxMoist[3] = {1354.67, 1330.67, 1368.83}; // value need to be adjust here
       

*Remember to change the pins according to your board*
