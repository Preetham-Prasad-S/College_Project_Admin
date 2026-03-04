import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:staff_app/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  bool _obscureText = true;

  bool _rememberMe = false;

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
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter The Email";
                        }
                        return null;
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "example@email.com",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(160, 167, 178, 1),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color.fromRGBO(156, 163, 175, 1),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(249, 250, 251, 1),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(229, 231, 235, 1),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(19, 109, 236, 1),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(198, 14, 36, 1),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(198, 14, 36, 1),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Password", style: TextStyle(fontSize: 15)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the password";
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color.fromRGBO(156, 163, 175, 1),
                          ),
                        ),
                        hintText: "• • • • • • • • • • •",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(160, 167, 178, 1),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color.fromRGBO(156, 163, 175, 1),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(249, 250, 251, 1),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(229, 231, 235, 1),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(19, 109, 236, 1),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(198, 14, 36, 1),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(198, 14, 36, 1),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(77, 87, 101, 1),
                            ),
                          ),
                        ],
                      ),
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
                  TextButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
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
                      fixedSize: WidgetStatePropertyAll(
                        Size(double.infinity, 70),
                      ),
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
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.exit_to_app, size: 26),
                      ],
                    ),
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
