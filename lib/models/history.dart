import 'package:intl/intl.dart';

class History {
  String date;
  double temp;
  int humidity;
  int moisturePlant1;
  int moisturePlant2;
  int moisturePlant3;

  History({
    required this.date,
    required this.temp,
    required this.humidity,
    required this.moisturePlant1,
    required this.moisturePlant2,
    required this.moisturePlant3,
  });

  factory History.fromMap(Map<dynamic, dynamic> map, key) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(key);
    var outputFormat = DateFormat('dd MMMM yyyy');
    var outputDate = outputFormat.format(inputDate);

    return History(
      date: outputDate,
      temp: map['temp'] as double,
      humidity: map['humidity'] as int,
      moisturePlant1: map['moisture']['plant1'] as int,
      moisturePlant2: map['moisture']['plant2'] as int,
      moisturePlant3: map['moisture']['plant3'] as int,
    );
  }

  Map<dynamic, dynamic> toSetMap() {
    return {
      'date': date,
      'temp': temp,
      'humidity': humidity,
      'moisturePlant1': moisturePlant1,
      'moisturePlant2': moisturePlant2,
      'moisturePlant3': moisturePlant3,
    };
  }
}
