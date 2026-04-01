import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginButtonWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginButtonWidget({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginButtonWidget> createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends State<LoginButtonWidget> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _formKey = widget.formKey;
    _emailController = widget.emailController;
    _passwordController = widget.passwordController;
    super.initState();
  }

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      // print(credential.user);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          FocusScope.of(context).unfocus();

          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(builder: (context) => HomeScreen()),
          // );
          await login(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
        }
      },
      style: const ButtonStyle(
        fixedSize: WidgetStatePropertyAll(Size(double.infinity, 70)),
        foregroundColor: WidgetStatePropertyAll(
          Color.fromRGBO(255, 255, 255, 1),
        ),
        backgroundColor: WidgetStatePropertyAll(
          Color.fromRGBO(19, 109, 236, 1),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "SIGN IN",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Icon(Icons.exit_to_app, size: 26),
        ],
      ),
    );
  }
}
