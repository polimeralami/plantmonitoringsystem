import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final double? value;
  final String symbol;
  final double minSafeValue;
  final double maxSafeValue;
  final Color minSafeColor;
  final Color maxSafeColor;
  final VoidCallback onTap;

  Color getActiveColor(
      double val, double min, double max, Color minColor, Color maxColor) {
    if (val < min) return minColor;
    if (val > max) return maxColor;
    return Colors.green;
  }

  const InfoCard({
    Key? key,
    required this.icon,
    required this.title,
    this.value,
    required this.symbol,
    required this.minSafeValue,
    required this.maxSafeValue,
    required this.minSafeColor,
    required this.maxSafeColor,
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
          color: getActiveColor(value ?? 0.0, minSafeValue, maxSafeValue,
              minSafeColor, maxSafeColor),
          elevation: 20,
          child: InkWell(
            onTap: onTap,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: ListTile(
                      leading: Icon(icon, size: 60, color: Colors.white),
                      subtitle: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(title,
                                style: const TextStyle(
                                    fontSize: 20.0, color: Colors.white)),
                            Text("${value ?? ''}$symbol",
                                style: const TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ])),
                ),
              ],
            ),
          ),
        ));
  }
}
