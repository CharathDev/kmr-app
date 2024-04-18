import 'package:flutter/material.dart';
import 'package:kmrapp/screens/login.dart';
import 'package:kmrapp/screens/register.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff966FD6),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/images/2.png',
              width: 350,
              height: 350,
            ),
            Text(
              'Consult, only with a doctor you trust!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Worry not, we will assist you with whatever needs you may have!',
              style: TextStyle(color: Colors.white, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: const Text(
                          'GET STARTED',
                          style: TextStyle(
                              color: Color(0xff966FD6),
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        )),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
