import 'package:flutter/material.dart';

class InPremisesWidget extends StatelessWidget {
  final String state;

  const InPremisesWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: state == "true"
                ? Color.fromRGBO(99, 255, 156, 1)
                : state == "loading"
                ? Color.fromRGBO(255, 245, 99, 1)
                : const Color.fromARGB(255, 255, 55, 41),

            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: 10,
          width: 10,
        ),
        const SizedBox(width: 10),

        Text(
          state == "true"
              ? "INSIDE COLLEGE PRIMESIS"
              : state == "loading"
              ? "GETTING GEOLOCATION"
              : "NOT IN COLLEGE CAMPUS",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
