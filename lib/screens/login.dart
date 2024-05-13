import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kmrapp/screens/ADMIN_home_page.dart';
import 'package:kmrapp/screens/STAFF_root.dart';
import 'package:kmrapp/screens/home_page.dart';
import 'package:kmrapp/screens/register.dart';
import 'package:kmrapp/screens/root.dart';
import 'package:kmrapp/screens/ADMIN_root.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController(
      text: "test@gmail.com"); //remove initial value later
  final passwordController =
      TextEditingController(text: "123123"); //remove initial value later

  void loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (emailController.text == "admin@gmail.com") {
        Navigator.push(
          context,
          // MaterialPageRoute(builder: (context) => RootPage()), //USER ROOT PAGE
          MaterialPageRoute(
              builder: (context) => ADMINRootPage()), //ADMIN ROOT PAGE
        );
      } else {
        var user = FirebaseAuth.instance.currentUser;
        var userInfo = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        if (userInfo.data()!['isStaff']) {
          Navigator.push(
            context,
            // MaterialPageRoute(builder: (context) => RootPage()), //USER ROOT PAGE
            MaterialPageRoute(
                builder: (context) => STAFFRootPage()), //ADMIN ROOT PAGE
          );
        } else {
          Navigator.push(
            context,
            // MaterialPageRoute(builder: (context) => RootPage()), //USER ROOT PAGE
            MaterialPageRoute(
                builder: (context) => RootPage()), //ADMIN ROOT PAGE
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffDFCEFA),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 0,
          bottom: 14,
        ),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
                color: Color(0xffDFCEFA),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'User Login',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff966FD6)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Please fill in your personal informations required below',
                  style: TextStyle(color: Color(0xff966FD6), fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: 'Email',
                  ),
                  controller: emailController, //initial value: "test@gmail.com"
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      labelText: 'Password'),
                  controller: passwordController, //initial value: "123123"
                ),
                const SizedBox(
                  height: 30,
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
                          );
                        },
                        child: const Text('Register here'))
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xff966FD6),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              loginUser();
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Text(
                                  'GET STARTED',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )),
                          ),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
