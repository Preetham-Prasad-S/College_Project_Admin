import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/features/auth/dependency.dart';

class LoginButtonWidget extends ConsumerStatefulWidget {
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
  ConsumerState<LoginButtonWidget> createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends ConsumerState<LoginButtonWidget> {
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

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (_, state) {
      state.whenOrNull(
        error: (error, stackTrace) => ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("$error"))),
      );
    });

    final authState = ref.watch(authControllerProvider);
    final authController = ref.read(authControllerProvider.notifier);

    return TextButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          FocusScope.of(context).unfocus();

          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(builder: (context) => HomeScreen()),
          // );
          await authController.login(
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
      child: authState.when(
        data: (data) => Row(
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
        error: (error, stackTrace) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SIGN IN",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Icon(Icons.exit_to_app, size: 26),
            ],
          );
        },
        loading: () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator(color: Colors.white)],
        ),
      ),
    );
  }
}
