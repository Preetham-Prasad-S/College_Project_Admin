import 'package:flutter/material.dart';

class LoginTextFieldWidget extends StatefulWidget {
  final String hintText;
  final IconData hintIcon;
  final bool obscureText;
  final TextEditingController controller;
  final Function(bool obscureText)? onPressed;

  const LoginTextFieldWidget({
    super.key,
    required this.hintText,
    required this.hintIcon,
    required this.controller,
    required this.obscureText,
    this.onPressed,
  });

  @override
  State<LoginTextFieldWidget> createState() => _LoginTextFieldWidgetState();
}

class _LoginTextFieldWidgetState extends State<LoginTextFieldWidget> {
  late bool obscureText;
  late bool enableObscureButton;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    enableObscureButton = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please Enter The Email";
        }
        return null;
      },
      obscureText: obscureText,

      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: enableObscureButton
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Color.fromRGBO(156, 163, 175, 1),
                ),
              )
            : null,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Color.fromRGBO(160, 167, 178, 1)),
        prefixIcon: Icon(
          widget.hintIcon,
          color: Color.fromRGBO(156, 163, 175, 1),
        ),
        filled: true,
        fillColor: Color.fromRGBO(249, 250, 251, 1),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(229, 231, 235, 1)),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(19, 109, 236, 1)),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(198, 14, 36, 1)),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(198, 14, 36, 1)),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
    );
  }
}
