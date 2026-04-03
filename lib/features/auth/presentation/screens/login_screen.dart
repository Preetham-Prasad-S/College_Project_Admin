import 'package:flutter/material.dart';
import 'package:staff_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:staff_app/features/auth/presentation/widgets/login_button_widget.dart';
import 'package:staff_app/features/auth/presentation/widgets/login_text_field_widget.dart';
import 'package:staff_app/features/auth/presentation/widgets/remember_me_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  final bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    maxRadius: 45,
                    backgroundColor: Color.fromRGBO(231, 240, 253, 1),
                    foregroundColor: Color.fromRGBO(19, 109, 236, 1),
                    child: Icon(Icons.school_rounded, size: 50),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "University Staff Portal",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Attendance Management System",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(107, 114, 128, 1),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Staff Login",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color.fromRGBO(243, 244, 246, 1),
                    thickness: 2,
                  ),
                  const SizedBox(height: 25),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email Or Staff ID",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: LoginTextFieldWidget(
                      obscureText: false,
                      controller: _emailController,
                      hintIcon: Icons.person,
                      hintText: "example@email.com",
                    ),
                  ),
                  const SizedBox(height: 18),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Password", style: TextStyle(fontSize: 15)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: LoginTextFieldWidget(
                      hintText: "• • • • • • • • • • •",
                      hintIcon: Icons.lock,
                      controller: _passwordController,
                      obscureText: true,
                      onPressed: (obscureText) {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RememberMeWidget(remeberMe: _rememberMe),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(19, 109, 236, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LoginButtonWidget(
                    formKey: _formkey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  SizedBox(height: 20),
                  const Divider(
                    color: Color.fromRGBO(243, 244, 246, 1),
                    thickness: 2,
                  ),
                  SizedBox(height: 10),
                  Card(
                    color: Color.fromRGBO(245, 246, 248, 1),
                    shadowColor: Color.fromRGBO(0, 0, 0, 0),
                    margin: EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      child: SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.security_rounded,
                              size: 16,
                              color: Color.fromRGBO(116, 122, 136, 1),
                            ),
                            Text(
                              "Secure Server Connection",
                              style: TextStyle(
                                color: Color.fromRGBO(116, 122, 136, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Having trouble togging in?",
                    style: TextStyle(
                      color: Color.fromRGBO(116, 122, 135, 1),
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "Contact IT support",
                    style: TextStyle(
                      color: Color.fromRGBO(19, 109, 236, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
