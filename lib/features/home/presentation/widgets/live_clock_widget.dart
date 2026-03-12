import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LiveClock extends StatefulWidget {
  const LiveClock({super.key});

  @override
  State<LiveClock> createState() => _LiveClockState();
}

class _LiveClockState extends State<LiveClock> {
  late Timer tick;
  String currentTime = DateFormat("hh:mm a").format(DateTime.now());

  @override
  void initState() {
    super.initState();

    tick = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        currentTime = DateFormat("hh:mm a").format(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    tick.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      currentTime,
      style: const TextStyle(
        height: 1.2,
        color: Colors.white,
        fontSize: 50,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
