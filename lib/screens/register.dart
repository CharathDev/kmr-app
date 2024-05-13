import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kmrapp/screens/login.dart';
import 'package:kmrapp/screens/root.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController fullNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController icNumberController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    Future<void> handleRegister() async {
      String fullName = fullNameController.text;
      String email = emailController.text;
      String icNumber = icNumberController.text;
      String phoneNumber = phoneNumberController.text;
      String password = passwordController.text;
      String confirmPassword = confirmPasswordController.text;

      if (password != confirmPassword) {
        return;
      }

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Get the newly registered user's ID
        String userId = userCredential.user!.uid;

        // Store user information in Firestore
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'fullName': fullName,
          'email': email,
          'icNumber': icNumber,
          'phoneNumber': phoneNumber,
          'isStaff': false,
        });

        //can change this
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RootPage()), //destination
        );
      } catch (e) {
        // if fail
        print('Failed to register user: $e');
      }
    }

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
                  'User Register',
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
                  controller: fullNameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: 'Full Name',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      labelText: 'Email'),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: icNumberController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: 'IC Number',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      labelText: 'Phone Number'),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      labelText: 'Confirm Password'),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text('Login here'))
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
                          onTap: handleRegister, // Call the function here
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
                            ),
                          ),
                        ),
                      ),
                    )
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
