import 'package:flutter/material.dart';

class RememberMeWidget extends StatefulWidget {
  final bool remeberMe;
  const RememberMeWidget({super.key, required this.remeberMe});

  @override
  State<RememberMeWidget> createState() => _RememberMeWidgetState();
}

class _RememberMeWidgetState extends State<RememberMeWidget> {
  late bool _rememberMe;

  @override
  void initState() {
    _rememberMe = widget.remeberMe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: Color.fromRGBO(19, 109, 236, 1),

          checkColor: Color.fromRGBO(255, 255, 255, 1),
          value: _rememberMe,
          onChanged: (value) {
            setState(() {
              _rememberMe = value!;
            });
          },
          side: const BorderSide(
            color: Color.fromRGBO(220, 223, 228, 1),
            width: 1,
          ),
        ),
        const Text(
          "Remember me",
          style: TextStyle(fontSize: 15, color: Color.fromRGBO(77, 87, 101, 1)),
        ),
      ],
    );
  }
}
