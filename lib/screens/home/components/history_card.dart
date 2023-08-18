import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String date;
  final String temp;
  final String humid;
  final String soilMoist1;
  final String soilMoist2;
  final String soilMoist3;
  final VoidCallback onTap;

  const HistoryCard({
    Key? key,
    required this.date,
    required this.temp,
    required this.humid,
    required this.soilMoist1,
    required this.soilMoist2,
    required this.soilMoist3,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.green,
          elevation: 20,
          child: InkWell(
              onTap: onTap,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 31, vertical: 21),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        date,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Text(
                        'Temp: $temp, Humid: $humid',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              const Text(
                                "Soil Moist 1: ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11.0),
                              ),
                              Text(
                                soilMoist1,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: <Widget>[
                              const Text(
                                "Soil Moist 2: ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11.0),
                              ),
                              Text(
                                soilMoist2,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: <Widget>[
                              const Text(
                                "Soil Moist 3: ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11.0),
                              ),
                              Text(
                                soilMoist3,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}
