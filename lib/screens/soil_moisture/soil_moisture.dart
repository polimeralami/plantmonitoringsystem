import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:plantmonitoringsystem/models/realtime.dart';
import 'package:plantmonitoringsystem/screens/home/components/info_card.dart';
import 'package:plantmonitoringsystem/utils/utils.dart';

class SoilMoistureScreen extends StatefulWidget {
  const SoilMoistureScreen({Key? key}) : super(key: key);

  @override
  State<SoilMoistureScreen> createState() => _SoilMoistureScreenState();
}

class _SoilMoistureScreenState extends State<SoilMoistureScreen> {
  late DatabaseReference _realtimeRef;
  Realtime? realtime;

  @override
  void initState() {
    super.initState();
    _realtimeRef = FirebaseDatabase.instance.ref('realtime');

    _realtimeRef.onValue.listen((event) {
      setState(() {
        realtime =
            Realtime.fromMap(event.snapshot.value as Map<dynamic, dynamic>);
      });
    }, onError: (Object o) {
      //
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-splash.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: const Color.fromARGB(68, 255, 255, 255),
            elevation: 0,
          ),
          body: SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              child: Container(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Text(
                    "Soil Moisture",
                    style: GoogleFonts.montserrat(
                      fontSize: 40,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InfoCard(
                  icon: CupertinoIcons.gauge,
                  title: "Plant 1",
                  value: realtime?.moisturePlant1 != null
                      ? realtime!.moisturePlant1.toDouble()
                      : 0.0,
                  symbol: "%",
                  minSafeValue: AlertConfig.minMoisture.toDouble(),
                  maxSafeValue: AlertConfig.maxMoisture.toDouble(),
                  minSafeColor: AlertConfig.minMoistureColor,
                  maxSafeColor: AlertConfig.maxMoistureColor,
                  onTap: () {
                    showCustomDialog(
                        context,
                        "Soil Moisture Level",
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(children: [
                            // LOW
                            Row(
                              children: [
                                FilledButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                AlertConfig.minMoistureColor)),
                                    onPressed: () {},
                                    child: const Text(
                                        '0 - ${AlertConfig.minMoisture}')),
                                Container(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: const Text(
                                    'Too Low',
                                    style: TextStyle(
                                      color: AlertConfig.minMoistureColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // GOOD
                            Row(
                              children: [
                                FilledButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                Colors.green)),
                                    onPressed: () {},
                                    child: const Text(
                                        '${AlertConfig.minMoisture} - ${AlertConfig.maxMoisture}')),
                                Container(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: const Text(
                                    'Good',
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // HIGH
                            Row(
                              children: [
                                FilledButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                AlertConfig.maxMoistureColor)),
                                    onPressed: () {},
                                    child: const Text(
                                        '${AlertConfig.maxMoisture}+')),
                                Container(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: const Text(
                                    'Too High',
                                    style: TextStyle(
                                      color: AlertConfig.maxMoistureColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                        ));
                  },
                ),
                InfoCard(
                  icon: CupertinoIcons.gauge,
                  title: "Plant 2",
                  value: realtime?.moisturePlant2 != null
                      ? realtime!.moisturePlant2.toDouble()
                      : 0.0,
                  symbol: "%",
                  minSafeValue: AlertConfig.minMoisture.toDouble(),
                  maxSafeValue: AlertConfig.maxMoisture.toDouble(),
                  minSafeColor: AlertConfig.minMoistureColor,
                  maxSafeColor: AlertConfig.maxMoistureColor,
                  onTap: () {
                    showCustomDialog(
                        context,
                        "Soil Moisture Level",
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(children: [
                            // LOW
                            Row(
                              children: [
                                FilledButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                AlertConfig.minMoistureColor)),
                                    onPressed: () {},
                                    child: const Text(
                                        '0 - ${AlertConfig.minMoisture}')),
                                Container(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: const Text(
                                    'Too Low',
                                    style: TextStyle(
                                      color: AlertConfig.minMoistureColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // GOOD
                            Row(
                              children: [
                                FilledButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                Colors.green)),
                                    onPressed: () {},
                                    child: const Text(
                                        '${AlertConfig.minMoisture} - ${AlertConfig.maxMoisture}')),
                                Container(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: const Text(
                                    'Good',
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // HIGH
                            Row(
                              children: [
                                FilledButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                AlertConfig.maxMoistureColor)),
                                    onPressed: () {},
                                    child: const Text(
                                        '${AlertConfig.maxMoisture}+')),
                                Container(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: const Text(
                                    'Too High',
                                    style: TextStyle(
                                      color: AlertConfig.maxMoistureColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                        ));
                  },
                ),
                InfoCard(
                  icon: CupertinoIcons.gauge,
                  title: "Plant 3",
                  value: realtime?.moisturePlant3 != null
                      ? realtime!.moisturePlant3.toDouble()
                      : 0.0,
                  symbol: "%",
                  minSafeValue: AlertConfig.minMoisture.toDouble(),
                  maxSafeValue: AlertConfig.maxMoisture.toDouble(),
                  minSafeColor: AlertConfig.minMoistureColor,
                  maxSafeColor: AlertConfig.maxMoistureColor,
                  onTap: () {
                    showCustomDialog(
                        context,
                        "Soil Moisture Level",
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(children: [
                            // LOW
                            Row(
                              children: [
                                FilledButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                AlertConfig.minMoistureColor)),
                                    onPressed: () {},
                                    child: const Text(
                                        '0 - ${AlertConfig.minMoisture}')),
                                Container(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: const Text(
                                    'Too Low',
                                    style: TextStyle(
                                      color: AlertConfig.minMoistureColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // GOOD
                            Row(
                              children: [
                                FilledButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                Colors.green)),
                                    onPressed: () {},
                                    child: const Text(
                                        '${AlertConfig.minMoisture} - ${AlertConfig.maxMoisture}')),
                                Container(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: const Text(
                                    'Good',
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // HIGH
                            Row(
                              children: [
                                FilledButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                AlertConfig.maxMoistureColor)),
                                    onPressed: () {},
                                    child: const Text(
                                        '${AlertConfig.maxMoisture}+')),
                                Container(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: const Text(
                                    'Too High',
                                    style: TextStyle(
                                      color: AlertConfig.maxMoistureColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                        ));
                  },
                ),
              ],
            ),
          ))),
    );
  }
}
