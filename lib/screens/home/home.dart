import 'dart:async';
import 'package:logger/logger.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantmonitoringsystem/models/history.dart';
import 'package:plantmonitoringsystem/models/realtime.dart';
import 'package:plantmonitoringsystem/utils/config.dart';
import 'package:plantmonitoringsystem/utils/custom.dart';
import 'package:provider/provider.dart';

import 'package:plantmonitoringsystem/routes/routes.dart';
import 'package:plantmonitoringsystem/screens/home/components/history_card.dart';
import 'package:plantmonitoringsystem/services/firebase_auth_methods.dart';

import 'components/info_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseReference _realtimeRef;
  late DatabaseReference _historyRef;
  Realtime? realtime;
  List<History> history = [];

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  void initState() {
    super.initState();
    _realtimeRef = FirebaseDatabase.instance.ref('realtime');
    _historyRef = FirebaseDatabase.instance.ref('history');

    _realtimeRef.onValue.listen((event) {
      setState(() {
        realtime =
            Realtime.fromMap(event.snapshot.value as Map<dynamic, dynamic>);
      });
      // logger.d(event.snapshot.value);
    }, onError: (Object o) {
      logger.e(o);
    });

    _historyRef.onValue.listen((event) {
      history.clear();
      for (final child in event.snapshot.children) {
        // logger.d(event.snapshot.children);
        setState(() {
          history.add(
              History.fromMap(child.value as Map<dynamic, dynamic>, child.key));
        });
      }
    }, onError: (Object o) {
      logger.e(o);
    });
  }

  int _selectedIndex = 0;

  Future<void> logOut() async {
    context.read<FirebaseAuthMethods>().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    List<Widget> widgetOptions = <Widget>[
      // HOMEPAGE
      Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Text(
                    "Home Page",
                    style: GoogleFonts.montserrat(
                      fontSize: 40,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InfoCard(
                  icon: CupertinoIcons.thermometer,
                  title: "Temperature",
                  value: realtime?.temp ?? 0.0,
                  symbol: "\u00B0C",
                  minSafeValue: AlertConfig.minTemp.toDouble(),
                  maxSafeValue: AlertConfig.maxTemp.toDouble(),
                  minSafeColor: AlertConfig.minTempColor,
                  maxSafeColor: AlertConfig.maxTempColor,
                  onTap: () {
                    showCustomDialog(
                        context,
                        "Temperature Level",
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
                                                AlertConfig.minTempColor)),
                                    onPressed: () {},
                                    child: const Text(
                                        '0 - ${AlertConfig.minTemp}')),
                                Container(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: const Text(
                                    'Too Low',
                                    style: TextStyle(
                                      color: AlertConfig.minTempColor,
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
                                        '${AlertConfig.minTemp} - ${AlertConfig.maxTemp}')),
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
                                                AlertConfig.maxTempColor)),
                                    onPressed: () {},
                                    child:
                                        const Text('${AlertConfig.maxTemp}+')),
                                Container(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: const Text(
                                    'Too High',
                                    style: TextStyle(
                                      color: AlertConfig.maxTempColor,
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
                  icon: CupertinoIcons.wind,
                  title: "Humidity",
                  value: realtime?.humidity != null
                      ? realtime!.humidity.toDouble()
                      : 0.0,
                  symbol: "%",
                  minSafeValue: AlertConfig.minHumid.toDouble(),
                  maxSafeValue: AlertConfig.maxHumid.toDouble(),
                  minSafeColor: AlertConfig.minHumidColor,
                  maxSafeColor: AlertConfig.maxHumidColor,
                  onTap: () {
                    showCustomDialog(
                        context,
                        "Humidity Level",
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
                                                AlertConfig.minHumidColor)),
                                    onPressed: () {},
                                    child: const Text(
                                        '0 - ${AlertConfig.minHumid}')),
                                Container(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: const Text(
                                    'Too Low',
                                    style: TextStyle(
                                      color: AlertConfig.minHumidColor,
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
                                        '${AlertConfig.minHumid} - ${AlertConfig.maxHumid}')),
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
                                                AlertConfig.maxHumidColor)),
                                    onPressed: () {},
                                    child:
                                        const Text('${AlertConfig.maxHumid}+')),
                                Container(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: const Text(
                                    'Too High',
                                    style: TextStyle(
                                      color: AlertConfig.maxHumidColor,
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
                  title: "Soil Moisture",
                  symbol: "3 Plants",
                  minSafeValue: 0.0,
                  maxSafeValue: 0.0,
                  minSafeColor: Colors.black,
                  maxSafeColor: Colors.black,
                  onTap: () {
                    Navigator.pushNamed(context, soilMoistureScreenRoute);
                  },
                ),
              ],
            ),
          )
        ],
      ),
      // HISTORY PAGE
      Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Text(
                    "History Page",
                    style: GoogleFonts.montserrat(
                      fontSize: 40,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: history.length,
                    itemBuilder: (BuildContext context, int index) {
                      return HistoryCard(
                        date: history[index].date,
                        temp: "${history[index].temp}\u00B0C",
                        humid: "${history[index].humidity}%",
                        soilMoist1: "${history[index].moisturePlant1}%",
                        soilMoist2: "${history[index].moisturePlant2}%",
                        soilMoist3: "${history[index].moisturePlant3}%",
                        onTap: () {
                          //
                        },
                      );
                    }),
              ],
            ),
          )
        ],
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-splash.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: SingleChildScrollView(
            child: widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.list_bullet),
              label: 'History',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.power),
              label: 'Log Out',
              backgroundColor: Colors.white,
            ),
          ],
          backgroundColor: Colors.green,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green[200],
          onTap: (int index) {
            switch (index) {
              case 2:
                showModal(context);
                break;
              default:
                setState(
                  () {
                    _selectedIndex = index;
                  },
                );
                break;
            }
          },
        ),
      ),
    );
  }

  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Are you sure you want to log out'),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              logOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pushReplacementNamed(loginScreenRoute);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              //
            },
            child: const Text('No'),
          )
        ],
      ),
    );
  }
}
