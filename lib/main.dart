import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/base_screen.dart';
import 'package:staff_app/firebase_options.dart';
import 'package:staff_app/features/auth/presentation/screens/login_screen.dart';
import 'package:staff_app/test_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: TextScaler.linear(1.0)),
        child: child!,
      ),
      debugShowCheckedModeBanner: false,
      title: "Staff Attendance App",
      theme: ThemeData(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Color.fromRGBO(255, 255, 255, 1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(19, 109, 236, 1),
        ),
      ),

      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TestScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
