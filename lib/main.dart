import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kmrapp/screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KMR APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorSchemeSeed: Colors.deepPurple,
          useMaterial3: true,
          textTheme: GoogleFonts.plusJakartaSansTextTheme(
              Theme.of(context).textTheme)),
      home: const OnboardingScreen(),
      // home: ADMINRootPage(),
    );
  }
}
