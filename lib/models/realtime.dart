class Realtime {
  double temp;
  int humidity;
  int moisturePlant1;
  int moisturePlant2;
  int moisturePlant3;

  Realtime({
    required this.temp,
    required this.humidity,
    required this.moisturePlant1,
    required this.moisturePlant2,
    required this.moisturePlant3,
  });

  factory Realtime.fromMap(Map<dynamic, dynamic> map) {
    return Realtime(
      temp: map['temp'] as double,
      humidity: map['humidity'] as int,
      moisturePlant1: map['moisture']['plant1'] as int,
      moisturePlant2: map['moisture']['plant2'] as int,
      moisturePlant3: map['moisture']['plant3'] as int,
    );
  }

  Map<dynamic, dynamic> toSetMap() {
    return {
      'temp': temp,
      'humidity': humidity,
      'moisturePlant1': moisturePlant1,
      'moisturePlant2': moisturePlant2,
      'moisturePlant3': moisturePlant3,
    };
  }
}
